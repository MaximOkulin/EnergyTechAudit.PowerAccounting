using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Тип подсистемы 
    /// </summary>
    [EntityName(Name = "Тип подсистемы")]
    public class SubsystemType : DictionaryEntityBase
    {
        public SubsystemType()
        {            
            ParameterMapDeviceParameters = new List<ParameterMapDeviceParameter>();
        }

        [Display(Name = "Сопоставления параметров с приборными параметрами")]
        [InverseProperty("SubsystemType")]
        public virtual ICollection<ParameterMapDeviceParameter> ParameterMapDeviceParameters { get; private set; }
    }
}
