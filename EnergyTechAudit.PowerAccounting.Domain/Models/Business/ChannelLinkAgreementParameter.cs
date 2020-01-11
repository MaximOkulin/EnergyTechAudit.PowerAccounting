using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Связь канал - договорной параметр")]
    public class ChannelLinkAgreementParameter
    {
        [Display(Name = "Ид")]
        [Required]
        public int ChannelId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int AgreementParameterId { get; set; }

        [Display(Name = "Канал")]
        [ForeignKey("ChannelId")]
        public virtual Channel Channel { get; set; }

        [Display(Name = "Договорный параметр")]
        [ForeignKey("AgreementParameterId")]
        public virtual AgreementParameter AgreementParameter { get; set; }
    }
}
