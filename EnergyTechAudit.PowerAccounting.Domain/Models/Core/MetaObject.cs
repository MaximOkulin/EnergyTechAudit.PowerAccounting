using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics.CodeAnalysis;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Метаобъект")]
    public class MetaObject
    {
        [SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public MetaObject()
        {
            MenuItems = new HashSet<MenuItem>();
            MetaObjectLinksRole = new List<MetaObjectLinkRole>();
            MetaObjectLinksDevice = new List<MetaObjectLinkDevice>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        public int MetaObjectTypeId { get; set; }

        [Display(Name = "Ид")]
        public int? DictionaryId { get; set; }

        [Display(Name = "Ид")]
        public int? PivotId { get; set; }

        [Display(Name = "Ид")]
        public int? ReportId { get; set; }

        [Display(Name = "Ид")]
        public int? QueryId { get; set; }

        [Display(Name = "Ид")]
        public int? FormId { get; set; }

        [Display(Name = "Ид")]
        public int? PivotDiagrammId { get; set; }

        [Display(Name = "Ид")]
        public int? ProcessingId { get; set; }

        [Display(Name = "Ид")]
        public int? DiagrammId { get; set; }
        
        [Display(Name = "Ид")]
        public int?  ParametricId { get; set; }

        [Display(Name = "Ид")]
        public int? SourceId { get; set; }

        public bool IsNotInlineParametric { get; set; }

        [ForeignKey("DictionaryId")]
        [Display(Name = "Словарь")]
        public virtual Dictionary Dictionary { get; set; }

        [ForeignKey("QueryId")]
        [Display(Name = "Запроса")]
        public virtual Query Query { get; set; }

        [ForeignKey("PivotId")]
        [Display(Name = "Сводная таблица")]
        public virtual Pivot Pivot { get; set; }

        [ForeignKey("ReportId")]
        [Display(Name = "Отчет")]
        public virtual Report Report { get; set; }
        
        [ForeignKey("FormId")]
        [Display(Name = "Конструктор")]
        public virtual Form Form { get; set; }

        [ForeignKey("PivotDiagrammId")]
        [Display(Name = "Сводная диаграмма")]
        public virtual PivotDiagramm Chart { get; set; }

        [ForeignKey("ProcessingId")]
        [Display(Name = "Задача")]
        public virtual Processing Processing { get; set; }

        [ForeignKey("DiagrammId")]
        [Display(Name = "Диаграмм")]
        public virtual Diagramm Diagramm { get; set; }

        [Display(Name = "Тип")]
        public virtual MetaObjectType MetaObjectType { get; set; }
        
        [JsonIgnore]
        [ForeignKey("ParametricId")]
        public virtual Parametric Parametric { get; set; }

        [JsonIgnore]
        [ForeignKey("SourceId")]
        public virtual Source Source { get; set; }

        public virtual ICollection<MenuItem> MenuItems { get; set; }
        
        [JsonIgnore]
        [Display(Name = "Роли")]
        [InverseProperty("MetaObject")]
        public virtual ICollection<MetaObjectLinkRole> MetaObjectLinksRole { get; private set; }

        [JsonIgnore]
        [Display(Name = "Модели измерительных устройств")]
        [InverseProperty("MetaObject")]
        public virtual ICollection<MetaObjectLinkDevice> MetaObjectLinksDevice { get; private set; }

        [JsonIgnore]
        [Display(Name = "Модели измерительных устройств")]
        [InverseProperty("MetaObject")]
        public virtual MetaObjectReferenceMeasurementDevice MetaObjectReferenceMeasurementDevice { get; set; }

    }
}
