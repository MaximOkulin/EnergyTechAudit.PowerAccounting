using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using System.Globalization;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using EnergyTechAudit.PowerAccounting.Domain.Models.WebApi;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name="Элемент расписания")]
    [RequireIncludeDescribablePropertiesEntity]
    public class ScheduleItem : IEntity, IDescribableEntity
    {

        public static bool CheckSchelude(IEnumerable<ScheduleItem> scheduleItems)
        {
            var scheduleItemList = scheduleItems as IList<ScheduleItem> ?? scheduleItems.ToList();

            // элементы расписания отсутствуют,то считаем,
            // что доступ оператору выгрузки разрешен в любое время 
            
            if (!scheduleItemList.Any())
            {
                return true;
            }

            var now = DateTime.Now;
            var dayOfWeek = (int)now.DayOfWeek;
            var timeOfDay = now.TimeOfDay;
            var dayOfMonth = now.Day;

            var expResult = true;

            Predicate<ScheduleItem> predicate = si =>
            {
                return

                    (timeOfDay >= si.PeriodBegin && timeOfDay <= si.PeriodEnd) &&
                    (
                        (
                            si.ScheduleType.Code == "ByDayOfWeek"
                            && si.OrdinalNumberOfDay != null
                            && dayOfWeek == si.OrdinalNumberOfDay.Value
                            )
                        ||
                        (
                            si.ScheduleType.Code == "ByWorkingDaysOfWeek" && (dayOfWeek >= 1 && dayOfWeek <= 5)
                            )
                        ||
                        (
                            si.ScheduleType.Code == "ByHolydaysOfWeek" && (dayOfWeek == 0 || dayOfWeek == 6)
                            )
                        ||
                        (
                            si.ScheduleType.Code == "ByDayOfMonth"
                            && si.OrdinalNumberOfDay != null
                            && si.OrdinalNumberOfDay.Value == dayOfMonth
                            )
                        );
            };

            // если есть элементы, но нет ни одного попадания 
            if (!scheduleItemList .Any(s => predicate(s)))
            {
                return false;
            }

            foreach (var scheduleItem in scheduleItemList )
            {
                if (predicate(scheduleItem))
                {
                    expResult = expResult && scheduleItem.Enabled;
                }
            }

            return expResult;
        }

        public ScheduleItem()
        {
            ScheduleTypeId = 1;
            Enabled = false;
            EditablePeriodBegin = DateTime.Now.Date;
            EditablePeriodEnd = DateTime.Now.Date.Add(TimeSpan.FromMinutes(1439));
            UserAdditionalInfoLinksScheduleItem = new List<UserAdditionalInfoLinkScheduleItem>();
            DeviceReaderLinksScheduleItem = new List<DeviceReaderLinkScheduleItem>();
            MeasurementDeviceLinksScheduleItem = new List<MeasurementDeviceLinkScheduleItem>();
            OrdinalNumberOfDay = 1;            
        }

        [Display(Name = "Ид"), UserInputRequired]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        
        [Display(Name = "Ид"), Required, NotDisplayGrid, UserInputRequired]
        public int ScheduleTypeId { get; set; }

        [Display(Name = "Разрешен")]
        public bool Enabled { get; set; }

        [Display(Name = "Тип элемента расписания")]
        [ForeignKey("ScheduleTypeId")]
        [RequiredDescribableProperty]
        public virtual ScheduleType ScheduleType { get; set; }

        [NotMapped, NotDisplayGrid, UserInputRequired]
        public DateTime EditablePeriodBegin 
        {
            get
            {
                return DateTime.Now.Date.Add(PeriodBegin);
            }
            set
            {
                PeriodBegin = value.TimeOfDay;              
            }
        }
        
        [NotMapped, NotDisplayGrid, UserInputRequiredAttribute]
        public DateTime EditablePeriodEnd
        {
            get
            {
                return DateTime.Now.Date.Add(PeriodEnd);
            }
            set
            {
                PeriodEnd = value.TimeOfDay;                
            }
        }

        [Display(Name = "Начало периода времени")]
        [DependencyDescribableProperty]
        public TimeSpan PeriodBegin { get; set; }

        [Display(Name = "Конец периода времени")]
        [DependencyDescribableProperty]
        public TimeSpan PeriodEnd { get; set; }

        [Display(Name = "Порядковый номер дня")]
        [NotMapped]
        public int? EditableOrdinalNumberOfDay 
        {
            get
            {
                return OrdinalNumberOfDay.HasValue & OrdinalNumberOfDay == default(int) 
                    ? Enum.GetValues(typeof(DayOfWeek)).Length 
                    : OrdinalNumberOfDay;                
            }
            set
            {
                if (value.HasValue && value.Value == Enum.GetValues(typeof(DayOfWeek)).Length)
                {
                    OrdinalNumberOfDay = default(int);
                }
                else
                {
                    OrdinalNumberOfDay = value;
                }
            }
        }

        [NotDisplayGrid]
        [DependencyDescribableProperty]
        public int? OrdinalNumberOfDay { get; set; }

        

        [Display(Name = "Операторы выгрузки архивов")]
        [InverseProperty("ScheduleItem")]
        public virtual ICollection<ArchiveDownloaderLinkScheduleItem> ArchiveDownloaderLinksScheduleItem { get; private set; }

        [Display(Name = "Пользователи, которым задано расписание рассылки сообщений")]
        [InverseProperty("ScheduleItem")]
        public virtual ICollection<UserAdditionalInfoLinkScheduleItem> UserAdditionalInfoLinksScheduleItem { get; private set; }

        [Display(Name = "Считыватели устройств, которым задано расписание отключения")]
        [InverseProperty("ScheduleItem")]
        public virtual ICollection<DeviceReaderLinkScheduleItem> DeviceReaderLinksScheduleItem { get; private set; }

        [Display(Name = "Измерительные устройства, которым задано расписание опроса")]
        public virtual ICollection<MeasurementDeviceLinkScheduleItem> MeasurementDeviceLinksScheduleItem { get; private set; }

        public override string ToString()
        {
            return Description;
        }
        
        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {

                var ordinalNumberOfDayDescription = string.Empty;

                if (ScheduleTypeId == 1)
                {
                    if (OrdinalNumberOfDay == Enum.GetValues(typeof(DayOfWeek)).Length)
                    {
                        OrdinalNumberOfDay = default(int);
                    }


                    if (DateTimeFormatInfo.CurrentInfo != null)
                    {
                        
                        ordinalNumberOfDayDescription = OrdinalNumberOfDay.HasValue
                            ? string.Format("({0})", DateTimeFormatInfo.CurrentInfo.GetDayName((DayOfWeek) OrdinalNumberOfDay))
                            : string.Empty;
                    }
                }
                else
                {
                    ordinalNumberOfDayDescription = OrdinalNumberOfDay.HasValue ? string.Format("({0} числo месяца)", OrdinalNumberOfDay) : string.Empty;
                }
                
                Description = string.Format
                (                    
                    @"{0} {1} (c {2:hh\:mm} по {3:hh\:mm})", 
                    ScheduleType.Description,
                    ordinalNumberOfDayDescription,
                    PeriodBegin, 
                    PeriodEnd
                );
            });
            
        }
    }
}