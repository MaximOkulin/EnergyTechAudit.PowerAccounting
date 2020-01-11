using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class StatusConnectionMapping : EntityTypeConfiguration<StatusConnection>
    {
        public StatusConnectionMapping()
        {
            HasKey(t => t.Id);
            
            Property(c => c.Code)
                .IsRequired()
                .HasMaxLength(16);

            Property(c => c.Description)
                .HasMaxLength(128);
            
            ToTable("StatusConnection", "Dictionaries");            
        }
    }
}
