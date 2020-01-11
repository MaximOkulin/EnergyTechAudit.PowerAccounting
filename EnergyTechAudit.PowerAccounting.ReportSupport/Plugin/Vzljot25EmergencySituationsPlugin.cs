using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using EnergyTechAudit.PowerAccounting.ReportSupport.Types;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Vzljot25EmergencySituationsPlugin : ReportPluginBase
    {
        private readonly DateTime _periodBegin;
        private readonly DateTime _periodEnd;
        private readonly int _periodTypeId;
        private readonly int _measurementDeviceId;

        public Vzljot25EmergencySituationsPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }

            var reportParameterTable = DataSource.Tables[DbTablePermanentResources.DefaultReportParameterTableName];
            var periodBeginRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodBeginColumn);

            if (periodBeginRow != null)
            {
                _periodBegin = Convert.ToDateTime(periodBeginRow[DbTablePermanentResources.ValueColumn]);
                // обнуление часовой-минутной-секундой компонент
                _periodBegin = _periodBegin.Date;
            }

            var periodEndRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodEndColumn);

            if (periodEndRow != null)
            {
                _periodEnd = Convert.ToDateTime(periodEndRow[DbTablePermanentResources.ValueColumn]);
                // обнуление часовой-минутной-секундой компонент
                _periodEnd = _periodTypeId == 3 ? _periodEnd.Date : _periodEnd.Date.AddHours(-1);

                var nowDate = DateTime.Now.Date;

                if (_periodTypeId == 3)
                {
                    if (_periodEnd >= nowDate)
                    {
                        _periodEnd = nowDate.AddDays(-1);
                    }
                }
                else
                {
                    if (_periodEnd >= nowDate)
                    {
                        _periodEnd = nowDate.AddHours(-1);
                    }
                }


            }

            var measurementDeviceIdParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.MeasurementDeviceIdColumn));
            if (measurementDeviceIdParam != null)
            {
                _measurementDeviceId = Convert.ToInt32(measurementDeviceIdParam.Value);
            }
        }

        public override void Execute()
        {
            var mainDataTableToRemove = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
            DataSource.Tables.Remove(mainDataTableToRemove);
            var mainDataTable = new DataTable(DbTablePermanentResources.DefaultMainDataTableName);
            mainDataTable.Columns.Add(new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime)));
            mainDataTable.Columns.Add(new DataColumn(ReportPluginResources.Event, typeof(string)));
            DataSource.Tables.Add(mainDataTable);

            int dynamicParameterId = _periodTypeId == 2 ? 194 : 193; // DeviceDayArchiveFailures or DeviceHourArchiveFailures
            int timeStepInHours = _periodTypeId == 2 ? 1 : 24;

            DynamicParameterValue dynamicParam = null;
            using (var context = new ApplicationDatabaseContext())
            {
                using (var tran = context.Database.BeginTransaction(IsolationLevel.ReadUncommitted))
                {
                    try
                    {
                        dynamicParam = context.DynamicParameterValues.FirstOrDefault(p => p.EntityId == _measurementDeviceId &&
                        p.DynamicParameterId == dynamicParameterId);
                        tran.Commit();
                    }
                    catch
                    {
                        tran.Rollback();
                    }
                }
            }

            if (dynamicParam != null && !string.IsNullOrEmpty(dynamicParam.Value))
            {
                var failures = JsonConvert.DeserializeObject<List<Vzljot25Failure>>(dynamicParam.Value);

                for (var dt = _periodBegin; dt <= _periodEnd; dt = dt.AddHours(timeStepInHours))
                {
                    var unixDate = 0;
                        
                    if (_periodTypeId == 3)
                    {
                        unixDate = dt.AddHours(23).AddMinutes(59).AddSeconds(59).ConvertToUnixTime();
                    }
                    else
                    {
                        unixDate = dt.AddMinutes(59).AddSeconds(59).ConvertToUnixTime();
                    }
                        
                    var dateFailures = failures.Where(p => p.DateTime == unixDate).ToList();

                    var newRow = mainDataTable.NewRow();
                    newRow[DbTablePermanentResources.TimeColumn] = dt;
                    if (dateFailures.Count == 0)
                    {
                        newRow[ReportPluginResources.Event] = ReportPluginResources.DashSymbol;
                    }
                    else
                    {
                        newRow[ReportPluginResources.Event] = ParseFailure(dateFailures);
                    }
                    mainDataTable.Rows.Add(newRow);
                }                
            }
        }

        private string ParseFailure(List<Vzljot25Failure> failures)
        {
            string result = string.Empty;

            // ищем и парсим отказы датчиков
            var hsSensorFailure = failures.FirstOrDefault(p => p.FailureType == Vzljot25FailureType.HsSensorFailure);
            if (hsSensorFailure != null)
            {
                result += "ОТКАЗЫ ДАТЧИКОВ: ";
                var hsIncidents = hsSensorFailure.Value.Split(',');
                var listHsIncidents = new List<string>();

                foreach(var hsI in hsIncidents)
                {
                    int hsInt = Convert.ToInt32(hsI);
                    if (hsInt == 0)
                    {
                        listHsIncidents.Add("отказ питания");
                    }

                    int trNumber = 0;
                    if (hsInt >= 1 && hsInt <= 6) { trNumber = 1; }
                    if (hsInt >= 7 && hsInt <= 12) { trNumber = 2; }
                    if (hsInt >= 13 && hsInt <= 18) { trNumber = 3; }
                    if (hsInt >= 19 && hsInt <= 24) { trNumber = 4; }
                    if (hsInt >= 25 && hsInt <= 30) { trNumber = 5; }
                    if (hsInt >= 31 && hsInt <= 36) { trNumber = 6; }

                    if (trNumber != 0)
                    {
                        int failBit = hsInt - 6 * (trNumber - 1);

                        switch(failBit)
                        {
                            case 1:
                                listHsIncidents.Add(string.Format("Q>Qвн ТР{0}", trNumber));
                                break;
                            case 2:
                                listHsIncidents.Add(string.Format("Qотс<Q<Qнн ТР{0}", trNumber));
                                break;
                            case 3:
                                listHsIncidents.Add(string.Format("Q<Qотс ТР{0}", trNumber));
                                break;
                            case 4:
                                listHsIncidents.Add(string.Format("отказ ПР ТР{0}", trNumber));
                                break;
                            case 5:
                                listHsIncidents.Add(string.Format("отказ ПТ ТР{0}", trNumber));
                                break;
                            case 6:
                                listHsIncidents.Add(string.Format("отказ ПД ТР{0}", trNumber));
                                break;
                        }
                    }
                }

                result += string.Join(ReportPluginResources.CommaDelimiter, listHsIncidents);
                result += ". ";
            }

            // ищем и парсим нештатные ситуации теплосистемы
            var hsIncidentsFailure = failures.FirstOrDefault(p => p.FailureType == Vzljot25FailureType.HsIncidents);

            if (hsIncidentsFailure != null)
            {
                result += "НС ТС: ";
                var hsIncidents = hsIncidentsFailure.Value.Split(',');
                var listHsIncidents = new List<string>();

                foreach (var hsI in hsIncidents)
                {
                    int hsInt = Convert.ToInt32(hsI) - 1;

                    switch(hsInt)
                    {
                        case 0:
                            listHsIncidents.Add("G2>KпрG1");
                            break;
                        case 1:
                            listHsIncidents.Add("G4>KпрG3");
                            break;
                        case 2:
                            listHsIncidents.Add("G6>KпрG5");
                            break;
                        case 3:
                            listHsIncidents.Add("t1-t2<Δt");
                            break;
                        case 4:
                            listHsIncidents.Add("t3-t4<Δt");
                            break;
                        case 5:
                            listHsIncidents.Add("t5-t6<Δt");
                            break;
                        case 6:
                            listHsIncidents.Add("G1/Kпр<G2<KпрG1");
                            break;
                        case 7:
                            listHsIncidents.Add("G3/Kпр<G4<KпрG3");
                            break;
                        case 8:
                            listHsIncidents.Add("G5/Kпр<G6<KпрG5");
                            break;
                    }

                    if (hsInt >= 9 && hsInt <= 14)
                    {
                        int tnNum = hsInt - 8;
                        listHsIncidents.Add(string.Format("t<tнн||t>tвн ТР{0}", tnNum));
                    }
                    if (hsInt >= 15 && hsInt <= 20)
                    {
                        int tnNum = hsInt - 14;
                        listHsIncidents.Add(string.Format("P<Pнн||P>Pвн ТР{0}", tnNum));
                    }
                    if (hsInt >= 21 && hsInt <= 26)
                    {
                        int tnNum = hsInt - 20;
                        listHsIncidents.Add(string.Format("Q<Qнн||Q>Qвн ТР{0}", tnNum));
                    }
                    if (hsInt >= 27 && hsInt <= 32)
                    {
                        int tnNum = hsInt - 26;
                        listHsIncidents.Add(string.Format("G<Gнн||G>Gвн ТР{0}", tnNum));
                    }
                }
                result += string.Join(ReportPluginResources.CommaDelimiter, listHsIncidents);
                result += ". ";
            }
            return result;
        }
    }
}
