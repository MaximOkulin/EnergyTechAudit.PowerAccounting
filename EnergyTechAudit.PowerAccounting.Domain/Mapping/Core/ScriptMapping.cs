using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class ScriptMapping : EntityTypeConfiguration<Script>
    {
        public ScriptMapping()
        {
            HasKey(t => t.Id);

            ToTable("Script", "Core");
        }
    }
}