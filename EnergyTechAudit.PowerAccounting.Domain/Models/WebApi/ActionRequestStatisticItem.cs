using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Common.Helpers;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.WebApi
{
    [EntityName(Name = "Статистика запроса")]
    [AllowDeleteCascadeLinkedEntity]
    public class ActionRequestStatisticItem : IEntity, IServerTimeSignatureEntity
    {
        private string _uid;

        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Уид")]
        public string Uid
        {
            get { return _uid; }
            set {
                _uid = !string.IsNullOrEmpty(value) ? value.ToUpperInvariant() : Guid.Empty.ToString();
            }
        }

        [NotDisplayGrid]
        [Display(Name = "Ид")]
        public int ArchiveDownloaderId { get; set; }

        [Display(Name = "Наименование действия")]
        public string ActionName { get; set; }
        
        [Display(Name = "Время запроса")]
        public DateTime Time { get; set; }

        [Display(Name = "Размер данных")]
        public long DataSize { get; set; }
        
        [LinkDisplayGrid(Text = "Параметры запроса", ContentType = MimeType.Xml)]
        [Display(Name = "Параметры запроса")]
        public string ActionRequestStatisticInfo { get; set; }

        [NotDisplayGrid]
        [Display(Name = "Оператор выгрузки")]
        [ForeignKey("ArchiveDownloaderId")]
        public ArchiveDownloader ArchiveDownloader { get; set; }
    }
}