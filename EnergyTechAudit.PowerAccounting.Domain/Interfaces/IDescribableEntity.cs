using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Threading.Tasks;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    public interface IDescribableEntity
    {
        string Description { get; set; }
        void CalculateDescription(IObjectContextAdapter contextAdapter);
    }

    public interface IMutant
    {
        Task Mutate(IObjectContextAdapter contextAdapter);
    }
    /// <summary>
    /// Интерфейс сущности реализующей элементы собственной комплексной валидацией
    /// </summary>
    public interface IValidatableEntityObject
    {
        DbEntityValidationResult Validate
        (
            IObjectContextAdapter context,
            DbEntityEntry entityEntry,
            IDictionary<object, object> items
        );
    }

    public interface ICommentableEntity
    {
        string Comments { get; set; }
    }
}