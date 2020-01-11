using EnergyTechAudit.PowerAccounting.ReportSupport.Types;
using System.Collections.Generic;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Helpers
{
    public static class VistHelper
    {
        public static List<VistPrecisionInfo> VistPrecisionInfo = new List<VistPrecisionInfo>
        {
            new VistPrecisionInfo {
                SystemNumber = 1,
                VistPrecisionDeviceParameters = new List<VistPrecisionDeviceParameter>
                {
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25188,
                       VistPrecisionType = VistPrecisionType.Channel1
                   },
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25189,
                       VistPrecisionType = VistPrecisionType.Channel2
                   },
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25190,
                       VistPrecisionType = VistPrecisionType.Channel3
                   },
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25191,
                       VistPrecisionType = VistPrecisionType.Heat
                   }
                }
            },
            new VistPrecisionInfo {
                SystemNumber = 2,
                VistPrecisionDeviceParameters = new List<VistPrecisionDeviceParameter>
                {
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25192,
                       VistPrecisionType = VistPrecisionType.Channel1
                   },
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25193,
                       VistPrecisionType = VistPrecisionType.Channel2
                   },
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25194,
                       VistPrecisionType = VistPrecisionType.Channel3
                   },
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25195,
                       VistPrecisionType = VistPrecisionType.Heat
                   }
                }
            },
            new VistPrecisionInfo {
                SystemNumber = 3,
                VistPrecisionDeviceParameters = new List<VistPrecisionDeviceParameter>
                {
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25196,
                       VistPrecisionType = VistPrecisionType.Channel1
                   },
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25197,
                       VistPrecisionType = VistPrecisionType.Channel2
                   },
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25198,
                       VistPrecisionType = VistPrecisionType.Channel3
                   },
                   new VistPrecisionDeviceParameter
                   {
                       DeviceParameterId = 25199,
                       VistPrecisionType = VistPrecisionType.Heat
                   }
                }
            }
        };
    }
}
