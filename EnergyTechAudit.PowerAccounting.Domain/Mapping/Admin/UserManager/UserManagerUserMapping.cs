using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin.UserManager;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin.UserManager
{
    public class UserManagerUserMapping : EntityTypeConfiguration<UserManagerUser>
    {
        public UserManagerUserMapping()
        {
            HasKey(t => t.Id);
                                    
            HasRequired(t => t.Role)
                .WithMany(t => t.Users)
                .HasForeignKey(d => d.RoleId);

            ToTable("User", "Admin");
        }
    }
}
