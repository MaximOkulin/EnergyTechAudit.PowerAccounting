using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{

    /// <summary>
    /// Задает описательное имя сущности
    /// </summary>
    [AttributeUsage(AttributeTargets.Class)]            
    public sealed class EntityNameAttribute: Attribute
    {
         public string Name { get; set; }        
         public string ShortName { get; set; }        
    }


    /// <summary>
    /// Указывает на возможность самостоятельного удаления 
    /// связанной сущности с каскадным удалением с помощью 
    /// операции асинхронного удаления
    /// </summary>
    [AttributeUsage(AttributeTargets.Class)]
    public sealed class AllowDeleteCascadeLinkedEntity : Attribute{}

    /// <summary>
    /// Сущность допускает существование только одной записи в связанной таблице
    /// </summary>
    [AttributeUsage(AttributeTargets.Class)]
    public sealed class SingletonEntity: Attribute{}

    [AttributeUsage(AttributeTargets.Class)]
    public sealed class AllowDeleteMultipleToMultipleRightEntity : Attribute { }

}
