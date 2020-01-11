using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class MeasurementUnitMapping : EntityTypeConfiguration<MeasurementUnit>
    {
        public MeasurementUnitMapping()
        {
            HasKey(t => t.Id);
            HasRequired(t => t.PhysicalParameter)
                .WithMany(t => t.MeasurementUnits)
                .HasForeignKey(d => d.PhysicalParameterId);

            ToTable("MeasurementUnit", "Dictionaries");
        }
    }
}
