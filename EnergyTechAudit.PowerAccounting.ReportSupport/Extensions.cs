using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Data;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport
{
    public static class Extensions
    {
        public static DataRow GetReportParameterRow(this DataTable reportParameterTable, string paramName)
        {
            return reportParameterTable.Rows.Cast<DataRow>()
                .FirstOrDefault(row => Convert.ToString(row[DbTablePermanentResources.NameColumn]).Equals(paramName, StringComparison.Ordinal));
        }

        /// <summary>
        /// Возвращает дату в формате SQL
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string GetDateStringInSqlStyle(this DateTime dt)
        {
            return string.Format(StringFormatResources.DateStringInSqlStyle, dt.Year, dt.Month, dt.Day, dt.Hour, dt.Minute, dt.Second);
        }

        /// <summary>
        /// Получает представление времени в формате Unix по текущей дате
        /// </summary>
        /// <param name="dt">Текущая дата</param>
        public static int ConvertToUnixTime(this DateTime dt)
        {
            return (Int32)(dt.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;
        }
    }
}
