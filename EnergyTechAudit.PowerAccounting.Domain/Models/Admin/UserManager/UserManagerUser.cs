using System;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin.UserManager
{
     
    public class UserManagerUser : IEntity
    {        
        public int Id { get; set; }

        public string UserName { get; set; }

        public string Password { get; set; }

        public byte[] EncryptedPassword { get; set; }
        
        public string Email { get; set; }
       
        public DateTime CreateDate { get; set; }

        public DateTime ExpiredDate { get; set; }

        public bool IsApproved { get; set; }

        public bool IsTemporary { get; set; }

        public int RoleId { get; set; }
        
        [ForeignKey("RoleId")]
        public UserManagerRole Role { get; set; }
        
        [InverseProperty("UserManagerUser")]
        public virtual UserManagerUserAdditionalInfo UserManagerUserAdditionalInfo { get; set; }
        
    }
}