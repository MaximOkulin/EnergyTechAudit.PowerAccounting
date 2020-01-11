using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin.UserManager
{
    [Table("Role", Schema = "Admin")]
    public class UserManagerRole : IEntity
    {
        public int Id { get; set; }

        public string Code { get; set; }

        public string StartupRoute { get; set; }

        public string MobileDeviceStartupRoute { get; set; }

        [InverseProperty("Role")]
        public virtual ICollection<UserManagerUser> Users { get; set; }
    }
}
