jQuery(Core.Common.Mnemoscheme.Selector).on(Core.Common.EventTypes.MnemoschemeWidgetManager.MnemoschemeLoadComplete,
    function () {
        Core.Common.Mnemoscheme.GetParametersCallback = function (parameters) {
           
            // проходим по индикаторам ревизий (канашек)
            var floodingStateCodeTemplate = "Monitoring.State.Flooding{0}";
            var floodingSensorsNumbers = ["1", "2", "3"];

            floodingSensorsNumbers.forEach(function (codeSuffix, indx) {
                var floodingParamName = floodingStateCodeTemplate.format(codeSuffix);
                var stateParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, floodingParamName);

                var svgFloodingOnElement = document.getElementById("Monitoring.State.Flooding{0}On".format(codeSuffix));
                var svgFloodingOffElement = document.getElementById("Monitoring.State.Flooding{0}Off".format(codeSuffix));

                if (stateParameterValue !== undefined && svgFloodingOnElement !== undefined && svgFloodingOffElement !== undefined)
                {
                    if (stateParameterValue === "АВАРИЯ") {
                        svgFloodingOnElement.setAttribute("display", "inline");
                        svgFloodingOffElement.setAttribute("display", "none");
                    }
                    else if (stateParameterValue === "НОРМА") {
                        svgFloodingOnElement.setAttribute("display", "none");
                        svgFloodingOffElement.setAttribute("display", "inline");
                    }
                }
            });

            // проходим по дверям (открываем или закрываем)
            var entranceDoorStateCodeTemplate = "Monitoring.State.EntranceDoor{0}";
            var entranceDoorSensorsNumbers = ["2"];

            entranceDoorSensorsNumbers.forEach(function (codeSuffix, indx) {
                var entranceDoorParamName = entranceDoorStateCodeTemplate.format(codeSuffix);
                var stateParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, entranceDoorParamName);

                var svgEntranceOpenElement = document.getElementById("Monitoring.State.EntranceDoor{0}Open".format(codeSuffix));
                var svgEntranceCloseElement = document.getElementById("Monitoring.State.EntranceDoor{0}Close".format(codeSuffix));

                if (stateParameterValue !== undefined && svgEntranceOpenElement !== undefined && svgEntranceCloseElement !== undefined) {
                    if (stateParameterValue === "ОТКРЫТО") {
                        svgEntranceOpenElement.setAttribute("display", "inline");
                        svgEntranceCloseElement.setAttribute("display", "none");
                    }
                    else if (stateParameterValue === "ЗАКРЫТО") {
                        svgEntranceOpenElement.setAttribute("display", "none");
                        svgEntranceCloseElement.setAttribute("display", "inline");
                    }
                }
            });

            // проходим по дверям чердака (открываем или закрываем)
            var atticDoorStateCodeTemplate = "Monitoring.State.AtticDoor{0}";
            var atticDoorSensorsNumbers = [];

            atticDoorSensorsNumbers.forEach(function (codeSuffix, indx) {
                var atticDoorParamName = atticDoorStateCodeTemplate.format(codeSuffix);
                var stateParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, atticDoorParamName);

                var svgAtticOpenElement = document.getElementById("Monitoring.State.AtticDoor{0}Open".format(codeSuffix));
                var svgAtticCloseElement = document.getElementById("Monitoring.State.AtticDoor{0}Close".format(codeSuffix));

                if (stateParameterValue !== undefined && svgAtticOpenElement !== undefined && svgAtticCloseElement !== undefined) {
                    if (stateParameterValue === "ОТКРЫТО") {
                        svgAtticOpenElement.setAttribute("display", "inline");
                        svgAtticCloseElement.setAttribute("display", "none");
                    }
                    else if (stateParameterValue === "ЗАКРЫТО") {
                        svgAtticOpenElement.setAttribute("display", "none");
                        svgAtticCloseElement.setAttribute("display", "inline");
                    }
                }
            });

            // проходим по индикаторам затопления колодцев
            var wellStateCodeTemplate = "Monitoring.State.Well{0}";
            var wellSensorsNumbers = [];

            wellSensorsNumbers.forEach(function (codeSuffix, indx) {
                var wellParamName = wellStateCodeTemplate.format(codeSuffix);
                var stateParameterValue = GetDictionaryValueDescriptionByParameterCode(parameters.parameters, wellParamName);

                var svgWellOnElement = document.getElementById("Monitoring.State.Well{0}On".format(codeSuffix));
                var svgWellOffElement = document.getElementById("Monitoring.State.Well{0}Off".format(codeSuffix));

                if (stateParameterValue !== undefined && svgWellOnElement !== undefined && svgWellOffElement !== undefined) {
                    if (stateParameterValue === "АВАРИЯ") {
                        svgWellOnElement.setAttribute("display", "inline");
                        svgWellOffElement.setAttribute("display", "none");
                    }
                    else if (stateParameterValue === "НОРМА") {
                        svgWellOnElement.setAttribute("display", "none");
                        svgWellOffElement.setAttribute("display", "inline");
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

