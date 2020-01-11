using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    public abstract class LinkRoleBase
    {
        [Display(Name = "Ид")]
        public int RoleId { get; set; } 
        
        [Display(Name = "Роль")]
        [ForeignKey("RoleId")]
        public virtual Role Role { get; set; }
    }
}