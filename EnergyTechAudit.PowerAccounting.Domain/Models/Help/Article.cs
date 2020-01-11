using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Help
{
    /// <summary>
    /// Класс сущности статьи справочной системы
    /// </summary>
    public class Article: IEntity
    {
        public int Id { get; set; }
        
        public int ParentId { get; set; }

        public string Html { get; set; }

        public string Title { get; set; }        
    }
}
