using System.ComponentModel.DataAnnotations.Schema;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    [NotMapped]
    public class CascadeDeletedEntity
    {
        public string EntityTypeName { get; set; }

        public string EntityTypeDescription { get; set; }
        
        public int EntityCount { get; set; }

        public string CascadeOperationType { get; set; }
    }
}
