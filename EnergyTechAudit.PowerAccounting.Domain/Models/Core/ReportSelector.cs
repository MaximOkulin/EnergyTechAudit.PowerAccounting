using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    
    public class ReportSelector: IPredicateExpressionMedium, IReportSelector
    {
        public int SelectorReportId { get; set; }
        
        /// <summary>
        /// Ид целевого отчета, который должен быть выбран в результате обработке условия селектора
        /// </summary>
        [Key]
        public int TargetReportId { get; set; }

        /// <summary>
        /// Выражение, которые должно быть обработано на основе параметрии отчетов.
        /// Положительный результат обработки означает необходимоть выбора целевого отчета
        /// </summary>
        public string PredicateExpression { get; set; }

        /// <summary>
        /// Отчет-селектор
        /// </summary>
        [ForeignKey("SelectorReportId")]
        public virtual Report SelectorReport { get; set; }

        /// <summary>
        /// Целевой отчет, который должен быть выбран в результате обработке условия селектора
        /// </summary>
        [ForeignKey("TargetReportId")]
        public virtual Report TargetReport { get; set; }
    }
}
