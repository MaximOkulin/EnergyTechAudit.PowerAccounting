using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ScheduleTypeMapping : EntityTypeConfiguration<ScheduleType>
    {
        public ScheduleTypeMapping()
        {
            HasKey(t => t.Id);
            ToTable("ScheduleType", "Dictionaries");
        }
    }
}