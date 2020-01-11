using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [Table("Core.MenuItem")]
    [EntityName(Name = "Пункт меню")]
    public partial class MenuItem
    {
        public MenuItem()
        {
            Visible = true;
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид меню")]
        [Required]
        public int MenuId { get; set; }

        [Display(Name = "Ид метаобъекта")]
        public int? MetaObjectId { get; set; }

        [Display(Name = "Порядок сортировки")]
        [Required]
        public int Order { get; set; }

        [Display(Name = "Заголовок")]
        [StringLength(64)]
        public string Title { get; set; }

        public string IconClass { get; set; }

        [Display(Name = "Видимость")]
        public bool Visible { get; set; }

        [Display(Name = "Меню")]
        public virtual Menu Menu { get; set; }

        [Display(Name = "Метаобъект")]
        public virtual MetaObject MetaObject { get; set; }

        [NotMapped]
        public virtual object CustomData { get; set; }
    }
}
