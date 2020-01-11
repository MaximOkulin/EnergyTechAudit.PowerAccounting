using System.ComponentModel.DataAnnotations;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// Протокол удаления сущности
    /// </summary>

    [EntityName(Name = "Протокол удаления сущностей")]
    public class DeletedEntityLogEntry : EntityLogEntryBase
    {
        [Display(Name = "Наименование")]
        public string EntityDescription { get; set; }

        [Display(Name = "Каскадно удаленные сущности")]
        [LinkDisplayGrid(Text = "Каскадно удаленные сущности")]
        public string CascadeDeletedEntities { get; set; }
    }
}
