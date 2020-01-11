using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace EnergyTechAudit.PowerAccounting.DataAccess.Interfaces
{
    public interface IDbContextConsumer<in T> : IDisposable where T : DbContext
    {
        void Consume(IDbContextFactory<T> contextFactory);
    }
}