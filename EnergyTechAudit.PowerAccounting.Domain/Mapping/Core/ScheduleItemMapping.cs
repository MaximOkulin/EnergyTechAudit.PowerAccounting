using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class ScheduleItemMapping : EntityTypeConfiguration<ScheduleItem>
    {
        public ScheduleItemMapping()
        {
            HasKey(p => p.Id);

            ToTable("ScheduleItem", "Core");
        }
    }
}