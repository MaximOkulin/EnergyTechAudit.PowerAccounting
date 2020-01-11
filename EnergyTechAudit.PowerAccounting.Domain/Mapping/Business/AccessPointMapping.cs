using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class AccessPointMapping : EntityTypeConfiguration<AccessPoint>
    {
        public AccessPointMapping()
        {
            HasKey(t => t.Id);
            ToTable("AccessPoint", "Business");
        }

        
    }
}
