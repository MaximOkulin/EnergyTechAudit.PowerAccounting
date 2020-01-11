using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Help
{
    public class Picture : IEntity
    {
        public int Id { get; set; }

        public byte[] Image { get; set; }

        public string Caption { get; set; }
        
    }
}