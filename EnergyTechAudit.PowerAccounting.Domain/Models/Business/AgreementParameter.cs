using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Договорный параметр"), RequireIncludeDescribablePropertiesEntity]
    public class AgreementParameter : IEntity, IDescribableEntity
    {
        public AgreementParameter()
        {
            ChannelLinksAgreementParameter = new List<ChannelLinkAgreementParameter>();
        }

        public override string ToString()
        {
            return Description;
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Описание")]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = AgreementParameterType.Description;
            });
        }


        [Display(Name = "Ид"), DependencyDescribableProperty, UserInputRequired]
        [Required]
        public int AgreementParameterTypeId { get; set; }

        [Display(Name = "Значение"), UserInputRequired]
        [Required]
        public string Value { get; set; }

        [Display(Name = "Тип договорного параметра"), RequiredDescribableProperty]
        [ForeignKey("AgreementParameterTypeId")]
        public virtual AgreementParameterType AgreementParameterType { get; set; }

        [Display(Name = "Каналы")]
        [InverseProperty("AgreementParameter")]
        public virtual ICollection<ChannelLinkAgreementParameter> ChannelLinksAgreementParameter { get; private set; }
    }
}
