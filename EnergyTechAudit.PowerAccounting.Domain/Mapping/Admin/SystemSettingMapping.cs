using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class SystemSettingMapping : EntityTypeConfiguration<SystemSetting>
    {
        public SystemSettingMapping()
        {
            HasKey(t => t.Id);
            ToTable("SystemSetting", "Admin");
        }
    }
}