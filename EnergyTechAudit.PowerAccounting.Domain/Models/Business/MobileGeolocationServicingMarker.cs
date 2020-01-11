using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Spatial;
using System.Linq;
using System.Threading.Tasks;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Геолокационная метка обслуживания"
    /// </summary> 
    [EntityName(Name = "Геолокационная метка обслуживания")]
    [Table("MobileGeolocationServicingMarker", Schema = "Business")]
    public class MobileGeolocationServicingMarker : IEntity, IMutant
    {
        public MobileGeolocationServicingMarker()
        {
            ServerTime = DateTime.Now;
        }

        public async Task Mutate(IObjectContextAdapter contextAdapter)
        {
            var userId = await ((DbContext) contextAdapter)
                .Set<User>()
                .Where(u => u.UserName == UserName)
                .Select(u => u.Id)
                .FirstOrDefaultAsync();
                       
            UserId = userId;
        }

        [Key]
        public int Id { get; set; }

        public  int UserId { get; set; }

        public int ChannelId { get; set; }

        public DbGeography Location { get; set; }

        [NotMapped]
        public string UserName { get; set; }

        [NotMapped]
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
        public DateTime Time { get; set; }

        public DateTime ServerTime { get; set; }

        public float Distance { get; set; }

        public  bool IsValid { get; set; }
    }
}