using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class UserAdditionalInfoMapping : EntityTypeConfiguration<UserAdditionalInfo>
    {
        public UserAdditionalInfoMapping()
        {
            HasKey(t => t.Id);
            HasRequired(c => c.User);

            ToTable("UserAdditionalInfo", "Business");
        }
    }
}
