using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EnergyTechAudit.PowerAccounting.Common.Serialization;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.Core;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using EnergyTechAudit.PowerAccounting.Domain.Models.WebApi;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// Сущность "Пользователь"
    /// </summary>
    /// 
    [EntityName(Name = "Пользователь системы"),
    RequireIncludeDescribablePropertiesEntity, PossibleCascadeDeletedEntity, LoggedDeletedTrackEntity]
    public class User : IEntity, IHistoryChangeTrackEntity, IDescribableEntity, IMutant
    {
        public User()
        {            
            RoleId = 2;
            CreateDate = DateTime.Now;
            ExpiredDate = DateTime.Now.AddYears(1);
            IsTemporary = false;
            IsApproved = false;

            UserLinksChannel = new List<UserLinkChannel>();
            UserMessages = new List<UserMessage>();
            DeviceReaders = new List<DeviceReader>();
            Briefcases = new List<Briefcase>();

            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;              
        }
        
        public override string ToString()
        {
            return Description;
        }

        public async Task Mutate(IObjectContextAdapter contextAdapter)
        {            
            var systemSettingsCustomData = await ((DbContext)contextAdapter)
                .Set<SystemSetting>()
                .Select(ss => ss.CustomData)
                .FirstOrDefaultAsync();
            
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

            systemSetting = JsonConvert.DeserializeAnonymousType
            (
                systemSettingsCustomData,
                systemSetting,
                new JsonSerializerSettingsEx()
            );

            if (systemSetting?.Appearance != null && systemSetting.Appearance.UsePermanentUserGroup)
            {
                UserGroupId = systemSetting.Appearance.PermanentUserGroupId;
            }
        }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = $"{UserName}-{Role.Code}";                
            });
        }

        [Display(Name = "Ид")]
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required, UserInputRequired, DependencyDescribableProperty]
        public int RoleId { get; set; }

        [Display(Name = "Ид")]        
        public int? UserGroupId { get; set; }
        
        [Display(Name = "Логин")]
        [Required, UserInputRequired, MaxLength(32), DependencyDescribableProperty]
        public string UserName { get; set; }
        
        [Display(Name = "Пароль"), NotDisplayGrid]
        [Required, UserInputRequired, MaxLength(64), DataType(DataType.Password) /*!important*/]
        public string Password { get; set; }

        [Display(Name = "Хранимый пароль"), NotDisplayGrid, MaxLength(512)]
        public byte[] EncryptedPassword { get; set; }

        [Display(Name = "Электронная почта")]
        [Required, UserInputRequired, MaxLength(128)]
        [EmailAddress(ErrorMessage = "Электронная почта")]

        public string Email { get; set; }

        [Display(Name = "Дата создания")]
        [Required]
        public DateTime CreateDate { get; set; }

        [Display(Name = "Дата истечения срока")]
        [Required]
        public DateTime ExpiredDate { get; set; }

        [Display(Name = "Временный")]
        [Required]
        public bool IsTemporary { get; set; }

        [Display(Name = "Подтвержден")]
        [Required, UserInputRequired]
        public bool IsApproved { get; set; }

        private string _editablePassword;
       
        [NotMapped]
        [Display(Name = "Редактируемый пароль"), NotDisplayGrid]
        [UserInputRequired]
        public string EditablePassword
        {
            get => string.Empty;
            set
            {                                
                _editablePassword = value;
                if (!string.IsNullOrEmpty(_editablePassword))
                {
                    var cryptoProvider = ApplicationDependencyResolver.Current.Resolve<ICryptoMethodsProvider>();
                    Password = cryptoProvider.GetHashString(_editablePassword);
                    EncryptedPassword = cryptoProvider.ProtectData(Encoding.Unicode.GetBytes(_editablePassword));
                }
            }
        }

        [Display(Name = "Роль"), ForeignKey("RoleId"), 
        RequireIncludeDescribablePropertiesEntity, 
        RequiredDescribableProperty]        
        public virtual Role Role { get; set; }

        [Display(Name = "Группа"), ForeignKey("UserGroupId")]
        public virtual UserGroup UserGroup { get; set; }

        [Display(Name = "Дополнительная информация"), NotDisplayGrid]
        [InverseProperty("User")]
        public virtual UserAdditionalInfo UserAdditionalInfo { get; set; }
        
        [Display(Name = "Оператор выгрузки"), NotDisplayGrid]
        [InverseProperty("User")]
        public virtual ArchiveDownloader ArchiveDownloader { get; set; }

        [Display(Name = "Каналы измерительных устойств")]
        [InverseProperty("User")]
        public virtual ICollection<UserLinkChannel> UserLinksChannel { get; private set; }

        [Display(Name = "Сообщения пользователя")]
        [InverseProperty("User")]
        public virtual ICollection<UserMessage> UserMessages { get; private set; }

        [Display(Name = "Считыватели устройств")]
        [InverseProperty("User")]
        public virtual ICollection<DeviceReader> DeviceReaders { get; private set; }

        [Display(Name = "Портфели сущностей")]
        [InverseProperty("User")]
        public virtual ICollection<Briefcase> Briefcases { get; private set; }


        [Display(Name = "Мобильные устройства")]
        [InverseProperty("User")]
        public virtual ICollection<MobileDevice> MobileDevices { get; private set; }
        
        public string CreatedBy { get; set; }

        [NotDisplayGrid]
        public string UpdatedBy { get; set; }

        [NotDisplayGrid]
        public DateTime CreatedDate { get; set; }

        [NotDisplayGrid]
        public DateTime UpdatedDate { get; set; }

    }
}
