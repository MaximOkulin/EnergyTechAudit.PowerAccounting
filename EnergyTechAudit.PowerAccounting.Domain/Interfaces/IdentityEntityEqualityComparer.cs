using System.Collections.Generic;

using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    /// <summary>
    /// Обобщенный компаратор сущностных классов  на основе сравнения их идентификаторов
    /// </summary>
    /// <typeparam name="T">Наследник IEntity</typeparam>
    public class IdentityEntityEqualityComparer<T> : IEqualityComparer<T> where T : IEntity
    {
        public bool Equals(T x, T y)
        {
            return x.Id == y.Id;
        }

        public int GetHashCode(T obj)
        {
            return base.GetHashCode();
        }
    }
}