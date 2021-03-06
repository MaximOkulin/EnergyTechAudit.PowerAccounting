jQuery(Core.Common.Mnemoscheme.Selector).on(Core.Common.EventTypes.MnemoschemeWidgetManager.MnemoschemeLoadComplete,
    function () {
        Core.Common.Mnemoscheme.GetParametersCallback = function (parameters) {

            // проходим по насосам (стоп/работа)
            var pumpStateCodeTemplate = "Monitoring.State.{0}";
            var pumpNames = ["SystemPump1", "SystemPump2", "SystemPump3", "SystemPump4"];

            pumpNames.forEach(function (codeSuffix, indx) {
                var stateParamName = pumpStateCodeTemplate.format(codeSuffix);
                var stateParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, stateParamName);

                var durableValue = Number.zero;
                if (stateParameterValue === "В работе от сети" || stateParameterValue === "В работе от ЧРП") {
                    durableValue = 1;
                }

                var animatedElement = document.getElementById("animate{0}".format(codeSuffix));
                if (animatedElement) {
                    animatedElement.setAttribute("dur", durableValue + "s");
                    animatedElement.beginElement();
                }
            }
            );

            // вы
            var freqConvParamValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters,
                "Monitoring.State.FrequencyConverter");
            var freqConvParamValues = ["Нет питания", "В работе", "Остановлен", "Авария", "Регулирование, мин. частота", "Ожидание включения"];
            var freqConvParamValues2 = ["", "", "Останов", "", "Регулирование, макс. частота", "Ожидание готовности"];
            var freqConvElementNames = ["FrequencyConverter_NoPower", "FrequencyConverter_InWork", "FrequencyConverter_Stop", "FrequencyConverter_Crash",
                "FrequencyConverter_Regulation", "FrequencyConverter_Wait"];

            if (freqConvParamValue !== undefined) {
                for (i = 0; i < freqConvParamValues.length; i++) {
                    var freqConvElement = document.getElementById(freqConvElementNames[i]);

                    if (freqConvElement !== null) {
                        if (freqConvParamValue === freqConvParamValues[i] || freqConvParamValue === freqConvParamValues2[i]) {
                            freqConvElement.setAttribute("display", "inline");
                        }
                        else {
                            freqConvElement.setAttribute("display", "none");
                        }
                    }
                }
            }

            var lines = ["FreqConvLine1", "FreqConvLine2", "FreqConvLine3", "FreqConvLine4"];
            if (freqConvParamValue === "В работе") {
                for (var i = 0; i < lines.length; i++) {
                    var lineGroup = document.getElementById(lines[i]);
                    var line = lineGroup.children[0];
                    line.setAttribute("stroke", "#D50AE5");
                    line.removeAttribute("class");
                }
            }
            else {
                for (var i = 0; i < lines.length; i++) {
                    var lineGroup = document.getElementById(lines[i]);
                    var line = lineGroup.children[0];
                    line.setAttribute("stroke", "#000000");
                }
            }

            // положение контактора ПЧ СН3
            var freqConvContactor3Value = GetDictionaryValueDescriptionByParameterCode(parameters.parameters,
                "Monitoring.State.FrequencyConverterContactor3");

            if (freqConvContactor3Value === "Включен") {
                var contactor3Off = document.getElementById("FrequencyConverterContactor3Off");
                contactor3Off.setAttribute("display", "none");
                var contactor3On = document.getElementById("FrequencyConverterContactor3On");
                contactor3On.setAttribute("display", "inline");

                var line5Group = document.getElementById("FreqConvLine5");
                var line = line5Group.children[0];
                line.setAttribute("stroke", "#D50AE5");
                line.removeAttribute("class");
            }
            else {
                var contactor3Off = document.getElementById("FrequencyConverterContactor3Off");
                contactor3Off.setAttribute("display", "inline");
                var contactor3On = document.getElementById("FrequencyConverterContactor3On");
                contactor3On.setAttribute("display", "none");

                var line5Group = document.getElementById("FreqConvLine5");
                var line = line5Group.children[0];
                line.setAttribute("stroke", "#000000");
                line.removeAttribute("class");
            }

            // положение контактора ПЧ СН4
            var freqConvContactor4Value = GetDictionaryValueDescriptionByParameterCode(parameters.parameters,
                "Monitoring.State.FrequencyConverterContactor4");

            if (freqConvContactor4Value === "Включен") {
                var contactor4Off = document.getElementById("FrequencyConverterContactor4Off");
                contactor4Off.setAttribute("display", "none");
                var contactor4On = document.getElementById("FrequencyConverterContactor4On");
                contactor4On.setAttribute("display", "inline");

                var line6Group = document.getElementById("FreqConvLine6");
                var line = line6Group.children[0];
                line.setAttribute("stroke", "#D50AE5");
                line.removeAttribute("class");
            }
            else {
                var contactor4Off = document.getElementById("FrequencyConverterContactor4Off");
                contactor4Off.setAttribute("display", "inline");
                var contactor4On = document.getElementById("FrequencyConverterContactor4On");
                contactor4On.setAttribute("display", "none");

                var line6Group = document.getElementById("FreqConvLine6");
                var line = line6Group.children[0];
                line.setAttribute("stroke", "#000000");
                line.removeAttribute("class");
            }

            // положение контактора сети СН3
            var networkContactor3Value = GetDictionaryValueDescriptionByParameterCode(parameters.parameters,
                "Monitoring.State.NetworkPowerContactor3");

            var networkContactor3Lines = ["FreqConvLine7", "FreqConvLine8", "FreqConvLine11"];

            if (networkContactor3Value === "Включен") {
                var contactor3Off = document.getElementById("NetworkPowerContactor3Off");
                contactor3Off.setAttribute("display", "none");
                var contactor3On = document.getElementById("NetworkPowerContactor3On");
                contactor3On.setAttribute("display", "inline");

                for (i = 0; i < networkContactor3Lines.length; i++) {
                    var line5Group = document.getElementById(networkContactor3Lines[i]);
                    var line = line5Group.children[0];
                    line.setAttribute("stroke", "#D50AE5");
                    line.removeAttribute("class");
                }
            }
            else {
                var contactor3Off = document.getElementById("NetworkPowerContactor3Off");
                contactor3Off.setAttribute("display", "inline");
                var contactor3On = document.getElementById("NetworkPowerContactor3On");
                contactor3On.setAttribute("display", "none");


                for (i = 0; i < networkContactor3Lines.length; i++) {
                    var line5Group = document.getElementById(networkContactor3Lines[i]);
                    var line = line5Group.children[0];
                    line.setAttribute("stroke", "#000000");
                    line.removeAttribute("class");
                }
            }

            // положение контактора сети СН4
            var networkContactor4Value = GetDictionaryValueDescriptionByParameterCode(parameters.parameters,
                "Monitoring.State.NetworkPowerContactor4");

            var networkContactor4Lines = ["FreqConvLine9", "FreqConvLine10", "FreqConvLine12"];

            if (networkContactor4Value === "Включен") {
                var contactor4Off = document.getElementById("NetworkPowerContactor4Off");
                contactor4Off.setAttribute("display", "none");
                var contactor4On = document.getElementById("NetworkPowerContactor4On");
                contactor4On.setAttribute("display", "inline");

                for (i = 0; i < networkContactor4Lines.length; i++) {
                    var line5Group = document.getElementById(networkContactor4Lines[i]);
                    var line = line5Group.children[0];
                    line.setAttribute("stroke", "#D50AE5");
                    line.removeAttribute("class");
                }
            }
            else {
                var contactor4Off = document.getElementById("NetworkPowerContactor4Off");
                contactor4Off.setAttribute("display", "inline");
                var contactor4On = document.getElementById("NetworkPowerContactor4On");
                contactor4On.setAttribute("display", "none");


                for (i = 0; i < networkContactor4Lines.length; i++) {
                    var line5Group = document.getElementById(networkContactor4Lines[i]);
                    var line = line5Group.children[0];
                    line.setAttribute("stroke", "#000000");
                    line.removeAttribute("class");
                }
            }

            // состояния горелок котлов 1-3 и работа факелов горелок 1-3
            for (i = 1; i <= 3; i++) {
                var boilerState = document.getElementById("ArtCityBoilerState{0}".format(i));

                var accidentBoilerBurnerValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters,
                    "Monitoring.State.AccidentBoilerBurner{0}".format(i));

                if (boilerState !== undefined && accidentBoilerBurnerValue !== undefined) {
                    if (accidentBoilerBurnerValue === "АВАРИЯ") {
                        boilerState.textContent = "АВАРИЯ";
                    }
                    else if (accidentBoilerBurnerValue === "НОРМА") {
                        boilerState.textContent = "НОРМА";
                    }
                }

                // текущая выходная мощность горелки
                var outputPowerValue = GetValueByParameterCode(parameters.parameters, "Monitoring.Percent.OutputPowerBurner{0}".format(i));
                var igniterBurnerValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters,
                    "Monitoring.State.IgniterBurner{0}".format(i));
                var svgFlameBoilerElement = document.getElementById("FlameBoiler{0}".format(i));

                if (outputPowerValue > 0 && igniterBurnerValue === "РАБОТА") {
                    svgFlameBoilerElement.setAttribute("display", "inline");
                }
                else {
                    svgFlameBoilerElement.setAttribute("display", "none");
                }
            }

            

            // состояние котла №4 и работа его горелки (обрабатываем отдельно, т.к. он подключен через дискретник)
            var flameBoiler4Value = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.BoilerBurner4");
            if (flameBoiler4Value !== undefined) {
                var svgFlameBoiler4Element = document.getElementById("FlameBoiler4");

                if (flameBoiler4Value === "СТОП") {
                    svgFlameBoiler4Element.setAttribute("display", "none");
                }
                else if (flameBoiler4Value === "РАБОТА") {
                    if (svgFlameBoiler4Element) {
                        svgFlameBoiler4Element.setAttribute("display", "inline");
                    }
                }
            }

            var boiler4State = document.getElementById("ArtCityBoilerState4");
            var accidentBoilerBurner4Value = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, "Monitoring.State.AccidentBoilerBurner4");

            if (boiler4State !== undefined && accidentBoilerBurner4Value !== undefined) {
                boiler4State.textContent = accidentBoilerBurner4Value;
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

