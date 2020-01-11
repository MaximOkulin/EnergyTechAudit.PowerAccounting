using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Дополнительная информация о пользователе"
    /// </summary>

    [
        EntityName(Name = "Сведения о пользователе"), 
        RequireIncludeDescribablePropertiesEntity,
        PossibleCascadeDeletedEntity,
        DynamicDataEntity
    ]
    public class UserAdditionalInfo : IPreviousStateIdEntity, IHistoryChangeTrackEntity, IDescribableEntity
    {
        public UserAdditionalInfo()
        {
            BirthDay = new DateTime(1900, 1, 1);
            Placements = new List<Placement>();
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
            GenderId = 3; // Не указан
            UserLinkEmergencyNotificationTypes = new List<UserLinkEmergencyNotificationType>();
            EmergencyMessages = new List<EmergencyMessage>();
            UserAdditionalInfoLinksScheduleItem = new List<UserAdditionalInfoLinkScheduleItem>();
        }

        public override string ToString()
        {
            return Description;
        }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            Description = string.Format("{0}{1}{2}",
                LastName,
                (!string.IsNullOrEmpty(FirstName) ? string.Format(" {0}.", FirstName.Substring(0, 1)) : string.Empty),
                (!string.IsNullOrEmpty(FirstName) && !string.IsNullOrEmpty(Patronimic) ? string.Format(" {0}.", Patronimic.Substring(0, 1)) : string.Empty));
        }

        [Key]
        [Display(Name = "Ид")]        
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        public int Id { get; set; }

        [NotMapped, NotDisplayGrid]
        public int PreviousId { get; set; }

        [Display(Name = "Ид")]
        [NotMapped, UserInputRequired]
        public int UserId 
        {
            get => Id;
            set
            {
                if (Id != default)
                {
                    PreviousId = Id;
                }
                Id = value;                
            } 
        }


        [Display(Name = "Имя")]
        [MaxLength(32)]
        public string FirstName { get; set; }

        [Display(Name = "Фамилия")]
        [Required, UserInputRequired, MaxLength(32)]
        public string LastName { get; set; }

        [Display(Name = "Отчество")]
        [MaxLength(32)]
        public string Patronimic { get; set; }

        [Display(Name = "Ид")]        
        public int GenderId { get; set; }

        [Display(Name = "Дата рождения")]
        public DateTime? BirthDay { get; set; }

        [Display(Name = "Телефон")]
        public string Phone { get; set; }

        [Display(Name = "Электронная почта")]
        public string Email { get; set; }

        [Display(Name = "Пользователь")]
        [ForeignKey("Id"), RequiredDescribableProperty, OneToOneForeignKey("UserId")]
        public virtual User User { get; set; }

        [Display(Name = "Пол")]
        [ForeignKey("GenderId")]
        public virtual Gender Gender { get; set; }

        [Display(Name = "Помещения")]
        [InverseProperty("UserAdditionalInfo")]
        public virtual ICollection<Placement> Placements { get; private set; }

        [Display(Name = "Сообщения о нештатных ситуациях")]
        [InverseProperty("UserAdditionalInfo")]
        public virtual ICollection<EmergencyMessage> EmergencyMessages { get; private set; }

        [Display(Name = "Оповещения о нештатных ситуациях")]
        [InverseProperty("UserAdditionalInfo")]
        public virtual ICollection<UserLinkEmergencyNotificationType> UserLinkEmergencyNotificationTypes { get; private set; }
            
        [Display(Name = "Элементы расписания рассылки сообщений")]
        [InverseProperty("UserAdditionalInfo")]
        public virtual ICollection<UserAdditionalInfoLinkScheduleItem> UserAdditionalInfoLinksScheduleItem { get; private set; }

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
