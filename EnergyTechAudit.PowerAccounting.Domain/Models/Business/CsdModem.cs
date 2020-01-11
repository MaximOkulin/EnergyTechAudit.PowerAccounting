using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "CSD-модем"), RequireIncludeDescribablePropertiesEntity, LoggedDeletedTrackEntity]
    public class CsdModem : IEntity, IHistoryChangeTrackEntity, IDescribableEntity
    {
        public CsdModem()
        {
            ComPortId = 1;
            UpdatedDate = DateTime.Now;
            CreatedDate = DateTime.Now;
            
            AccessPoints = new List<AccessPoint>();
        }

        public override string ToString()
        {
            return Description;
        }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = string.Format("{0}-{1}", Device.Code, NetPhone);
            });
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        [Display(Name = "Номер телефона")]
        [Required, UserInputRequired]
        [DependencyDescribableProperty]
        public string NetPhone { get; set; }

        [Display(Name = "Ид")]
        [Required, UserInputRequired]
        public int ComPortId { get; set; }

        [Display(Name = "Ид")]
        [Required, DependencyDescribableProperty, UserInputRequired]
        public int DeviceId { get; set; }

        [Display(Name = "Com-порт")]
        [ForeignKey("ComPortId")]
        [JsonIgnore]
        public virtual ComPort ComPort { get; set; }

        [Display(Name = "Модель модема")]
        [ForeignKey("DeviceId"), RequireIncludeDescribablePropertiesEntity, RequiredDescribableProperty]
        [JsonIgnore]
        public virtual Device Device { get; set; }

        [Display(Name = "Точки доступа")]
        [InverseProperty("CsdModem")]
        public virtual ICollection<AccessPoint> AccessPoints { get; private set; }

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
