using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using System.ComponentModel.DataAnnotations;
using EnergyTechAudit.PowerAccounting.Common.Helpers;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Словарь "Источник метеоданных"
    /// </summary>
    [EntityName(Name ="Источник метеоданных")]
    public class MeteoDataSourceType : DictionaryEntityBase
    {        
        [LinkDisplayGrid(Text = "Настройки", ContentType = MimeType.Json)]
        [Display(Name = "Настройки")]
        public string Settings { get; set; }

        [Display(Name = "Использовать")]
        [Required]
        public bool IsUse { get; set; }        
    }
}
