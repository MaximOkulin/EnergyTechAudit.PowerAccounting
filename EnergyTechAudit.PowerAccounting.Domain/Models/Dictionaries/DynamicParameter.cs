using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Динамический параметр")]
    public class DynamicParameter : DictionaryEntityBase
    {
        public DynamicParameter()
        {
            EntityTypeName = "MeasurementDevice";
            Type = "System.String";
            IsDefault = false;
            IsReadOnly = true;
            DeviceLinkDynamicParameter = new List<DeviceLinkDynamicParameter>();
            DynamicParameterValues = new List<DynamicParameterValue>();
        }

        [Display(Name = "Название сущности")]
        [Required]
        public string EntityTypeName { get; set; }

        [Display(Name = "Тип данных")]
        [Required]
        public string Type { get; set; }

        [Display(Name = "Обязательный")]
        [Required]
        public bool IsDefault { get; set; }

        [Display(Name = "Значение по умолчанию")]
        public string DefaultValue { get; set; }

        [Display(Name = "Только для чтения")]
        [Required]
        public bool IsReadOnly { get; set; }

        [Display(Name = "Json-описание")]
        public string Descriptor { get; set; }

        [InverseProperty("DynamicParameter")]
        public virtual ICollection<DeviceLinkDynamicParameter> DeviceLinkDynamicParameter { get; private set; }

        [InverseProperty("DynamicParameter")]
        public virtual ICollection<DynamicParameterValue> DynamicParameterValues { get; private set; }
    }
}
