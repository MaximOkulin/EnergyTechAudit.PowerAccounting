using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Spatial;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using EnergyTechAudit.PowerAccounting.Domain.Models.WebApi;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Организация"
    /// </summary>
    ///     
    [
        EntityName(Name = "Организация"),
        LoggedDeletedTrackEntity,
        PossibleCascadeDeletedEntity,
        DynamicDataEntity   
    ]
    public class Organization : IEntity, IHistoryChangeTrackEntity, IDescribableEntity
    {
        public Organization()
        {            
            OrganizationTypeId = 1;            
            Location = null;
            
            Buildings = new List<Building>();
            CheckingAccounts = new List<CheckingAccount>(); 
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
            
        }
        
        [Display(Name = "Полный адрес")]
        [MaxLength(256), Required, UserInputRequired]
        public string FullAddress { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired]
        public int OrganizationTypeId { get; set; }

        
        [Display(Name = "Географические координаты"), NotDisplayGrid, Required]
        public DbGeography Location { get; set; }

        [Display(Name = "Геолокация"), NotMapped, NotDisplayGrid, Required]       
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

        [Display(Name = "Тип организации")]
        [ForeignKey("OrganizationTypeId")]
        public virtual OrganizationType OrganizationType { get; set; }

        
        [Display(Name = "Строения")]
        [InverseProperty("Organization")]
        public virtual ICollection<Building> Buildings { get; private set; }

        [Display(Name = "Расчетные счета")]
        [InverseProperty("Organization")]
        public virtual ICollection<CheckingAccount> CheckingAccounts { get; private set; }

        [Display(Name= "Помещения")]
        [InverseProperty("Organization")]
        public virtual ICollection<Placement> Placements { get; private set; }

        [Display(Name = "Операторы выгрузки архивов")]
        [InverseProperty("Organization")]
        public virtual ICollection<ArchiveDownloader> ArchiveDownloaders { get; private set; }

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
