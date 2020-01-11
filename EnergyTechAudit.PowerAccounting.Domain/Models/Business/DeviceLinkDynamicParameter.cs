using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Связь модель прибора - динамический параметр")]
    public class DeviceLinkDynamicParameter
    {
        [Display(Name = "Ид")]
        [Required]
        public int DeviceId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int DynamicParameterId { get; set; }

        [Display(Name =  "Модель измерительного устройства")]
        [ForeignKey("DeviceId")]
        [JsonIgnore]
        public virtual Device Device { get; set; }

        [Display(Name = "Динамический параметр")]
        [ForeignKey("DynamicParameterId")]
        [JsonIgnore]
        public virtual Dictionaries.DynamicParameter DynamicParameter { get; set; }
    }
}
