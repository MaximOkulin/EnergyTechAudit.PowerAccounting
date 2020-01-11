using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin.UserManager;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin.UserManager
{
    public class UserManagerUserAdditionalInfoMapping : EntityTypeConfiguration<UserManagerUserAdditionalInfo>
    {
        public UserManagerUserAdditionalInfoMapping()
        {
            HasKey(t => t.Id);
            
            HasRequired(c => c.UserManagerUser);

            ToTable("UserAdditionalInfo", "Business");            
        }
    }
}