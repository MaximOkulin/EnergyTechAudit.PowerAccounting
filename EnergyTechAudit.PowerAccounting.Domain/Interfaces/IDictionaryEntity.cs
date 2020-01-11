using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    /// <summary>
    /// Интерфейс реализуемый классами словарных сущностных моделей
    /// </summary>
    public interface IDictionaryEntity: IEntity
    {        
        string Code { get; set; }
              
        string Description { get; set; }
    }

    public interface IMetaObjectLinkedEntity : IDictionaryEntity
    {
        
    }
}
