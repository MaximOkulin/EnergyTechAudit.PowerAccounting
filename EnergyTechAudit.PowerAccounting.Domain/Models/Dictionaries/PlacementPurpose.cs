using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Назначение помещения")]
    public class PlacementPurpose : DictionaryEntityBase
    {
        public PlacementPurpose()
        {
            Placements = new List<Placement>();
        }

        [InverseProperty("PlacementPurpose")]
        public virtual ICollection<Placement> Placements { get; private set; }
    }
}
