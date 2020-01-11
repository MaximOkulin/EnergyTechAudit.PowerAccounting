using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    /// <summary>
    /// Указывает на то, что сущность может иметь присоединенные типизированные элементы дополнительных данных (динамических данных) 
    /// </summary>
    [AttributeUsage(AttributeTargets.Class)]
    public sealed class DynamicDataEntityAttribute : Attribute
    {
        private Type _linkType;

        /// <summary>
        /// Конструктор DynamicDataEntityAttribute
        /// </summary>
        /// <param name="linkType">Указывает на тип задающий через ссылочную сущность дополнительную привязку
        /// Например: Связь модель прибора - динамический параметр (MeasurementDevice - Device - DeviceLinkDynamicParameter)
        /// </param>
        public DynamicDataEntityAttribute(Type linkType)
        {
            LinkType = linkType;
        }

        public DynamicDataEntityAttribute()
        {
            
        }

        /// <summary>
        /// Указывает на тип задающий через ссылочную сущность дополнительную привязку
        /// Например: Связь модель прибора - динамический параметр (MeasurementDevice - Device - DeviceLinkDynamicParameter)
        /// </summary>
        public Type LinkType
        {
            get { return _linkType; }
            set { _linkType = value; }
        }
    }
}