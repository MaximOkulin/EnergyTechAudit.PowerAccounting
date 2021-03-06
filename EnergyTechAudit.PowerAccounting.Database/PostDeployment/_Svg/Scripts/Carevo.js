jQuery(Core.Common.Mnemoscheme.Selector).on(Core.Common.EventTypes.MnemoschemeWidgetManager.MnemoschemeLoadComplete,
    function () {
        Core.Common.Mnemoscheme.GetParametersCallback = function (parameters) {
        // проходим по режимам работы горелок котлов
        var boilerBurnerParameterCodeTemplate = "Monitoring.State.BoilerBurner{0}";
        var svgFlameBoilerTemplate = "FlameBoiler{0}";

        for (i = 1; i <= 4; i++) {
            var paramValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, boilerBurnerParameterCodeTemplate.format(i));

            if (paramValue !== undefined) {
                var svgFlameBoilerElement = document.getElementById(svgFlameBoilerTemplate.format(i));

                if (paramValue === "СТОП") {
                    svgFlameBoilerElement.setAttribute("display", "none");
                }
                else if (paramValue === "РАБОТА") {
                    if (svgFlameBoilerElement) {
                        svgFlameBoilerElement.setAttribute("display", "inline");
                    }
                }
            }
        }

        // проходим по насосам (стоп/работа)
        var pumpStateCodeTemplate = "Monitoring.State.{0}";
        // проходим по статусу наличия аварий на насосах
        var accidentPumpCodeTemplate = "Monitoring.State.Accident{0}";
        var accidentCodeTemplate = "Accident{0}";

        var pumpNames = ["RecirculatingPump1", "RecirculatingPump2", "RecirculatingPump3", "RecirculatingPump4", "SystemPump1", "SystemPump2", "SystemPump3", "MakeupPump1", "MakeupPump2", "DeflatingDieselFuelPump", "DieselFuelPump"];

        pumpNames.forEach(function (codeSuffix, indx) {
            var stateParamName = pumpStateCodeTemplate.format(codeSuffix);
            var stateParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, stateParamName);

            var durableValue = Number.zero;
            if (stateParameterValue === "РАБОТА") {
                durableValue = 1;
            }

            var animatedElement = document.getElementById("animate{0}".format(codeSuffix));
            if (animatedElement) {
                animatedElement.setAttribute("dur", durableValue + "s");
                animatedElement.beginElement();
            }

            var accidentParamName = accidentPumpCodeTemplate.format(codeSuffix);
            var accidentParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, accidentParamName);
            var accidentSignElement = document.getElementById(accidentCodeTemplate.format(codeSuffix));

            if (accidentSignElement) {
                if (accidentParameterValue === "НОРМА") {
                    accidentSignElement.setAttribute("display", "none");
                }
                else if (accidentParameterValue === "АВАРИЯ") {
                    accidentSignElement.setAttribute("display", "inline");
                }
            }
        }
        );

        // аварии клапанов обраток котлов
        var valveNames = ["ReturnValve1", "ReturnValve2", "ReturnValve3", "ReturnValve4"];

        valveNames.forEach(function (codeSuffix, indx) {

            var accidentParamName = accidentPumpCodeTemplate.format(codeSuffix);
            var accidentParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, accidentParamName);
            var accidentSignElement = document.getElementById(accidentCodeTemplate.format(codeSuffix));

            if (accidentSignElement) {
                if (accidentParameterValue === "НОРМА") {
                    accidentSignElement.setAttribute("display", "none");
                }
                else if (accidentParameterValue === "АВАРИЯ") {
                    accidentSignElement.setAttribute("display", "inline");
                }
            }
        }
        );

        // клапаны обраток котлов
        var flapNumbers = ["1", "2", "3", "4"];
        flapNumbers.forEach(function (codeSuffix, indx) {
            var closedParamName = "Monitoring.State.ReturnValveClosedPosition{0}".format(codeSuffix);
            var openedParamName = "Monitoring.State.ReturnValveOpenedPosition{0}".format(codeSuffix);
            var closedParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, closedParamName);
            var openedParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, openedParamName);

            var openFlapControl = document.getElementById("Flap{0}Open".format(codeSuffix));
            var closeFlapControl = document.getElementById("Flap{0}Close".format(codeSuffix));

            if (closedParameterValue === "НЕТ" && openedParameterValue === "ДА") {
                openFlapControl.setAttribute("display", "inline");
                closeFlapControl.setAttribute("display", "none");
            }
            else {
                openFlapControl.setAttribute("display", "none");
                closeFlapControl.setAttribute("display", "inline");
            }
        }
        );

        // клапан ДТ
        var flapDTParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.DieselFuelValveClosed");
        var openFlapDTControl = document.getElementById("DieselFuelOpen");
        var closeFlapDTControl = document.getElementById("DieselFuelClose");

        if (flapDTParameterValue === "ДА") {
            openFlapDTControl.setAttribute("display", "none");
            closeFlapDTControl.setAttribute("display", "inline");
        }
        else if (flapDTParameterValue === "НЕТ") {
            openFlapDTControl.setAttribute("display", "inline");
            closeFlapDTControl.setAttribute("display", "none");
        }

        // клапан газа
        var gasFlapParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.GasValveClosed");
        var openGasFlapControl = document.getElementById("GasValveOpen");
        var closeGasFlapControl = document.getElementById("GasValveClose");

        if (gasFlapParameterValue === "ДА") {
            openGasFlapControl.setAttribute("display", "none");
            closeGasFlapControl.setAttribute("display", "inline");
        }
        else if (gasFlapParameterValue === "НЕТ") {
            openGasFlapControl.setAttribute("display", "inline");
            closeGasFlapControl.setAttribute("display", "none");
        }


        // значок охранной сигнализации
        var securityAlarmParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.SecurityAlarm");
        var redSecurityAlarmElement = document.getElementById("SecurityAlarmRed");
        var blackSecurityAlarmElement = document.getElementById("SecurityAlarmBlack");

        if (securityAlarmParameterValue === "НОРМА") {
            redSecurityAlarmElement.setAttribute("display", "none");
            blackSecurityAlarmElement.setAttribute("display", "inline");
        }
        else if (securityAlarmParameterValue === "АВАРИЯ") {
            redSecurityAlarmElement.setAttribute("display", "inline");
            blackSecurityAlarmElement.setAttribute("display", "none");
        }

        // значок пожара
        var fireParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.Fire");
        var flameOnElement = document.getElementById("FlameRed");
        var flameOffElement = document.getElementById("FlameBlack");

        if (fireParameterValue === "НОРМА") {
            flameOnElement.setAttribute("display", "none");
            flameOffElement.setAttribute("display", "inline");
        }
        else if (fireParameterValue === "АВАРИЯ") {
            flameOnElement.setAttribute("display", "inline");
            flameOffElement.setAttribute("display", "none");
        }

        // значок угарного газа (порог 2)
        var monoxideParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.CarbonMonoxideLevel2");
        var monoxideOnElement = document.getElementById("MonoxideRed");
        var monoxideOffElement = document.getElementById("MonoxideBlack");

        if (monoxideParameterValue === "НОРМА") {
            monoxideOnElement.setAttribute("display", "none");
            monoxideOffElement.setAttribute("display", "inline");
        }
        else if (monoxideParameterValue === "АВАРИЯ") {
            monoxideOnElement.setAttribute("display", "inline");
            monoxideOffElement.setAttribute("display", "none");
        }

        // значок метана
        var methaneParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.Methane");
        var methaneOnElement = document.getElementById("MethaneRed");
        var methaneOffElement = document.getElementById("MethaneBlack");

        if (methaneParameterValue === "НОРМА") {
            methaneOnElement.setAttribute("display", "none");
            methaneOffElement.setAttribute("display", "inline");
        }
        else if (methaneParameterValue === "АВАРИЯ") {
            methaneOnElement.setAttribute("display", "inline");
            methaneOffElement.setAttribute("display", "none");
        }

        // значок давления подпиточных насосов
        var pressureMakeupParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.MakeupPumpsPressureControl");
        var pressureMakeupOnElement = document.getElementById("PressureMakeupRed");
        var pressureMakeupOffElement = document.getElementById("PressureMakeupBlack");

        if (pressureMakeupParameterValue === "НОРМА") {
            pressureMakeupOnElement.setAttribute("display", "none");
            pressureMakeupOffElement.setAttribute("display", "inline");
        }
        else if (pressureMakeupParameterValue === "АВАРИЯ") {
            pressureMakeupOnElement.setAttribute("display", "inline");
            pressureMakeupOffElement.setAttribute("display", "none");
        }

        // значок давления сетевых насосов
        var pressureSystemParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.SystemPumpsPressureControl");
        var pressureSystemOnElement = document.getElementById("PressureSystemRed");
        var pressureSystemOffElement = document.getElementById("PressureSystemBlack");

        if (pressureSystemParameterValue === "НОРМА") {
            pressureSystemOnElement.setAttribute("display", "none");
            pressureSystemOffElement.setAttribute("display", "inline");
        }
        else if (pressureSystemParameterValue === "АВАРИЯ") {
            pressureSystemOnElement.setAttribute("display", "inline");
            pressureSystemOffElement.setAttribute("display", "none");
        }
    };       

        function GetValueByParameterCode(parameters, code) {
            var value = undefined;

            for (var i = Number.zero; i < parameters.length; i++) {
                if (parameters[i].parameterCode === code) {
                    return parameters[i].value;
                }
            }

            return value;
        };

        function GetDictionaryValueDescriptionByParameterCode(parameters, code) {
            var value = undefined;

            for (var i = Number.zero; i < parameters.length; i++) {
                if (parameters[i].parameterCode === code) {
                    return parameters[i].dictionaryValueDescription;
                }
            }

            return value;
        };
    }
);
