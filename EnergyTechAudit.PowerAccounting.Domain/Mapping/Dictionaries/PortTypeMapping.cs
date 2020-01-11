using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class PortTypeMapping : EntityTypeConfiguration<PortType>
    {
        public PortTypeMapping()
        {
            HasKey(t => t.Id);

            ToTable("PortType", "Dictionaries");
        }
    }
}
