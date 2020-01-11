using System.Data.SqlTypes;
using System.Text.RegularExpressions;
using Microsoft.SqlServer.Server;

namespace EnergyTechAudit.PowerAccounting.Database.Programmability.Clr
{
    public partial class TextHelper
    {
        [SqlFunction
            (            
            DataAccess = DataAccessKind.None,
            IsDeterministic = true,
            IsPrecise = true,
            Name = "RegExReplace",
            SystemDataAccess = SystemDataAccessKind.None
            )
        ]
        public static SqlString RegExReplace(SqlString input, SqlString pattern, SqlString replacement)
        {
            if (input.IsNull || pattern.IsNull)
            {
                return SqlString.Null;
            }

            return new SqlString
                (
                Regex.Replace
                    (
                        input.Value,
                        pattern.Value,
                        replacement.Value,
                        RegexOptions.IgnoreCase | RegexOptions.Multiline
                    )
                );
        }

        [SqlFunction
            (
            DataAccess = DataAccessKind.None,
            IsDeterministic = true,
            IsPrecise = true,
            Name = "TrimEnd",
            SystemDataAccess = SystemDataAccessKind.None
            )
        ]
        public static SqlString TrimEnd(SqlString input, SqlChars pattern)
        {
            return new SqlString(input.ToString().TrimEnd(pattern.Value));
        }

        [SqlFunction
            (
            DataAccess = DataAccessKind.None,
            IsDeterministic = true,
            IsPrecise = true,
            Name = "TrimStart",
            SystemDataAccess = SystemDataAccessKind.None
            )
        ]
        public static SqlString TrimStart(SqlString input, SqlChars pattern)
        {
            return new SqlString(input.ToString().TrimStart(pattern.Value));
        }

        [SqlFunction
            (
            DataAccess = DataAccessKind.None,
            IsDeterministic = true,
            IsPrecise = true,
            Name = "Trim",
            SystemDataAccess = SystemDataAccessKind.None
            )
        ]
        public static SqlString Trim(SqlString input, SqlChars pattern)
        {
            return new SqlString(input.ToString().Trim(pattern.Value));
        }
        
    }
}