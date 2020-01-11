using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Описание дерева сущностей")]
    public class EntityTree : TemplateEntityBase
    {
        public EntityTree()
        {
            EntityTreeLinksRole = new List<EntityTreeLinkRole>();
        }

        [Display(Name = "Роли")]
        [InverseProperty("EntityTree")]
        public virtual ICollection<EntityTreeLinkRole> EntityTreeLinksRole { get; private set; }
    }
}
