using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using System.Data.Entity.ModelConfiguration;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class DeviceTechnicalParameterMapping : EntityTypeConfiguration<DeviceTechnicalParameter>
    {
        public DeviceTechnicalParameterMapping()
        {
            HasKey(t => t.Id);

            ToTable("DeviceTechnicalParameter", "Business");
        }
    }
}
