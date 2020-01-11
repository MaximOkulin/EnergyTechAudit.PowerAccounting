using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.Common.Serialization;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using EnergyTechAudit.PowerAccounting.Infrastructure.Helpers;
using EnergyTechAudit.PowerAccounting.Infrastructure.Security;
using EnergyTechAudit.PowerAccounting.Web.Models.Common;
using EnergyTechAudit.PowerAccounting.Web.Models.Dialogs;
using FastReport;
using FastReport.Data;
using IronPython.Hosting;
using Microsoft.Scripting.Hosting;
using Newtonsoft.Json;
using FastReportReport = FastReport.Report;
using Report = EnergyTechAudit.PowerAccounting.Domain.Models.Core.Report;

namespace EnergyTechAudit.PowerAccounting.ReportEngine
{
    public class ReportEnginePipeline: IDisposable
    {
        
        private DataSet _metaObjectLinkedDataSet;
        
        private ApplicationDatabaseContext _databaseContext;

        public ReportEnginePipeline()
        {
            _databaseContext =  new ApplicationDatabaseContext();
        }

        public DataSet MetaObjectLinkedDataSet
        {
            get { return _metaObjectLinkedDataSet; }
            set { _metaObjectLinkedDataSet = value; }
        }

        #region Сборка мусора 
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        ~ReportEnginePipeline()
        {
            Dispose(false);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                
                if (MetaObjectLinkedDataSet != null)
                {
                    MetaObjectLinkedDataSet.Dispose();
                    MetaObjectLinkedDataSet = null;
                }

                if (_databaseContext != null)
                {
                    _databaseContext.Dispose();
                    _databaseContext = null;
                }               
            }            
        }

        #endregion

        /// <summary>
        /// Запускает конвейенр формированния отчета
        /// </summary>
        /// <param name="report">Экземпляр объекта отчета, 
        /// который должен освобождаться на вызывающей стороне</param>
        /// <param name="metaObjectEx">Метаобъект полученный из клиентского запроса</param>
        /// <returns></returns>
        public FastReportReport Execute(FastReportReport report, MetaObjectEx metaObjectEx)
        {            
            // пытаемся найти параметр с предопределенным именем  HasRequiredGroupPrint 
            // указывает на групповую печать
             bool? hasRequiredGroupPrintReport = false;

            if (metaObjectEx.ParametricDialog != null)
            {
                hasRequiredGroupPrintReport = metaObjectEx
                    .ParametricDialog
                    .TryGetDescriptorValue<bool?>(ParametricParameterResources.HasRequiredGroupPrint);
                hasRequiredGroupPrintReport = hasRequiredGroupPrintReport ?? false;
            }

            if (hasRequiredGroupPrintReport.Value)
            {
                var variator = metaObjectEx
                    .ParametricDialog
                    .TryGetDescriptorValue<string>(ParametricParameterResources.Variator);

                var variatorSource = metaObjectEx
                    .ParametricDialog
                    .TryGetDescriptorValue<string>(ParametricParameterResources.VariatorSource);

                if (variator != null && variatorSource != null)
                {
                    // формируем источник для параметра(ов), которые будут передаваться 
                    // в объект параметрии запроса отчета

                    variatorSource = metaObjectEx.ParametricDialog.SubstituteIntoExpression(variatorSource);
                    
                    var variatorSet = _databaseContext.ExecuteQuery(variatorSource, null, null);

                    var variatorValueTable = variatorSet.Tables.Cast<DataTable>().FirstOrDefault();
                    if (variatorValueTable != null)
                    {
                        var append = false;
                        
                        Action<FastReport.Report, string> outlineBuilder = null;

                        if (variatorValueTable.Columns[ParametricParameterResources.OutlineExpression] != null)
                        {
                            outlineBuilder = (rawReport, outlineExpression) =>
                            {
                                var reportPage = rawReport.Pages[default] as ReportPage;
                                if (reportPage != null)
                                {
                                    reportPage.OutlineExpression = $"\"{outlineExpression}\" ";
                                }
                            };    
                        }

                        foreach (DataRow row in variatorValueTable.Rows)
                        {
                            /* Расширенный конвенциональный выбор вариативных параметров */
                            foreach (DataColumn column in variatorValueTable.Columns)
                            {
                                var variatorDescriptor1 =
                                    metaObjectEx
                                        .ParametricDialog
                                        .Descriptors
                                        .FirstOrDefault(desc => desc.Name.Equals(column.ColumnName, StringComparison.InvariantCultureIgnoreCase));

                                if (variatorDescriptor1 != null)
                                {
                                    object variatorValue1 = row[column.ColumnName];
                                    variatorDescriptor1.Value = Convert.ToString(variatorValue1);
                                }
                            }
                      
                            try
                            {                                
                                BuildReport(report, metaObjectEx, rawReport =>
                                {                                    
                                    if (outlineBuilder != null)
                                    {
                                        var outlineExpression = (string) row[ParametricParameterResources.OutlineExpression];
                                        outlineBuilder(rawReport, outlineExpression);
                                    }
                                });
                            }
                            catch (Exception)
                            {
                                continue;                                
                            }
                            
                            // источник данных содержит пустую таблицу с основным набором данных   
                            var mainDataTable = MetaObjectLinkedDataSet.Tables[DbTablePermanentResources.DefaultMainDataTableName];
                            if (mainDataTable.Rows.Count == default)
                            {
                                continue;
                            }
                            try
                            {
                                if (report != null)
                                {                                    
                                    report.Prepare(append);                                    
                                }
                                append = true;                                    
                            }
                            catch (Exception /*ex*/)
                            {
                                continue;                              
                            }                            
                        }                                                                        
                    }
                }
            }
            else
            {                
                BuildReport(report, metaObjectEx, null);

                // источник данных содержит пустую таблицу с основным набором данных   
                if(MetaObjectLinkedDataSet != null)
                {
                    var mainDataTable = MetaObjectLinkedDataSet.Tables[DbTablePermanentResources.DefaultMainDataTableName];

                    if (mainDataTable.Rows.Count == default)
                    {
                        return null;
                    }
                }

            }

            return report;
        }

