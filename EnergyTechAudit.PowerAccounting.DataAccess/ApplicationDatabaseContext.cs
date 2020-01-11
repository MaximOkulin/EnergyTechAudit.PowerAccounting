using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Mapping;
using System.Data.Entity.Core.Metadata.Edm;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using DevExpress.Data.Filtering;
using DevExpress.Data.Linq;
using DevExpress.Data.Linq.Helpers;
using EnergyTechAudit.PowerAccounting.Common.Entity;
using EnergyTechAudit.PowerAccounting.Common.Enumerable;
using EnergyTechAudit.PowerAccounting.Common.Helpers;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin;
using EnergyTechAudit.PowerAccounting.Domain.Mapping.Business;
using EnergyTechAudit.PowerAccounting.Domain.Mapping.Core;
using EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries;
using EnergyTechAudit.PowerAccounting.Domain.Mapping.Help;
using EnergyTechAudit.PowerAccounting.Domain.Mapping.Rules;
using EnergyTechAudit.PowerAccounting.Domain.Mapping.WebApi;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using EnergyTechAudit.PowerAccounting.Domain.Models.Help;
using EnergyTechAudit.PowerAccounting.Web.Resources;


namespace EnergyTechAudit.PowerAccounting.DataAccess
{

    public class ApplicationDatabaseContext : DbContext, IDatabaseContext, IDependencyType
    {
        private readonly DatabaseContextHistoryChangeTracker _historyChangeTracker;

        private DataSet _executeQueryResultSet;
        
        static ApplicationDatabaseContext()
        {
            Database.SetInitializer<ApplicationDatabaseContext>(null);
        }
        
        public override int SaveChanges()
        {
            _historyChangeTracker.SaveChanges();
            return base.SaveChanges();                                
        }

        public override Task<int> SaveChangesAsync()
        {            
            _historyChangeTracker.SaveChanges();
            return base.SaveChangesAsync();
        }

        protected override bool ShouldValidateEntity(DbEntityEntry entityEntry)
        {
            if ((object)entityEntry == null)
                throw new ArgumentNullException();
            
            return entityEntry.State == EntityState.Added || entityEntry.State == EntityState.Modified ||
                    (entityEntry.Entity is IValidatableEntityObject && entityEntry.State == EntityState.Deleted);
        }

        protected override DbEntityValidationResult ValidateEntity
            (
                DbEntityEntry entityEntry,
                IDictionary<object, object> items
            )
        {
            if (entityEntry.Entity is IValidatableEntityObject)
            {
                var validationResult = ((IValidatableEntityObject)entityEntry.Entity).Validate(this, entityEntry, items);
                if (validationResult.ValidationErrors.Count > 0)
                {
                    return validationResult;
                }
            }
            
            return base.ValidateEntity(entityEntry, items);
        }

        public ApplicationDatabaseContext() : base("Name=DatabaseContext")
        {
            Configuration.EnsureTransactionsForFunctionsAndCommands = true;
            
            Configuration.LazyLoadingEnabled = false;
            Configuration.ProxyCreationEnabled = false;
            Configuration.AutoDetectChangesEnabled = false;

            _historyChangeTracker = new DatabaseContextHistoryChangeTracker(this);
        }

        /// <summary>
        /// Возвращает имя схемы таблицы в соответствии с именем ее типа
        /// </summary>
        /// <param name="entityTypeName"></param>        
        public string GetScheme(string entityTypeName)
        {
            var scheme = string.Empty;

            var storageMetadata = ((IObjectContextAdapter)this)
                .ObjectContext.MetadataWorkspace
                .GetItems<EntityContainerMapping>(DataSpace.CSSpace);

            foreach (var entityContainerMapping in storageMetadata)
            {
                EntitySet entitySet;
                if (entityContainerMapping.StoreEntityContainer.TryGetEntitySetByName(entityTypeName, true, out entitySet))
                {
                    scheme = entitySet.Schema;
                    break;
                }
            }

            return scheme;
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (_executeQueryResultSet != null)
                {
                    _executeQueryResultSet.Dispose();
                    _executeQueryResultSet = null;
                }
            }
            base.Dispose(disposing);
        }

