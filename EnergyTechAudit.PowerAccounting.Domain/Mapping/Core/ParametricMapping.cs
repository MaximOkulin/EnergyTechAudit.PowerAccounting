using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class ParametricMapping : EntityTypeConfiguration<Parametric>
    {
        public ParametricMapping()
        {
            HasKey(t => t.Id);

            ToTable("Parametric", "Core");
        }
    }
}
