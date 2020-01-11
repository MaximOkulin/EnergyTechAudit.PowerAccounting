using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class UserMessageMapping : EntityTypeConfiguration<UserMessage>
    {
        public UserMessageMapping()
        {
            HasKey(t => t.Id);
            ToTable("UserMessage", "Admin");
        }
    }
}