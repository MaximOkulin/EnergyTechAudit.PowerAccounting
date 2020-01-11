using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

namespace EnergyTechAudit.PowerAccounting.Database.Programmability.Clr
{
    public partial class HtmlGridHyperLink
    {
        [SqlFunction]
        public static SqlString GetGridHyperlink(
            SqlString entityTypeName, SqlString entityPropertyName, SqlInt32 entityId, 
            SqlString commandName, SqlString caption)
        {
            return new SqlString( string.Format
                (
                    "<a href='javascript:;' data-core-entity-id='{0}' data-core-entity-type-name='{1}' data-core-entity-property-name='{2}' data-core-command-{3}>{4}</a>",
                    entityId, 
                    entityTypeName, 
                    entityPropertyName, 
                    commandName, 
                    caption
                ));
        }
    }
}