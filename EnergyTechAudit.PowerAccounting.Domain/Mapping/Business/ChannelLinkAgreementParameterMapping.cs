using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class ChannelLinkAgreementParameterMapping : EntityTypeConfiguration<ChannelLinkAgreementParameter>
    {
        public ChannelLinkAgreementParameterMapping()
        {
            HasKey(k => new
            {
                k.ChannelId,
                k.AgreementParameterId
            });

            HasRequired(t => t.Channel)
                .WithMany(t => t.ChannelLinksAgreementParameter)
                .HasForeignKey(d => d.ChannelId);

            HasRequired(t => t.AgreementParameter)
                .WithMany(t => t.ChannelLinksAgreementParameter)
                .HasForeignKey(d => d.AgreementParameterId);

            ToTable("ChannelLinkAgreementParameter", "Business");
        }
    }
}
