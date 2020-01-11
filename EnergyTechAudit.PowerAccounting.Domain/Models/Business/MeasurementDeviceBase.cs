using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    public abstract class MeasurementDeviceBase : IDescribableEntity, IEntity
    {
        [Key, DoOrderGrid(GridColumnSortOrder.Descending)]
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Заводской номер"), Required, DependencyDescribableProperty, UserInputRequired, Immutable]
        public long FactoryNumber { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        [Display(Name = "Дата действующей поверки")]
        public DateTime CurrentAccreditationDate { get; set; }

        [Display(Name = "Дата следующей поверки")]
        public DateTime NextAccreditationDate { get; set; }

        [Display(Name = "Дата производства")]
        public DateTime ManufacturingDate { get; set; }

        [Display(Name = "Ид"), Required, DependencyDescribableProperty, UserInputRequired, Immutable]
        public int DeviceId { get; set; }

        [Display(Name = "Модель прибора"), ForeignKey("DeviceId"), RequireIncludeDescribablePropertiesEntity, RequiredDescribableProperty]
        public virtual Device Device { get; set; }

        public override string ToString()
        {
            return Description;
        }

        public abstract void CalculateDescription(IObjectContextAdapter contextAdapter);

    }
}