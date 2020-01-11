using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.WebApi;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.WebApi
{
    public class ActionRequestStatisticItemMapping : EntityTypeConfiguration<ActionRequestStatisticItem>
    {
        public ActionRequestStatisticItemMapping()
        {
            HasKey(t => t.Id);

            ToTable("ActionRequestStatisticItem", "WebApi");
        }
    }
}