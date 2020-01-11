namespace EnergyTechAudit.PowerAccounting.Domain.EnumTypes
{
    /// <summary>
    /// Определяет источник задания параметра для параметрика 
    /// </summary>
    public enum ParameterValueSourceType
    {
        /// <summary>
        /// Вводится пользователем
        /// </summary>        
        FromUser,
        
        /// <summary>
        /// Cчитывается из настроек приложения    
        /// </summary>
        FromSetting,

        /// <summary>
        /// Устанавливается кодом приложения
        /// </summary> 
        FromInternalCode,

        FromFake
    }
}
