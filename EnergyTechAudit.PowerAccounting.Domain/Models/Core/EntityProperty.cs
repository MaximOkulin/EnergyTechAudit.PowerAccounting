using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Свойство сущности")]
    public class EntityProperty
    {
        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int EntityId { get; set; }

        [Display(Name = "Название")]
        [Required]
        [MaxLength(64)]
        public string PropertyName { get; set; }

        [Display(Name = "Наименование")]
        [Required]
        [MaxLength(128)]
        public string Description { get; set; }

        [Display(Name = "Сущность")]
        [ForeignKey("EntityId")]
        public virtual Entity Entity { get; set; }
    }
}
