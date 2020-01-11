using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class TechnologicAdjunctionTypeMapping : EntityTypeConfiguration<TechnologicAdjunctionType>
    {
        public TechnologicAdjunctionTypeMapping()
        {
            HasKey(c => c.Id);
            ToTable("TechnologicAdjunctionType", "Dictionaries");
        }
    }
}
