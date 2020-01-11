using System.Collections.Generic;

namespace EnergyTechAudit.PowerAccounting.Domain.Analytics
{
    /// <summary>
    /// Класс, хранящий десериализованную информацию о точках температурного графика
    /// </summary>
    public class RawHeatCurve
    {
        public List<UserInputValue> UserInputValues { get; set; }
    }
}
