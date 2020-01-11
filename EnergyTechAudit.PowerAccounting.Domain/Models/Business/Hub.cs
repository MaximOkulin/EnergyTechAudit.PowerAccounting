using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Концентратор"
    /// </summary>
    [EntityName(Name = "Концентратор", ShortName = "Концентратор"),
    RequireIncludeDescribablePropertiesEntity, LoggedDeletedTrackEntity]
    public class Hub : IEntity, IHistoryChangeTrackEntity, IDescribableEntity
    {
        public Hub()
        {
            MeasurementDevices = new List<MeasurementDevice>();
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }

        public override string ToString()
        {
            return Description;
        }

        [Key]
        [Display(Name = "Ид")]        
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }
        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = string.Format("Концентратор WCN - {0}", FactoryNumber);
            });
        }

        [Display(Name = "Заводской номер")]
        [Required, DependencyDescribableProperty, UserInputRequired]
        public int FactoryNumber { get; set; }

        [Display(Name = "Внешний IP-адрес (прошивка в приборе)")]
        public string ExternalNetAddress { get; set; }

        [Display(Name = "Внешний порт (прошивка в приборе)")]
        public int? ExternalPort { get; set; }

        [Display(Name = "Локальный IP-адрес (прослушивается сервером)")]
        public string LocalNetAddress { get; set; }

        [Display(Name = "Локальный порт (прослушивается сервером)")]
        public int? LocalPort { get; set; }

        [Display(Name = "Сетевой идентификатор"), Required, UserInputRequired]
        public int Identifier { get; set; }

        [Display(Name = "Ид")]
        public int? DeviceReaderId { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired]
        public int BuildingId { get; set; }

        [Display(Name = "Считыватель данных")]
        [
            ForeignKey("DeviceReaderId"), 
            SetNullOnCascadeDeletingProperty
        ]
        public virtual DeviceReader DeviceReader { get; set; }

        [Display(Name = "Строение")]
        [ForeignKey("BuildingId")]
        public virtual Building Building { get; set; }
        
        [Display(Name = "Измерительные устройства")]
        [InverseProperty("Hub")]
        public virtual ICollection<MeasurementDevice> MeasurementDevices { get; private set; }

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
