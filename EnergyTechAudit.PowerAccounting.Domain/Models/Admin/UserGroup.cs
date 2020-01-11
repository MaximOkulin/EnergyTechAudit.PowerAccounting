using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Common.Helpers;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// Сущность "Группа пользователя"
    /// </summary>
    [EntityName(Name = "Группа пользователя")]

    public class UserGroup : IEntity, IHistoryChangeTrackEntity, IDescribableEntity
    {
        public UserGroup()
        {
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;            
        }

        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        [Display(Name = "Пользователи")]
        [InverseProperty("UserGroup")]
        public virtual ICollection<User> Users { get; private set; }

        [NotDisplayGrid]
        public string ProductLogoPlaceholder { get; set; }

        [NotDisplayGrid]
        public string ProductCard { get; set; }

        [Display(Name = "Дополнительные настройки")]
        [LinkDisplayGrid(ContentType = MimeType.Json)]
        public string CustomData { get; set; }

        [NotDisplayGrid]
        public string CreatedBy { get; set; }

        [NotDisplayGrid]
        public string UpdatedBy { get; set; }

        [NotDisplayGrid]
        public DateTime CreatedDate { get; set; }

        [NotDisplayGrid]
        public DateTime UpdatedDate { get; set; }

        public override string ToString()
        {
            return Description;
        }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {

        }
    }
}
