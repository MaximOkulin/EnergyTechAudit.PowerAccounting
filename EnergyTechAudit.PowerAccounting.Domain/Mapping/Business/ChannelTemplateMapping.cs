using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class ChannelTemplateMapping : EntityTypeConfiguration<ChannelTemplate>
    {
        public ChannelTemplateMapping()
        {
            HasKey(t => t.Id);

            ToTable("ChannelTemplate", "Business");
        }
    }
}
