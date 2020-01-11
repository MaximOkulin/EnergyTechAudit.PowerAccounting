using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.WebApi;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.WebApi
{
    public class ArchiveDownloaderLinkScheduleItemMapping : EntityTypeConfiguration<ArchiveDownloaderLinkScheduleItem>
    {
        public ArchiveDownloaderLinkScheduleItemMapping()
        {
            HasKey(k => new
            {
                k.ArchiveDownloaderId,
                k.ScheduleItemId
            });

            HasRequired(t => t.ArchiveDownloader)
                .WithMany(t => t.ArchiveDownloaderLinksScheduleItem)
                .HasForeignKey(d => d.ArchiveDownloaderId);

            HasRequired(t => t.ScheduleItem)
                .WithMany(t => t.ArchiveDownloaderLinksScheduleItem)
                .HasForeignKey(d => d.ScheduleItemId);

            ToTable("ArchiveDownloaderLinkScheduleItem", "WebApi");
        }
    }
}