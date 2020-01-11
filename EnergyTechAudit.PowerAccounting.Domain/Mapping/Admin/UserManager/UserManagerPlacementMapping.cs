using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin.UserManager;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin.UserManager
{
    public class UserManagerPlacementMapping : EntityTypeConfiguration<UserManagerPlacement>
    {
        public UserManagerPlacementMapping()
        {
            HasKey(t => t.Id);

            ToTable("Placement", "Business");
        }
    }
}