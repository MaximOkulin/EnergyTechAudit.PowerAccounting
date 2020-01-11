using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class UserLinkEmergencyNotificationTypeMapping : EntityTypeConfiguration<UserLinkEmergencyNotificationType>
    {
        public UserLinkEmergencyNotificationTypeMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.EmergencySituationParameter)
                .WithMany(d => d.UserLinkEmergencyNotificationTypes)
                .HasForeignKey(u => u.EmergencySituationParameterId);

            HasRequired(k => k.UserAdditionalInfo)
                .WithMany(s => s.UserLinkEmergencyNotificationTypes)
                .HasForeignKey(u => u.UserAdditionalInfoId);

            HasRequired(r => r.NotificationType)
                .WithMany(t => t.UserLinkEmergencyNotificationTypes)
                .HasForeignKey(l => l.NotificationTypeId);

            ToTable("UserLinkEmergencyNotificationType", "Business");
        }
    }
}
