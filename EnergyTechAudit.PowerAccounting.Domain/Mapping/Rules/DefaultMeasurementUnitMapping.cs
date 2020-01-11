using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Rules;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Rules
{
    public class DefaultMeasurementUnitMapping : EntityTypeConfiguration<DefaultMeasurementUnit>
    {
        public DefaultMeasurementUnitMapping()
        {
            HasKey(t => t.Id);

            ToTable("DefaultMeasurementUnit", "Rules");
        }
    }
}