        private void CustomerLogoInjector(FastReportReport report, MetaObjectEx metaObjectEx)
        {
            if (report == null) return;

            var page = report.Pages.Cast<ReportPage>().FirstOrDefault();

            if (page != null)
            {
                var reportingPart = new
                {
                    Reporting = new
                    {
                        CustomerDependency = new
                        {
                            ForceSuppress = false,
                            LogoBinaryCode = string.Empty,
                            LogoControlName = string.Empty,
                            InheritFromSystem = false
                        }
                    }
                };

                string customData;

                var logoIsAppointed = false;

                Action<string, bool> injector = (jsonCustomData, fromSystem) =>
                {
                    if (jsonCustomData != null)
                    {
                        try
                        {
                            reportingPart = JsonConvert.DeserializeAnonymousType
                                (
                                    jsonCustomData, reportingPart,
                                    new JsonSerializerSettingsEx()
                                );

                            // доступно описание секции репортинга и необходимых структур 
                            var accessable = reportingPart != null &&
                                             reportingPart.Reporting != null &&
                                             reportingPart.Reporting.CustomerDependency != null;

                            if (accessable)
                            {
                                // явно указано наследовать лого от системного уровня 
                                if (!fromSystem && reportingPart.Reporting.CustomerDependency.InheritFromSystem) return;

                                logoIsAppointed = !reportingPart.Reporting.CustomerDependency.ForceSuppress;

                                if (logoIsAppointed)
                                {
                                    var customerReportLogoControlName =
                                        reportingPart.Reporting.CustomerDependency.LogoControlName;

                                    object pictureObj =
                                        (PictureObject) page.ReportTitle.FindObject(customerReportLogoControlName);

                                    if (pictureObj != null)
                                    {

                                        var binaryLogo = _databaseContext.Set<Binary>()
                                            .FirstOrDefault(
                                                b => b.Code == reportingPart.Reporting.CustomerDependency.LogoBinaryCode);

                                        if (binaryLogo != null)
                                        {
                                            ((PictureObject) pictureObj).Image =
                                                System.Drawing.Image.FromStream(new MemoryStream(binaryLogo.Data));                                            
                                        }
                                    }
                                }
                                else
                                {
                                    // если установлено подавление уровня группы показываем, 
                                    // что назначение выполнено для пропуска назначения уровня системы  
                                    logoIsAppointed = !fromSystem;
                                }
                            }
                        }
                        catch
                        {
                            logoIsAppointed = false;
                        }
                    }
                };

                string userName = null;

                // ищем имя пользователя или в контексте
                // или в дескрипторе, если ушли из конвейерного кода в background групповой печати
                if (HttpContext.Current != null)
                {
                    userName = HttpContext.Current.User.GetUserName();
                }
                else
                {
                    var desc =  metaObjectEx.ParametricDialog.Descriptors
                        .FirstOrDefault(d => d.Name == ParametricParameterResources.UserName);

                    if (desc != null)
                    {
                        userName = desc.Value;
                    }
                }

                // попытка назначения лого для отчета 
                // на основании принадлежности пользователя к группе
                if (userName.IsNotNullOrEmpty())
                {
                    var userGroupId = _databaseContext.Set<User>()
                        .Where(u => u.UserName == userName)
                        .Select(u => u.UserGroupId).FirstOrDefault();

                    if (userGroupId.HasValue)
                    {
                        customData = _databaseContext.Set<UserGroup>()
                            .Where(ug => ug.Id == userGroupId.Value)
                            .Select(ug => ug.CustomData)
                            .FirstOrDefault();

                        injector(customData, false);
                    }
                }

                // если назначение лого еще не было выполнено 
                // пытаемся применить системный уровень
                if (!logoIsAppointed)
                {
                    customData = _databaseContext
                        .Set<SystemSetting>().Select(ss => ss.CustomData)
                        .FirstOrDefault();

                    injector(customData, true);
                }
            }
        }

