using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class PeriodTypeMapping : EntityTypeConfiguration<PeriodType>
    {
        public PeriodTypeMapping()
        {
            HasKey(t => t.Id);

            ToTable("PeriodType", "Dictionaries");
        }
    }
}
