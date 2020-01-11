using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class ChannelMapping : EntityTypeConfiguration<Channel>
    {
        public ChannelMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.ResourceSystemType)
                .WithMany(t => t.Channels)
                .HasForeignKey(d => d.ResourceSystemTypeId);

            HasRequired(t => t.TechnologicAdjunctionType)
                .WithMany(t => t.Channels)
                .HasForeignKey(d => d.TechnologicAdjunctionTypeId);

            ToTable("Channel", "Business");
        }
    }
}
