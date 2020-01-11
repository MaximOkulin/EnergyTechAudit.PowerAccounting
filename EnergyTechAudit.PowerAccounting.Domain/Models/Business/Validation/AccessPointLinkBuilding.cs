using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

// ReSharper disable once CheckNamespace
namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Связь между строениями и точками доступа"
    /// </summary>    
    public partial class AccessPointLinkBuilding : IValidatableEntityObject
    {               
        public DbEntityValidationResult Validate(IObjectContextAdapter context, DbEntityEntry entityEntry, IDictionary<object, object> items)
        {
            var validationErrorList = new List<DbValidationError>();

            if (entityEntry.State == EntityState.Deleted)
            {
                var link = (AccessPointLinkBuilding) entityEntry.Entity;

                var isActualLink = context
                    .ObjectContext
                    .CreateObjectSet<MeasurementDevice>()
                    .Where(md => md.AccessPointId == link.AccessPointId)
                    .Include(md => md.Channels.Select(ch => ch.Placement))
                    .SelectMany(md => md.Channels.Select(ch => ch.Placement.BuildingId))
                    .Any(bid => bid == link.BuildingId);

                if (isActualLink)
                {
                    validationErrorList.Add
                        (
                            new DbValidationError
                                (
                                "BuildingId",
                                "Ссылка на строение не может быть отсоединена. " +
                                "Каналы измерительных устройств, связанных c точкой доступа, находятся в этом строении. " +
                                "Перед удалением  следует обнулить ссылку на точку доступа в измерительных устройствах."
                                )
                        );
                }                
            }

            return new DbEntityValidationResult(entityEntry, validationErrorList);  
        }
    }
}
