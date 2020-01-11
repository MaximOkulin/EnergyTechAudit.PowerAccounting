using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    public interface IPreviousStateIdEntity: IEntity
    {
        int PreviousId { get; set; }
    }
}