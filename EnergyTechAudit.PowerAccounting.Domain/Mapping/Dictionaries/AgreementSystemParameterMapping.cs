using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class AgreementSystemParameterMapping : EntityTypeConfiguration<AgreementSystemParameter>
    {
        public AgreementSystemParameterMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.PhysicalParameter)
                .WithMany(t => t.AgreementSystemParameters)
                .HasForeignKey(d => d.PhysicalParameterId);

            HasRequired(t => t.ResourceSystemType)
                .WithMany(t => t.AgreementSystemParameters)
                .HasForeignKey(d => d.ResourceSystemTypeId);

            ToTable("AgreementSystemParameter", "Dictionaries");
        }
    }
}
