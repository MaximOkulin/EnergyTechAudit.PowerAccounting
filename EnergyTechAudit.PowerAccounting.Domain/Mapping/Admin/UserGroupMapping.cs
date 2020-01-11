using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class UserGroupMapping : EntityTypeConfiguration<UserGroup>
    {
        public UserGroupMapping()
        {
            HasKey(t => t.Id);
            ToTable("UserGroup", "Admin");
        }
    }
}