using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{

    public class AlertMapping : EntityTypeConfiguration<Alert>
    {
        public AlertMapping()
        {
            HasKey(t => t.Id);
            ToTable("Alert", "Admin");
        }
    }
}
