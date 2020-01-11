using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    public class DictionaryEntityBase : IDictionaryEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [DisplayColumnMetadata(Width = 25, IsDescriptive = false)]
        [Display(Name = "Ид", Order = 0)]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Код", Order = 1)]
        [DisplayColumnMetadata(Width = 100, IsDescriptive = false)]
        [Required, MaxLength(64)]
        public string Code { get; set; }

        [Display(Name = "Наименование", Order = 2)]
        [DisplayColumnMetadata(Width = 225, IsDescriptive = true)]
        [MaxLength(128)]
        public string Description { get; set; }

        public override string ToString()
        {
            return Description;
        }
    }
}
