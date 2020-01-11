using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class BinaryContentTypeMapping : EntityTypeConfiguration<BinaryContentType>
    {
        public BinaryContentTypeMapping()
        {
            HasKey(t => t.Id);
            ToTable("BinaryContentType", "Dictionaries");
        }
    }
}
