using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class SubsystemTypeMapping : EntityTypeConfiguration<SubsystemType>
    {
        public SubsystemTypeMapping()
        {
            HasKey(c => c.Id);

            ToTable("SubsystemType", "Dictionaries");
        }
    }
}
