using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class DataBitMapping : EntityTypeConfiguration<DataBit>
    {
        public DataBitMapping()
        {
            HasKey(t => t.Id);
            ToTable("DataBit", "Dictionaries");
        }
    }
}
