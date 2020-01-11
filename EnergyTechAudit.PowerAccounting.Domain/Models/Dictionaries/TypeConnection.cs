using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Тип подключения (клиент/сервер)
    /// </summary>
    [EntityName(Name = "Тип подключения")]
    public partial class TypeConnection : DictionaryEntityBase
    {
        public TypeConnection()
        {
           
        }        
    }
}
