using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class TransportServerModelMapping : EntityTypeConfiguration<TransportServerModel>
    {
        public TransportServerModelMapping()
        {
            HasKey(t => t.Id);

            ToTable("TransportServerModel", "Dictionaries");
        }
    }
}
