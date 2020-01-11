using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Связь дерево - роль")]
    public class EntityTreeLinkRole
    {

        [Display(Name = "Ид")]
        public int EntityTreeId { get; set; }

        [Display(Name = "Ид")]
        public int RoleId { get; set; }

        [Display(Name = "Дерево сущностей")]
        [ForeignKey("EntityTreeId")]
        public virtual EntityTree EntityTree { get; set; }

        [Display(Name = "Измерительное устройство")]
        [ForeignKey("RoleId")]
        public virtual Role Role { get; set; }
    }
}