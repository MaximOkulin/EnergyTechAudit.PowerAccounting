using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Common.Helpers;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Мнемосхема")]
    public class Mnemoscheme: IEntity, IDescribableEntity
    {
        public Mnemoscheme()
        {
            MnemoschemeTypeId = 1;
            Zoom = 1;
            Image =
                "<svg " +
                "xmlns=\"http://www.w3.org/2000/svg\" " +
                "xmlns:xlink=\"http://www.w3.org/1999/xlink\"" +
                " version=\"1.1\" id=\"mnemoscheme\">" +
                "</svg>";
        }

        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        [Display(Name = "Масштаб")]
        public double Zoom { get; set; }

        [LinkDisplayGridAttribute(ContentType = MimeType.Xml)]
        public string Image { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int MnemoschemeTypeId { get; set; }
        
        [Display(Name = "Тип мнемосхемы"), JsonIgnore]
        [ForeignKey("MnemoschemeTypeId")]
        public virtual MnemoschemeType MnemoschemeType { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            
        }
    }
}