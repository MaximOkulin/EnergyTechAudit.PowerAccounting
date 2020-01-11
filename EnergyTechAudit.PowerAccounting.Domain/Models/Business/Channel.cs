using System;
using System.Collections.Generic;
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
    /// <summary>
    /// Сущность "Канал измерительного прибора"
    /// </summary>

    [
        EntityName(Name = "Канал измерительного прибора", ShortName = "Канал"), 
        RequireIncludeDescribablePropertiesEntity,
        LoggedDeletedTrackEntity,
        DynamicDataEntity,
        PossibleCascadeDeletedEntity
    ]
    public partial class Channel : IHistoryChangeTrackEntity, IDescribableEntity, IEntity
    {
        public Channel()
        {               
            ResourceSystemTypeId = 4;
            TechnologicAdjunctionTypeId = 1;
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
            Activated = true;
            UserLinksChannel = new List<UserLinkChannel>();
            ChannelLinksAgreementParameter = new List<ChannelLinkAgreementParameter>();
            EmergencySituationParameters = new List<EmergencySituationParameter>();
        }

        public override string ToString()
        {
            return Description;
        }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = string.Format
                    (
                        "{0} / {1}",
                        MeasurementDevice.Description, ResourceSubsystemType != null ? ResourceSubsystemType.ShortName : ResourceSystemType.ShortName
                    );
            });
        }


        [Display(Name = "Ид")]
        [Key]
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        public int Id { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired]
        [DependencyDescribableProperty]
        public int ResourceSystemTypeId { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired]
        [DependencyDescribableProperty] // !important
        public int MeasurementDeviceId { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired]
        public int PlacementId { get; set; }

        [Display(Name = "Активен"), Required]
        public bool Activated { get; set; }

        [Display(Name = "Ид"), Required, NotDisplayGrid, UserInputRequired]
        public int ChannelTemplateId { get; set; }

        [Display(Name = "Ид"), NotDisplayGrid]
        public int? MnemoschemeId { get; set; }

        [Display(Name = "Ид")]
        [NotDisplayGrid]
        public int? OrganizationId { get; set; }

        [Display(Name = "Ид"), Required, NotDisplayGrid]
        public int TechnologicAdjunctionTypeId { get; set; }

        [Display(Name = "Ид")]
        [DependencyDescribableProperty]
        [NotDisplayGrid]
        public int? ResourceSubsystemTypeId { get; set; }

        [NotDisplayGrid]
        [Display(Name = "Ид")]
        public int? LastEmergencyTimeSignatureId { get; set; }

        [NotDisplayGrid]
        public int? Order { get; set; }

        [NotMapped]
        [Display(Name = "Содержит динамические параметры")]
        public bool HasDynamicData
        {
            get
            {
                return false;
            }
        }

        [Display(Name = "Тип ресурсной системы")]
        [ForeignKey("ResourceSystemTypeId"), RequiredDescribableProperty]
        public virtual ResourceSystemType ResourceSystemType { get; set; }

        [Display(Name = "Мнемосхема"), ForeignKey("MnemoschemeId"), NotDisplayGrid]
        public virtual Mnemoscheme Mnemoscheme { get; set; }

        [Display(Name = "Измерительное устройство")]
        [ForeignKey("MeasurementDeviceId"), RequiredDescribableProperty]
        public virtual MeasurementDevice MeasurementDevice { get; set; }

        [Display(Name = "Помещение")]
        [ForeignKey("PlacementId")]
        public virtual Placement Placement { get; set; }

        [
            Display(Name = "Шаблон настроек канала"), 
            ForeignKey("ChannelTemplateId"),
            NotDisplayGrid, 
            SetNullOnCascadeDeletingProperty
        ]
        public virtual ChannelTemplate ChannelTemplate { get; set; }

        [Display(Name = "Ресурсоснабжающая организация")]
        [ForeignKey("OrganizationId")]
        [NotDisplayGrid]
        public virtual Organization Organization { get; set; }

        [Display(Name = "Тип присоединения")]
        [ForeignKey("TechnologicAdjunctionTypeId")]
        [NotDisplayGrid]
        public virtual TechnologicAdjunctionType TechnologicAdjunctionType { get; set; }

        [Display(Name = "Подтип ресурсной системы")]
        [ForeignKey("ResourceSubsystemTypeId"), RequiredDescribableProperty]
        [NotDisplayGrid]
        public virtual ResourceSubsystemType ResourceSubsystemType { get; set; }

        [NotDisplayGrid]
        [Display(Name = "Последняя временная сигнатура нештатных ситуаций")]
        [ForeignKey("LastEmergencyTimeSignatureId")]
        public virtual EmergencyTimeSignature LastEmergencyTimeSignature { get; set; }

        [Display(Name = "Пользователи")]
        [InverseProperty("Channel")]
        public virtual ICollection<UserLinkChannel> UserLinksChannel { get; private set; }

        [Display(Name = "Договорные параметры")]
        [InverseProperty("Channel")]
        public virtual ICollection<ChannelLinkAgreementParameter> ChannelLinksAgreementParameter { get; private set; }

        [Display(Name = "Параметры нештатных ситуаций")]
        [InverseProperty("Channel")]
        public virtual ICollection<EmergencySituationParameter> EmergencySituationParameters { get; private set; }
            
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
