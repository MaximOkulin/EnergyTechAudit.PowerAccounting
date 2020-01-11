using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin.UserManager;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin.UserManager
{
    public class UserManagerRoleMapping : EntityTypeConfiguration<UserManagerRole>
    {
        public UserManagerRoleMapping()
        {
            HasKey(t => t.Id);
            ToTable("Role", "Admin");
        }
    }
}
