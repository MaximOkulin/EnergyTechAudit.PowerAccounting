using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class NotificationTypeMapping : EntityTypeConfiguration<NotificationType>
    {
        public NotificationTypeMapping()
        {
            HasKey(p => p.Id);

            ToTable("NotificationType", "Dictionaries");
        }
    }
}
