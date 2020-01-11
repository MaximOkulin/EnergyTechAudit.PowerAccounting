using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ParameterDictionaryMapping : EntityTypeConfiguration<ParameterDictionary>
    {
        public ParameterDictionaryMapping()
        {
            HasKey(t => t.Id);

            ToTable("ParameterDictionary", "Dictionaries");
        }
    }
}
