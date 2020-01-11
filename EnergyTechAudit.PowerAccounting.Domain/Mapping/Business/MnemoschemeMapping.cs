using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class MnemoschemeMapping: EntityTypeConfiguration<Mnemoscheme>
    {
        public MnemoschemeMapping() 
        {
            HasKey(t => t.Id);

            ToTable("Mnemoscheme", "Business");
        }     
    }
}