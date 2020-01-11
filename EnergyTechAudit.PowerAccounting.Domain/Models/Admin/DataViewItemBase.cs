using System;
using System.ComponentModel.DataAnnotations;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    public abstract class DataViewItemBase : IEntity, IHistoryChangeTrackEntity
    {
        protected DataViewItemBase()
        {
            Date = DateTime.Now;

            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;           
        }

        [Key]
        [Display(Name = "Ид")]
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        public int Id { get; set; }

        [Display(Name = "Заголовок")]
        [LinkDisplayGrid(Text = "Заголовок"), Required, UserInputRequired]
        public string Caption { get; set; }

        [Display(Name = "Дата"), Required, UserInputRequired]
        public DateTime Date { get; set; }

        [NotDisplayGrid]
        public string CreatedBy { get; set; }

        [NotDisplayGrid]
        public string UpdatedBy { get; set; }

        [NotDisplayGrid]
        public DateTime CreatedDate { get; set; }

        [NotDisplayGrid]
        public DateTime UpdatedDate { get; set; }
    }
}