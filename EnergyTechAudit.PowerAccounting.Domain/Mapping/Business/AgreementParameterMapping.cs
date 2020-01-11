using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class AgreementParameterMapping : EntityTypeConfiguration<AgreementParameter>
    {
        public AgreementParameterMapping()
        {
            HasKey(p => p.Id);

            HasRequired(p => p.AgreementParameterType)
                .WithMany(t => t.AgreementParameters)
                .HasForeignKey(d => d.AgreementParameterTypeId);

            ToTable("AgreementParameter", "Business");
        }
    }
}
