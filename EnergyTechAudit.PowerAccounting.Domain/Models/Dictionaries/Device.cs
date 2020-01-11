using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using EnergyTechAudit.PowerAccounting.Domain.Models.Rules;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Модель измерительного устройства
    /// </summary>
    [EntityName(Name = "Модель измерительного устройства")]
    public class Device : DictionaryEntityBase, ITemplatableEntity,  IDescribableEntity
    {
        public Device()
        {
            ArchiveDepthHour = 0;
            ArchiveDepthDay = 0;
            ArchiveDepthMonth = 0;
            ChannelsCount = 1;
            MeasurementDevices = new List<MeasurementDevice>();
            ChannelTemplates = new List<ChannelTemplate>(); 
            MetaObjectLinksDevice = new List<MetaObjectLinkDevice>();
            DeviceParameters = new List<DeviceParameter>();            
            CsdModems = new List<CsdModem>();
            DeviceLinkDynamicParameter = new List<DeviceLinkDynamicParameter>();
            ParameterDictionaryValues = new List<ParameterDictionaryValue>();
            InternalDeviceEvents = new List<InternalDeviceEvent>();
            DeviceArchiveTimeConverters = new List<DeviceArchiveTimeConverter>();
        }

        [Display(Name = "Межповерочный интервал (мес.)")]
        [Required]
        public int CalibrationInterval { get; set; }

        [Display(Name ="Глубина часового архива")]
        public int ArchiveDepthHour { get; set; }

        [Display(Name = "Глубина суточного архива")]
        public int ArchiveDepthDay { get; set; }

        [Display(Name = "Глубина месячного архива")]
        public int ArchiveDepthMonth { get; set; }

        [Display(Name = "Количество каналов")]
        public int ChannelsCount { get; set; }

        [Display(Name =  "Краткое наименование")]
        public string ShortName { get; set; }

        [Display(Name = "Наличие цифрового интерфейса")]
        public bool HasDigitalInterface { get; set; }

        [Display(Name = "Ид")]
        public int BaudId { get; set; }

        [Display(Name = "Ид")]
        public int DataBitId { get; set; }

        [Display(Name = "Ид")]
        public int StopBitId { get; set; }

        [Display(Name = "Ид")]
        public int ParityId { get; set; }

        [Display(Name = "Архивы накопительным итогом")]
        [Required]
        public bool IsIntegralArchiveValue { get; set; }

        [Display(Name = "Скорость передачи")]
        [ForeignKey("BaudId")]
        public virtual Baud Baud { get; set; }

        [Display(Name = "Число значимых битов")]
        [ForeignKey("DataBitId")]
        public virtual DataBit DataBit { get; set; }

        [Display(Name = "Стоповые биты")]
        [ForeignKey("StopBitId")]
        public virtual StopBit StopBit { get; set; }

        [Display(Name = "Четность")]
        [ForeignKey("ParityId")]
        public virtual Parity Parity { get; set; }

        [Display(Name = "Изображение")]
        [JsonIgnore]
        public byte[] Image { get; set; }

        [InverseProperty("Device")]
        public virtual ICollection<MeasurementDevice> MeasurementDevices { get; private set; }

        [InverseProperty("Device")]
        public virtual ICollection<ChannelTemplate> ChannelTemplates { get; private set; }

        [Display(Name = "Метаобъекты")]
        [InverseProperty("Device")]
        public virtual ICollection<MetaObjectLinkDevice> MetaObjectLinksDevice { get; private set; }

        [InverseProperty("Device")]
        public virtual ICollection<DeviceParameter> DeviceParameters { get; private set; }

        [InverseProperty("Device")]
        public virtual ICollection<CsdModem> CsdModems { get; private set; }
        
        [InverseProperty("Device")]
        public virtual ICollection<ParameterDictionaryValue> ParameterDictionaryValues { get; private set; }
            
       [InverseProperty("Device")]
        public virtual ICollection<DeviceLinkDynamicParameter> DeviceLinkDynamicParameter { get; private set; }

       [InverseProperty("Device")]
       public virtual ICollection<InternalDeviceEvent> InternalDeviceEvents { get; private set; }

        [InverseProperty("Device")]
       public virtual ICollection<DeviceArchiveTimeConverter> DeviceArchiveTimeConverters { get; private set; }
        

        [NotDisplayGrid]
        [NotMapped]
        public bool HasDynamicData
        {
            get { return false; }
        }
        
        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            throw new NotImplementedException();
        }
    }
}
