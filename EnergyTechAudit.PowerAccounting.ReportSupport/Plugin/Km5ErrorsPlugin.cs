using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.ReportSupport.Types;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Km5ErrorsPlugin : ReportPluginBase
    {
        private readonly int _periodTypeId;
        private readonly string _resourceSystemTypeCode;
        private readonly string _deviceCode;
        private readonly int _channelTemplateId;

        public Km5ErrorsPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }

            var resourceSystemTypeParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ResourceSystemTypeCodeColumn));
            if (resourceSystemTypeParam != null)
            {
                _resourceSystemTypeCode = Convert.ToString(resourceSystemTypeParam.Value);
            }

            var deviceCodeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.DeviceCodeColumn));
            if (deviceCodeParam != null)
            {
                _deviceCode = Convert.ToString(deviceCodeParam.Value);
            }

            var channelTemplateParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ChannelTemplateIdColumn));

            if (channelTemplateParam != null)
            {
                _channelTemplateId = Convert.ToInt32(channelTemplateParam.Value);
            }

            // включаем видимость информационного бэнда отчета (в нем отображается информация по ошибкам КМ-5)
            var infoBandVisibleParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.InfoBandVisibleColumn));
            if (infoBandVisibleParam != null)
            {
                infoBandVisibleParam.Value = ReportPluginResources.IntToBooleanTrue;
            }
        }

        public override void Execute()
        {
            // проводим анализ только для суточных архивов
            if (_periodTypeId == 3)
            {
                var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
                var errorsDataTable = DataSource.Tables[DbTablePermanentResources.DefaultErrorsDataTableName];

                // отбираем дни в которые были ошибки
                var errorDays = mainDataTable.Select(string.Format(mainDataTable.Locale,
                    string.Format(StringFormatResources.Km5ErrorsPluginErrorDaysCondition, _resourceSystemTypeCode)));

                var errorTimes = new Km5ErrorTimes();

                if (errorDays.Any())
                {
                    foreach (DataRow errorDay in errorDays)
                    {
                        var km5ErrorSchedule = new Km5ErrorSchedule(_deviceCode);

                        var dt = Convert.ToDateTime(errorDay[DbTablePermanentResources.TimeColumn]);

                        var timeNormalDiffColumnName = string.Format(StringFormatResources.TimeNormalDiff, _resourceSystemTypeCode);

                        // время нормальной работы приборы (в часах)
                        var normalTime = Convert.ToDecimal(errorDay[timeNormalDiffColumnName], CultureInfo.InvariantCulture);

                        // количество секунд, во время которых прибор находился в нештатной ситуации
                        int secondsInError = (int)((24 - normalTime)*3600);

                        // если секунд ноль или время нормальной работы в рамках ошибки округления, то выравниваем до 24 часов
                        if (secondsInError == 0 || normalTime > 23.999M)
                        {
                            errorDay[timeNormalDiffColumnName] = 24;
                            continue;
                        }

                        // получаем список всех событий произошедших в эти сутки с прибором
                        var km5Errors = errorsDataTable
                            .Select(string.Format(errorsDataTable.Locale, StringFormatResources.Km5ErrorsPluginErrorsCondition, dt,
                                dt.AddDays(1)))
                            .Select(p => new Km5Error(p)).OrderBy(p => p.Time).ToList();

                        // получаем список событий с их датами начала и конца
                        var durationList = TransformErrorsToDurations(km5Errors, dt);

                        km5ErrorSchedule.AddInternalDeviceEventDurations(durationList);

                        // получаем реальные продолжительности типов ошибок
                        var km5ErrorTimes = km5ErrorSchedule.GetKm5ErrorTimes();

                        km5ErrorTimes = CorrectKm5ErrorTimes(km5ErrorTimes, secondsInError, errorDay);

                        errorDay[string.Format(StringFormatResources.ErrorInfoColumn, _resourceSystemTypeCode)] = GetErrorInfo(km5ErrorTimes);

                        // суммируем общие продолжительности по типам событий
                        errorTimes += km5ErrorTimes;
                    }
                }

                // отбираем дни, в которые не было питания
                var powerFailureDays = mainDataTable.Select(string.Format(mainDataTable.Locale,
                    string.Format(ReportPluginResources.Km5ErrorsPluginPowerFailureDaysCondition, _resourceSystemTypeCode)));
                
                if (powerFailureDays.Any())
                {
                    foreach (DataRow powerFailureDay in powerFailureDays)
                    {
                        powerFailureDay[string.Format(StringFormatResources.ErrorInfoColumn, _resourceSystemTypeCode)] =
                            ReportPluginResources.Km5ErrorsPluginUType;

                        errorTimes.U += 86400;
                    }
                }


                var infoParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.InfoColumn));
                if (infoParam != null)
                {
                    infoParam.Value = GenerateSummaryErrorString(errorTimes);
                }
            }
        }

        /// <summary>
        /// Возвращает строку с литералами типов событий, продолжительность по которым была больше нуля
        /// </summary>
        /// <param name="errorTimes">Продолжительности событий</param>
        private string GetErrorInfo(Km5ErrorTimes errorTimes)
        {
            List<string> result = new List<string>();

            if (errorTimes.D > 0) { result.Add(ReportPluginResources.Km5ErrorsPluginDType);}
            if (errorTimes.U > 0) { result.Add(ReportPluginResources.Km5ErrorsPluginUType); }
            if (errorTimes.G > 0) { result.Add(ReportPluginResources.Km5ErrorsPluginGType); }
            if (errorTimes.g > 0) { result.Add(ReportPluginResources.Km5ErrorsPlugin_gType); }
            if (errorTimes.E > 0) { result.Add(ReportPluginResources.Km5ErrorsPluginEType); }

            return string.Join(ReportPluginResources.CommaDelimiter, result);
        }

        /// <summary>
        /// Корректирует продолжительности типов событий
        /// </summary>
        /// <param name="errorTimes">Реальные продолжительности типов событий</param>
        /// <param name="secondsInError">Количество секунд прибора в нештатной ситуации</param>
        /// <param name="row">Строчка таблицы, для получения доп информации</param>
        private Km5ErrorTimes CorrectKm5ErrorTimes(Km5ErrorTimes errorTimes, int secondsInError, DataRow row)
        {
            var result = new Km5ErrorTimes();

            // если ошибок не было, но время в нештатке есть, то проверяем для ЦО не закончился ли отопительный сезон
            if (errorTimes.IsEmpty() && secondsInError > 0 &&
                _resourceSystemTypeCode.Equals(ReportPluginResources.HeatSysResourceSystemTypeCode,
                    StringComparison.Ordinal))
            {
                // для шаблона подпитки ЦО КМ5 через импульсный вход не вычисляем (там нет температур подачи и обратки)
                if (_channelTemplateId != 243)
                {
                    var t1 = Convert.ToDecimal(row[FieldsNamesResources.HeatSysTemperSupplyPipeFieldName]);
                    var t2 = Convert.ToDecimal(row[FieldsNamesResources.HeatSysTemperReturnPipeFieldName]);
                    var diff = Math.Abs(t1 - t2);
                    // если разница температур подачи и обратки меньше 3 градусов, то отопительный сезон завершился
                    // списываем все на тип ошибки D (t1-t2 < dtmin)
                    // TODO: в перспективе читать в динпараметр реальное значение dtmin и использовать его
                    if (diff <= 3)
                    {
                        result.D = secondsInError;
                        secondsInError = 0;
                    }
                }
            }
            else
            {
                // по приоритету списываем все на сбой питания
                if (errorTimes.U <= secondsInError)
                {
                    result.U = errorTimes.U;
                    secondsInError -= errorTimes.U;
                }
                else
                {
                    result.U = secondsInError;
                    secondsInError = 0;
                }
                // далее остатки списываем на t1-t2 < dtmin
                if (errorTimes.D <= secondsInError)
                {
                    result.D = errorTimes.D;
                    secondsInError -= errorTimes.D;
                }
                else
                {
                    result.D = secondsInError;
                    secondsInError = 0;
                }
                // остатки на события с расходами G и g
                if (errorTimes.G <= secondsInError)
                {
                    result.G = errorTimes.G;
                    secondsInError -= errorTimes.G;
                }
                else
                {
                    result.G = secondsInError;
                    secondsInError = 0;
                }

                if (errorTimes.g <= secondsInError)
                {
                    result.g = errorTimes.g;
                    secondsInError -= errorTimes.g;
                }
                else
                {
                    result.g = secondsInError;
                    secondsInError = 0;
                }
            }

            // все, что осталось списываем на функциональный отказ
            result.E = secondsInError;

            return result;
        }

        /// <summary>
        /// Возвращает результирующую строку продолжительности типов событий
        /// </summary>
        /// <param name="errorTimes">Общие продолжительности типов событий</param>
        private string GenerateSummaryErrorString(Km5ErrorTimes errorTimes)
        {
            return string.Format(StringFormatResources.Km5ErrorsResultInfoString,
                ReportPluginResources.Km5ErrorsPluginUInfo,
                ConvertSecondsToHourMinuteSecondsFormat(errorTimes.U), Environment.NewLine,
                ReportPluginResources.Km5ErrorsPluginEInfo,
                ConvertSecondsToHourMinuteSecondsFormat(errorTimes.E), Environment.NewLine,
                ReportPluginResources.Km5ErrorsPluginDInfo,
                ConvertSecondsToHourMinuteSecondsFormat(errorTimes.D), Environment.NewLine,
                ReportPluginResources.Km5ErrorsPlugin_gInfo,
                ConvertSecondsToHourMinuteSecondsFormat(errorTimes.g), Environment.NewLine,
                ReportPluginResources.Km5ErrorsPluginGInfo,
                ConvertSecondsToHourMinuteSecondsFormat(errorTimes.G));
        }

        /// <summary>
        /// Конвертирует секунды в формат (час:мин:сек)
        /// </summary>
        /// <param name="totalSeconds">Общее количество секунд</param>
        private string ConvertSecondsToHourMinuteSecondsFormat(int totalSeconds)
        {
            int hours = totalSeconds / 3600;
            int minutes = (totalSeconds - hours * 3600) / 60;
            int seconds = totalSeconds - hours * 3600 - minutes * 60;

            return string.Format(StringFormatResources.HourMinuteSecondFormat, hours, minutes, seconds);
        }

        /// <summary>
        /// Возвращает список событий с датами их начала и окончания
        /// </summary>
        /// <param name="km5Errors">Список событий</param>
        /// <param name="dt">Сутки для которых происходит манипуляция</param>
        private List<Km5InternalDeviceEventDuration> TransformErrorsToDurations(List<Km5Error> km5Errors, DateTime dt)
        {
            var result = new List<Km5InternalDeviceEventDuration>();
            var periodBegin = dt;
            var periodEnd = dt.AddDays(1);

            while (km5Errors.Count > 0)
            {
                var error = km5Errors.First();
                // если событий началось
                if (error.State == Km5ErrorState.Start)
                {
                    // ищем событие окончания
                    var endError = SearchFinalEvent(km5Errors, error.InternalDeviceEventId);

                    // событие окончания найдено
                    if (endError != null)
                    {
                        result.Add(new Km5InternalDeviceEventDuration
                        {
                            Duration = new Duration(error.Time, endError.Time),
                            InternalDeviceEventId = error.InternalDeviceEventId
                        });
                        km5Errors.Remove(endError);
                    }
                    // событий окончания не найдено (считаем, что оно началось и закончилось в одно время)
                    else
                    {
                        // для сбоя питания, если окончание не нашлось, то это конец суток
                        DateTime endEventDate = error.InternalDeviceEventId == PowerFailInternalDeviceEventId()
                            ? periodEnd
                            : error.Time;

                        result.Add(new Km5InternalDeviceEventDuration
                        {
                            Duration = new Duration(error.Time, endEventDate),
                            InternalDeviceEventId = error.InternalDeviceEventId
                        });
                    }
                }
                // если событие окончилось (начала не было в этих сутках)
                else
                {
                    // для сбоя питания, если начало не нашлось, то это начало суток
                    DateTime beginEventDate = error.InternalDeviceEventId == PowerFailInternalDeviceEventId()
                        ? periodBegin
                        : error.Time;
                    // считаем, что оно началось и закончилось в одно время
                    result.Add(new Km5InternalDeviceEventDuration
                    {
                        Duration = new Duration(beginEventDate, error.Time),
                        InternalDeviceEventId = error.InternalDeviceEventId
                    });
                }
                km5Errors.Remove(error);
            }
            return result;
        }

        private int PowerFailInternalDeviceEventId()
        {
            return _deviceCode.Equals("KM5", StringComparison.Ordinal) ? 1122 : 2122;
        }

        /// <summary>
        /// Ищет в списке событий, для заданного типа событий, ближайшее событий окончания
        /// </summary>
        /// <param name="km5Errors">Сортированный по времени список ошибок</param>
        /// <param name="internalDeviceEventId">Тип события</param>
        private Km5Error SearchFinalEvent(List<Km5Error> km5Errors, int internalDeviceEventId)
        {
            Km5Error result = null;
            foreach (var km5Error in km5Errors)
            {
                if (km5Error.InternalDeviceEventId == internalDeviceEventId && km5Error.State == Km5ErrorState.End)
                {
                    result = km5Error;
                    break;
                }
            }
            return result;
        }
    }
}
