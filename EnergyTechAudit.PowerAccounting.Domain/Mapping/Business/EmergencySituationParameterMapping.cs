using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class EmergencySituationParameterMapping : EntityTypeConfiguration<EmergencySituationParameter>
    {
        public EmergencySituationParameterMapping()
        {
            HasKey(p => p.Id);

            HasRequired(p => p.SeasonType)
                .WithMany(p => p.EmergencySituationParameters)
                .HasForeignKey(d => d.SeasonTypeId);

            HasRequired(p => p.EmergencySituationParameterTemplate)
                .WithMany(p => p.EmergencySituationParameters)
                .HasForeignKey(d => d.EmergencySituationParameterTemplateId);

            HasRequired(p => p.Channel)
                .WithMany(d => d.EmergencySituationParameters)
                .HasForeignKey(u => u.ChannelId);

            ToTable("EmergencySituationParameter", "Business");
        }
    }
}
