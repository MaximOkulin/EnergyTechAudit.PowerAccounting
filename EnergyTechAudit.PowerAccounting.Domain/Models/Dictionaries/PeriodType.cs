using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.Domain.Models.Rules;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Тип периодичности чтения архивных данных (мгновенный, часовой...)
    /// </summary>
    [EntityName(Name = "Тип периода")]
    public class PeriodType : DictionaryEntityBase
    {
        public PeriodType()
        {
            Archives = new List<Archive>();            
            ParameterMapDeviceParameters = new List<ParameterMapDeviceParameter>();
            DeviceArchiveTimeConverters = new List<DeviceArchiveTimeConverter>();
            IntegrationArchiveInfos = new List<IntegrationArchiveInfo>();
        }

        [InverseProperty("PeriodType")]
        public virtual ICollection<Archive> Archives { get; private set; }

        [InverseProperty("PeriodType")]
        public virtual ICollection<IntegrationArchiveInfo> IntegrationArchiveInfos { get; private set; }

        [InverseProperty("PeriodType")]
        public virtual ICollection<ParameterMapDeviceParameter> ParameterMapDeviceParameters { get; private set; }

        [InverseProperty("PeriodType")]
        public virtual ICollection<DeviceArchiveTimeConverter> DeviceArchiveTimeConverters { get; private set; }

    }
}
