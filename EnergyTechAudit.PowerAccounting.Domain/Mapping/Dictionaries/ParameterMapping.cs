using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ParameterMapping : EntityTypeConfiguration<Parameter>
    {
        public ParameterMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.PhysicalParameter)
                .WithMany(t => t.Parameters)
                .HasForeignKey(d => d.PhysicalParameterId);

            HasRequired(t => t.ResourceSystemType)
                .WithMany(t => t.Parameters)
                .HasForeignKey(d => d.ResourceSystemTypeId);

            ToTable("Parameter", "Dictionaries");
        }
    }
}
