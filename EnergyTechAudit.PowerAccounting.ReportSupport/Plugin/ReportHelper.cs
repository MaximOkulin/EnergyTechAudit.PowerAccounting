using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public static class ReportHelper
    {
        /// <summary>
        /// Возвращает строчку таблицы по заданному времени
        /// </summary>
        /// <param name="dataTable"></param>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static DataRow GetDataRowByDate(DataTable dataTable, DateTime dt)
        {
            return dataTable.Rows.Cast<DataRow>().FirstOrDefault(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) == dt);
        }

        /// <summary>
        /// Возвращает список строчек таблицы по стартовому и конечному временам
        /// </summary>
        /// <param name="dataTable"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <returns></returns>
        public static List<DataRow> GetDataRowsByDates(DataTable dataTable, DateTime startDate, DateTime endDate)
        {
            return dataTable.Rows.Cast<DataRow>().Where(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) >= startDate &&
                                                                          Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) <= endDate).ToList();
        }
    }
}
