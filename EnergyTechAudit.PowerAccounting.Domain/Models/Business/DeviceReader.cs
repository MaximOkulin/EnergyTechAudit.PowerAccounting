using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Core.Attributes;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Считыватель архивных данных"
    /// </summary>
    [
        EntityName(Name = "Считыватель архивных данных с приборов", ShortName = "Считыватель"),
        LoggedDeletedTrackEntity,
        PossibleCascadeDeletedEntity,
        RequireIncludeDescribablePropertiesEntity,
        DynamicDataEntity
    ]
    public class DeviceReader : IEntity, IHistoryChangeTrackEntity, IDescribableEntity
    {
        public DeviceReader()
        {
            UpdateConfigInterval = 60;
            MaxThreadCount = 50;
            QueuePollingInterval = 45;
            HoveringTaskRemoveTime = 5;
            AccessPoints = new List<AccessPoint>();
            DeviceReaderErrorLogs = new List<DeviceReaderErrorLog>();
            DeviceReaderLinksScheduleItem = new List<DeviceReaderLinkScheduleItem>();
            Hubs = new List<Hub>();
            SignalRNetAddress = "192.168.0.1";
            SignalRPort = 8529;

            ServerCommunicatorNetAddress = "https://localhost";
            ServerCommunicatorController = "DeviceReaderCommunication";
            UserId = 3; // Device.Reader

            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }

        public void CalculateDescription(IObjectContextAdapter contextAdapter) { }

        public override string ToString()
        {
            return Description;
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [DisplayColumnMetadata(Width = 25, IsDescriptive = false)]
        [Display(Name = "Ид", Order = 0)]
        [Key]
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        public int Id { get; set; }

        [Display(Name = "Код", Order = 1)]
        [DisplayColumnMetadata(Width = 100, IsDescriptive = false)]
        [Required, MaxLength(64)]
        public string Code { get; set; }

        [Display(Name = "Наименование", Order = 2)]
        [DisplayColumnMetadata(Width = 225, IsDescriptive = true)]
        [MaxLength(128)]
        public string Description { get; set; }

        [Display(Name = "Интервал обновления конфигурации (мин.)"), Required, UserInputRequired]
        public int UpdateConfigInterval { get; set; }

        [Display(Name = "Максимальное количество одновременных потоков опроса"), Required, UserInputRequired]
        public int MaxThreadCount { get; set; }

        [Display(Name = "Частота просмотра очереди потоков опроса (сек.)"), Required, UserInputRequired]
        public int QueuePollingInterval { get; set; }

        [Display(Name = "Интервал времени снятия зависших потоков (мин.)")]
        [Required, UserInputRequired]
        public int HoveringTaskRemoveTime { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired]
        public int DeviceReaderTypeId { get; set; }
        
        [Required]
        public string SignalRNetAddress { get; set; }

        [Display(Name = "IP-адрес SignalR")]
        [NotMapped, Required, UserInputRequired]
        public string EditableSignalRNetAddress
        {
            get { return SignalRNetAddress.Replace(".", ","); }

            set { SignalRNetAddress = value.Replace(" ", string.Empty).Replace(",", "."); }
        }

        [Display(Name = "Порт SignalR")]
        [Required, UserInputRequired]
        public int SignalRPort { get; set; }

        [Display(Name = "Хаб SignalR")]
        [UserInputRequired]
        public string SignalRHub { get; set; }

        
        [Display(Name = "Адрес IIS для коммуникаций")]
        [Required, UserInputRequired]
        public string ServerCommunicatorNetAddress { get; set; }

        [Display(Name = "Ид")]
        [Required, UserInputRequired]
        public int UserId { get; set; }

        [Display(Name = "Коммуникационный контроллер IIS")]
        [Required, UserInputRequired]
        public string ServerCommunicatorController { get; set; }

        [Display(Name = "Дейстие контроллера")]
        [UserInputRequired]
        public string ServerCommunicatorReceiveAction{ get; set; }

        [Display(Name = "Тип считывателя")]
        [ForeignKey("DeviceReaderTypeId")]
        public virtual DeviceReaderType DeviceReaderType { get; set; }

        [Display(Name = "Учетная запись")]
        [ForeignKey("UserId"), RequireIncludeDescribablePropertiesEntity]
        public virtual User User { get; set; }

        [Display(Name="Точки доступа")]
        [InverseProperty("DeviceReader")]
        public virtual ICollection<AccessPoint> AccessPoints { get; private set; }

        [InverseProperty("DeviceReader"), SuppressInverseLinkedEntity]
        public virtual ICollection<DeviceReaderErrorLog> DeviceReaderErrorLogs { get; private set; }

        [Display(Name= "Элементы расписания")]
        [InverseProperty("DeviceReader")]
        public virtual ICollection<DeviceReaderLinkScheduleItem> DeviceReaderLinksScheduleItem { get; private set; }

        [Display(Name = "Концентраторы")]
        [InverseProperty("DeviceReader")]
        public virtual ICollection<Hub> Hubs { get; private set; }

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
