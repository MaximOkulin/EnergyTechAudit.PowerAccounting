using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using System.Reflection;
using EnergyTechAudit.PowerAccounting.Common.Helpers;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.WebApi
{
    [EntityName(Name = "Оператор выгрузки")]
    [RequireIncludeDescribablePropertiesEntity, PossibleCascadeDeletedEntity]

    public class ArchiveDownloader: IPreviousStateIdEntity, IDescribableEntity, IHistoryChangeTrackEntity
    {
        public ArchiveDownloader()
        {
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }

        public override string ToString()
        {            
            return Description;
        }

        [NotMapped, NotDisplayGrid]
        public int PreviousId { get; set; }

        [Display(Name = "Ид")]
        [NotMapped, UserInputRequired, DependencyDescribableProperty]
        public int UserId
        {
            get
            {
                return Id;
            }
            set
            {
                if (Id != default)
                {
                    PreviousId = Id;
                }
                Id = value;
            }
        }

        [Display(Name="Ид")]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [DependencyDescribableProperty]
        public int? OrganizationId { get; set; }
        
        [Display(Name = "Ресурсоснабжающая организация")]
        [ForeignKey("OrganizationId"), RequiredDescribableProperty]
        public Organization Organization { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = string.Format("{2}: {0}{1}",
                    User.Description,
                    Organization != null ? string.Format("{0}({1})", StringCharSet.WhiteSpace, Organization.Description) : string.Empty,
                    typeof(ArchiveDownloader).GetCustomAttribute<EntityNameAttribute>().Name
                );    
            });            
        }

        [Display(Name = "Пользователь")]
        [ForeignKey("Id"), RequiredDescribableProperty, OneToOneForeignKey("UserId")]
        public virtual User User { get; set; }

        [Display(Name = "Элементы расписания")]
        [InverseProperty("ArchiveDownloader")]
        public virtual ICollection<ArchiveDownloaderLinkScheduleItem> ArchiveDownloaderLinksScheduleItem { get; private set; }


        [Display(Name = "Статистика запроса")]
        [InverseProperty("ArchiveDownloader")]
        public virtual ICollection<ActionRequestStatisticItem> ActionRequestStatisticItems { get; private set; }

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
