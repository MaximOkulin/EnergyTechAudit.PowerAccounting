using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics.CodeAnalysis;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Меню")]
    public class Menu
    {
        [SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Menu()
        {
            MenuItems = new HashSet<MenuItem>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Порядок сортировки")]
        [Required]
        public int Order { get; set; }

        [Display(Name = "Заголовок")]
        [Required]
        [StringLength(32)]
        public string Title { get; set; }

        public string IconClass { get; set; }

        [Display(Name = "Показывать в основном меню")]
        public bool DisplayInMainMenu { get; set; }

        [Display(Name = "Показывать в панели навигации")]
        public bool DisplayInNavbar { get; set; }

        public virtual ICollection<MenuItem> MenuItems { get; set; }
    }
}
