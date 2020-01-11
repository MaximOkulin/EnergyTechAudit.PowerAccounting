using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class MetaObjectReferenceMeasurementDeviceMapping : EntityTypeConfiguration<MetaObjectReferenceMeasurementDevice>
    {
        public MetaObjectReferenceMeasurementDeviceMapping()
        {
            HasKey(t => t.Id);
            HasRequired(c => c.MetaObject);

            ToTable("MetaObjectReferenceMeasurementDevice", "Core");
        }
    }
}
