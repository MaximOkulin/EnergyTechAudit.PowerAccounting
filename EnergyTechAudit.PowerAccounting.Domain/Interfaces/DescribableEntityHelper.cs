using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Reflection;

using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    public static class DescribableEntityHelper
    {
        public static void CalculateDescription(IObjectContextAdapter contextAdapter, IEntity entity, Action action)
        {
            if (action != null)
            {
                var objectStateManager = contextAdapter.ObjectContext.ObjectStateManager;
                var modifiedProperties = objectStateManager.GetObjectStateEntry(entity).GetModifiedProperties().ToList();
                
                var properties = entity.GetType().GetProperties();

                var describableDependencyProperties =
                    properties
                        .Where(pi => pi.GetCustomAttribute<DependencyDescribablePropertyAttribute>() != null)
                        .Select(pi => pi.Name).ToList();

                var requiredDescribableProperties = properties
                    .Where(pi => pi.GetCustomAttribute<RequiredDescribablePropertyAttribute>() != null)
                    .Select(pi => pi.Name);

                var state = objectStateManager.GetObjectStateEntry(entity).State;

                if (state == EntityState.Added)
                {
                    modifiedProperties = describableDependencyProperties;
                }

                if (modifiedProperties.Intersect(describableDependencyProperties).Any() || state == EntityState.Unchanged )
                {
                    requiredDescribableProperties.ToList().ForEach(name =>
                    {
                        if (state == EntityState.Added)
                        {                           
                            var prop = properties.First(p => p.Name == name);
                            var fk = prop.GetCustomAttribute<ForeignKeyAttribute>();

                            if (fk != null && describableDependencyProperties.Contains(fk.Name))
                            {
                                var de = (IDescribableEntity)((DbContext) contextAdapter).Set(prop.PropertyType).Find(1);
                            }
                          
                        }
                        else
                        {
                            contextAdapter.ObjectContext.LoadProperty(entity, name);    
                        }
                        
                    });
                    try
                    {
                        action();                            
                    }
                    catch (NullReferenceException)
                    {
                        if (entity is IDescribableEntity)
                        {
                            ((IDescribableEntity) entity).Description = null;
                        }
                    }
                    
                }
            }
        }
    }
}