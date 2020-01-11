using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class PhysicalParameterMapping : EntityTypeConfiguration<PhysicalParameter>
    {
        public PhysicalParameterMapping()
        {
            HasKey(t => t.Id);
            ToTable("PhysicalParameter", "Dictionaries");
        }
    }
}