        public DbSet<Mnemoscheme> Mnemoschemes { get; set; }

        public DbSet<StatusConnection> StatusConnections { get; set; }
        
        public DbSet<TypeConnection> TypeConnections { get; set; }        

        public DbSet<ErrorLogEntry> ErrorLogEntries { get; set; }

        public DbSet<User> Users { get; set; }

        public DbSet<Role> Roles { get; set; }

        public DbSet<City> Cities { get; set; }

        public DbSet<PlacementPurpose> PlacementPurposes { get; set; }

        public DbSet<BuildingPurpose> BuildingPurposes { get; set; }

        public DbSet<MeasurementUnit> MeasurementUnits { get; set; }

        public DbSet<ResourceSystemType> ResourceSystemTypes { get; set; }

        public DbSet<PhysicalParameter> PhysicalParameters { get; set; }

        public DbSet<DeviceEventParameter> DeviceEventParameters { get; set; }

        public DbSet<Device> Devices { get; set; }

        public DbSet<MeasurementDevice> MeasurementDevices { get; set; }

        public DbSet<AccessPoint> AccessPoints { get; set; }

        public DbSet<Building> Buildings { get; set; }

        public DbSet<AccessPointLinkBuilding> AccessPointLinksBuilding { get; set; }

        public DbSet<UserAdditionalInfo> UserAdditionalInfos { get; set; }

        public DbSet<Placement> Placements { get; set; }

        public DbSet<Channel> Channels { get; set; }

        public DbSet<ChannelTemplate> ChannelTemplates { get; set; }

        public DbSet<Menu> Menus { get; set; }

        public DbSet<MenuItem> MenuItems { get; set; }

        public DbSet<MetaObject> MetaObjects { get; set; }

        public DbSet<MetaObjectType> MetaObjectTypes { get; set; }

        public DbSet<Dictionary> Dictionaries { get; set; }

        public DbSet<Pivot> Pivots { get; set; }
        
        public DbSet<AgreementSystemParameter> AgreementSystemParameters { get; set; }

        public DbSet<Dimension> Dimensions { get; set; }

        public DbSet<Parameter> Parameters { get; set; }

        public DbSet<TimeSignature> TimeSignatures { get; set; }

        public DbSet<PeriodType> PeriodTypes { get; set; }

        public DbSet<Archive> Archives { get; set; }

        public DbSet<Report> Reports { get; set; }

        public DbSet<Parametric> Parametrics { get; set; }

        public DbSet<Source> Sources { get; set; }

        public DbSet<Query> Queries { get; set; }

        public DbSet<News> News { get; set; }

        public DbSet<Form> Forms { get; set; }

        public DbSet<Baud> Bauds { get; set; }

        public DbSet<Parity> Parities { get; set; }

        public DbSet<StopBit> StopBits { get; set; }

        public DbSet<ComPort> ComPorts { get; set; }
        public DbSet<DataBit> DataBits { get; set; }

        public DbSet<TransportType> TransportTypes { get; set; }        

        public DbSet<DeviceEvent> DeviceEvents { get; set; }

        public DbSet<TransportServerModel> TransportServerModels { get; set; }

        public DbSet<DeviceReader> DeviceReaders { get; set; }

        public DbSet<Gender> Genders { get; set; }
        public DbSet<District> Districts { get; set; }
        
        public DbSet<DeviceReaderErrorLog> DeviceReaderErrorLogs { get; set; }

        public DbSet<Hub> Hubs { get; set; }

        public DbSet<Article> Articles { get; set; }
        public DbSet<Picture> Pictures { get; set; }

        
        public DbSet<UserLinkChannel> UserLinksChannel { get; set; }

        public DbSet<EntityHistory> EntityHistories{ get; set; }

        public DbSet<EntityTree> EntityTrees { get; set; }

        public DbSet<EntityTreeLinkRole> EntityTreeLinksRole { get; set; }
        
        public DbSet<AccessPointStatusConnectionLog> AccessPointStatusConnectionLogs { get; set; }

        public DbSet<SubsystemType> SubsystemTypes { get; set; }

        public DbSet<RegulatorParameterValue> RegulatorParameterValues { get; set; }

