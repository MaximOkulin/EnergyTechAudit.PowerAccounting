using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class MenuMapping : EntityTypeConfiguration<Menu>
    {
        public MenuMapping()
        {
            HasKey(t => t.Id);
            
            HasMany(e => e.MenuItems)
                .WithRequired(e => e.Menu)
                .WillCascadeOnDelete(false);

            ToTable("Menu", "Core");
        }
    }
}
