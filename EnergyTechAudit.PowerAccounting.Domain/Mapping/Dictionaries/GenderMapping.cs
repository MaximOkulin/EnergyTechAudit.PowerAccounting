using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class GenderMapping : EntityTypeConfiguration<Gender>
    {
        public GenderMapping()
        {
            HasKey(t => t.Id);
            ToTable("Gender", "Dictionaries");
        }
    }
}