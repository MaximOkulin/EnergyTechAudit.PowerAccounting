using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.WebApi;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.WebApi
{
    public class ArchiveDownloaderMapping : EntityTypeConfiguration<ArchiveDownloader>
    {
        public ArchiveDownloaderMapping()
        {
            HasKey(t => t.Id);
            HasRequired(c => c.User);

            ToTable("ArchiveDownloader", "WebApi");
        }
    }
}