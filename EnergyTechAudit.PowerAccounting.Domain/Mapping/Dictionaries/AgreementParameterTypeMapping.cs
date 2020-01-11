using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class AgreementParameterTypeMapping : EntityTypeConfiguration<AgreementParameterType>
    {
        public AgreementParameterTypeMapping()
        {
            HasKey(t => t.Id);
            ToTable("AgreementParameterType", "Dictionaries");
        }
    }
}
