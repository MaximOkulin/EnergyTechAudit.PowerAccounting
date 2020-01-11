using System;
using System.ComponentModel;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Types
{
    [Flags]
    public enum ElfFailCauseFlags : uint
    {
        [Description("Низкий уровень напряжения батареи")]
        BatteryLow = 1,
        [Description("Используется договорное давление подающей магистрали")]
        FlowContractP = 0x8000000,
        [Description("Обрыв или короткое замыкание измерительной линии давления в подающей магистрали")]
        FlowP_Err = 0x4000000,
        [Description("Давление в подающей магистрали меньше допустимого (P < Pmin)")]
        FlowP_LessPmin = 0x2000000,
        [Description("Давление в подающей магистрали больше допустимого (P > Pmax)")]
        FlowP_MorePmax = 0x1000000,
        [Description("В открытой схеме тепловая мощность подающей трубы меньше обратной")]
        FlowPowerLessReturnPower = 8,
        [Description("Темп. подающей магистрали меньше темп. обратной (Тпод < Тобр)")]
        FlowTempLessReturnTemp = 4,
        [Description("Обрыв или короткое замыкание измерительной линии температуры подающей магистрали")]
        FlowTErr = 0x40000,
        [Description("Температура подающей магистрали меньше допустимой (T < Tmin)")]
        FlowTLessTmin = 0x20000,
        [Description("Температура подающей магистрали больше допустимой (T > Tmax)")]
        FlowTMoreTmax = 0x10000,
        [Description("Значение расхода подающей магистрали меньше допустимого (V < Vmin)")]
        FlowV_LessVmin = 0x200,
        [Description("Значение расхода подающей магистрали больше допустимого (V > Vmax)")]
        FlowV_MoreVmax = 0x100,
        [Description("Пропало питание сетевых расходомеров подающей магистрали")]
        FlowV_PowerErr = 0x400,
        [Description("Невозможно вычислить массу воды подающей магистрали")]
        FlowV_UnableCalcMass = 0x800,
        [Description("Общая ошибка системы")]
        GeneralSystemError = 0x80,
        [Description("Вычислитель выключали")]
        PowerOff = 0x40,
        [Description("Вычислитель включали")]
        PowerOn = 0x20,
        [Description("Используется договорное давление обратной магистрали")]
        ReturnContractP = 0x80000000,
        [Description("Обрыв или короткое замыкание измерительной линии давления в обратной магистрали")]
        ReturnP_Err = 0x40000000,
        [Description("Давление в обратной магистрали меньше допустимого (P < Pmin)")]
        ReturnP_LessPmin = 0x20000000,
        [Description("Давление в обратной магистрали больше допустимого (P > Pmax)")]
        ReturnP_MorePmax = 0x10000000,
        [Description("Обрыв или короткое замыкание измерительной линии температуры обратной магистрали")]
        ReturnTErr = 0x400000,
        [Description("Температура обратной магистрали меньше допустимой (T < Tmin)")]
        ReturnTLessTmin = 0x200000,
        [Description("Температура обратной магистрали больше допустимой (T > Tmax)")]
        ReturnTMoreTmax = 0x100000,
        [Description("Значение расхода обратной магистрали меньше допустимого (V < Vmin)")]
        ReturnV_LessVmin = 0x2000,
        [Description("Значение расхода обратной магистрали больше допустимого (V > Vmax)")]
        ReturnV_MoreVmax = 0x1000,
        [Description("Пропало питание сетевых расходомеров обратной магистрали")]
        ReturnV_PowerErr = 0x4000,
        [Description("Невозможно вычислить массу воды обратной магистрали")]
        ReturnV_UnableCalcMass = 0x8000
    }
}
