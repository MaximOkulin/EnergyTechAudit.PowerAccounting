using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Назначение строения (Жилой дом, завод, детский сад)
    /// </summary>
    [EntityName(Name = "Назначение строения")]
    public class BuildingPurpose : DictionaryEntityBase
    {
        public BuildingPurpose()
        {
            Buildings = new List<Building>();
        }

        [InverseProperty("BuildingPurpose")]
        public virtual ICollection<Building> Buildings { get; private set; }
    }
}
