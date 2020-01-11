using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class CityMapping : EntityTypeConfiguration<City>
    {
        public CityMapping()
        {
            HasKey(t => t.Id);
            ToTable("City", "Dictionaries");
        }
    }
}