        /// <summary>
        /// Общее конфигурирование отчета.
        /// Формирование параметрии отчета,  препроцессинг на основе селекторов отчетов,  постпроцессинг источника данных,
        /// подготовка бэндов и регистрациия источников данных
        /// </summary>
        private
            void BuildReport(FastReportReport report, MetaObjectEx metaObjectEx, Action<FastReportReport> outlineBuilder)
        {
            var reportParameters = new List<Parameter>();

            var metaObjectLinkedReport = metaObjectEx.LinkedEntity as Report;

            if (metaObjectLinkedReport != null)
            {
                if (metaObjectEx.ParametricDialog != null && metaObjectEx.ParametricDialog.Descriptors.Any())
                {
                    reportParameters = PrepareSystemParameters(metaObjectEx.ParametricDialog.Descriptors);
                }

                MetaObjectLinkedDataSet = metaObjectEx.GetLinkedDataSource();

                if (MetaObjectLinkedDataSet != null)
                {

                    var tables = MetaObjectLinkedDataSet.Tables
                        .Cast<DataTable>()
                        .ToList();

                    var reportParameterTable = tables
                        .FirstOrDefault(t => t.TableName == DbTablePermanentResources.DefaultReportParameterTableName);

                    // делаем копию свободных параметров из параметрика
                    var copyReportParameters = new Parameter[reportParameters.Count];
                    reportParameters.CopyTo(copyReportParameters);

                    // присоединяем параметры из источника данных
                    if (reportParameterTable != null)
                    {
                        foreach (DataRow row in reportParameterTable.Rows)
                        {
                            reportParameters.Add(new Parameter
                            {
                                Name = (string) row[DbTablePermanentResources.NameColumn],
                                Value = (string) row[DbTablePermanentResources.ValueColumn]
                            });
                        }
                    }

                    // дополняем таблицу "ReportParameter" свободными параметрами из параметрика
                    if (reportParameterTable != null)
                    {
                        foreach (var copyReportParameter in copyReportParameters)
                        {

                            var row = reportParameterTable.NewRow();
                            row[DbTablePermanentResources.NameColumn] = copyReportParameter.FullName;
                            row[DbTablePermanentResources.ValueColumn] = copyReportParameter.Value;
                            reportParameterTable.Rows.Add(row);
                        }
                    }

                    // выбор целевого отчета
                    if (metaObjectLinkedReport.ReportTypeId == 2)
                    {
                        var selectors = _databaseContext.Set<ReportSelector>()
                            .Where(rs => rs.SelectorReportId == metaObjectLinkedReport.Id)
                            .ToList();

                        DoReportProcessing(selectors, reportParameters, (selector) =>
                        {
                            var targetReport = _databaseContext
                                .Set<Report>()
                                .FirstOrDefault(r => r.Id == ((ReportSelector) selector).TargetReportId);

                            if (targetReport != null)
                            {
                                metaObjectLinkedReport = targetReport;
                            }
                        });
                    }
                    if (report != null)
                    {
                        using (var reportStream = new MemoryStream(metaObjectLinkedReport.File))
                        {
                            report.Load(reportStream);

                            CustomerLogoInjector(report, metaObjectEx);

                            if (outlineBuilder != null)
                            {
                                outlineBuilder(report);
                            }
                        }
                    }

                    // применение плагинов препроцессинга отчета и/или его источника данных
                    if (metaObjectLinkedReport.HasPluginProcessing)
                    {
                        var selectors = _databaseContext.Set<ReportPluginSelector>()
                            .Where(rps => rps.ReportId == metaObjectLinkedReport.Id)
                            .ToList();

                        DoReportProcessing(selectors, reportParameters, (selector) =>
                        {
                            var pluginType = Type.GetType(((ReportPluginSelector) selector).TypeName);

                            if (pluginType != null)
                            {
                                var plugin = (IReportPlugin) Activator.CreateInstance(pluginType, new object[]
                                {
                                    MetaObjectLinkedDataSet,
                                    reportParameters
                                });

                                if (plugin != null)
                                {
                                    var parentMetaObjectExPropertyInfo = plugin.GetType()
                                        .GetProperty(ParametricParameterResources.ParentMetaObjectEx);

                                    if (parentMetaObjectExPropertyInfo != null)
                                    {
                                        parentMetaObjectExPropertyInfo.SetValue(plugin, metaObjectEx);
                                    }
                                    plugin.Execute();
                                }
                            }
                        });
                    }

                    if (report != null)
                    {
                        if (reportParameters.Any())
                        {
                            report.Parameters.AddRange(reportParameters.ToArray());
                        }

                        report.ReportInfo.Description = metaObjectLinkedReport.Description;

                        RegisterReportDataSource(report);
                    }
                }
            } //
        }

