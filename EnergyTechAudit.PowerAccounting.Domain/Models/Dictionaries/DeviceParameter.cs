using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Параметр прибора")]
    public class DeviceParameter : DictionaryEntityBase
    {
        public DeviceParameter()
        {
            ParameterMapDeviceParameters = new List<ParameterMapDeviceParameter>();
            Archives = new List<Archive>();
            RegulatorParameterValues = new List<RegulatorParameterValue>();
            IntegrationArchiveInfos = new List<IntegrationArchiveInfo>();
        }

        [Display(Name = "Ид")]
        [Required]
        public int DeviceId { get; set; }

        [Display(Name = "Модель прибора")]
        [ForeignKey("DeviceId")]
        public Device Device { get; set; }

        [Display(Name = "Настройка параметра прибора"), NotDisplayGrid]
        [InverseProperty("DeviceParameter")]
        public virtual DeviceParameterSetting DeviceParameterSetting { get; set; }

        [InverseProperty("DeviceParameter")]
        public virtual ICollection<ParameterMapDeviceParameter> ParameterMapDeviceParameters { get; private set; }

        [InverseProperty("DeviceParameter")]
        [NotDisplayGrid]
        public virtual ICollection<Archive> Archives { get; private set; }

        [InverseProperty("DiffDeviceParameter")]
        [NotDisplayGrid]
        public virtual ICollection<IntegrationArchiveInfo> IntegrationArchiveInfos { get; private set; }

        public virtual ICollection<RegulatorParameterValue> RegulatorParameterValues { get; private set; }
    }
}
