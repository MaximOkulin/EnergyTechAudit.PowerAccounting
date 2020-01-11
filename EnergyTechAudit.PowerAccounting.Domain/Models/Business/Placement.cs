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
    /// Сущность "Помещение" (квартира, подвал, склад и т.д.)
    /// </summary>
    
    [
        EntityName(Name = "Помещение"), 
        RequireIncludeDescribablePropertiesEntity, 
        LoggedDeletedTrackEntity,
        PossibleCascadeDeletedEntity
    ]

    public class Placement : IEntity, IHistoryChangeTrackEntity, IDescribableEntity
    {
         
        public Placement()
        {
            AmountRooms = 0;
            AmountPeople = 0;
            Area = 0;
            HasIndividualAccounting = false;
            Channels = new List<Channel>();
            CheckingAccountLinksPlacement = new List<CheckingAccountLinkPlacement>();
            PlacementPurposeId = 2;
            FrontNumber = 0;
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }

        public override string ToString()
        {
            return Description;
        }

        [Display(Name = "Ид")]
        [Key]
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                if (PlacementPurpose == null)
                {
                    contextAdapter.ObjectContext.LoadProperty(this, "PlacementPurpose");
                }

                Description = string.Format("{0}{1}{4}{3} - {2}",
                    PlacementPurpose.Description,
                    (PlacementPurpose.Id == 1  ||  PlacementPurpose.Id == 3) ? // квартира или нежилое помещение
                        string.Format("{0}{1}", string.IsNullOrEmpty(Number) ? string.Empty : " ",  Number) : string.Empty,
                    Building.Description,
                    PlacementPurpose.Id == 2 /* узел учета */ && FrontNumber != 0 ? string.Format(" под.{0}", FrontNumber) : string.Empty,
                    string.IsNullOrEmpty(Comment) ? string.Empty : string.Format(" ({0})", Comment));
            });
        }

        [Display(Name = "Ид")]
        [Required, DependencyDescribableProperty, UserInputRequired]
        public int PlacementPurposeId { get; set; }

        [Display(Name = "Ид")]
        [Required, UserInputRequired]
        public int BuildingId { get; set; }

        [Display(Name = "Ид")]
        public int? OrganizationId { get; set; }


        [Display(Name = "Ид")]
        public int? MnemoschemeId { get; set; }
        
        [Display(Name = "Индивидуальный учет")]
        [Required]
        public bool HasIndividualAccounting { get; set; }

        [Display(Name = "Номер"), DependencyDescribableProperty]
        [MaxLength(10)]
        public string Number { get; set; }

        [Display(Name = "Количество комнат")]
        public int AmountRooms { get; set; }

        [Display(Name = "Количество людей")]
        public int AmountPeople { get; set; }

        [DependencyDescribableProperty]
        [Display(Name = "Подъезд")]
        public int FrontNumber { get; set; }

        [Display(Name = "Комментарий"), DependencyDescribableProperty]
        public string Comment { get; set; }

        [Display(Name = "Площадь")]
        public double Area { get; set; }

        [Display(Name = "Ид")]        
        public int? UserAdditionalInfoId { get; set; }

        [Display(Name = "Мнемосхема")]
        [ForeignKey("MnemoschemeId"), NotDisplayGrid]
        public virtual Mnemoscheme Mnemoscheme { get; set; }

        [Display(Name = "Назначение помещения")]
        [ForeignKey("PlacementPurposeId"), RequiredDescribableProperty]
        public virtual PlacementPurpose PlacementPurpose { get; set; }

        [Display(Name = "Строение")]
        [ForeignKey("BuildingId"), RequiredDescribableProperty]
        public virtual Building Building { get; set; }

        [Display(Name = "Собственник (физ. лицо)")]
        [
            ForeignKey("UserAdditionalInfoId"), 
            SetNullOnCascadeDeletingProperty
        ]
        public virtual UserAdditionalInfo UserAdditionalInfo { get; set; }

        [Display(Name = "Собственник (юр. лицо)")]
        [ForeignKey("OrganizationId")]
        public virtual Organization Organization { get; set; }

        [Display(Name = "Каналы измерительного устройства")]
        [InverseProperty("Placement")]        
        public virtual ICollection<Channel> Channels { get; private set; }

        [Display(Name = "Расчетные счета")]
        [InverseProperty("Placement")]
        public virtual ICollection<CheckingAccountLinkPlacement> CheckingAccountLinksPlacement { get; private set; }

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
