using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Связь метаобъект - роль")]
    public class MetaObjectLinkRole
    {

        [Display(Name = "Ид")]
        public int MetaObjectId { get; set; }

        [Display(Name = "Ид")]
        public int RoleId { get; set; }

        [Display(Name = "Метаобъект")]
        [ForeignKey("MetaObjectId")]
        public virtual MetaObject MetaObject { get; set; }

        [Display(Name = "Роль")]
        [ForeignKey("RoleId")]
        public virtual Role Role { get; set; }
    }
}