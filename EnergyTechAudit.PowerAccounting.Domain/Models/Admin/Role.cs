using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// Сущность "Роль пользователя системы"
    /// </summary>
    [EntityName(Name = "Роль пользователя системы")]
    public class Role: DictionaryEntityBase, IDescribableEntity
    {    
        public Role()
        {
            Users = new List<User>();
            EntityTreeLinksRole = new List<EntityTreeLinkRole>();
            NewsLinksRole = new List<NewsLinkRole>();
            MetaObjectLinksRole = new List<MetaObjectLinkRole>();
        }
        [NotDisplayGrid]
        public string StartupRoute { get; set; }

        [NotDisplayGrid]
        public string MobileDeviceStartupRoute { get; set; }

        [InverseProperty("Role")]
        public virtual ICollection<User> Users { get; private set; }

        [Display(Name = "Деревья сущностей")]
        [InverseProperty("Role")]
        public virtual ICollection<EntityTreeLinkRole> EntityTreeLinksRole { get; private set; }

        [Display(Name = "Новости")]
        [InverseProperty("Role")]
        public virtual ICollection<NewsLinkRole> NewsLinksRole { get; private set; }

        [Display(Name = "Часто задаваемые вопросы")]
        [InverseProperty("Role")]
        public virtual ICollection<FaqLinkRole> FaqLinksRole { get; private set; }

        [Display(Name = "Метаобъекты")]
        [InverseProperty("Role")]
        public virtual ICollection<MetaObjectLinkRole> MetaObjectLinksRole { get; private set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            throw new NotImplementedException();
        }
    }
}
