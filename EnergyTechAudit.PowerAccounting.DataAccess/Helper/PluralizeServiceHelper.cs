using System.Data.Entity.Design.PluralizationServices;
using System.Globalization;

namespace EnergyTechAudit.PowerAccounting.DataAccess.Helper
{
    public static class PluralizeServiceHelper
    {
        public static string ToPlural(string singular)
        {
            return PluralizationService
                    .CreateService(CultureInfo.CreateSpecificCulture("en-US")).Pluralize(singular);
        }

        public static string ToSingular(string plural)
        {
            return PluralizationService
                .CreateService(CultureInfo.CreateSpecificCulture("en-US")).Singularize(plural);
        }
    }
}
