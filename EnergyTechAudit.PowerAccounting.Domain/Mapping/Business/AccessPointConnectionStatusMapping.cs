using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class AccessPointStatusConnectionLogMapping : EntityTypeConfiguration<AccessPointStatusConnectionLog>
    {
        public AccessPointStatusConnectionLogMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.StatusConnection)
                .WithMany(t => t.AccessPointStatusConnectionLogs)
                .HasForeignKey(d => d.StatusConnectionId);

            HasRequired(t => t.AccessPoint)
                .WithMany(t => t.AccessPointStatusConnectionLogs)
                .HasForeignKey(d => d.AccessPointId);

            ToTable("AccessPointStatusConnectionLog", "Business");
        }
    }
}
