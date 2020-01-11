using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class EmergencyTimeSignatureMapping : EntityTypeConfiguration<EmergencyTimeSignature>
    {
        public EmergencyTimeSignatureMapping()
        {
            HasKey(k => k.Id);

            ToTable("EmergencyTimeSignature", "Business");
        }
    }
}
