using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class FormMapping : EntityTypeConfiguration<Form>
    {
        public FormMapping()
        {
            HasKey(t => t.Id);

            ToTable("Form", "Core");
        }
    }
}
