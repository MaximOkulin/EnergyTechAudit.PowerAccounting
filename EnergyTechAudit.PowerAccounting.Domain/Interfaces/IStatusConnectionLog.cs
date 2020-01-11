using System;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    /// <summary>
    /// Интерфейс носителя статуса соединения
    /// </summary>
    public interface IStatusConnectionLog
    {
        DateTime ConnectionTime { get; set; }

        StatusConnection StatusConnection { get; set; }
    }
}