using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.ReportSupport.Types;
using FastReport.Data;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public abstract class ReportPluginBase : IReportPlugin
    {
        protected DataSet DataSource { get; set; }

        protected List<Parameter> Parameters { get; set; }

        private IEnumerable<object> _parameters;

        public ReportPluginBase(object dataSource, IEnumerable<object> parameters)
        {
            _parameters = parameters;
            DataSource = (DataSet) dataSource;
            UpdateParameters();
        }

        protected void UpdateParameters()
        {
            Parameters = _parameters.Cast<Parameter>().ToList();
        }

        protected void AddParameter<T>(string name, object value)
        {
            ((List<Parameter>)_parameters).Add(new Parameter
            {
                Name = name,
                Value = value,
                DataType = typeof(T)
            });
        }

        protected T GetParameterValue<T>(string name)
        {
            var parameter = Parameters.Find(p => p.Name == name);
            T value;
            if (parameter != null)
            {
                var type = typeof(T);
                var typeCode = Type.GetTypeCode(type);

                value = (T)Convert.ChangeType(parameter.Value, typeCode,
                    typeCode == TypeCode.DateTime || (typeCode == TypeCode.Decimal && Convert.ToString(parameter.Value).Contains(NumberFormatInfo.CurrentInfo.NumberDecimalSeparator))
                        ? CultureInfo.CurrentCulture
                        : CultureInfo.InvariantCulture);
            }
            else
            {
                throw new Exception($"Parameter {name} not found"); 
            }
            return value;
        }
        public virtual void Execute()
        {            
        }
        
    }
}