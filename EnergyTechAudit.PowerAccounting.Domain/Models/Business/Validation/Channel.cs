using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Common.Resources;

// ReSharper disable once CheckNamespace
namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    public partial class Channel : IValidatableEntityObject 
    {
        public DbEntityValidationResult Validate(IObjectContextAdapter context, DbEntityEntry entityEntry, IDictionary<object, object> items)
        {
            var validationErrorList = new List<DbValidationError>();

            // Cписок строений связанных с каналом через точку доступа измерительного устройства или хаба
            if (entityEntry.State != EntityState.Deleted)
            {

                var buildingsFromMeasurementDevice = context
                    .ObjectContext
                    .CreateObjectSet<MeasurementDevice>()
                    .Include(md => md.AccessPoint.AccessPointLinksBuilding)
                    .Where(md => md.AccessPointId.HasValue && md.Id == MeasurementDeviceId)
                    .SelectMany(md => md.AccessPoint.AccessPointLinksBuilding)
                    .Select(apbl => apbl.BuildingId)
                    .Union
                    (
                        context
                            .ObjectContext
                            .CreateObjectSet<MeasurementDevice>()
                            .Include(md => md.Hub.Building)
                            .Where(md => md.HubId.HasValue && md.Id == MeasurementDeviceId)
                            .Select(md => md.Hub.BuildingId)
                    ).ToList();

                var buildingsFromPlacement = context
                    .ObjectContext
                    .CreateObjectSet<Placement>()
                    .Where(p => p.Id == PlacementId)
                    .Select(p => p.BuildingId)
                    .ToList();

                // есть ли в списке строений из точки доступа выбираемого измерительного устройства строения 
                // которые соответствуют строению из выбираемого помещения  
                if (!buildingsFromMeasurementDevice.Intersect(buildingsFromPlacement).Any())
                {
                    // формируем список ошибок валидации (торжество машины над макакой!)
                    validationErrorList.Add
                        (
                            new DbValidationError
                                (
                                DbTablePermanentResources.MeasurementDeviceIdColumn,
                                "Выбираемое помещение не соответствует привязке измерительного устройства к строению. " +
                                "Точка доступа связана со строениями отличными от строений, с которыми связам канал через выбранное помещение."
                                )
                        );
                }
            }
            return new DbEntityValidationResult(entityEntry, validationErrorList);
        }
    }
}
