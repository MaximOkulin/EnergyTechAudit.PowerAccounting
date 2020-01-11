using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using Microsoft.SqlServer.Server;

namespace EnergyTechAudit.PowerAccounting.Database.Programmability.Clr
{
    public partial class HtmlStatusConnectionBarHelper
    {
        private const int LowBound = 1;
        private const int HighBound = 20;
        private const int Half = 10;
        private const int DefaultStatusConnectionId = 1;

        private const string QueryTemplate = @"SELECT [Id], [{0}Id] [EntityId], [StatusConnectionId]    
                      FROM 
                      (
                        SELECT
                              [SCL1].[Id],
                              ROW_NUMBER() OVER(PARTITION BY [SCL1].[{0}Id] ORDER BY [SCL1].[ConnectionTime] DESC) [Num],                              
                              [SCL1].[StatusConnectionId] [StatusConnectionId], 
                              [SCL1].[{0}Id] [{0}Id]           
                            FROM [Business].[{0}StatusConnectionLog] [SCL1] WITH (NOLOCK)             
                      ) [SCL2] 
                    WHERE [SCL2].[Num] BETWEEN 1 AND 20 AND ([SCL2].[{0}Id] = @entityId OR @entityId IS NULL)";

        private class StatusConnectionBar
        {
            public SqlInt32 EntityId { get; set; }
            public SqlString HtmlTable { get; set; }
        }

        private static void GetHtmlStatusConnectionBar_FillRow(object resultObj, out SqlInt32 entityId, out SqlString htmlTable)
        {
            var result = (StatusConnectionBar)resultObj;

            entityId = result.EntityId;
            htmlTable = result.HtmlTable;
        }

        [
        SqlFunction
            (
                DataAccess = DataAccessKind.Read, 
                FillRowMethodName = "GetHtmlStatusConnectionBar_FillRow",
                TableDefinition = "EntityId INT, HtmlTable NVARCHAR(1800)"
            )
        ]
        public static IEnumerable GetHtmlStatusConnectionBar(SqlInt32 entityId, SqlString entityTypeName)
        {
            DataTable table;

            using (SqlConnection connection = new SqlConnection("context connection=true"))
            {
                connection.Open();

                SqlCommand command = null;

                var query = string.Format(QueryTemplate, entityTypeName);

                using (command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add(new SqlParameter
                    {
                        ParameterName = "@entityId",
                        Value = entityId
                    });

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        table = new DataTable();
                        table.Load(reader);                        
                    }
                }
            }
            
            try
            {
                return table.Rows.Cast<DataRow>()
                .GroupBy(row => row["EntityId"])
                .Select(groupRowsByMid =>
                {
                    var cells = string.Empty;
                    var rows = string.Empty;

                    var i = LowBound;

                    var count = groupRowsByMid.Count();

                    var entId = (int)groupRowsByMid.Key;

                    IEnumerable<DataRow> groupRows;
                    
                    if (count < HighBound)
                    {

                        groupRows = groupRowsByMid
                            .Concat(Enumerable.Range(LowBound, HighBound - count)
                                .Select(dataRow =>
                                {
                                    var paddedRow = table.NewRow();
                                    paddedRow["Id"] = default(int);
                                    paddedRow["EntityId"] = entId;
                                    paddedRow["StatusConnectionId"] = DefaultStatusConnectionId;
                                    return paddedRow;
                                }));
                    }
                    else
                    {
                        groupRows = groupRowsByMid;
                    }

                    foreach (var dataRow in groupRows)
                    {

                        cells = string.Format("{0}<td data-id='{1}' data-sid='{2}'></td>", cells,
                            dataRow["Id"],
                            dataRow["StatusConnectionId"]);

                        if (i % Half == default(int))
                        {
                            rows = string.Format("{0}<tr>{1}</tr>", rows, cells);
                            cells = string.Empty;
                        }
                        i++;
                    }

                    var html =
                        string.Format
                            (
                                "<table data-core-entityTypeName='{2}' data-core-entityId='{0}' class='statusConnectionBar'><tbody>{1}</tbody></table>",
                                entId,
                                rows,
                                entityTypeName
                            );

                    return new StatusConnectionBar
                    {
                        EntityId = entId,
                        HtmlTable = html
                    };

                });
            }
            finally
            {
                table.Dispose();
            }
        }
    }
}
