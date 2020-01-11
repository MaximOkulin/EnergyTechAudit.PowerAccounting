using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class FaqMapping : EntityTypeConfiguration<Faq>
    {
        public FaqMapping()
        {
            HasKey(t => t.Id);
            ToTable("Faq", "Admin");
        }
    }
}