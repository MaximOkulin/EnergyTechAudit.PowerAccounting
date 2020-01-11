using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    /// <summary>
    /// Указывает на ограничение редактирования и удаления сущности созданной другим пользователем
    /// </summary>
    [AttributeUsage(AttributeTargets.Class)]
    public sealed class UserRestrictedPermissionEntityAttribute : Attribute
    {
    }
    
    /// <summary>
    /// Обязательное поля для ввода пользователем
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class UserInputRequiredAttribute : Attribute
    {
    }

    /// <summary>
    /// Указывает, что поле сущности является неизменяемым
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class ImmutableAttribute : Attribute
    {       
        /// <summary>
        /// If this flag is set on then underlying property won't change 
        /// without rejecting the saving of the entire entity    
        ///</summary>
        public bool SuppressRefusing { get; set;}
    }
    
}