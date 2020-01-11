using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Связь между строениями и точками доступа"
    /// </summary>
    [EntityName(Name = "Связь строение - точка доступа")]
    public partial class AccessPointLinkBuilding : IValidatableEntityObject
    {
        
        [Display(Name = "Ид")]
        public int AccessPointId { get; set; }
        
        [Display(Name = "Ид")]
        public int BuildingId { get; set; }

        [Display(Name = "Точка доступа")]
        [ForeignKey("AccessPointId")]
        public virtual AccessPoint AccessPoint { get; set; }

        [Display(Name = "Строение")]
        [ForeignKey("BuildingId")]
        public virtual Building Building { get; set; }
        
    }
}
