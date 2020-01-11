using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class PivotDiagrammMapping : EntityTypeConfiguration<PivotDiagramm>
    {
        public PivotDiagrammMapping()
        {
            HasKey(t => t.Id);

            ToTable("PivotDiagramm", "Core");
        }
    }
}
