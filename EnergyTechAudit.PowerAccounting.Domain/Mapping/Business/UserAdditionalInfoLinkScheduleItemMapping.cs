using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using System.Data.Entity.ModelConfiguration;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class UserAdditionalInfoLinkScheduleItemMapping : EntityTypeConfiguration<UserAdditionalInfoLinkScheduleItem>
    {
        public UserAdditionalInfoLinkScheduleItemMapping()
        {
            HasKey(k => new
            {
                k.UserAdditionalInfoId,
                k.ScheduleItemId
            });

            HasRequired(t => t.UserAdditionalInfo)
                .WithMany(t => t.UserAdditionalInfoLinksScheduleItem)
                .HasForeignKey(d => d.UserAdditionalInfoId);

            HasRequired(t => t.ScheduleItem)
                .WithMany(t => t.UserAdditionalInfoLinksScheduleItem)
                .HasForeignKey(d => d.ScheduleItemId);

            ToTable("UserAdditionalInfoLinkScheduleItem", "Business");
        }
    }
}
