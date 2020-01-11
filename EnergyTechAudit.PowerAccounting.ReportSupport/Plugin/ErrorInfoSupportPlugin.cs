using System.Collections.Generic;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.ReportSupport.Helpers;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class ErrorInfoSupportPlugin : ReportPluginBase
    {
        private CommonHelper _commonHelper;
        public ErrorInfoSupportPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            _commonHelper = new CommonHelper(DataSource, Parameters);
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
            _commonHelper.SetErrorInfoColumn(mainDataTable);            
        }
    }
}
