using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Запрос")]
    public class Query : DictionaryEntityBase, IMetaObjectLinkedEntity
    {
        /// <summary>
        /// Указывает на то, что решетка связанная с запросом не поддерживает аналитических операций
        /// </summary>
        public bool ExportableOnly { get; set; }

        public string Template { get; set; }
    }
}
