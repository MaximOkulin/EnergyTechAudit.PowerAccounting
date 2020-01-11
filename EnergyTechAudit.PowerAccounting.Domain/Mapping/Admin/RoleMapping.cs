using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{

    public class RoleMapping : EntityTypeConfiguration<Role>
    {
        public RoleMapping()
        {
            HasKey(t => t.Id);
            ToTable("Role", "Admin");
        }
    }
}
