using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Rules;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Rules
{
    public class MeasurementUnitConverterMapping : EntityTypeConfiguration<MeasurementUnitConverter>
    {
        public MeasurementUnitConverterMapping()
        {
            HasKey(t => t.Id);

            ToTable("MeasurementUnitConverter", "Rules");
        }
    }
}