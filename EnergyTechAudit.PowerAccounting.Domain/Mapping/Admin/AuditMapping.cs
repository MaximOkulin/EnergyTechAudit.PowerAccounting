using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class AuditMapping : EntityTypeConfiguration<Audit>
    {
        public AuditMapping()
        {
            HasKey(t => t.Id);
            
            ToTable("Audit", "Admin");
        }
    }
}