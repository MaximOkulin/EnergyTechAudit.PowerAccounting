using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class RegulatorParameterValueMapping : EntityTypeConfiguration<RegulatorParameterValue>
    {
        public RegulatorParameterValueMapping()
        {
            HasKey(t => t.Id);
            
            HasRequired(t => t.MeasurementDevice)
                .WithMany(t => t.RegulatorParameterValues)
                .HasForeignKey(u => u.MeasurementDeviceId);

            Property(x => x.DeviceValue).HasPrecision(9, 3);
            Property(x => x.UserValue).HasPrecision(9, 3);

            ToTable("RegulatorParameterValue", "Business");
        }
    }
}
