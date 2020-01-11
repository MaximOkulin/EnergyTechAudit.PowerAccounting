using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Расчетный счет")]
    [RequireIncludeDescribablePropertiesEntity]
    [PossibleCascadeDeletedEntity]
    public class CheckingAccount : IEntity, IDescribableEntity, IHistoryChangeTrackEntity
    {
        public CheckingAccount()
        {
            CheckingAccountLinksPlacement = new List<CheckingAccountLinkPlacement>();

            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }

        [Key]
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        [Display(Name = "Номер счета"), Required, UserInputRequired]
        public long AccountNumber { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired]
        [DependencyDescribableProperty]
        public int OrganizationId { get; set; }

        [Display(Name = "Организация")]
        [ForeignKey("OrganizationId")]
        [RequireIncludeDescribablePropertiesEntity, RequiredDescribableProperty]
        public virtual Organization Organization { get; set; }

        [Display(Name = "Помещения")]
        [InverseProperty("CheckingAccount")]
        public virtual ICollection<CheckingAccountLinkPlacement> CheckingAccountLinksPlacement { get; private set; }


        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = string.Format("Счет № {0} ({1})", AccountNumber, Organization.Description);
            });
        }

        public override string ToString()
        {
            return Description;
        }

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