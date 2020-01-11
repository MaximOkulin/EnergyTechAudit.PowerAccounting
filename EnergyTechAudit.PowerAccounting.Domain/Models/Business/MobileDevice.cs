using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [
        EntityName(Name = "Точка доступа"),
        Table("MobileDevice", Schema = "Business")
    ]
    public class MobileDevice : IEntity
    {
        public MobileDevice()
        {
            IsActive = true;
        }

        [Key]
        public int Id { get; set; }

        public int UserId { get; set; }

        public string Imei { get; set; }

        public string Model { get; set; }

        public string Os { get; set; }

        public DateTime? RegistrationDate { get; set; }

        public DateTime? LastConnectionDate { get; set; }

        public string FcmToken { get; set; }

        public bool IsActive { get; set; }

        [ForeignKey("UserId")]
        public virtual User User { get; set; }
    }
}
