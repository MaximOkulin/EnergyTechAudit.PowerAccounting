using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    public class SeasonType : DictionaryEntityBase
    {
        public SeasonType()
        {
            EmergencySituationParameters = new List<EmergencySituationParameter>();
        }

        [InverseProperty("SeasonType")]
        public virtual ICollection<EmergencySituationParameter> EmergencySituationParameters { get; private set; }
    }
}
