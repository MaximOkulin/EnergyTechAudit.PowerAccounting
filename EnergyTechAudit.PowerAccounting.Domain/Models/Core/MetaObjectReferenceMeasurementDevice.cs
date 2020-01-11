using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    /// <summary>
    /// Указывает на требование обработки метаобъекта в контексте 
    /// привязки к конкретному измерительному устройству
    /// </summary>
    [EntityName(Name = "Обработка метаобъекта в контексте изм. устройства")]
    public class MetaObjectReferenceMeasurementDevice
    {

        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Метаобъект")]
        [ForeignKey("Id")]
        public virtual MetaObject MetaObject { get; set; }               
    }
}