using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;


// ReSharper disable once CheckNamespace
namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    public partial class MeasurementDevice : IValidatableEntityObject
    {
         public DbEntityValidationResult Validate(IObjectContextAdapter context, DbEntityEntry entityEntry, IDictionary<object, object> items)
         {
             
             var validationErrorList = new List<DbValidationError>();

             if (entityEntry.State != EntityState.Deleted)
             {
                 /* Валидация соответствия между строениями связанными с каналами и строениями связанными с точкой доступа */
                 if (AccessPointId.HasValue)
                 {
                     // Cписок строений связанных с устройством через каналы

                     var buildingsFromMeasurementDevice = context
                         .ObjectContext
                         .CreateObjectSet<Channel>()
                         .Include(ch => ch.Placement.Building)
                         .Where(ch => ch.MeasurementDeviceId == Id)
                         .Select(ch => ch.Placement.Building.Id)
                         .ToList();

                     // Cписок строений связанных с устройством через точку доступа
                     var buildingsFromAccessPoint = context
                         .ObjectContext
                         .CreateObjectSet<AccessPointLinkBuilding>()
                         .Where(apbl => apbl.AccessPointId == AccessPointId)
                         .Select(apbl => apbl.BuildingId)
                         .ToList();

                     if (!buildingsFromAccessPoint.Any() && buildingsFromMeasurementDevice.Any())
                     {
                         // формируем список ошибок валидации (торжество машины над макакой!)
                         validationErrorList.Add
                             (
                                 new DbValidationError
                                     (
                                     "AccessPointId",
                                     "Выбираемая точка доступа не присоединена ни к одному строению."
                                     )
                             );
                     }

                     var correlatedBuildings = buildingsFromMeasurementDevice
                         .Except(buildingsFromAccessPoint.Intersect(buildingsFromMeasurementDevice));

                     // коррелированный список строений должен быть пустым, 
                     // что означает, что все строения из спика "через каналы" 
                     // имеются в списке "через точку доступа"
                     if (correlatedBuildings.Any())
                     {
                         // формируем список ошибок валидации (торжество машины над макакой!)
                         validationErrorList.Add
                             (
                                 new DbValidationError
                                     (
                                     "AccessPointId",
                                     "Выбираемая точка доступа не соответствует привязке измерительного устройства через связанные каналы со строениями."
                                     )
                             );
                     }

                 }
             }

             return new DbEntityValidationResult(entityEntry, validationErrorList);
         }
    }
}
