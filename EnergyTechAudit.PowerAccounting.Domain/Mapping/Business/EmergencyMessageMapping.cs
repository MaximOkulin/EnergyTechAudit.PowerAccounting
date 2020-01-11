using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class EmergencyMessageMapping : EntityTypeConfiguration<EmergencyMessage>
    {
        public EmergencyMessageMapping()
        {
            HasKey(p => p.Id);

            HasRequired(p => p.NotificationType)
                .WithMany(p => p.EmergencyMessages)
                .HasForeignKey(t => t.NotificationTypeId);

            HasRequired(p => p.UserAdditionalInfo)
                .WithMany(p => p.EmergencyMessages)
                .HasForeignKey(t => t.UserAdditionalInfoId);

            HasRequired(p => p.EmergencyLog)
                .WithMany(p => p.EmergencyMessages)
                .HasForeignKey(t => t.EmergencyLogId);

            ToTable("EmergencyMessage", "Business");
        }
    }
}
