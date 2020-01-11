using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class UserMapping: EntityTypeConfiguration<User>
    {
        public UserMapping()
        {
            HasKey(t => t.Id);
                                    
            HasRequired(t => t.Role)
                .WithMany(t => t.Users)
                .HasForeignKey(d => d.RoleId);

            ToTable("User", "Admin");
        }
    }
}
