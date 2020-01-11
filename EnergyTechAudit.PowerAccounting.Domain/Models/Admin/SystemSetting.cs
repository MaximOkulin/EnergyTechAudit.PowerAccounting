using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Configuration;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Threading.Tasks;
using System.Xml.Linq;
using EnergyTechAudit.PowerAccounting.Common.Serialization;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Serialization;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    [EntityName(Name = "Параметры системы"), SingletonEntity]
    public class SystemSetting : IEntity, IHistoryChangeTrackEntity, IMutant
    {
        public async Task Mutate(IObjectContextAdapter contextAdapter)
        {
            var systemSetting = new
            {
                Appearance = new
                {
                    UsePermanentUserGroup = default(bool),
                    PermanentUserGroupId = default(int),
                    UseBaseThemeColor = default(bool),
                    BaseThemeColor = default(string)
                }
            };
           
            var systemSettingsCustomData = this.CustomData;
            systemSetting = JsonConvert.DeserializeAnonymousType
            (
                systemSettingsCustomData,
                systemSetting,
                new JsonSerializerSettingsEx()
            );

            if (systemSetting.Appearance != null)
            {
                if (systemSetting.Appearance.BaseThemeColor != null && systemSetting.Appearance.UseBaseThemeColor)
                {
                    var appConfig = ConfigurationManager.OpenExeConfiguration(string.Empty);
                    var xConfig = XDocument.Load(appConfig.FilePath);

                    var config = new
                    {
                        DevExpress = new
                        {
                            Themes = new
                            {
                                Theme = default(string),
                                BaseColor = default(string)
                            }
                        }
                    };

                    var configAsJson = JsonConvert.SerializeXNode(xConfig.Root.Element("devExpress"));

                    configAsJson = configAsJson.Replace("@", string.Empty);
                    config = JsonConvert.DeserializeAnonymousType(configAsJson, config, new JsonSerializerSettings
                    {
                        ContractResolver = new CamelCasePropertyNamesContractResolver(),
                    });

                    if (config.DevExpress.Themes.BaseColor != null)
                    {
                        if (config.DevExpress.Themes.BaseColor != systemSetting.Appearance.BaseThemeColor)
                        {
                            xConfig.Root.Element("devExpress").Element("themes").Attribute("baseColor").Value
                                = systemSetting.Appearance.BaseThemeColor;

                            xConfig.Save(appConfig.FilePath);
                            ConfigurationManager.RefreshSection("devExpress/themes");
                        }
                    }
                }

                if (systemSetting.Appearance.UsePermanentUserGroup && systemSetting.Appearance.PermanentUserGroupId != default)
                {
                    await ((DbContext) contextAdapter)
                        .Set<User>()
                        .ForEachAsync(user => { user.UserGroupId = systemSetting.Appearance.PermanentUserGroupId; });
                    await ((DbContext) contextAdapter).SaveChangesAsync();
                }
            }
        }

        public int Id { get; set; }

        [Immutable]
        public string SystemName { get; set; }

        public string EmailAddress { get; set; }

        
        public string EmailSmtpServer { get; set; }
        
        public int EmailSmtpPort { get; set; }
        
        public string EmailUserName { get; set; }

        [DataType(DataType.Password)]
        public string EmailPassword { get; set; }

        public bool EmailEnableSsl { get; set; }

        public string EmailAdminAddress { get; set; }

        private string _editableEmailPassword;

        [NotMapped]
        public string EditableEmailPassword
        {
            get
            {
                return string.Empty;
            }
            set
            {
                _editableEmailPassword = value;
                EmailPassword = _editableEmailPassword;                
            }
        }

        private string _customData;

        public string CustomData 
        {
            get
            {                
                return _customData;                 
            }
            set
            {
                // проверяем JSON на вилидность (JsonReaderException)
                 var jsonValue = JObject.Parse(value);                                        
                _customData = value;                 
            } 
        }
        
        public string CreatedBy { get; set; }

        public string UpdatedBy { get; set; }

        public DateTime CreatedDate { get; set; }

        public DateTime UpdatedDate { get; set; }
        
    }
}
