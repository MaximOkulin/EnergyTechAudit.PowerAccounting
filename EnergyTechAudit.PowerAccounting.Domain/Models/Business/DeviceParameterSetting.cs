using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Настройка параметра устройства")]
    public class DeviceParameterSetting : IEntity
    {
        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Мин. знач.")]
        [Required]
        public decimal Min { get; set; }

        [Display(Name = "Макс. знач.")]
        [Required]
        public decimal Max { get; set; }

        [Display(Name = "Метод записи параметра")]
        public string WriteMethodName { get; set; }

        [Display(Name = "Код типа значения")]
        [Required]
        public string ValueTypeCode { get; set; }

        public RegulatorParameterValueType ValueType
        {
            get
            {
                RegulatorParameterValueType valueType;

                return Enum.TryParse(ValueTypeCode, false, out valueType)
                    ? valueType
                    : RegulatorParameterValueType.Int32;
            }
        }

        [Display(Name = "Параметр прибора")]
        [ForeignKey("Id")]
        public virtual DeviceParameter DeviceParameter { get; set; }
    }
}
