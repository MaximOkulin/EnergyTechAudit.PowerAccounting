using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class SeasonTypeMapping : EntityTypeConfiguration<SeasonType>
    {
        public SeasonTypeMapping()
        {
            HasKey(p => p.Id);

            ToTable("SeasonType", "Dictionaries");
        }
    }
}
