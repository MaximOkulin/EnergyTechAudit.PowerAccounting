using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using System.Collections.Generic;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [AllowDeleteCascadeLinkedEntity]
    public class EmergencyLog : IContextUserNameEntity
    {
        private bool _isAcknowledgement;

        public EmergencyLog()
        {
            IsAcknowledgement = false;
            EmergencyMessages = new List<EmergencyMessage>();
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int EmergencySituationParameterId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int EmergencyTimeSignatureId { get; set; }

        [Display(Name = "Аварийные параметры")]
        public string Value { get; set; }

        [Display(Name = "Время восстановления")]
        public DateTime? RecoveryTime { get; set; }

        [Display(Name = "Параметр нештатной ситуации")]
        [ForeignKey("EmergencySituationParameterId")]
        public virtual EmergencySituationParameter EmergencySituationParameter { get; set; }

        [Display(Name = "Временная сигнатура нештатных ситуаций")]
        [ForeignKey("EmergencyTimeSignatureId")]
        public virtual EmergencyTimeSignature EmergencyTimeSignature { get; set; }

        [Display(Name = "Оповещения о нештатных ситуациях")]
        [InverseProperty("EmergencyLog")]
        [NotDisplayGrid]
        public virtual ICollection<EmergencyMessage> EmergencyMessages { get; private set; }

        //  private bool _isAcknowledgement;

        [Display(Name = "Квитировано")]
        public bool IsAcknowledgement
        {
            get => _isAcknowledgement;
            set
            {
                _isAcknowledgement = value;
                if (value)
                {
                    AcknowledgementDate = DateTime.Now;        
                }                
            }
        }

        [Display(Name = "Время квитирования")]
        public DateTime? AcknowledgementDate { get; set; }

        [Display(Name = "Пользователь")]
        public string AcknowledgementUserName { get; set; }

        [NotMapped]
        public string UserName
        {
            get => AcknowledgementUserName;
            set
            {
                if (value != null)
                {                 
                    AcknowledgementUserName = value;
                }                
            }
        }
    }
}
