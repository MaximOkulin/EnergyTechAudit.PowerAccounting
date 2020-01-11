using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Сущность")]
    public class Entity : DictionaryEntityBase
    {
        public Entity()
        {
            EntityProperties = new List<EntityProperty>();
        }

        [Required]
        [MaxLength(32)]
        public string Schema { get; set; }

        [InverseProperty("Entity")]
        public virtual ICollection<EntityProperty> EntityProperties { get; private set; }
    }
}
