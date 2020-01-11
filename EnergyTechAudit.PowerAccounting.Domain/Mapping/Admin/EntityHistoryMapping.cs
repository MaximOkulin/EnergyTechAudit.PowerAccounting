using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class EntityHistoryMapping : EntityTypeConfiguration<EntityHistory>
    {
        public EntityHistoryMapping()
        {
            HasKey(t => t.Id);

            Property(c => c.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

            ToTable("EntityHistory", "Admin");
        }
    }
}