using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    /// <summary>
    /// История изменения сущности
    /// </summary>

    [EntityName(Name = "Протокол удаления сущностей")]
    public abstract class EntityLogEntryBase : IEntity
    {
        
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name="Ид сущности")]
        public int EntityId { get; set; }
        
        /// <summary>
        /// Наименование типа сущности
        /// </summary>
        
        [Display(Name="Наименование типа")]
        public string EntityTypeDescription { get; set; }

        /// <summary>
        /// Имя типа сущности
        /// </summary>        
        [Display(Name = "Ид типа")]
        public string EntityTypeName { get; set; }

        /// <summary>
        /// Дата и время удаления
        /// </summary>

        [Display(Name = "Дата и время")]
        [DoOrderGridAttribute(GridColumnSortOrder.Descending)]
        public DateTime DateTime { get; set; }
        

        [Display(Name = "Пользователь")]
        public string User { get; set; }
        
    }
}
