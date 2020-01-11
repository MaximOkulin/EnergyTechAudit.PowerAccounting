using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Spatial;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Строение"
    /// </summary> 
    [
        EntityName(Name = "Строение"),
        RequireIncludeDescribablePropertiesEntity,
        PossibleCascadeDeletedEntity, 
        LoggedDeletedTrackEntity,
        DynamicDataEntity
    ]
    public class Building : IEntity, IHistoryChangeTrackEntity, IDescribableEntity
    {
        public Building()
        {
            Square = 0;
            CountFlats = 0;
            BuildingPurposeId = 1;
            Location = null;
            AccessPointLinksBuilding = new List<AccessPointLinkBuilding>();
            BuildingMapResourceBuildings = new List<BuildingMapResourceBuilding>();
            Placements = new List<Placement>();
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
                Description = string.Join(",", FullAddress.Split(',').Take(3).ToArray());

                if (Placements != null)
                {
                    foreach (var placement in Placements)
                    {
                        placement.Description = string.Format("{0} - {1}",
                            placement.Description.Split('-').First(),
                            Description);
                    }
                }
            });
        }

        [Display(Name = "Полный адрес"), DependencyDescribableProperty, Required, UserInputRequired]
        [MaxLength(256)]
        public string FullAddress { get; set; }

        [Display(Name = "Площадь")]
        public double Square { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired]
        public int BuildingPurposeId { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired]
        public int DistrictId { get; set; }

        [Display(Name = "Количество квартир")]
        public int CountFlats { get; set; }

        [Display(Name = "Географические координаты"), Required, NotDisplayGrid]
        public DbGeography Location { get; set; }
        
        [Display(Name = "Геолокация"), Required, NotMapped, NotDisplayGrid]       
        public string Geolocation
        {
            get
            {
                if (Location != null)
                {
                    return Location.AsText();
                }
                return string.Empty;
            }
            set
            {
                if (value != null)
                {
                    Location = DbGeography.FromText(value);
                }
            }
        }
        [Display(Name = "Ид")]
        public int? OrganizationId { get; set; }

        [Display(Name = "Эксплуатационная организация")]
        [ForeignKey("OrganizationId")]      
        [SetNullOnCascadeDeletingProperty]
        public virtual  Organization Organization {get; set; }

        [Display(Name = "Ид")]
        public int? UserAdditionalInfoId { get; set; }

        [Display(Name = "Ответственное лицо")]
        [ForeignKey("UserAdditionalInfoId")]
        [SetNullOnCascadeDeletingProperty]
        public virtual UserAdditionalInfo UserAdditionalInfo { get; set; }

        [Display(Name = "Назначение строения")]
        [ForeignKey("BuildingPurposeId")]
        public virtual BuildingPurpose BuildingPurpose { get; set; }

        [Display(Name = "Район населенного пункта")]
        [ForeignKey("DistrictId")]
        public virtual District District { get; set; }

        [InverseProperty("Building")]
        [Display(Name = "Помещения"), RequiredDescribableProperty]
        public virtual ICollection<Placement> Placements { get; private set; }

        [Display(Name = "Строения")]
        [InverseProperty("Building")]
        public virtual ICollection<BuildingMapResourceBuilding> BuildingMapResourceBuildings { get; private set; }

        [Display(Name = "Точки доступа")]
        [InverseProperty("Building")]
        public virtual ICollection<AccessPointLinkBuilding> AccessPointLinksBuilding { get; private set; }

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
