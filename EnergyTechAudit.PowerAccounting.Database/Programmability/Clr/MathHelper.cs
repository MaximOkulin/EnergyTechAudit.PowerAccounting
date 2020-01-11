using System.Data.SqlTypes;
using System.Globalization;
using Microsoft.SqlServer.Server;

namespace EnergyTechAudit.PowerAccounting.Database.Programmability.Clr
{
    public partial class MathHelper
    {        
        [SqlFunction]
        [return: SqlFacet(Precision = 38, Scale = 7)]
        public static SqlDecimal ConvertMeasurementUnit
        (
            [SqlFacet(Precision = 20, Scale = 7)]SqlDecimal dimention1,
            [SqlFacet(Precision = 20, Scale = 7)]SqlDecimal dimention2, 
            [SqlFacet(Precision = 19, Scale = 7)]SqlDecimal value, 
            SqlString expression
        )
        {
            
            if (!dimention1.IsNull && !dimention2.IsNull && !value.IsNull && !expression.IsNull)
            {
                string exp = expression.ToString();
                string val = value.ToString();
                string dim1 = dimention1.ToString();
                string dim2 = dimention2.ToString();

                MathParser parser = new MathParser
                    (
                    CultureInfo.InvariantCulture.NumberFormat.NumberDecimalSeparator[0]
                    );

                exp = string.Format
                    (
                        CultureInfo.InvariantCulture,
                        "(({0}) * {1}) / {2}", exp.Replace("x", val), dim1, dim2
                    );

                var expCalcResult = parser.Parse(exp);
                return new SqlDecimal(expCalcResult);
            }
            else
            {
                return value;
            }            
        }
    }
}
