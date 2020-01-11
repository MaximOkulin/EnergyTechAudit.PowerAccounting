using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class MnemoschemeTypeMapping : EntityTypeConfiguration<MnemoschemeType>
    {
        public MnemoschemeTypeMapping()
        {
            HasKey(t => t.Id);
            ToTable("MnemoschemeType", "Dictionaries");
        }
    }
}
