using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    /// <summary>
    /// Интерфейс, указывающий на то, что изменения сущности
    /// должны логироваться в таблицу историй изменений
    /// </summary>
    public interface IHistoryChangeTrackEntity
    {      
        string CreatedBy { get; set; }
    
        string UpdatedBy { get; set; }
     
        DateTime CreatedDate { get; set; }

        DateTime UpdatedDate { get; set; }
    }

    public interface IHistoryChangeTrackSuppressingEntity
    {
        bool SuppressHistory { get; set; }
    }
}
