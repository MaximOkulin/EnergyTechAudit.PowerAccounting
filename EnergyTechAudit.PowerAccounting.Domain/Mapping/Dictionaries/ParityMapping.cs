using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ParityMapping : EntityTypeConfiguration<Parity>
    {
        public ParityMapping()
        {
            HasKey(t => t.Id);
            ToTable("Parity", "Dictionaries");
        }
    }
}