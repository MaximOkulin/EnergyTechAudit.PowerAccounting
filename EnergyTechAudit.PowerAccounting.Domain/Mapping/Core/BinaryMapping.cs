using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class BinaryMapping : EntityTypeConfiguration<Binary>
    {
        public BinaryMapping()
        {
            HasKey(t => t.Id);
            ToTable("Binary", "Core");
        }
    }
}
