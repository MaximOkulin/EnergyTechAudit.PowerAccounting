using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class EmergencyLogMapping : EntityTypeConfiguration<EmergencyLog>
    {
        public EmergencyLogMapping()
        {
            HasKey(p => p.Id);

            HasRequired(p => p.EmergencySituationParameter)
                .WithMany(p => p.EmergencyLogs)
                .HasForeignKey(t => t.EmergencySituationParameterId);

            HasRequired(p => p.EmergencyTimeSignature)
                .WithMany(p => p.EmergencyLogs)
                .HasForeignKey(t => t.EmergencyTimeSignatureId);

            ToTable("EmergencyLog", "Business");
        }
    }
}
