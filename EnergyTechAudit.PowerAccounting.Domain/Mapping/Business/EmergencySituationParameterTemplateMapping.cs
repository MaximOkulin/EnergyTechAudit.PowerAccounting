using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class EmergencySituationParameterTemplateMapping : EntityTypeConfiguration<EmergencySituationParameterTemplate>
    {
        public EmergencySituationParameterTemplateMapping()
        {
            HasKey(p => p.Id);

            ToTable("EmergencySituationParameterTemplate", "Business");
        }
    }
}
