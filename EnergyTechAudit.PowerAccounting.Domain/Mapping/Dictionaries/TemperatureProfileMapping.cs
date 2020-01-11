using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class TemperatureProfileMapping : EntityTypeConfiguration<TemperatureProfile>
    {
        public TemperatureProfileMapping()
        {
            HasKey(c => c.Id);
            ToTable("TemperatureProfile", "Dictionaries");
        }
    }
}
