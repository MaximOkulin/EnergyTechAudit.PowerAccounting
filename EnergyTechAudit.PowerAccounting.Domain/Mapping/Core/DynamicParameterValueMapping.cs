using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class DynamicParameterValueMapping : EntityTypeConfiguration<DynamicParameterValue>
    {
        public DynamicParameterValueMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.DynamicParameter)
                .WithMany(t => t.DynamicParameterValues)
                .HasForeignKey(u => u.DynamicParameterId);

            ToTable("DynamicParameterValue", "Core");
        }
    }
}
