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

            var pumpNames = ["RecirculatingPump1", "RecirculatingPump2", "RecirculatingPump3", "RecirculatingPump4", "SystemPump1", "SystemPump2", "SystemPump3", "MakeupPump1", "MakeupPump2","ThreeWayValve"];

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

            // значок угарного газа
            var monoxideParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.CarbonMonoxide");
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

            // состояние трехходового клапана
            var threeWayValveValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.ThreeWayValve");
            
            debugger;
            jQuery("#threeWayValveState").text(threeWayValveValue);
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

