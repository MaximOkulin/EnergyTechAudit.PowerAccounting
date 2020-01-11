using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin.UserManager
{
    /// <summary>
    /// Сущность "Помещение" (квартира, подвал, склад и т.д.)
    /// </summary>    
    public class UserManagerPlacement : IEntity
    {
        public int Id { get; set; }
        
        public int? UserAdditionalInfoId { get; set; }
        
        [ForeignKey("UserAdditionalInfoId")]
        public virtual UserManagerUserAdditionalInfo UserManagerUserAdditionalInfo { get; set; }
    }
}
