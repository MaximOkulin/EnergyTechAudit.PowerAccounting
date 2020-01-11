using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Spatial;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Security.Claims;
using System.Threading;
using System.Web;
using DevExpress.Data.Filtering;
using DevExpress.Data.Linq;
using DevExpress.Data.Linq.Helpers;
using EnergyTechAudit.PowerAccounting.Common.Entity;
using EnergyTechAudit.PowerAccounting.Common.Serialization;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.DataAccess
{
    /// <summary>
    /// Отслеживатель изменений сущностей, которые реализуют интерфейс IHistoryChangeTrackEntity 
    /// </summary>
    
    public class DatabaseContextHistoryChangeTracker
    {
        private readonly DbContext _context;

        private readonly string _userName;

        public DatabaseContextHistoryChangeTracker(DbContext context)
        {
            _context = context;
            
            if (HttpContext.Current != null && HttpContext.Current.User != null && HttpContext.Current.User is ClaimsPrincipal)
            {
               var userNameClaim = ((ClaimsPrincipal) HttpContext.Current.User).Claims
                    .FirstOrDefault(claim => claim.Type.EndsWith("name", StringComparison.InvariantCultureIgnoreCase));
                if (userNameClaim != null)
                {
                    _userName = userNameClaim.Value;
                }
            }
            else if (Thread.CurrentPrincipal != null && Thread.CurrentPrincipal  is ClaimsPrincipal)
            {
                if (((ClaimsPrincipal) Thread.CurrentPrincipal).Identity.AuthenticationType == "Passport")
                {
                    var userNameClaim = ((ClaimsPrincipal) Thread.CurrentPrincipal).Claims
                        .FirstOrDefault(claim => claim.Type.EndsWith("name", StringComparison.InvariantCultureIgnoreCase));
                    if (userNameClaim != null)
                    {
                        _userName = userNameClaim.Value;
                    }
                }                
            }

            if(string.IsNullOrEmpty(_userName))            
            {
                _userName = "system";    
            }            
        }

        private readonly Predicate<DbEntityEntry> _isHistoryTrackable =
            (entityEntry) => entityEntry.Entity is IHistoryChangeTrackEntity 
                             && ( !(entityEntry.Entity is IHistoryChangeTrackSuppressingEntity) || (entityEntry.Entity as IHistoryChangeTrackSuppressingEntity).SuppressHistory == false)
                             && (entityEntry.State == EntityState.Added || entityEntry.State == EntityState.Modified);

        private readonly Predicate<DbEntityEntry> _isLoggedDeletedTrackable = (entityEntry) =>
        {
            var loggedDeletedTrackEntityAttribute =
                entityEntry.Entity.GetType().GetCustomAttribute<LoggedDeletedTrackEntityAttribute>();

            return loggedDeletedTrackEntityAttribute != null && entityEntry.State == EntityState.Deleted;
        };
        
        private readonly Func<Type, object, object, bool> _isComplexTypeEquals = (propertyType, currentValue, originalValue) =>
        {
            var equals = false;
            if (propertyType == typeof(DbGeography) && currentValue is DbGeography && originalValue is DbGeography)
            {         
                currentValue = ((DbGeography)currentValue).AsText();
                originalValue = ((DbGeography)originalValue).AsText();
                equals = currentValue.Equals(originalValue);
            }

            return equals;
        };

        public IEnumerable<CascadeDeletedEntity> GetCascadeDeletedEntities(EntityInfo entityInfo)
        {
            var entityType = EntityTypeHelper.GetEntityTypeByName(entityInfo.EntityTypeName);

            var cascadeDeleteInverseTypeInfoList = EntityTypeHelper
               .GetInverseLinkedEntityTypeInfoList(entityType, false);

            var criteriaToEfExpressionConverter = new CriteriaToEFExpressionConverter();

            var result = cascadeDeleteInverseTypeInfoList.Select(entityTypeInfo =>
            {
                CriteriaOperator criteriaOperator = CriteriaOperator.Parse
                    (
                    $"[{entityInfo.EntityTypeName}Id] = {entityInfo.EntityId}"
                );

                var navigationProperty =
                    entityTypeInfo.Type.GetProperties().FirstOrDefault(p => p.PropertyType == entityType);

                var deleted = true;

                if (navigationProperty != null)
                {
                    if (navigationProperty.GetCustomAttribute<OneToOneForeignKeyAttribute>() != null)
                    {
                        criteriaOperator = CriteriaOperator.Parse
                            (
                            $"[Id] = {entityInfo.EntityId}"
                        );
                    }
                    if (navigationProperty
                        .GetCustomAttribute<SetNullOnCascadeDeletingPropertyAttribute>() != null)
                    {
                        deleted = false;
                    }
                }

                int count = default;

                if (!ReferenceEquals(criteriaOperator, null))
                {
                    count = _context.Set(entityTypeInfo.Type)
                        .AppendWhere(criteriaToEfExpressionConverter, criteriaOperator)
                        .Count();
                }

                return new CascadeDeletedEntity
                {
                    EntityTypeName = entityTypeInfo.Type.Name,
                    EntityTypeDescription = entityTypeInfo.Description,
                    EntityCount = count,
                    CascadeOperationType = deleted ? "ON DELETE" : "ON SET NULL"
                };
            });

            return result;
        }

        public void SaveChanges()
        {
            if (!_userName.Equals("system"))
            {
                var historyTrack = _context.ChangeTracker.Entries()
                    .Where(entityEntry => _isHistoryTrackable(entityEntry));

                var historyChangeTrackEntityProperyNames = typeof (IHistoryChangeTrackEntity)
                    .GetProperties()
                    .Select(p => p.Name);

                historyTrack.ToList().ForEach(entityEntry =>
                {
                    SetHistoryProperty(entityEntry);

                    var propertyNames = entityEntry.CurrentValues
                        .PropertyNames
                        .Except(historyChangeTrackEntityProperyNames);

                    var entityType = entityEntry.Entity.GetType();

                    propertyNames.ToList().ForEach(propertyName =>
                    {
                        AddEntityHistoryEntry(entityEntry, propertyName, entityType);
                    });
                });

                var loggedDeletedTrack = _context
                    .ChangeTracker
                    .Entries()
                    .Where(entityEntry => _isLoggedDeletedTrackable(entityEntry));

                loggedDeletedTrack.ToList().ForEach(entityEntry =>
                {
                    var entityType = entityEntry.Entity.GetType();
                    var entityNameAttribute = entityType.GetCustomAttribute<EntityNameAttribute>();
                    var entityTypeId = ((IEntity) entityEntry.Entity).Id;
                    var entityTypeName = entityType.Name;

                    var cascadeDeletedEntities = GetCascadeDeletedEntities(new EntityInfo
                    {
                        EntityId = entityTypeId,
                        EntityTypeName = entityTypeName                      
                    });

                    var xmlCascadeDeletedEntities = XmlEntitySerializer.Serialize(cascadeDeletedEntities.ToArray(), 
                        "CascadeDeletedEntities", true);
                    
                    if (typeof(IDescribableEntity).IsAssignableFrom(entityType))
                    {
                        entityEntry.Reload();                        
                        entityEntry.State = EntityState.Deleted;
                    }
                      
                    var deletedEntityLogEntry = new DeletedEntityLogEntry
                    {
                        EntityId = entityTypeId,

                        EntityDescription = typeof(IDescribableEntity).IsAssignableFrom(entityType)
                            ? ((IDescribableEntity)entityEntry.Entity).Description
                            : null,

                        EntityTypeName = entityTypeName,

                        EntityTypeDescription = entityNameAttribute != null
                            ? entityNameAttribute.Name
                            : entityTypeName,

                        CascadeDeletedEntities = xmlCascadeDeletedEntities,
                                                        
                        User = _userName,
                        DateTime =  DateTime.Now
                    };

                    _context.Set<DeletedEntityLogEntry>().Add(deletedEntityLogEntry); 
                });

            }
        }

        private void AddEntityHistoryEntry(DbEntityEntry entityEntry, string propertyName, Type entityType)
        {
            var propertyEntry = entityEntry.Property(propertyName);

            var property = entityType.GetProperty(propertyName);

            var propertyType = property?.PropertyType;

            if (propertyEntry.IsModified)
            {
                var currentValue = Convert.ToString(entityEntry.CurrentValues[propertyName], 
                    CultureInfo.CurrentCulture);

                var originalValue = Convert.ToString(entityEntry.State == EntityState.Modified
                    ? entityEntry.OriginalValues[propertyName]
                    : string.Empty, CultureInfo.CurrentCulture);

                var entityNameAttribute = entityType.GetCustomAttribute<EntityNameAttribute>();
                var propertyDisplayAttribute = property.GetCustomAttribute<DisplayAttribute>();

                var entityHistory = new EntityHistory
                {
                    EntityId = ((IEntity)entityEntry.Entity).Id,

                    EntityTypeDescription = entityNameAttribute != null
                        ? entityNameAttribute.Name
                        : entityType.Name,

                    EntityTypeName = entityType.Name,

                    PropertyDescription = propertyDisplayAttribute != null
                        ? propertyDisplayAttribute.Name
                        : propertyName,

                    PropertyName = propertyName,

                    CurrentValue = currentValue,

                    OriginalValue = originalValue,

                    User = _userName,

                    DateTime = DateTime.Now,
                    
                };

                var equals = _isComplexTypeEquals(propertyType,
                    entityEntry.CurrentValues[propertyName],
                    entityEntry.OriginalValues[propertyName]);

                if (!equals)
                {
                    var validationResult = _context.Entry(entityHistory).GetValidationResult();
                    if (validationResult.IsValid)
                    {
                        _context.Set<EntityHistory>().Add(entityHistory);
                    }
                }
            }
        }

        private void SetHistoryProperty(DbEntityEntry entityEntry)
        {
            if (entityEntry.Entity is IHistoryChangeTrackEntity entity)
            {
                if (entityEntry.State == EntityState.Added)
                {
                    entity.CreatedBy = _userName;
                    entity.CreatedDate = DateTime.Now;
                }

                entity.UpdatedBy = _userName;
                entity.UpdatedDate = DateTime.Now;
            }
        }
    }
}