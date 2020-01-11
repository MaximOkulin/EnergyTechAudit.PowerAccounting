using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Шаблон канала измерительного прибора"
    /// </summary>
    [
        EntityName(Name = "Шаблон канала измерительного прибора"), 
        RequireIncludeDescribablePropertiesEntity, 
        PossibleCascadeDeletedEntity, 
        LoggedDeletedTrackEntity
    ]
    public class ChannelTemplate : ITemplatableEntity, IDescribableEntity, IHistoryChangeTrackEntity
    {
        public ChannelTemplate()
        {
            Channels = new List<Channel>();
            ParameterMapDeviceParameters = new List<ParameterMapDeviceParameter>();
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = string.Format("{0} - \"{1}\"{2}",
                    Device.Code,
                    ResourceSystemType.Description,
                    Comment != null ? string.Format(" ({0})", Comment) : string.Empty);
            });
        }

        public override string ToString()
        {
            return Description;
        }

        [Key]
        [Display(Name = "Ид")]        
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        public int Id{ get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        [Display(Name = "Ид"), Required, DependencyDescribableProperty, UserInputRequired]
        public int ResourceSystemTypeId { get; set; }

        [Display(Name = "Ид"), Required, DependencyDescribableProperty, UserInputRequired]
        public int DeviceId { get; set; }

        [Display(Name = "Ид")]
        public int? MnemoschemeId { get; set; }

        [Display(Name = "Комментарий"), DependencyDescribableProperty]
        public string Comment { get; set; }

        [Display(Name = "Ид")]
        public int? ResourceSubsystemTypeId { get; set; }

        [Display(Name = "Тип ресурсной системы")]
        [ForeignKey("ResourceSystemTypeId"), RequiredDescribableProperty, RequireIncludeDescribablePropertiesEntity]
        public virtual ResourceSystemType ResourceSystemType { get; set; }
        
        [Display(Name = "Модель прибора")]
        [ForeignKey("DeviceId"), RequiredDescribableProperty, RequireIncludeDescribablePropertiesEntity]
        public virtual Device Device { get; set; }
        
        [Display(Name = "Мнемосхема"), ForeignKey("MnemoschemeId"), NotDisplayGrid]
        public virtual Mnemoscheme Mnemoscheme { get; set; }
        
        [Display(Name = "Каналы измерительного устройства")]
        [InverseProperty("ChannelTemplate")]
        public virtual ICollection<Channel> Channels { get; private set; }

        [Display(Name = "Связь предметного параметра")]
        [InverseProperty("ChannelTemplate")]
        public virtual ICollection<ParameterMapDeviceParameter> ParameterMapDeviceParameters { get; private set; }

        [Display(Name = "Подтип ресурсной системы")]
        [ForeignKey("ResourceSubsystemTypeId")]
        public virtual ResourceSubsystemType ResourceSubsystemType { get; set; }

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
