using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class ErrorLogEntryMapping:EntityTypeConfiguration<ErrorLogEntry>
    {
        public ErrorLogEntryMapping()
        {
            HasKey(t => t.Id);            

            ToTable("ErrorLogEntry", "Admin");
        }
    }
}
