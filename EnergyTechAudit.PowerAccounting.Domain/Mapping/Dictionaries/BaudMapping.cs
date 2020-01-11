using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class BaudMapping : EntityTypeConfiguration<Baud>
    {
        public BaudMapping()
        {
            HasKey(t => t.Id);
            ToTable("Baud", "Dictionaries");
        }
    }
}
