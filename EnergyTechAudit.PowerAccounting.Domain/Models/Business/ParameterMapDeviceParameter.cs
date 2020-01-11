using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Связь предметного параметра"), LoggedDeletedTrackEntity]
    public class ParameterMapDeviceParameter : IEntity, IHistoryChangeTrackEntity
    {
        public ParameterMapDeviceParameter()
        {
            Order = 1;
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int ParameterId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int PeriodTypeId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int MeasurementUnitId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int DimensionId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int DeviceParameterId { get; set; }

        [Display(Name = "Ид")]
        [Required]        
        public int SubsystemTypeId { get; set; }
        
        [Display(Name = "Ид")]
        public int? ParameterDictionaryId { get; set; }
        
        [Display(Name = "Ид")]
        [Required]
        public int ChannelTemplateId { get; set; }

        [Display(Name = "Порядок")]
        [Required]
        public int Order { get; set; }

        [Display(Name = "Параметр")]
        [ForeignKey("ParameterId")]
        public virtual Parameter Parameter { get; set; }

        [Display(Name = "Период")]
        [ForeignKey("PeriodTypeId")]
        public virtual PeriodType PeriodType { get; set; }

        [Display(Name = "Единица измерения")]
        [ForeignKey("MeasurementUnitId")]
        public virtual MeasurementUnit MeasurementUnit { get; set; }

        [Display(Name = "Размерность")]
        [ForeignKey("DimensionId")]
        public virtual Dimension Dimension { get; set; }

        [Display(Name = "Параметр прибора")]
        [ForeignKey("DeviceParameterId")]
        public virtual DeviceParameter DeviceParameter { get; set; }

        [Display(Name = "Шаблон канала")]
        [ForeignKey("ChannelTemplateId"), NotDisplayGrid]
        public virtual ChannelTemplate ChannelTemplate { get; set; }

        [Display(Name = "Тип подсистемы")]
        [ForeignKey("SubsystemTypeId")]
        public virtual SubsystemType SubsystemType { get; set; }

        [Display(Name = "Словарь значений")]
        [ForeignKey("ParameterDictionaryId")]
        public virtual ParameterDictionary ParameterDictionary { get; set; }

        [NotDisplayGrid]
        public string CreatedBy { get; set; }

        [NotDisplayGrid]
        public DateTime CreatedDate { get; set; }

        [NotDisplayGrid]
        public string UpdatedBy { get; set; }

        [NotDisplayGrid]
        public DateTime UpdatedDate { get; set; }
    }
}
