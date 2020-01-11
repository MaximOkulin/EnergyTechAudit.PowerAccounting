using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    public interface IServerTimeSignatureEntity
    {
        DateTime Time { get; set; }
    }
}