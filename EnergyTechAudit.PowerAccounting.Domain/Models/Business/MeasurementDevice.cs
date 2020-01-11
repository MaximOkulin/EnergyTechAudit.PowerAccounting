using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Core.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Измерительный прибор"
    /// </summary>
    [
        EntityName(Name = "Измерительное устройство"), 
        RequireIncludeDescribablePropertiesEntity, 
        PossibleCascadeDeletedEntity,
        LoggedDeletedTrackEntity,
        DynamicDataEntity(LinkType = typeof(Device))
    ]
    public partial class MeasurementDevice : MeasurementDeviceBase, IHistoryChangeTrackEntity, ISuccessConnectionPercent
    {        
        public MeasurementDevice()
        {
            BaudId = 3;
            DataBitId = 1;
            LastStatusConnectionId = 1;
            ComPortId = 1;
            ParityId = 1;
            StopBitId = 1;
            PortTypeId = 3;
            ProtocolSubTypeId = 1;
            
            StartReadArchiveDate = new DateTime(1900, 1, 1);
            CurrentAccreditationDate = new DateTime(1900, 1, 1);
            NextAccreditationDate = new DateTime(1900, 1, 1);
            ManufacturingDate = new DateTime(1900, 1, 1);
            LastSuccessConnectionTime = new DateTime(1900, 1, 1);

            NetworkAddress = 1;
            AutoDefTimeoutAnswer = 5000;
            AmountAttempt = 3;
            LastConnectionTime = new DateTime(1900, 1, 1);
            SuccessConnectionPercent = 0;
            Priority = 0;
            PollingInterval = 60;

            Channels = new List<Channel>();
            TimeSignatures = new List<TimeSignature>();
            Events = new List<DeviceEvent>();
            DeviceReaderErrorLogs = new List<DeviceReaderErrorLog>();
            MeasurementDeviceJournals = new List<MeasurementDeviceJournal>();
            
            MeasurementDeviceStatusConnectionLogs = new List<MeasurementDeviceStatusConnectionLog>();

            IntegrationArchiveInfos = new List<IntegrationArchiveInfo>();

            Archives = new List<Archive>();
            RegulatorParameterValues = new List<RegulatorParameterValue>();
            MeasurementDeviceLinksScheduleItem = new List<MeasurementDeviceLinkScheduleItem>();

            TurnOn = true;

            GiveCurrData = true;
            GiveDArcData = true;
            GiveHArcData = true;
            GiveMArcData = true;

            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }


        public override string ToString()
        {
            return Description;
        }

        public override void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = $"{Device.Code}-{FactoryNumber}";

                // TODO: 
                if (DeviceId == 34 || DeviceId == 8)
                {
                    Description = "Danfoss ECL";
                }
                if (DeviceId == 41)
                {
                    Description = "Signetics";
                }

                if (Channels != null)
                {
                    contextAdapter.ObjectContext.CreateObjectSet<ResourceSystemType>().Load();

                    foreach (var channel in Channels)
                    {
                        channel.Description = $"{Description} / {channel.ResourceSystemType.ShortName}";
                    }
                }
            });
        }

        [Display(Name = "Модель исполнения")]
        public string SubModel { get; set; }

        [Display(Name = "Время последнего опроса")]
        [DataType(DataType.DateTime), Required]
        public DateTime LastConnectionTime { get; set; }

        [Display(Name = "Автоматический таймаут")]
        public int AutoDefTimeoutAnswer { get; set; }

        [Display(Name = "Количество попыток подключения")]
        public int AmountAttempt { get; set; }

        [Display(Name = "Интервал опроса (мин.)")]
        public int PollingInterval { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired, NotDisplayGrid]
        public int ProtocolSubTypeId { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired, NotDisplayGrid]
        public int ComPortId { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired, NotDisplayGrid]
        public int BaudId { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired, NotDisplayGrid]        
        public int DataBitId { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired, NotDisplayGrid]        
        public int StopBitId { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired, NotDisplayGrid]
        public int ParityId { get; set; }
       
        [Display(Name = "Приоритет"), Required, NotDisplayGrid]        
        public int Priority { get; set; }

        [Display(Name = "Процент успешных соединений"), Required]
        public double SuccessConnectionPercent { get; set; }

        [Display(Name = "Сетевой адрес"), Required, UserInputRequired]
        public int NetworkAddress { get; set; }

        [Display(Name = "Прибор включен"), Required, UserInputRequired] 
        public bool TurnOn { get; set; }

        [Display(Name = "Время последнего успешного опроса")]
        public DateTime? LastSuccessConnectionTime { get; set; }

        [Display(Name = "Количество значимых битов")]
        [ForeignKey("DataBitId"), NotDisplayGrid]
        [JsonIgnore]
        public virtual DataBit DataBit { get; set; }

        [Display(Name = "Com-порт")]
        [ForeignKey("ComPortId"), NotDisplayGrid]
        [JsonIgnore]
        public virtual ComPort ComPort { get; set; }

        [Display(Name = "Скорость передачи")]
        [ForeignKey("BaudId"), NotDisplayGrid]
        [JsonIgnore]
        public virtual Baud Baud { get; set; }

        [Display(Name = "Четность")]
        [ForeignKey("ParityId"), NotDisplayGrid]
        [JsonIgnore]
        public virtual Parity Parity { get; set; }

        [Display(Name = "Кол-во стоповых битов")]
        [ForeignKey("StopBitId"), NotDisplayGrid]
        [JsonIgnore]
        public virtual StopBit StopBit { get; set; }

        [Display(Name = "Номер версии ПО")]
        [MaxLength(16)]
        public string Firmware { get; set; }

        [Display(Name = "Начальная дата архива")]        
        public DateTime StartReadArchiveDate { get; set; }
        
        [Display(Name = "Ид"), NotDisplayGrid]
        public int? HubId { get; set; }

        [Display(Name = "Мгновенные данные"), Required]        
        public bool GiveCurrData { get; set; }

        [Display(Name = "Часовой архив"), Required]        
        public bool GiveHArcData { get; set; }

        [Display(Name = "Дневной архив"), Required]        
        public bool GiveDArcData { get; set; }

        [Display(Name = "Месячный архив"), Required]        
        public bool GiveMArcData { get; set; }

        
        [Display(Name = "Концентратор"), ForeignKey("HubId"), NotDisplayGrid, RequireIncludeDescribablePropertiesEntity]
        public virtual Hub Hub { get; set; }

        [InverseProperty("MeasurementDevice")]
        [Display(Name = "Каналы измерительного устройства")]
        [JsonIgnore]
        [RequiredDescribableProperty]
        public virtual ICollection<Channel> Channels { get; private set; }

        [InverseProperty("MeasurementDevice"), SuppressInverseLinkedEntity]
        [Display(Name = "Временные отметки")]
        [JsonIgnore]
        public virtual ICollection<TimeSignature> TimeSignatures { get; private set; }

        [InverseProperty("MeasurementDevice")]
        [Display(Name = "События")]        
        [JsonIgnore]
        public virtual ICollection<DeviceEvent> Events { get; private set; }

        [InverseProperty("MeasurementDevice")]
        [Display(Name = "Логи ошибок опроса")]
        [JsonIgnore]        
        public virtual ICollection<DeviceReaderErrorLog> DeviceReaderErrorLogs { get; private set; }
        
        [Display(Name = "Ид")]
        public int? AccessPointId { get; set; }

        [
            Display(Name = "Точка доступа"), 
            ForeignKey("AccessPointId"),  
            RequireIncludeDescribablePropertiesEntity,
            SetNullOnCascadeDeletingProperty
        ]
        public virtual AccessPoint AccessPoint { get; set; }

        [Display(Name = "Подтип протокола"), ForeignKey("ProtocolSubTypeId"), NotDisplayGrid]
        [JsonIgnore]
        public virtual ProtocolSubType ProtocolSubType { get; set; }

        [Display(Name = "Ид")]
        public int LastStatusConnectionId { get; set; }

        [NotDisplayGrid, Immutable(SuppressRefusing = true)]
        public int? LastTimeSignatureId { get; set; }

        [Display(Name = "Статус последнего подключения")]
        [ForeignKey("LastStatusConnectionId")]
        [JsonIgnore]
        public virtual StatusConnection LastStatusConnection { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired, NotDisplayGrid]
        public int PortTypeId { get; set; }

        [Display(Name = "Тип порта")]
        [ForeignKey("PortTypeId"), NotDisplayGrid]
        [JsonIgnore]
        public virtual PortType PortType { get; set; }

        [Display(Name = "Архивы")]
        [InverseProperty("MeasurementDevice")]
        [NotDisplayGrid]
        public virtual ICollection<Archive> Archives { get;  set; }

        [Display(Name = "Информация об интегральных архивах")]
        [InverseProperty("MeasurementDevice")]
        [NotDisplayGrid]
        public virtual ICollection<IntegrationArchiveInfo> IntegrationArchiveInfos { get; private set; }

        [Display(Name = "Статусы подключений")]
        [InverseProperty("MeasurementDevice"), SuppressInverseLinkedEntity]
        public virtual ICollection<MeasurementDeviceStatusConnectionLog> MeasurementDeviceStatusConnectionLogs { get; private set; }

        [Display(Name = "Значения регулируемых параметров")]
        [InverseProperty("MeasurementDevice"), SuppressInverseLinkedEntity]
        [NotDisplayGrid]
        public virtual ICollection<RegulatorParameterValue> RegulatorParameterValues { get; private set; }

        [Display(Name = "Журналы изменений")]
        [InverseProperty("MeasurementDevice"), SuppressInverseLinkedEntity]
        [NotDisplayGrid]
        public virtual ICollection<MeasurementDeviceJournal> MeasurementDeviceJournals { get; private set; }

        [Display(Name = "Расписание опроса")]
        [InverseProperty("MeasurementDevice")]
        public virtual ICollection<MeasurementDeviceLinkScheduleItem> MeasurementDeviceLinksScheduleItem { get; private set; }

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
