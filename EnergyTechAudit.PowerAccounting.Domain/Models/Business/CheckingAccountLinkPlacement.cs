using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Связь расчетный счет - помещение")]
    public class CheckingAccountLinkPlacement
    {

        [Display(Name = "Ид")]
        public int CheckingAccountId { get; set; }

        [Display(Name = "Ид")]
        public int PlacementId { get; set; }

        [Display(Name = "Расчетный счет")]
        [ForeignKey("CheckingAccountId")]
        public virtual CheckingAccount CheckingAccount { get; set; }

        [Display(Name = "Помещение")]
        [ForeignKey("PlacementId")]
        public virtual Placement Placement { get; set; }
    }
}