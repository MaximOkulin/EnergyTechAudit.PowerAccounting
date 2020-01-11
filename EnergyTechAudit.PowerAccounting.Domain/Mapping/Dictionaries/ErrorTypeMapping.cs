using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ErrorTypeMapping : EntityTypeConfiguration<ErrorType>
    {
        public ErrorTypeMapping()
        {
            HasKey(t => t.Id);
            ToTable("ErrorType", "Dictionaries");
        }
    }
}
