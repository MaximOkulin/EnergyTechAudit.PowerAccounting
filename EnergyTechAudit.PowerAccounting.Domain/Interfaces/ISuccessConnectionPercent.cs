using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    public interface ISuccessConnectionPercent
    {
        double SuccessConnectionPercent { get; set; }

        DateTime LastConnectionTime { get; set; }
    }
}
