using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class DeviceParameterSettingMapping : EntityTypeConfiguration<DeviceParameterSetting>
    {
        public DeviceParameterSettingMapping()
        {
            HasKey(t => t.Id);

            HasRequired(c => c.DeviceParameter);

            Property(x => x.Max).HasPrecision(9, 3);
            Property(x => x.Min).HasPrecision(9, 3);

            ToTable("DeviceParameterSetting", "Business");
        }
    }
}
