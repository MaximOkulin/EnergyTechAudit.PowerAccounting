jQuery(Core.Common.Mnemoscheme.Selector).on(Core.Common.EventTypes.MnemoschemeWidgetManager.MnemoschemeLoadComplete,
    function () {
        Core.Common.Mnemoscheme.GetParametersCallback = function (parameters) {
           
            var parameterCodeTemplate = "Monitoring.Frequency.{0}";

            var parameterCodeSuffixes = ["HwsPump1", "HwsPump2", "HwsMakeupPump1", "HwsMakeupPump2", "HeatSysPump1", "HeatSysPump2"];

            parameterCodeSuffixes.forEach(function (codeSuffix, indx) {

                var parameterValue = GetValueByParameterCode(parameters.parameters, parameterCodeTemplate.format(codeSuffix));

                if (parameterValue) {
                    var durableValue = (parameterValue > Number.zero) ? 60 / parameterValue : Number.zero;

                    var animatedElement = document.getElementById("animate{0}".format(codeSuffix));
                    if (animatedElement) {
                        animatedElement.setAttribute("dur", durableValue + "s");
                        animatedElement.beginElement();
                    }
                }
            });

            var stateParameterCodeTemplate = "Monitoring.State.{0}";
            var stateTextCodeTemplate = "Text.State.{0}";
            var stateParameterCodeSuffixes = ["Yp1Valve", "Yp2Valve", "Yp3Valve", "Ypt1Valve", "Ypt2Valve", "Yts1Valve", "Yts2Valve", "HeatSysPump1", "HeatSysPump2", "HwsPump1", "HwsPump2", "HwsMakeupPump1", "HwsMakeupPump2", "HeatSysValve1", "HeatSysValve2", "HeatSysValve3", "HeatSysValve4", "HwsValve1", "HwsValve2", "HwsValve3", "HwsValve4"];

            stateParameterCodeSuffixes.forEach(function (codeSuffix, indx) {
                var paramName = stateParameterCodeTemplate.format(codeSuffix);
                var parameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, paramName);

                if (parameterValue)
                {
                    var stateTextName = stateTextCodeTemplate.format(codeSuffix);
                    var textElement = document.getElementById(stateTextName);
                    if (textElement)
                    {
                        textElement.textContent = parameterValue;
                    }
                }
            });
            
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

        function GetDictionaryValueDescriptionByParameterCode(parameters, code)
        {
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

