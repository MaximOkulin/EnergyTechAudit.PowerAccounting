using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ParameterDictionaryValueMapping : EntityTypeConfiguration<ParameterDictionaryValue>
    {
        public ParameterDictionaryValueMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.Device)
                .WithMany(t => t.ParameterDictionaryValues)
                .HasForeignKey(u => u.DeviceId);

            HasRequired(t => t.ParameterDictionary)
                .WithMany(t => t.ParameterDictionaryValues)
                .HasForeignKey(u => u.ParameterDictionaryId);

            Property(t => t.Value).HasPrecision(19, 7);

            ToTable("ParameterDictionaryValue", "Dictionaries");
        }
    }
}
