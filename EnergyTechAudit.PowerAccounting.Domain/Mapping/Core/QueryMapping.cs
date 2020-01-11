using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class QueryMapping : EntityTypeConfiguration<Query>
    {
        public QueryMapping()
        {
            HasKey(t => t.Id);

            ToTable("Query", "Core");
        }
    }
}
