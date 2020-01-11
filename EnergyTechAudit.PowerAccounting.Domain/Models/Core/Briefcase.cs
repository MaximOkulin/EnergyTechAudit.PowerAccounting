using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{

    /// <summary>
    /// Сущность "Портфель". 
    /// Реализует персистентное хранилище  идентификаторов 
    /// сущностей добавляемых сохраняемых пользователем
    /// </summary>
    [EntityName(Name = "Портфель сущностей")]
    public class Briefcase: DictionaryEntityBase,ICommentableEntity
    {
        public Briefcase()
        {
            BriefcaseItems = new List<BriefcaseItem>();            
        }
        
        [NotDisplayGrid]
        public int UserId { get; set; }

        [NotDisplayGrid]
        public string Comments { get; set; }

        [NotDisplayGrid]
        [ForeignKey("UserId")]
        public User User { get; set; }

        [InverseProperty("Briefcase")]
        public virtual ICollection<BriefcaseItem> BriefcaseItems { get; private set; }
                
    }
}
