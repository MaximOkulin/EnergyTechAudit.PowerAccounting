using System;
using System.Data.Entity;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin.UserManager;

namespace EnergyTechAudit.PowerAccounting.DataAccess
{
    public sealed class UserManagerDatabaseContext : DbContext, IDatabaseContext, IDependencyType
    {
        static UserManagerDatabaseContext()
        {
            Database.SetInitializer<UserManagerDatabaseContext>(null);
        }

        public UserManagerDatabaseContext(): base("Name=DatabaseContext")
        {
            Configuration.LazyLoadingEnabled = false;
            Configuration.ProxyCreationEnabled = false;
            Configuration.AutoDetectChangesEnabled = false;
        }

        [SuppressMessage("Microsoft.Design", "CA1062:Validate arguments of public methods", MessageId = "0")]
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new UserManagerRoleMapping());
            modelBuilder.Configurations.Add(new UserManagerUserMapping());
            modelBuilder.Configurations.Add(new UserManagerUserAdditionalInfoMapping());
            modelBuilder.Configurations.Add(new UserManagerPlacementMapping());

            base.OnModelCreating(modelBuilder);
        }

        IQueryable<T> IDatabaseContext.Set<T>()
        {
            return Set<T>();
        }

        int IDatabaseContext.SaveChanges()
        {
            return base.SaveChanges();
        }

        T IDatabaseContext.Add<T>(T entity)
        {
            return Set<T>().Add(entity);
        }

        T IDatabaseContext.Remove<T>(T entity)
        {
            throw  new NotImplementedException();
        }
    }
}