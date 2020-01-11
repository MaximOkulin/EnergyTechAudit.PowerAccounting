using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Help;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Help
{
    public class ArticleMapping : EntityTypeConfiguration<Article>
    {
        public ArticleMapping()
        {
            HasKey(t => t.Id);
               
            ToTable("Article", "Help");
        }
    }
}
