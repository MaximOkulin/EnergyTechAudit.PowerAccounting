using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class DiagrammMapping : EntityTypeConfiguration<Diagramm>
    {
        public DiagrammMapping()
        {
            HasKey(t => t.Id);

            ToTable("Diagramm", "Core");
        }
    }
}