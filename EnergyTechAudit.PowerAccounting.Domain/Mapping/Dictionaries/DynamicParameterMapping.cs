using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class DynamicParameterMapping : EntityTypeConfiguration<DynamicParameter>
    {
        public DynamicParameterMapping()
        {
            HasKey(c => c.Id);
            ToTable("DynamicParameter", "Dictionaries");
        }
    }
}
