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
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Точка доступа"
    /// </summary>

    [EntityName(Name = "Точка доступа"), 
        RequireIncludeDescribablePropertiesEntity, 
        PossibleCascadeDeletedEntity,
        LoggedDeletedTrackEntity,
        DynamicDataEntity
    ]
    public class AccessPoint : IEntity, IHistoryChangeTrackEntity,
        IDescribableEntity, ISuccessConnectionPercent
    {
        public AccessPoint()
        {
            NetAddress = "10.135.64.1";
            Port = 5010;           
            TransportTypeId = 3;
            TransportServerModelId = 4;            
            LastConnectionTime = new DateTime(1900, 1, 1);
            ControllerAddress = 255;
            SuccessConnectionPercent = 0;
            LastStatusConnectionId = 1;
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
            IsNeedToReconfigure = false;

            MeasurementDevices = new List<MeasurementDevice>();
            AccessPointLinksBuilding = new List<AccessPointLinkBuilding>();
            AccessPointStatusConnectionLogs = new List<AccessPointStatusConnectionLog>();
        }

        public override string ToString()
        {
            return Description;
        }

        [Display(Name = "Ид")]
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Идентификатор"), DependencyDescribableProperty]
        public string Identifier { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {

                Description = string.Format("{0}-{1}{2}",
                    // {0}
                    TransportServerModel.Code.Equals("Bars02") || TransportServerModel.Code.Contains("ATM") ||
                    TransportServerModel.Code.Contains("LersGsm") || TransportServerModel.Code.Equals("EtaModem")  ? "GPRS" : TransportType.Code,
                    // {1}
                    TransportType.Code.Equals("Http") ? string.Empty : TransportServerModel.Code,
                    // {2}
                    TransportServerModel.Code.Equals("Bars02") || TransportServerModel.Code.Equals("LersGsm") || TransportServerModel.Code.Equals("EtaModem") ? "-" + Identifier :
                    TransportServerModel.Code.Equals("None") && TransportType.Code.Equals("Http") ? Identifier :
                    TransportServerModel.Code.Contains("ATM") ? "-" + Port :
                    TransportType.Code.Equals("Ethernet") ? "-" + NetAddress.Replace(",", ".").Replace(" ", string.Empty) + ":" + Port :
                    TransportType.Code.Equals("CSD") ? "-" + NetPhone : string.Empty);
            });
        }
        [Required, DependencyDescribableProperty]
        public string NetAddress { get; set; }

        [Display(Name = "Сетевой адрес"), Required, UserInputRequired]
        [NotMapped]
        public string EditableNetAddress
        {
            get { return NetAddress.Replace(".", ","); }

            set { NetAddress = value.Replace(" ", string.Empty).Replace(",", "."); }
        }

        [Display(Name = "Порт"), Required, UserInputRequired, DependencyDescribableProperty]
        public int Port { get; set; }

        [Display(Name = "Номер телефона"), DependencyDescribableProperty]
        [MaxLength(11)]
        public string NetPhone { get; set; }

        [Display(Name = "Ид"), Required, DependencyDescribableProperty, UserInputRequired]
        public int TransportTypeId { get; set; }

        [Display(Name = "Ид"), Required, DependencyDescribableProperty, UserInputRequired]
        public int TransportServerModelId { get; set; }

        [Display(Name = "Ид")]
        public int? DeviceReaderId { get; set; }

        [Display(Name = "Ид")]
        public int? CsdModemId { get; set; }

        [Display(Name = "Адрес контроллера")]
        public int ControllerAddress { get; set; }

        [Display(Name = "Конфигурировать при каждом подключении")]
        [Required]
        public bool IsNeedToReconfigure { get; set; }
        
        [Display(Name = "Тип транспорта подключения")]
        [ForeignKey("TransportTypeId"), RequiredDescribableProperty]
        public virtual TransportType TransportType { get; set; }

        [Display(Name = "Тип модели сервера транспорта")]
        [ForeignKey("TransportServerModelId"), RequiredDescribableProperty]
        public virtual TransportServerModel TransportServerModel { get; set; }

        [Display(Name = "Считыватель данных")]
        [
            ForeignKey("DeviceReaderId"), 
            RequiredDescribableProperty, 
            SetNullOnCascadeDeletingProperty
        ]
        public virtual DeviceReader DeviceReader { get; set; }

        [Display(Name = "Время последнего опроса")]
        [DataType(DataType.DateTime)]
        public DateTime LastConnectionTime { get; set; }

        [Display(Name = "Процент успешных соединений")]
        public double SuccessConnectionPercent { get; set; }

        [InverseProperty("AccessPoint")]
        [Display(Name = "Измерительные устройства")]
        public virtual ICollection<MeasurementDevice> MeasurementDevices { get; private set; }

        [Display(Name = "Строения")]
        [InverseProperty("AccessPoint")]
        public virtual ICollection<AccessPointLinkBuilding> AccessPointLinksBuilding { get; private set; }

        [Display(Name = "Статусы подключения к точке доступа")]
        [InverseProperty("AccessPoint"), SuppressInverseLinkedEntity]
        public virtual ICollection<AccessPointStatusConnectionLog> AccessPointStatusConnectionLogs { get; private set; }

        [Display(Name = "Ид")]
        public int LastStatusConnectionId { get; set; }

        [Display(Name = "Статус последнего подключения")]
        [ForeignKey("LastStatusConnectionId")]
        [JsonIgnore]
        public virtual StatusConnection LastStatusConnection { get; set; }

        [Display(Name ="CSD-модем"), RequireIncludeDescribablePropertiesEntity]
        [ForeignKey("CsdModemId")]
        public virtual CsdModem CsdModem { get; set; }

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
