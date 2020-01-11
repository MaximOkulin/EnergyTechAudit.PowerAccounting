using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using System.Globalization;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Analytics;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{

    [
        EntityName(Name = "Параметр нештатной ситуации"), 
        RequireIncludeDescribablePropertiesEntity,
        LoggedDeletedTrackEntity
    ]
    public class EmergencySituationParameter : IEntity, IDescribableEntity, IHistoryChangeTrackEntity
    {
        public EmergencySituationParameter()
        {
            SeasonTypeId = 1;
            UserLinkEmergencyNotificationTypes = new List<UserLinkEmergencyNotificationType>();
            EmergencyLogs = new List<EmergencyLog>();
            TurnOn = true;

            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = string.Format("{0}{2}{1}", EmergencySituationParameterTemplate.Description,
                    string.Format("{0}", SeasonTypeId != 1 ? string.Format(" - {0}", SeasonType.Description) : string.Empty),
                    GetPredicateExpressionUserInputValues());
            });
        }

        private string GetPredicateExpressionUserInputValues()
        {
            var emergencyCondition = JsonConvert.DeserializeObject<EmergencyCondition>(PredicateExpression);
            if (emergencyCondition.UserInputValues != null && emergencyCondition.UserInputValues.Any())
            {
                return string.Format(" ({0})", string.Join(",", emergencyCondition.UserInputValues.Select(p => string.Format(CultureInfo.InvariantCulture, p.Format, p.Value))));
            }
            return string.Empty;
        }

        [Display(Name = "Ид"), DependencyDescribableProperty, UserInputRequired]
        [Required]
        public int SeasonTypeId { get; set; }

        [Display(Name = "Включен"), Required]
        public bool TurnOn { get; set; }

        [Display(Name  = "Ид"), DependencyDescribableProperty, UserInputRequired]
        [Required]
        public int EmergencySituationParameterTemplateId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int ChannelId { get; set; }

        [Display(Name = "Условие"), DependencyDescribableProperty, NotDisplayGrid]
        [Required]
        public string PredicateExpression { get; set; }

        [Display(Name = "Название сущности")]
        [Required]
        public string EntityTypeName { get; set; }

        [Display(Name = "Режим"), RequiredDescribableProperty]
        [ForeignKey("SeasonTypeId")]
        public virtual SeasonType SeasonType { get; set; }

        [Display(Name = "Канал")]
        [ForeignKey("ChannelId")]
        public virtual Channel Channel { get; set; }

        [Display(Name = "Шаблон параметра нештатной ситуации"), RequiredDescribableProperty]
        [ForeignKey("EmergencySituationParameterTemplateId")]
        
        public virtual EmergencySituationParameterTemplate EmergencySituationParameterTemplate { get; set; }

        [Display(Name = "Записи нештатных ситуаций")]
        [InverseProperty("EmergencySituationParameter")]
        public virtual ICollection<EmergencyLog> EmergencyLogs { get; private set; }

        [Display(Name = "Связи пользователей с типами оповещения о нештатных ситуациях")]
        [InverseProperty("EmergencySituationParameter")]
        public virtual ICollection<UserLinkEmergencyNotificationType> UserLinkEmergencyNotificationTypes { get; private set; }
        
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
