using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Район")]
    public class  District : IEntity
    {
        public District()
        {
            Buildings = new List<Building>();
        }

        public override string ToString()
        {
            return Description;
        }
        
        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }
        
        [Display(Name = "Ид")]
        public int CityId { get; set; }

        [Display(Name = "Населенный пункт")]
        [ForeignKey("CityId")]
        public virtual City City { get; set; }

        [Display(Name = "Строения")]
        [InverseProperty("District")]
        public virtual ICollection<Building> Buildings { get; set; }
    }
}