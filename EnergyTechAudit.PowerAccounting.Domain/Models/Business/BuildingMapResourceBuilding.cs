using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Связь строения с источником ресурса")]
    [Table("BuildingMapResourceBuilding", Schema = "Business")]
    public class BuildingMapResourceBuilding : IEntity
    {
        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int BuildingId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int ResourceBuildingId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int ResourceSystemTypeId { get; set; }

        [Display(Name = "Строение")]
        [ForeignKey("BuildingId")]
        public  virtual  Building Building { get; set; }

        [Display(Name = "Источник")]
        [ForeignKey("ResourceBuildingId")]
        public virtual Building ResourceBuilding { get; set; }

        [Display(Name = "Тип ресурсной системы")]
        [ForeignKey("ResourceSystemTypeId")]
        public virtual ResourceSystemType ResourceSystemType { get; set; }
    }
}