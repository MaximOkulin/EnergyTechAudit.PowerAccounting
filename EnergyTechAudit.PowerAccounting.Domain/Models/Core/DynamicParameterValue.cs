using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Значение динамического параметра")]
    public class DynamicParameterValue : IEntity
    {
        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int EntityId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int DynamicParameterId { get; set; }

        [Display(Name = "Значение")]
        [Required]
        public string Value { get; set; }

        [Display(Name = "Динамический параметр")]
        [ForeignKey("DynamicParameterId")]
        [JsonIgnore]
        public virtual Dictionaries.DynamicParameter DynamicParameter { get; set; }
    }
}
