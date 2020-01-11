using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class MapInfoWindowMapping : EntityTypeConfiguration<MapInfoWindow>
    {
        public MapInfoWindowMapping()
        {
            HasKey(t => t.Id);

            ToTable("MapInfoWindow", "Core");
        }
    }
}
