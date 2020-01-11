using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    /// <summary>
    /// Сущность "Бинуарий"
    /// </summary>
    [EntityName(Name = "Бинуарий")]
    public class Binary: DictionaryEntityBase, IDescribableEntity
    {
        public Binary()
        {
            News = new List<News>();
        }

        public override string ToString()
        {
            return Description;
        }
      
        [Display(Name = "Ид")]
        [Required]
        public int BinaryContentTypeId { get; set; }

        [Display(Name = "Тип бинарного содержимого")]
        [ForeignKey("BinaryContentTypeId")]
        public virtual BinaryContentType BinaryContentType { get; set; }

        [Display(Name = "Данные")]
        [JsonIgnore]
        public byte[] Data { get; set; }

        [Display(Name = "Категория")]
        public string Category { get; set; }

        [Display(Name = "Новость")]
        [InverseProperty("Binary")]
        public virtual ICollection<News> News { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            throw new NotImplementedException();
        }
    }
}
