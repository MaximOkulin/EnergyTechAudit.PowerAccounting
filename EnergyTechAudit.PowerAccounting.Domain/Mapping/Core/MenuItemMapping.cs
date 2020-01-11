using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class MenuItemMapping: EntityTypeConfiguration<MenuItem>
    {
        public MenuItemMapping()
        {
            HasKey(t => t.Id);
            ToTable("MenuItem", "Core");
        }
    }
}
