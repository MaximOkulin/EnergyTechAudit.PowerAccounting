using System;
using System.ComponentModel;
using System.Reflection;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Helpers
{
    public class BaseHelper
    {
        public static string GetEnumDescription(Enum enumObj)
        {
            DescriptionAttribute attribute = (DescriptionAttribute)GetAttribute(enumObj, typeof(DescriptionAttribute));
            if (attribute != null)
            {
                return attribute.Description;
            }
            return enumObj.ToString();
        }

        public static object GetAttribute(Enum enumObj, Type attributeType)
        {
            if (!attributeType.IsSubclassOf(typeof(Attribute)))
            {
                throw new ArgumentException("Тип должен быть атрибутом.", "attributeType");
            }
            FieldInfo field = enumObj.GetType().GetField(enumObj.ToString());
            if (field != null)
            {
                object[] customAttributes = field.GetCustomAttributes(attributeType, false);
                if (customAttributes.Length != 0)
                {
                    return customAttributes[0];
                }
            }
            return null;
        }
    }
}
