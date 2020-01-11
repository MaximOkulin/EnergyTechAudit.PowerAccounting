using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class CommandMenuTemplateMapping : EntityTypeConfiguration<CommandMenuTemplate>
    {
        public CommandMenuTemplateMapping()
        {
            HasKey(t => t.Id);
            ToTable("CommandMenuTemplate", "Core");
        }
    }
}
