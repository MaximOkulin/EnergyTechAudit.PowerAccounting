using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    public class ReportPluginSelector : IEntity, IPredicateExpressionMedium, IReportSelector
    {
        [Key]
        public int Id { get; set; }
        
        [Required]
        public int ReportId { get; set; }
        
        [Required]
        public string PredicateExpression { get; set; }

        public string TypeName { get; set; }

        [ForeignKey("ReportId")]
        public virtual Report Report { get; set; }
    }
}
