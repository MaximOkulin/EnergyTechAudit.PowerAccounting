using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Тип ресурсной системы (газовая система)
    /// </summary>
    [EntityName(Name = "Тип ресурсной системы")]
    public class ResourceSystemType : DictionaryEntityBase
    {
        public ResourceSystemType()
        {
            Channels = new List<Channel>();
            ChannelTemplates = new List<ChannelTemplate>();
            AgreementSystemParameters = new List<AgreementSystemParameter>();
            Parameters = new List<Parameter>();
            ResourceSubsystemTypes = new List<ResourceSubsystemType>();
        }


        [Display(Name = "Короткое наименование")]
        [Required]
        public string ShortName { get; set; }

        [InverseProperty("ResourceSystemType")]
        public virtual ICollection<Channel> Channels { get; private set; }

        [InverseProperty("ResourceSystemType")]
        public virtual ICollection<ChannelTemplate> ChannelTemplates { get; private set; }

        [InverseProperty("ResourceSystemType")]
        public virtual ICollection<AgreementSystemParameter> AgreementSystemParameters { get; private set; }

        [InverseProperty("ResourceSystemType")]
        public virtual ICollection<Parameter> Parameters { get; private set; }

        [InverseProperty("ResourceSystemType")]
        public virtual ICollection<ResourceSubsystemType> ResourceSubsystemTypes { get; private set; }
    }
}
