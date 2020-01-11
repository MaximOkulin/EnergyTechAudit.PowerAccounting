using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Help;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Help
{
    public class PictureMapping : EntityTypeConfiguration<Picture>
    {
        public PictureMapping()
        {
            HasKey(t => t.Id);

            ToTable("Picture", "Help");
        }
    }
}