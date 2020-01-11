using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ProtocolSubTypeMapping : EntityTypeConfiguration<ProtocolSubType>
    {
        public ProtocolSubTypeMapping()
        {
            HasKey(t => t.Id);
            ToTable("ProtocolSubType", "Dictionaries");
        }
    }
}
