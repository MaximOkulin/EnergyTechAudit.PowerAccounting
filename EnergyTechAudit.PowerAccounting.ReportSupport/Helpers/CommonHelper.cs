using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.ReportSupport.Types;
using FastReport.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Helpers
{
    public class CommonHelper
    {
        private readonly DataSet _dataSet;
        private List<Parameter> _parameters;

        public CommonHelper(DataSet dataSet, List<Parameter> parameters)
        {
            _dataSet = dataSet;
            _parameters = parameters;
        }

        public int GetChannelTemplateId()
        {
            return Convert.ToInt32(ReportParameterTable.GetReportParameterRow(DbTablePermanentResources.ChannelTemplateIdColumn)[DbTablePermanentResources.ValueColumn]);
        }

        /// <summary>
        /// Возвращает тип периода
        /// </summary>
        /// <returns></returns>
        public int GetPeriodTypeId()
        {
            return Convert.ToInt32(ReportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodTypeIdColumn)[DbTablePermanentResources.ValueColumn]);
        }

        public int GetMeasurementDeviceId()
        {
            return Convert.ToInt32(ReportParameterTable.GetReportParameterRow(DbTablePermanentResources.MeasurementDeviceIdColumn)[DbTablePermanentResources.ValueColumn]);
        }

        public DateTime GetPeriod(string name)
        {
            return Convert.ToDateTime(ReportParameterTable.GetReportParameterRow(name)[DbTablePermanentResources.ValueColumn]);
        }

        public bool GetBoolValue(string name)
        {
            return Convert.ToBoolean(ReportParameterTable.GetReportParameterRow(name)[DbTablePermanentResources.ValueColumn]);
        }


        private DataTable ReportParameterTable
        {
            get
            {
                return _dataSet.Tables[DbTablePermanentResources.DefaultReportParameterTableName];
            }
        }

        public void SetErrorInfoColumn(DataTable dataTable)
        {
            var resourceSystemTypeParam =
               _parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ResourceSystemTypeCodeColumn));

            if (resourceSystemTypeParam != null)
            {
                var resourceSystemTypeCode = Convert.ToString(resourceSystemTypeParam.Value);

                var errorInfoColumnName = string.Format(StringFormatResources.ErrorInfoColumn,
                    resourceSystemTypeCode);

                // если в главной таблице нет еще колонки HeatSys.ErrorInfo (в зависимости от типа ресурсной системы)
                if (!dataTable.Columns.Contains(errorInfoColumnName))
                {
                    // добавляем кастомный столбец для хранения информации об ошибках
                    dataTable.Columns.Add(new DataColumn(errorInfoColumnName, typeof(string)));
                }
            }
        }

        public List<SummaryParameterInfo> GetSummaryParametersInfo()
        {
            var reportFieldInfoTable = _dataSet.Tables[DbTablePermanentResources.DefaultReportFieldInfoTableName];

            var integrableFieldsNames = reportFieldInfoTable
                .Select(string.Format(reportFieldInfoTable.Locale, ReportPluginResources.IntegrableValueTrue))
                .Select(fieldsRow => Convert.ToString(fieldsRow[DbTablePermanentResources.NameColumn]))
                .ToList();

            var summaryParametersInfo = new List<SummaryParameterInfo>();
            List<ParameterMapDeviceParameter> pMdp = null;

            using (var context = new ApplicationDatabaseContext())
            {
                using (var tran = context.Database.BeginTransaction(System.Data.IsolationLevel.ReadUncommitted))
                {
                    try
                    {
                        foreach (var integrableFieldName in integrableFieldsNames)
                        {

                            var integParam = context.Parameters.FirstOrDefault(p => p.Code.Equals(integrableFieldName));
                            var diffFieldName = string.Format(StringFormatResources.DiffParameter, integrableFieldName);
                            var diffParam = context.Parameters.FirstOrDefault(p => p.Code.Equals(diffFieldName));

                            summaryParametersInfo.Add(new SummaryParameterInfo
                            {
                                SumName = integrableFieldName,
                                DiffName = diffFieldName,
                                SumParameterId = integParam != null ? integParam.Id : 0,
                                DiffParameterId = diffParam != null ? diffParam.Id : 0
                            });
                        }

                        // идентификаторы параметров, которые нам нужны из шаблона
                        var parametersIds = summaryParametersInfo.Select(p => p.SumParameterId).Union(summaryParametersInfo.Select(p => p.DiffParameterId)).ToList();

                        var channelTemplateId = GetChannelTemplateId();
                        var periodTypeId = GetPeriodTypeId();
                        pMdp = context.ParameterLinkDeviceParameters.Where(p => p.ChannelTemplateId == channelTemplateId && p.PeriodTypeId == periodTypeId &&
                                    parametersIds.Contains(p.ParameterId)).ToList();

                        if (pMdp != null && pMdp.Any())
                        {
                            foreach (var summaryParameterInfo in summaryParametersInfo)
                            {
                                summaryParameterInfo.SumDeviceParameterId = pMdp.First(p => p.ParameterId == summaryParameterInfo.SumParameterId).DeviceParameterId;
                                summaryParameterInfo.DiffDeviceParameterId = pMdp.First(p => p.ParameterId == summaryParameterInfo.DiffParameterId).DeviceParameterId;

                                var devParam = context.Set<Domain.Models.Dictionaries.DeviceParameter>().FirstOrDefault(p => p.Id == summaryParameterInfo.SumDeviceParameterId);
                                if (devParam != null)
                                {
                                    summaryParameterInfo.SumDeviceParameterName = devParam.Code;
                                }
                            }
                        }

                        tran.Commit();
                    }
                    catch
                    {
                        tran.Rollback();
                        throw new Exception();
                    }
                }
            }
            return summaryParametersInfo;
        }
    }
}