        public DbSet<Entity> Entities { get; set; }

        public DbSet<EntityProperty> EntityProperties { get; set; }

        public DbSet<Processing> Processings { get; set; }

        public DbSet<MeasurementDeviceStatusConnectionLog> MeasurementDeviceStatusConnectionLogs { get; set; }

        public DbSet<DeviceParameter> DeviceParameters { get; set; }

        public DbSet<ParameterMapDeviceParameter> ParameterLinkDeviceParameters { get; set; }

        public DbSet<CsdModem> CsdModems { get; set; }
        
        public DbSet<PortType> PortTypes { get; set; }

        public DbSet<DynamicParameterValue> DynamicParameterValues { get; set; }

        public DbSet<MobileDevice> MobileDevices { get; set; }

        public DbSet<MobileGeolocationServicingMarker> MobileGeolocationServicingMarkers { get; set; }


        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new UserMapping());
            modelBuilder.Configurations.Add(new RoleMapping());
            modelBuilder.Configurations.Add(new DictionaryMapping());
            modelBuilder.Configurations.Add(new StatusConnectionMapping());
            modelBuilder.Configurations.Add(new TypeConnectionMapping());
            modelBuilder.Configurations.Add(new ErrorLogEntryMapping());            
            modelBuilder.Configurations.Add(new CityMapping());
            modelBuilder.Configurations.Add(new PlacementPurposeMapping());
            modelBuilder.Configurations.Add(new BuildingPurposeMapping());
            modelBuilder.Configurations.Add(new MeasurementUnitMapping());
            modelBuilder.Configurations.Add(new ResourceSystemTypeMapping());
            modelBuilder.Configurations.Add(new PhysicalParameterMapping());
            modelBuilder.Configurations.Add(new DeviceEventParameterMapping());
            modelBuilder.Configurations.Add(new DeviceMapping());
            modelBuilder.Configurations.Add(new MeasurementDeviceMapping());
            modelBuilder.Configurations.Add(new AccessPointMapping());            
            modelBuilder.Configurations.Add(new BuildingMapping());
            modelBuilder.Configurations.Add(new AccessPointLinkBuildingMapping());
            modelBuilder.Configurations.Add(new UserAdditionalInfoMapping());
            modelBuilder.Configurations.Add(new PlacementMapping());
            modelBuilder.Configurations.Add(new ChannelMapping());
            modelBuilder.Configurations.Add(new ChannelTemplateMapping());
            modelBuilder.Configurations.Add(new MetaObjectMapping());
            modelBuilder.Configurations.Add(new MetaObjectTypeMapping());
            modelBuilder.Configurations.Add(new MenuMapping());
            modelBuilder.Configurations.Add(new MenuItemMapping());
            modelBuilder.Configurations.Add(new PivotMapping());            
            modelBuilder.Configurations.Add(new AgreementSystemParameterMapping());
            modelBuilder.Configurations.Add(new DimensionMapping());
            modelBuilder.Configurations.Add(new ParameterMapping());
            modelBuilder.Configurations.Add(new TimeSignatureMapping());
            modelBuilder.Configurations.Add(new PeriodTypeMapping());
            modelBuilder.Configurations.Add(new ArchiveMapping());
            modelBuilder.Configurations.Add(new ReportMapping());
            modelBuilder.Configurations.Add(new ParametricMapping());
            modelBuilder.Configurations.Add(new SourceMapping());
            modelBuilder.Configurations.Add(new QueryMapping());
            modelBuilder.Configurations.Add(new NewsMapping());
            modelBuilder.Configurations.Add(new FormMapping());
            modelBuilder.Configurations.Add(new BaudMapping());
            modelBuilder.Configurations.Add(new ParityMapping());
            modelBuilder.Configurations.Add(new StopBitMapping());
            modelBuilder.Configurations.Add(new ComPortMapping());
            modelBuilder.Configurations.Add(new DataBitMapping());
            modelBuilder.Configurations.Add(new TransportTypeMapping());            
            modelBuilder.Configurations.Add(new DeviceEventMapping());
            modelBuilder.Configurations.Add(new TransportServerModelMapping());
            modelBuilder.Configurations.Add(new DeviceReaderMapping());
            modelBuilder.Configurations.Add(new GenderMapping());
            modelBuilder.Configurations.Add(new DistrictMapping());
            modelBuilder.Configurations.Add(new DeviceReaderErrorLogMapping());
            modelBuilder.Configurations.Add(new HubMapping());
            modelBuilder.Configurations.Add(new UserLinkChannelMapping());
            modelBuilder.Configurations.Add(new MnemoschemeMapping());
            modelBuilder.Configurations.Add(new EntityHistoryMapping());
            modelBuilder.Configurations.Add(new DeletedEntityLogEntryMapping());
            modelBuilder.Configurations.Add(new EntityTreeMapping());
            modelBuilder.Configurations.Add(new EntityTreeLinkRoleMapping());
            modelBuilder.Configurations.Add(new MetaObjectLinkDeviceMapping());
            modelBuilder.Configurations.Add(new MetaObjectLinkRoleMapping());
            modelBuilder.Configurations.Add(new MetaObjectReferenceMeasurementDeviceMapping());
            modelBuilder.Configurations.Add(new PivotDiagrammMapping());
            modelBuilder.Configurations.Add(new DiagrammMapping());
            modelBuilder.Configurations.Add(new MapInfoWindowMapping());
            modelBuilder.Configurations.Add(new GoogleMapsStyleMapping());
            modelBuilder.Configurations.Add(new AuditMapping());
            modelBuilder.Configurations.Add(new AccessPointStatusConnectionLogMapping());
            modelBuilder.Configurations.Add(new SubsystemTypeMapping());
            modelBuilder.Configurations.Add(new RegulatorParameterValueMapping());
            modelBuilder.Configurations.Add(new EntityMapping());
            modelBuilder.Configurations.Add(new EntityPropertyMapping());
            modelBuilder.Configurations.Add(new ProcessingMapping());
            modelBuilder.Configurations.Add(new MeasurementDeviceStatusConnectionLogMapping());
            modelBuilder.Configurations.Add(new ReportSelectorMapping());
            modelBuilder.Configurations.Add(new DeviceParameterMapping());
            modelBuilder.Configurations.Add(new ParameterMapDeviceParameterMapping());
            modelBuilder.Configurations.Add(new AlertMapping());
            modelBuilder.Configurations.Add(new MeasurementUnitConverterMapping());
            modelBuilder.Configurations.Add(new DefaultMeasurementUnitMapping());
            modelBuilder.Configurations.Add(new CsdModemMapping());
            modelBuilder.Configurations.Add(new BinaryContentTypeMapping());
            modelBuilder.Configurations.Add(new BinaryMapping());
            modelBuilder.Configurations.Add(new PortTypeMapping());
            modelBuilder.Configurations.Add(new OrganizationMapping());
            modelBuilder.Configurations.Add(new OrganizationTypeMapping());
            modelBuilder.Configurations.Add(new ProcessingLogEntryMapping());
            modelBuilder.Configurations.Add(new ProcessingStatusMapping());
            modelBuilder.Configurations.Add(new UserMessageMapping());
            modelBuilder.Configurations.Add(new NewsLinkRoleMapping());
            modelBuilder.Configurations.Add(new DynamicParameterMapping());
            modelBuilder.Configurations.Add(new DeviceLinkDynamicParameterMapping());
            modelBuilder.Configurations.Add(new DynamicParameterValueMapping());
            modelBuilder.Configurations.Add(new CommandMenuTemplateMapping());
            modelBuilder.Configurations.Add(new CheckingAccountMapping());
            modelBuilder.Configurations.Add(new CheckingAccountLinkPlacementMapping());
            modelBuilder.Configurations.Add(new DeviceParameterSettingMapping());
            modelBuilder.Configurations.Add(new FaqMapping());
            modelBuilder.Configurations.Add(new FaqLinkRoleMapping());
            modelBuilder.Configurations.Add(new ParameterDictionaryMapping());
            modelBuilder.Configurations.Add(new ParameterDictionaryValueMapping());
            modelBuilder.Configurations.Add(new ProtocolSubTypeMapping());
            modelBuilder.Configurations.Add(new ReportPluginSelectorMapping());
            modelBuilder.Configurations.Add(new DeviceReaderTypeMapping());
            modelBuilder.Configurations.Add(new SystemSettingMapping());
            modelBuilder.Configurations.Add(new InternalDeviceEventMapping());
            modelBuilder.Configurations.Add(new MeasurementDeviceJournalMapping());
            modelBuilder.Configurations.Add(new ErrorTypeMapping());
            modelBuilder.Configurations.Add(new TemperatureProfileMapping());
            modelBuilder.Configurations.Add(new TechnologicAdjunctionTypeMapping());
            modelBuilder.Configurations.Add(new AgreementParameterTypeMapping());
            modelBuilder.Configurations.Add(new AgreementParameterMapping());
            modelBuilder.Configurations.Add(new ChannelLinkAgreementParameterMapping());
            modelBuilder.Configurations.Add(new ResourceSubsystemTypeMapping());
            modelBuilder.Configurations.Add(new SeasonTypeMapping());
            modelBuilder.Configurations.Add(new EmergencySituationParameterMapping());
            modelBuilder.Configurations.Add(new EmergencySituationParameterTemplateMapping());
            modelBuilder.Configurations.Add(new NotificationTypeMapping());
            modelBuilder.Configurations.Add(new EmergencyTimeSignatureMapping());
            modelBuilder.Configurations.Add(new EmergencyLogMapping());
            modelBuilder.Configurations.Add(new EmergencyMessageMapping());
            modelBuilder.Configurations.Add(new DeviceArchiveTimeConverterMapping());
            modelBuilder.Configurations.Add(new BriefcaseMapping());
            modelBuilder.Configurations.Add(new BriefcaseItemMapping());
            modelBuilder.Configurations.Add(new UserLinkEmergencyNotificationTypeMapping());
            modelBuilder.Configurations.Add(new ScheduleItemMapping());
            modelBuilder.Configurations.Add(new ScheduleTypeMapping());
            modelBuilder.Configurations.Add(new ArchiveDownloaderMapping());
            modelBuilder.Configurations.Add(new ArchiveDownloaderLinkScheduleItemMapping());            
            modelBuilder.Configurations.Add(new MeteoDataSourceTypeMapping());            
            modelBuilder.Configurations.Add(new ActionRequestStatisticItemMapping());
            modelBuilder.Configurations.Add(new MnemoschemeTypeMapping());
            modelBuilder.Configurations.Add(new ScriptMapping());
            modelBuilder.Configurations.Add(new UserAdditionalInfoLinkScheduleItemMapping());
            modelBuilder.Configurations.Add(new IntegrationArchiveInfoMapping());
            modelBuilder.Configurations.Add(new UserGroupMapping());
            modelBuilder.Configurations.Add(new DeviceReaderLinkScheduleItemMapping());
            modelBuilder.Configurations.Add(new DashboardExtentionTemplateMapping());
            modelBuilder.Configurations.Add(new MeasurementDeviceLinkScheduleItemMapping());
            modelBuilder.Configurations.Add(new DeviceTechnicalParameterMapping());


            #region Help
            modelBuilder.Configurations.Add(new ArticleMapping());
            modelBuilder.Configurations.Add(new PictureMapping());
            #endregion
        }

        /// <summary>
        /// Получает целевую сущность на основе цепочки типов, указания на идентификатор и имя исходного типа и целевого типа 
        /// </summary>     
        /// <exception cref="InvalidOperationException"></exception>   
        public async Task<object> GetEntityByNavigationChainAsync
            (
                Type[] typeNavigationChain, 
                EntityInfo leafEntityInfo, 
                Type targetEntityType,
                bool incudeAllGraph = false
            )
        {
            object targetObject = null;
            var leafEntityType = EntityTypeHelper.GetEntityTypeByName(leafEntityInfo.EntityTypeName);
            var leafEntityTypeIndex = Array.IndexOf(typeNavigationChain, leafEntityType);

            if (leafEntityType != null)
            {
                DbQuery entity = Set(leafEntityType);

                if (leafEntityType != targetEntityType || incudeAllGraph)
                {
                    var entityNavigationPath = string.Join
                        (
                            StringCharSet.Dot,
                            typeNavigationChain.Skip(leafEntityTypeIndex + 1).Select(t => t.Name)
                        );
                    if (!string.IsNullOrEmpty(entityNavigationPath))
                    {
                        entity = entity.Include(entityNavigationPath);
                    }                   
                }

                var convertor = new CriteriaToEFExpressionConverter();

                var criteriaOperator = CriteriaOperator.Parse
                    (
                        string.Format(InternalResources.KeyFilterExpressionTemplate, leafEntityInfo.EntityId)
                    );

                await entity.AppendWhere(convertor, criteriaOperator).LoadAsync();

                targetObject = Set(targetEntityType).Local.FirstOrDefaultObject();
            }
            return targetObject;
        }


        public IList<DictionaryEntityBase> GetDictionaryLocal(string dictionaryEntityName)
        {
            var entityType = EntityTypeHelper.GetEntityTypeByName(dictionaryEntityName);
            return Set(entityType).ToListAsync().Result.Cast<DictionaryEntityBase>().ToList();
        }

        
        public IQueryable<SystemSetting> GetSystemSettingsQueryable()
        {
            return Set<SystemSetting>();
        }

        public Task<DataSet> ExecuteQueryAsync(
            string sqlQuery,
            DbContextTransaction transaction = null,
            SqlParameter[] parameters = null
        )
        {
            return Task.Run(() => ExecuteQuery(sqlQuery, transaction, parameters));
        }

        public DataSet ExecuteQuery
        (
            string sqlQuery,
            DbContextTransaction transaction = null, 
            SqlParameter[] parameters = null
        )
        {            
            _executeQueryResultSet = new DataSet(DbTablePermanentResources.DefaultDataSetName);
            
            var sqlConnection = (SqlConnection) Database.Connection;
            using (var sqlCommand = new SqlCommand(sqlQuery, sqlConnection))
            {
                
                sqlCommand.CommandType = CommandType.Text;
                sqlCommand.CommandTimeout = 1200;

                if (parameters != null)
                {
                    sqlCommand.Parameters.AddRange(parameters);
                }

                sqlCommand.Transaction = transaction != null ? (SqlTransaction)transaction.UnderlyingTransaction : null;
                using (var sqlDataAdapter = new SqlDataAdapter(sqlCommand))
                {
                    sqlDataAdapter.Fill(_executeQueryResultSet);                    
                }
                
                var tables = _executeQueryResultSet.Tables.Cast<DataTable>().ToList();

                if (tables.Count > 1)
                {
                    // в соответствии с конвенциями считаем, что первая таблица должна 
                    // задавать осмысленные имена в наборе, который возвращает хранимая процедура 
                    var resultSetNameDataTable = tables.First();

                    var hasRequiredColumns = !resultSetNameDataTable.Columns.Cast<DataColumn>()
                        .Select(col => col.ColumnName)
                        .Except(new[] {DbTablePermanentResources.OrderColumn, DbTablePermanentResources.NameColumn})
                        .Any();

                    // назначаем остальным таблицам имена в порядке их следования 
                    if (hasRequiredColumns)
                    {
                        resultSetNameDataTable.TableName = DbTablePermanentResources.DefaultResultSetNameTableName;

                        foreach (DataRow row in resultSetNameDataTable.Rows)
                        {
                            var order = (int) row[DbTablePermanentResources.OrderColumn];
                            var name = (string) row[DbTablePermanentResources.NameColumn];
                            tables[order].TableName = name;
                        }
                    }
                }
            }
            return _executeQueryResultSet;
        }

        IQueryable<T> IDatabaseContext.Set<T>()
        {            
            return Set<T>();
        }
        int IDatabaseContext.SaveChanges()
        {            
            return SaveChanges();
        }

        T IDatabaseContext.Add<T>(T entity)
        {
            return Set<T>().Add(entity);
        }
        
        T IDatabaseContext.Remove<T>(T entity)
        {
            Set<T>().Attach(entity);
            return Set<T>().Remove(entity);
        }

        
    }
}
