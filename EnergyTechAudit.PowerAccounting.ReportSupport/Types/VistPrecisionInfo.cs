using System.Collections.Generic;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Types
{
    public class VistPrecisionInfo
    {
        public List<VistPrecisionDeviceParameter> VistPrecisionDeviceParameters { get; set; }
        public int SystemNumber { get; set; }
    }
}