        /// <summary>
        /// Процессинг отчета на основе селектора отчетов или селектора плагинов отчетов 
        /// </summary>
        private void DoReportProcessing
        (
            IEnumerable<IReportSelector> selectors, List<Parameter> reportParameters,
            Action<IReportSelector> processingAction
        )
        {
            var reportSelectors = selectors as IList<IReportSelector> ?? selectors.ToList();

            if (reportSelectors.Any())
            {
                var scriptScope = CreateScriptEngineScope(reportParameters);

                foreach (var selector in reportSelectors)
                {
                    var predicateExpressionResult = false;
                    var hasProcessError = false;
                    try
                    {
                        var source = scriptScope.Engine.CreateScriptSourceFromString(((IPredicateExpressionMedium)selector).PredicateExpression);
                        predicateExpressionResult = source.Execute<bool>(scriptScope);
                    }
                    catch (Exception)
                    {
                        hasProcessError = true;
                    }

                    if (!hasProcessError && predicateExpressionResult)
                    {
                        processingAction(selector);
                    }
                }
            }
        }

        /// <summary>
        /// Порождение cкриптовой машины, настройка ее окружения с передачей параметров отчета 
        /// </summary>        
        private static ScriptScope CreateScriptEngineScope(List<Parameter> reportParameters)
        {
            var scriptEngine = Python.CreateEngine();
            var scriptScope = scriptEngine.CreateScope();

            reportParameters.ForEach(p => { scriptScope.SetVariable(p.Name, p.Value); });
            return scriptScope;
        }

        private void RegisterReportDataSource(FastReportReport report)
        {
            var reportRegisterDataSet = new DataSet();

            var serviceTableNames = new[]
            {
                DbTablePermanentResources.DefaultResultSetNameTableName,
                DbTablePermanentResources.DefaultReportParameterTableName
            };

            var dataTables = MetaObjectLinkedDataSet.Tables.Cast<DataTable>()
                .Where(t => !serviceTableNames.Contains(t.TableName))
                .ToList();

            foreach (var table in dataTables)
            {
                reportRegisterDataSet.Tables.Add(table.Copy());
            }

            report.RegisterData(reportRegisterDataSet);

            foreach (DataTable table in dataTables)
            {
                var dataBand = report.FindObject(table.TableName + "Band") as DataBand;

                if (dataBand != null)
                {
                    report.GetDataSource(table.TableName).Enabled = true;
                    dataBand.DataSource = report.GetDataSource(table.TableName);
                }
            }
        }

        /// <summary>
        /// Подготавливает системные опции, которые требуются для работы отчета
        /// </summary>
        /// <param name="descriptors">Описатели опций</param>
        private List<Parameter> PrepareSystemParameters(IEnumerable<FormLayoutItemDescriptor> descriptors)
        {
            var parameters = new List<Parameter>();

            foreach (var descriptor in descriptors)
            {
                if (descriptor.ParameterValueSourceType == ParameterValueSourceType.FromSetting)
                {
                    // TODO
                }
                else
                {
                    if (descriptor.TypeCode != TypeCode.Empty)
                    {
                        parameters.Add(new Parameter
                        {
                            Name = descriptor.Name.Capitalize(),
                            Value = 
                                (descriptor.TypeCode == TypeCode.Decimal || descriptor.TypeCode == TypeCode.Double || descriptor.TypeCode == TypeCode.Single) 
                                    ? Convert.ChangeType(descriptor.Value, descriptor.TypeCode, CultureInfo.InvariantCulture)
                                    : Convert.ChangeType(descriptor.Value, descriptor.TypeCode)

                        });
                    }
                }
            }
            return parameters;
        }
    }
}