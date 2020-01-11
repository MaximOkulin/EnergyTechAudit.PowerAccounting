using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Types
{
    public class Vzljot25Failure
    {
        [JsonProperty(PropertyName = "d")]
        public int DateTime { get; set; }
        [JsonProperty(PropertyName = "ft")]
        public Vzljot25FailureType FailureType { get; set; }
        [JsonProperty(PropertyName = "v")]
        public string Value { get; set; }
    }
}
