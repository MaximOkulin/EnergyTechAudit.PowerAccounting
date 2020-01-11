using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    /// <summary>
    /// Указывает на поле являющее ключом для связи типа один-к-одному
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class OneToOneForeignKeyAttribute : Attribute
    {
        private readonly string _name;

        public OneToOneForeignKeyAttribute(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) {
                throw new ArgumentException();
            }

            _name = name;
        }
        
        public string Name {
            get { return _name; }
        }
    }
}