using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin.UserManager
{
    /// <summary>
    /// Сущность "Дополнительная информация о пользователе" (для собственников квартир)
    /// </summary>
    
    public class UserManagerUserAdditionalInfo : IEntity
    {
                
        [Key]
        public int Id { get; set; }       
        
        [ForeignKey("Id")]
        public virtual UserManagerUser UserManagerUser { get; set; }

        [InverseProperty("UserManagerUserAdditionalInfo")]
        public virtual ICollection<UserManagerPlacement> UserManagerPlacements { get; set; }
        
    }
}
