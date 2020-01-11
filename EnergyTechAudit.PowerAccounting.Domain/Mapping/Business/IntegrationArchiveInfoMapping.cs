using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using System.Data.Entity.ModelConfiguration;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class IntegrationArchiveInfoMapping : EntityTypeConfiguration<IntegrationArchiveInfo>
    {
        public IntegrationArchiveInfoMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.MeasurementDevice)
                .WithMany(t => t.IntegrationArchiveInfos)
                .HasForeignKey(d => d.MeasurementDeviceId);

            HasRequired(t => t.PeriodType)
                .WithMany(t => t.IntegrationArchiveInfos)
                .HasForeignKey(d => d.PeriodTypeId);

            HasRequired(t => t.DiffDeviceParameter)
                .WithMany(t => t.IntegrationArchiveInfos)
                .HasForeignKey(d => d.DiffDeviceParameterId);

            ToTable("IntegrationArchiveInfo", "Business");
        }
    }
}
