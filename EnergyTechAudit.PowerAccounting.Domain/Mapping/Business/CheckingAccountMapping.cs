using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class CheckingAccountMapping : EntityTypeConfiguration<CheckingAccount>
    {
        public CheckingAccountMapping()
        {
            HasKey(t => t.Id);
            ToTable("CheckingAccount", "Business");
        }
    }
}