using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Словарь значений абстрактных параметров")]
    public class ParameterDictionary : DictionaryEntityBase
    {
        public ParameterDictionary()
        {
            ParameterDictionaryValues = new List<ParameterDictionaryValue>();
        }

        [InverseProperty("ParameterDictionary")]
        public virtual ICollection<ParameterDictionaryValue> ParameterDictionaryValues { get; private set; }
    }
}
