using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class GoogleMapsStyleMapping : EntityTypeConfiguration<GoogleMapsStyle>
    {
        public GoogleMapsStyleMapping()
        {
            HasKey(t => t.Id);

            ToTable("GoogleMapsStyle", "Core");
        }
    }
}
