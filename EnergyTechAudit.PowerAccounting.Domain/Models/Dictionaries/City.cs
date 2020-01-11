using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using System.ComponentModel.DataAnnotations;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Город
    /// </summary>
    [EntityName(Name = "Населенный пункт")]
    public class City : DictionaryEntityBase
    {
        public City()
        {
            Districts = new List<District>();
            
        }

        [Display(Name = "Латинский код")]
        public string LatinCode { get; set; }

        [Display(Name = "Минимальная температура")]
        public int? MinimalTemperature { get; set; }

        [InverseProperty("City")]
        public virtual ICollection<District> Districts { get;  set; }                
    }
}

