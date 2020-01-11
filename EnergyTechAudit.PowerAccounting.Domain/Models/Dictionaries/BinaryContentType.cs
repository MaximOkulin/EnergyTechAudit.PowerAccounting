using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Тип бинарного содержимого
    /// </summary>
    [EntityName(Name = "Тип бинарного содержимого (mime-тип)")]
    public class BinaryContentType : DictionaryEntityBase
    {
        [InverseProperty("BinaryContentType")]
        public virtual ICollection<Binary> Binaries { get; set; }
    }
}
