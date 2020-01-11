using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ComPortMapping : EntityTypeConfiguration<ComPort>
    {
        public ComPortMapping()
        {
            HasKey(t => t.Id);
            ToTable("ComPort", "Dictionaries");
        }
    }
}
