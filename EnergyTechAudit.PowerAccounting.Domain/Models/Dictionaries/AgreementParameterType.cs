using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Тип договорного параметра системы ресурсов")]
    public class AgreementParameterType : DictionaryEntityBase
    {
        public AgreementParameterType()
        {
            AgreementParameters = new List<AgreementParameter>();
        }

        [InverseProperty("AgreementParameterType")]
        public virtual ICollection<AgreementParameter> AgreementParameters { get; private set; }
    }
}
