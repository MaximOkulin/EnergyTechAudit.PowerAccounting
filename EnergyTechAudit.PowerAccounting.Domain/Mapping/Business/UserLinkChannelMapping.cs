using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class UserLinkChannelMapping : EntityTypeConfiguration<UserLinkChannel>
    {
        public UserLinkChannelMapping()
        {
            HasKey(k => new
            {
                k.UserId,
                k.ChannelId
            });

            HasRequired(t => t.User)
                .WithMany(t => t.UserLinksChannel)
                .HasForeignKey(d => d.UserId);

            HasRequired(t => t.Channel)
                .WithMany(t => t.UserLinksChannel)
                .HasForeignKey(d => d.ChannelId);

            ToTable("UserLinkChannel", "Business");
        }
    }
}