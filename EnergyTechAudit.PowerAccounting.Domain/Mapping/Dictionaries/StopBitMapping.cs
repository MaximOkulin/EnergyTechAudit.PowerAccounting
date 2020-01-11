using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class StopBitMapping : EntityTypeConfiguration<StopBit>
    {
        public StopBitMapping()
        {
            HasKey(t => t.Id);
            ToTable("StopBit", "Dictionaries");
        }
    }
}

