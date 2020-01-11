using System.Data;

namespace EnergyTechAudit.PowerAccounting.DataAccess.Helper
{    
    public static class DataTableExtension
    {
        public static void DeepTableCopy(this DataTable table, string newTableName)
        {
            var copiedTable = table.Copy();
            copiedTable.TableName = newTableName;
            table.DataSet.Tables.Add(copiedTable);
        }
    }
}
