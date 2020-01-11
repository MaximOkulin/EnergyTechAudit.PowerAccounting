﻿SET IDENTITY_INSERT [Dictionaries].[InternalDeviceEvent] ON;
GO

INSERT INTO [Dictionaries].[InternalDeviceEvent]
([Id],[Code],[Description],[DeviceId])
VALUES
--ТВ7
 (1, 'Tv7DatabaseChanges0', 'Исп. БД2', 27),
 (2, 'Tv7DatabaseChanges1', 'БД1<>БД2', 27),
 (3, 'Tv7DatabaseChanges2', 'С клав.', 27),
 (4, 'Tv7DatabaseChanges3', 'С ПК', 27),
 (5, 'Tv7DatabaseChanges4', 'БД1 с', 27),
 (6, 'Tv7DatabaseChanges5', 'БД2 с', 27),
 (7, 'Tv7DatabaseChanges16', 'Час отчета', 27),
 (8, 'Tv7DatabaseChanges17', 'Дата отчета', 27),
 (9, 'Tv7DatabaseChanges18', 'Сет. адрес', 27),
 (10, 'Tv7DatabaseChanges19', 'Код.орг.', 27),
 (11, 'Tv7DatabaseChanges20', 'Договор', 27),
 (12, 'Tv7DatabaseChanges21', 'Сист.единиц', 27),
 (13, 'Tv7DatabaseChanges22', 'Термопреобр.', 27),
 (14, 'Tv7DatabaseChanges23', 'Перев.часов', 27),
 (15, 'Tv7DatabaseChanges24', 'Время', 27),
 (16, 'Tv7DatabaseChanges25', 'Пароль', 27),
 (17, 'Tv7DatabaseChanges26', 'Дата', 27),
 (18, 'Tv7DatabaseChanges37', 'Контр.V', 27),
 (19, 'Tv7DatabaseChanges38', 'Контр. ВС', 27),
 (20, 'Tv7DatabaseChanges39', 'Датчик P', 27),
 (21, 'Tv7DatabaseChanges40', 'Тип ВС', 27),
 (22, 'Tv7DatabaseChanges41', 'Pдог', 27),
 (23, 'Tv7DatabaseChanges42', 'tдог', 27),
 (24, 'Tv7DatabaseChanges43', 'Pп', 27),
 (25, 'Tv7DatabaseChanges44', 'Pв', 27),
 (26, 'Tv7DatabaseChanges45', 'Вес импульса', 27),
 (27, 'Tv7DatabaseChanges46', 'Vmin', 27),
 (28, 'Tv7DatabaseChanges47', 'Vmax', 27),
 (29, 'Tv7DatabaseChanges48', 'Vдог', 27),
 (30, 'Tv7DatabaseChanges59', 'СИ', 27),
 (31, 'Tv7DatabaseChanges60', 'dMmax', 27),
 (32, 'Tv7DatabaseChanges61', 'tхд', 27),
 (33, 'Tv7DatabaseChanges62', 'Pхд', 27),
 (34, 'Tv7DatabaseChanges63', 'КТ3', 27),
 (35, 'Tv7DatabaseChanges64', 'ФРТ', 27),
 (36, 'Tv7DatabaseChanges65', 'Контр.t', 27),
 (37, 'Tv7DatabaseChanges66', 'Контр.dM', 27),
 (38, 'Tv7DatabaseChanges67', 'Контр.Q', 27),
 (39, 'Tv7DatabaseChanges68', 'Контр.dt', 27),
 (40, 'Tv7DatabaseChanges69', 'dtmin', 27),
 (41, 'Tv7DatabaseChanges70', 'Исп.tx', 27),
 (42, 'Tv7DatabaseChanges71', 'Исп.Px', 27),
 (43, 'Tv7DatabaseChanges82', 'Назнач. ДП', 27),
 (44, 'Tv7DatabaseChanges83', 'Уровень', 27),
 (45, 'Tv7DatabaseChanges84', 'Ед.изм.', 27),
 (46, 'Tv7DatabaseChanges85', 'Вес имп.', 27),
 (47, 'Tv7DatabaseChanges86', 'ДПmin', 27),
 (48, 'Tv7DatabaseChanges87', 'ДПmax', 27),
 (49, 'Tv7DatabaseChanges88', 'Т подт.', 27),

 (50, 'Tv7Events0', 'Запрет калибр. (ПК)', 27),
 (51, 'Tv7Events1', 'Запись настроек (ПК)', 27),
 (52, 'Tv7Events2', 'Уст. COMов на умолч.', 27),
 (53, 'Tv7Events3', 'Сброс архива', 27),
 (54, 'Tv7Events4', 'Резерв', 27),
 (55, 'Tv7Events5', 'Калибр.t(ПК)', 27),
 (56, 'Tv7Events6', 'Калибр.P(ПК)', 27),
 (57, 'Tv7Events7', 'Калибр.t', 27),
 (58, 'Tv7Events8', 'Калибр.P', 27),
 (59, 'Tv7Events9', 'Поверка (Старт, ПК)', 27),
 (60, 'Tv7Events10', 'Поверка (Стоп, ПК)', 27),
 (61, 'Tv7Events11', 'Поверка (Старт)', 27),
 (62, 'Tv7Events12', 'Поверка (Стоп)', 27),
 (63, 'Tv7Events13', 'Уск. режим (старт)', 27),
 (64, 'Tv7Events14', 'Уск. режим (стоп)', 27),
 (65, 'Tv7Events15', 'Доступ запр.', 27),
 (66, 'Tv7Events16', 'Доступ разр.', 27),
 (67, 'Tv7Events17', 'Калибр запр.', 27),
 (68, 'Tv7Events18', 'Калибр разр.', 27),
 (69, 'Tv7Events19', 'Уст. акт. БД1', 27),
 (70, 'Tv7Events20', 'Уст. акт. БД2', 27),
 (71, 'Tv7Events21', 'Уст. акт. БД1 (авто)', 27),
 (72, 'Tv7Events22', 'Уст. акт. БД2 (авто)', 27),
 (73, 'Tv7Events23', 'Уст. акт. БД1 (ПК)', 27),
 (74, 'Tv7Events24', 'Уст. акт. БД2 (ПК)', 27),
 (75, 'Tv7Events25', 'Запись незащ. настр. (ПК)', 27),
 (76, 'Tv7Events26', 'Запись дан. производит.', 27),
 (77, 'Tv7Events27', 'Запись дан. серв.-центра', 27),
 (78, 'Tv7Events28', 'Авто перевод часов', 27),
 (79, 'Tv7Events29', 'Очистка архивов', 27),
 (80, 'Tv7Events30', 'Замена батареи', 27),

 (81, 'Tv7Diagnostic0', 'Рестарт', 27),
 (82, 'Tv7Diagnostic1', 'Инициализация', 27),
 (83, 'Tv7Diagnostic2', 'Вкл. 220В', 27),
 (84, 'Tv7Diagnostic3', 'Откл. 220В', 27),
 (85, 'Tv7Diagnostic4', 'LB', 27),
 (86, 'Tv7Diagnostic5', 'BR', 27),

 -- Пульсар-16
 (140, 'Pulsar16StartValueChannel1', 'Стартовое значение по каналу 1', 2),
 (141, 'Pulsar16StartValueChannel2', 'Стартовое значение по каналу 2', 2),
 (142, 'Pulsar16StartValueChannel3', 'Стартовое значение по каналу 3', 2),
 (143, 'Pulsar16StartValueChannel4', 'Стартовое значение по каналу 4', 2),
 (144, 'Pulsar16StartValueChannel5', 'Стартовое значение по каналу 5', 2),
 (145, 'Pulsar16StartValueChannel6', 'Стартовое значение по каналу 6', 2),
 (146, 'Pulsar16StartValueChannel7', 'Стартовое значение по каналу 7', 2),
 (147, 'Pulsar16StartValueChannel8', 'Стартовое значение по каналу 8', 2),
 (148, 'Pulsar16StartValueChannel9', 'Стартовое значение по каналу 9', 2),
 (149, 'Pulsar16StartValueChannel10', 'Стартовое значение по каналу 10', 2),
 (150, 'Pulsar16StartValueChannel11', 'Стартовое значение по каналу 11', 2),
 (151, 'Pulsar16StartValueChannel12', 'Стартовое значение по каналу 12', 2),
 (152, 'Pulsar16StartValueChannel13', 'Стартовое значение по каналу 13', 2),
 (153, 'Pulsar16StartValueChannel14', 'Стартовое значение по каналу 14', 2),
 (154, 'Pulsar16StartValueChannel15', 'Стартовое значение по каналу 15', 2),
 (155, 'Pulsar16StartValueChannel16', 'Стартовое значение по каналу 16', 2),


 -- Пульсар-2
 (170, 'Pulsar2StartValueChannel1', 'Стартовое значение по каналу 1', 14),
 (171, 'Pulsar2StartValueChannel2', 'Стартовое значение по каналу 2', 14),

 -- Пульсар-2M
 (172, 'Pulsar2MStartValueChannel1', 'Стартовое значение по каналу 1', 62),
 (173, 'Pulsar2MStartValueChannel2', 'Стартовое значение по каналу 2', 62),

--КМ-5
 (1051, 'Km5t4Greatert4Max', 't4 > максимума t4max', 9),
 (1052, 'Km5t4Lesst4Min', 't4 < минимума t4min', 9),
 (1053, 'Km5Reserve1', 'Резерв', 9),
 (1054, 'Km5Gv4GreaterGv4Max', 'Gv4 > максимума Gv4max', 9),
 (1055, 'Km5Gv3GreaterGv3Max', 'Gv3 > максимума Gv3max', 9),
 (1056, 'Km5ModeMainSummer', 'Режим "Основной (Зима)"', 9),
 (1057, 'Km5ModeSummer1', 'Режим "Лето 1"', 9),
 (1058, 'Km5ModeSummer2', 'Режим "Лето 2"', 9),
 (1059, 'Km5ModeSummer3', 'Режим "Лето 3"', 9),
 (1060, 'Km5ModeNoFlow', 'Режим "Нет потока"', 9),
 (1061, 'Km5ModeEmergency', 'Режим "НЕШТАТНЫЙ"', 9),
 (1062, 'Km5Reserve2', 'Резерв', 9),
 (1063, 'Km5Reserve3', 'Резерв', 9),
 (1064, 'Km5UPpsGreaterMax', 'U канала G ППС > допустимого максимума', 9),
 (1065, 'Km5IPpsGreaterMax', 'I катушки ППС > допустимого максимума', 9),
 (1066, 'Km5IPpsLessMin', 'I катушки ППС < допустимого минимума', 9),
 (1067, 'Km5UGreaterMax', 'U канала G КМ-5 > допустимого максимума', 9),
 (1068, 'Km5IGreaterMax', 'I катушки КМ-5 > допустимого максимума', 9),
 (1069, 'Km5ILessMin', 'I катушки KM-5 < допустимого минимума', 9),
 (1070, 'Km5Gv2Greater104Gv2', 'Gv2 > 1.04*Gv2 (только для КМ-5-5)', 9),
 (1071, 'Km5thpGreaterMax', 'tхп > максимума tхпmax', 9),
 (1072, 'Km5Reserve4', 'Резерв', 9),
 (1073, 'Km5ThpLessMin', 'Tхп < минимума tхпmin', 9),
 (1074, 'Km5t2pGreaterMax', 't2п > максимума t2пmax', 9),
 (1075, 'Km5Reserve5', 'Резерв', 9),
 (1076, 'Km5t2pLessMin', 't2п < минимума t2пmin', 9),
 (1077, 'Km5taGreatertaMax', 'ta > максимума tamax', 9),
 (1078, 'Km5taLesstaMin', 'ta < минимума tamin', 9),
 (1079, 'Km5txkGreatertxkMax', 'tхк > максимума tхкmax', 9),
 (1080, 'Km5Reserve6', 'Резерв', 9),
 (1081, 'Km5txkLesstxkMin', 'tхк < минимума tхкmin', 9),
 (1082, 'Km5Gv2GreaterGv2Max', 'Gv2 > максимума Gv2max', 9),
 (1083, 'Km5Reserve7', 'Резерв', 9),
 (1084, 'Km5Gv2LessGv2Min', 'Gv2 < минимума Gv2min', 9),
 (1085, 'Km4Gv1GreaterGv1Max', 'Gv1 > максимума Gv1max', 9),
 (1086, 'Km5Reserve8', 'Резерв', 9),
 (1087, 'Km5Gv1LessGv1Min', 'Gv1 < минимума Gv1min', 9),
 (1088, 'Km5t2kGreatert2kMax', 't2k > максимума t2kmax', 9),
 (1089, 'Km5Reserve9', 'Резерв', 9),
 (1090, 'Km5t2kLesst2kMin', 't2k < минимума t2kmin', 9),
 (1091, 'Km5t1kGreatert1kMax', 't1k > максимума t1kmax', 9),
 (1092, 'Km5Reserve10', 'Резерв', 9),
 (1093, 'Km5t1kLesst1kMin', 't1k < минимума t1kmin', 9),
 (1094, 'Km5t1t2GreaterdtMax', 't1 - t2 > максимума dtmax', 9),
 (1095, 'Km5Reserve11', 'Резерв', 9),
 (1096, 'Km5t1t2LessdtMin', 't1 - t2 < минимума dtmin', 9),
 (1097, 'Km5PxLessPxMin', 'Давление Px < Pxmin', 9),
 (1098, 'Km5ResetOrWatchdog', 'Был RESET или WATCHDOG', 9),
 (1099, 'Km5DateTimeChanged', 'Было выполнено изменение даты и/или времени в RTC теплосчетчика', 9),
 (1100, 'Km5PxGreaterPxMax', 'Давление Px > Pxmax', 9),
 (1101, 'Km5P2LessP2Min', 'Давление P2 < P2min', 9),
 (1102, 'Km5HourZeroing', 'Обнуление интеграторов за час', 9),
 (1103, 'Km5ErrorCountGreaterMax', 'Количество ошибок за сутки > максимума', 9),
 (1104, 'Km5P2GreaterP2Max', 'Давление P2 > P2max', 9),
 (1105, 'Km5P1LessP1Min', 'Давление P1 < P1min', 9),
 (1106, 'Km5ThermalPowerLess0', 'Тепловая мощность W < 0', 9),
 (1107, 'Km5Reserve12', 'Резерв', 9),
 (1108, 'Km5P1GreaterP1Max', 'Давление P1 > P1Max', 9),
 (1114, 'Km5ErrorExchangePps', 'Ошибка обмена с ППС', 9),
 (1115, 'Km5BreakPx', 'Обрыв цепи датчика Px', 9),
 (1116, 'Km5BreakP2Pps', 'Обрыв цепи датчика P2 ППС', 9),
 (1117, 'Km5BreakP2', 'Обрыв цепи датчика P2 КМ-5', 9),
 (1118, 'Km5BreakP1', 'Обрыв цепи датчика P1', 9),
 (1119, 'Km5FaultThermocouplesPps', 'Неисправность в цепи термопреобразователей ППС', 9),
 (1120, 'Km5FaultThermocouples', 'Неисправность в цепи термопреобразователей КМ-5', 9),
 (1121, 'Km5StopCounting', 'Останов счета', 9),
 (1122, 'Km5PowerFailure', 'Сбой питания', 9),
 (1123, 'Km5Reserve13', 'Резерв', 9),
 (1124, 'Km5ReadErrorRTC', 'Ошибка чтения из RTC', 9),
 (1125, 'Km5WriteErrorRTC', 'Ошибка записи в RTC', 9),
 (1126, 'Km5ReadErrorEEPROM', 'Ошибка чтения из EEPROM', 9),
 (1127, 'Km5WriteErrorEEPROM', 'Ошибка записи в EEPROM', 9),

 -- Пульсар-16М
 (1500, 'Pulsar16MStartValueChannel1', 'Стартовое значение по каналу 1', 2),
 (1501, 'Pulsar16MStartValueChannel2', 'Стартовое значение по каналу 2', 2),
 (1502, 'Pulsar16MStartValueChannel3', 'Стартовое значение по каналу 3', 2),
 (1503, 'Pulsar16MStartValueChannel4', 'Стартовое значение по каналу 4', 2),
 (1504, 'Pulsar16MStartValueChannel5', 'Стартовое значение по каналу 5', 2),
 (1505, 'Pulsar16MStartValueChannel6', 'Стартовое значение по каналу 6', 2),
 (1506, 'Pulsar16MStartValueChannel7', 'Стартовое значение по каналу 7', 2),
 (1507, 'Pulsar16MStartValueChannel8', 'Стартовое значение по каналу 8', 2),
 (1508, 'Pulsar16MStartValueChannel9', 'Стартовое значение по каналу 9', 2),
 (1509, 'Pulsar16MStartValueChannel10', 'Стартовое значение по каналу 10', 2),
 (1510, 'Pulsar16MStartValueChannel11', 'Стартовое значение по каналу 11', 2),
 (1511, 'Pulsar16MStartValueChannel12', 'Стартовое значение по каналу 12', 2),
 (1512, 'Pulsar16MStartValueChannel13', 'Стартовое значение по каналу 13', 2),
 (1513, 'Pulsar16MStartValueChannel14', 'Стартовое значение по каналу 14', 2),
 (1514, 'Pulsar16MStartValueChannel15', 'Стартовое значение по каналу 15', 2),
 (1515, 'Pulsar16MStartValueChannel16', 'Стартовое значение по каналу 16', 2),

--РМ-5
 (2051, 'Rm5t4Greatert4Max', 't4 > максимума t4max', 13),
 (2052, 'Rm5t4Lesst4Min', 't4 < минимума t4min', 13),
 (2053, 'Rm5Reserve1', 'Резерв', 13),
 (2054, 'Rm5Gv4GreaterGv4Max', 'Gv4 > максимума Gv4max', 13),
 (2055, 'Rm5Gv3GreaterGv3Max', 'Gv3 > максимума Gv3max', 13),
 (2056, 'Rm5ModeMainSummer', 'Режим "Основной (Зима)"', 13),
 (2057, 'Rm5ModeSummer1', 'Режим "Лето 1"', 13),
 (2058, 'Rm5ModeSummer2', 'Режим "Лето 2"', 13),
 (2059, 'Rm5ModeSummer3', 'Режим "Лето 3"', 13),
 (2060, 'Rm5ModeNoFlow', 'Режим "Нет потока"', 13),
 (2061, 'Rm5ModeEmergency', 'Режим "НЕШТАТНЫЙ"', 13),
 (2062, 'Rm5Reserve2', 'Резерв', 13),
 (2063, 'Rm5Reserve3', 'Резерв', 13),
 (2064, 'Rm5UPpsGreaterMax', 'U канала G ППС > допустимого максимума', 13),
 (2065, 'Rm5IPpsGreaterMax', 'I катушки ППС > допустимого максимума', 13),
 (2066, 'Rm5IPpsLessMin', 'I катушки ППС < допустимого минимума', 13),
 (2067, 'Rm5UGreaterMax', 'U канала G РМ-5 > допустимого максимума', 13),
 (2068, 'Rm5IGreaterMax', 'I катушки РМ-5 > допустимого максимума', 13),
 (2069, 'Rm5ILessMin', 'I катушки РM-5 < допустимого минимума', 13),
 (2070, 'Rm5Gv2Greater104Gv2', 'Gv2 > 1.04*Gv2', 13),
 (2071, 'Rm5thpGreaterMax', 'tхп > максимума tхпmax', 13),
 (2072, 'Rm5Reserve4', 'Резерв', 13),
 (2073, 'Rm5ThpLessMin', 'Tхп < минимума tхпmin', 13),
 (2074, 'Rm5t2pGreaterMax', 't2п > максимума t2пmax', 13),
 (2075, 'Rm5Reserve5', 'Резерв', 13),
 (2076, 'Rm5t2pLessMin', 't2п < минимума t2пmin', 13),
 (2077, 'Rm5taGreatertaMax', 'ta > максимума tamax', 13),
 (2078, 'Rm5taLesstaMin', 'ta < минимума tamin', 13),
 (2079, 'Rm5txkGreatertxkMax', 'tхк > максимума tхкmax', 13),
 (2080, 'Rm5Reserve6', 'Резерв', 13),
 (2081, 'Rm5txkLesstxkMin', 'tхк < минимума tхкmin', 13),
 (2082, 'Rm5Gv2GreaterGv2Max', 'Gv2 > максимума Gv2max', 13),
 (2083, 'Rm5Reserve7', 'Резерв', 13),
 (2084, 'Rm5Gv2LessGv2Min', 'Gv2 < минимума Gv2min', 13),
 (2085, 'Rm4Gv1GreaterGv1Max', 'Gv1 > максимума Gv1max', 13),
 (2086, 'Rm5Reserve8', 'Резерв', 13),
 (2087, 'Rm5Gv1LessGv1Min', 'Gv1 < минимума Gv1min', 13),
 (2088, 'Rm5t2kGreatert2kMax', 't2k > максимума t2kmax', 13),
 (2089, 'Rm5Reserve9', 'Резерв', 13),
 (2090, 'Rm5t2kLesst2kMin', 't2k < минимума t2kmin', 13),
 (2091, 'Rm5t1kGreatert1kMax', 't1k > максимума t1kmax', 13),
 (2092, 'Rm5Reserve10', 'Резерв', 13),
 (2093, 'Rm5t1kLesst1kMin', 't1k < минимума t1kmin', 13),
 (2094, 'Rm5t1t2GreaterdtMax', 't1 - t2 > максимума dtmax', 13),
 (2095, 'Rm5Reserve11', 'Резерв', 13),
 (2096, 'Rm5t1t2LessdtMin', 't1 - t2 < минимума dtmin', 13),
 (2097, 'Rm5PxLessPxMin', 'Давление Px < Pxmin', 13),
 (2098, 'Rm5ResetOrWatchdog', 'Был RESET или WATCHDOG', 13),
 (2099, 'Rm5DateTimeChanged', 'Было выполнено изменение даты и/или времени в RTC теплосчетчика', 13),
 (2100, 'Rm5PxGreaterPxMax', 'Давление Px > Pxmax', 13),
 (2101, 'Rm5P2LessP2Min', 'Давление P2 < P2min', 13),
 (2102, 'Rm5HourZeroing', 'Обнуление интеграторов за час', 13),
 (2103, 'Rm5ErrorCountGreaterMax', 'Количество ошибок за сутки > максимума', 13),
 (2104, 'Rm5P2GreaterP2Max', 'Давление P2 > P2max', 13),
 (2105, 'Rm5P1LessP1Min', 'Давление P1 < P1min', 13),
 (2106, 'Rm5ThermalPowerLess0', 'Тепловая мощность W < 0', 13),
 (2107, 'Rm5Reserve12', 'Резерв', 13),
 (2108, 'Rm5P1GreaterP1Max', 'Давление P1 > P1Max', 13),
 (2114, 'Rm5ErrorExchangePps', 'Ошибка обмена с ППС', 13),
 (2115, 'Rm5BreakPx', 'Обрыв цепи датчика Px', 13),
 (2116, 'Rm5BreakP2Pps', 'Обрыв цепи датчика P2 ППС', 13),
 (2117, 'Rm5BreakP2', 'Обрыв цепи датчика P2 РМ-5', 13),
 (2118, 'Rm5BreakP1', 'Обрыв цепи датчика P1', 13),
 (2119, 'Rm5FaultThermocouplesPps', 'Неисправность в цепи термопреобразователей ППС', 13),
 (2120, 'Rm5FaultThermocouples', 'Неисправность в цепи термопреобразователей РМ-5', 13),
 (2121, 'Rm5StopCounting', 'Останов счета', 13),
 (2122, 'Rm5PowerFailure', 'Сбой питания', 13),
 (2123, 'Rm5Reserve13', 'Резерв', 13),
 (2124, 'Rm5ReadErrorRTC', 'Ошибка чтения из RTC', 13),
 (2125, 'Rm5WriteErrorRTC', 'Ошибка записи в RTC', 13),
 (2126, 'Rm5ReadErrorEEPROM', 'Ошибка чтения из EEPROM', 13),
 (2127, 'Rm5WriteErrorEEPROM', 'Ошибка записи в EEPROM', 13),

 --Взлет-26
 -- журнал нештатных ситуаций
       (3000, 'Vzljot26EmergencySituation0', 'Нештатная ситуация 0', 20),
       (3001, 'Vzljot26EmergencySituation1', 'Нештатная ситуация 1', 20),
       (3002, 'Vzljot26EmergencySituation2', 'Нештатная ситуация 2', 20),
	   (3003, 'Vzljot26EmergencySituation3', 'Нештатная ситуация 3', 20),
	   (3004, 'Vzljot26EmergencySituation4', 'Нештатная ситуация 4', 20),
	   (3005, 'Vzljot26EmergencySituation5', 'Нештатная ситуация 5', 20),
	   (3006, 'Vzljot26EmergencySituation6', 'Нештатная ситуация 6', 20),
	   (3007, 'Vzljot26EmergencySituation7', 'Нештатная ситуация 7', 20),
	   (3008, 'Vzljot26EmergencySituation8', 'Нештатная ситуация 8', 20),
	   (3009, 'Vzljot26EmergencySituation9', 'Нештатная ситуация 9', 20),
	   (3010, 'Vzljot26EmergencySituation10', 'Нештатная ситуация 10', 20),
	   (3011, 'Vzljot26EmergencySituation11', 'Нештатная ситуация 11', 20),
	   (3012, 'Vzljot26EmergencySituation12', 'Нештатная ситуация 12', 20),
	   (3013, 'Vzljot26EmergencySituation13', 'Нештатная ситуация 13', 20),
	   (3014, 'Vzljot26EmergencySituation14', 'Нештатная ситуация 14', 20),
	   (3015, 'Vzljot26EmergencySituation15', 'Нештатная ситуация 15', 20),
	   (3016, 'Vzljot26EmergencySituation16', 'Нештатная ситуация 16', 20),
	   (3017, 'Vzljot26EmergencySituation17', 'Нештатная ситуация 17', 20),
	   (3018, 'Vzljot26EmergencySituation18', 'Нештатная ситуация 18', 20),
	   (3019, 'Vzljot26EmergencySituation19', 'Нештатная ситуация 19', 20),
	   (3020, 'Vzljot26EmergencySituation20', 'Нештатная ситуация 20', 20),
	   (3021, 'Vzljot26EmergencySituation21', 'Нештатная ситуация 21', 20),
	   (3022, 'Vzljot26EmergencySituation22', 'Нештатная ситуация 22', 20),
	   (3023, 'Vzljot26EmergencySituation23', 'Нештатная ситуация 23', 20),
	   (3024, 'Vzljot26EmergencySituation24', 'Нештатная ситуация 24', 20),
	   (3025, 'Vzljot26EmergencySituation25', 'Нештатная ситуация 25', 20),
	   (3026, 'Vzljot26EmergencySituation26', 'Нештатная ситуация 26', 20),
	   (3027, 'Vzljot26EmergencySituation27', 'Нештатная ситуация 27', 20),
	   (3028, 'Vzljot26EmergencySituation28', 'Нештатная ситуация 28', 20),
	   (3029, 'Vzljot26EmergencySituation29', 'Нештатная ситуация 29', 20),
	   (3030, 'Vzljot26EmergencySituation30', 'Нештатная ситуация 30', 20),
  -- журнал отказов
       (3031, 'Vzljot26ClockFailure', 'Отказ часов', 20),
	   (3032, 'Vzljot26SettingsMemoryFailure', 'Отказ памяти настроек', 20),
	   (3033, 'Vzljot26ArchiveMemoryFailure', 'Отказ памяти архивов', 20),
	   (3034, 'Vzljot26NoPower', 'Отсутствие питания', 20),
	   (3035, 'Vzljot26DeviceConfigurationBroken', 'Разрушена конфигурация прибора', 20),
   -- журнал режимов (электронная пломба)
       (3036, 'Vzljot26Work', 'Режим работы: "Работа"', 20),
	   (3037, 'Vzljot26Service', 'Режим работы: "Сервис"', 20),
	   (3038, 'Vzljot26Verification', 'Режим работы: "Поверка"', 20),
	   (3039, 'Vzljot26Calibration', 'Режим работы: "Калибровка"', 20),
	   (3040, 'Vzljot26UnknownFailure', 'Отказ по неизвестной причине', 20),

--Взлет-26M
 -- журнал нештатных ситуаций
       (4000, 'Vzljot26MEmergencySituation0', 'Нештатная ситуация 0', 21),
       (4001, 'Vzljot26MEmergencySituation1', 'Нештатная ситуация 1', 21),
       (4002, 'Vzljot26MEmergencySituation2', 'Нештатная ситуация 2', 21),
	   (4003, 'Vzljot26MEmergencySituation3', 'Нештатная ситуация 3', 21),
	   (4004, 'Vzljot26MEmergencySituation4', 'Нештатная ситуация 4', 21),
	   (4005, 'Vzljot26MEmergencySituation5', 'Нештатная ситуация 5', 21),
	   (4006, 'Vzljot26MEmergencySituation6', 'Нештатная ситуация 6', 21),
	   (4007, 'Vzljot26MEmergencySituation7', 'Нештатная ситуация 7', 21),
	   (4008, 'Vzljot26MEmergencySituation8', 'Нештатная ситуация 8', 21),
	   (4009, 'Vzljot26MEmergencySituation9', 'Нештатная ситуация 9', 21),
	   (4010, 'Vzljot26MEmergencySituation10', 'Нештатная ситуация 10', 21),
	   (4011, 'Vzljot26MEmergencySituation11', 'Нештатная ситуация 11', 21),
	   (4012, 'Vzljot26MEmergencySituation12', 'Нештатная ситуация 12', 21),
	   (4013, 'Vzljot26MEmergencySituation13', 'Нештатная ситуация 13', 21),
	   (4014, 'Vzljot26MEmergencySituation14', 'Нештатная ситуация 14', 21),
	   (4015, 'Vzljot26MEmergencySituation15', 'Нештатная ситуация 15', 21),
	   (4016, 'Vzljot26MEmergencySituation16', 'Нештатная ситуация 16', 21),
	   (4017, 'Vzljot26MEmergencySituation17', 'Нештатная ситуация 17', 21),
	   (4018, 'Vzljot26MEmergencySituation18', 'Нештатная ситуация 18', 21),
	   (4019, 'Vzljot26MEmergencySituation19', 'Нештатная ситуация 19', 21),
	   (4020, 'Vzljot26MEmergencySituation20', 'Нештатная ситуация 20', 21),
	   (4021, 'Vzljot26MEmergencySituation21', 'Нештатная ситуация 21', 21),
	   (4022, 'Vzljot26MEmergencySituation22', 'Нештатная ситуация 22', 21),
	   (4023, 'Vzljot26MEmergencySituation23', 'Нештатная ситуация 23', 21),
	   (4024, 'Vzljot26MEmergencySituation24', 'Нештатная ситуация 24', 21),
	   (4025, 'Vzljot26MEmergencySituation25', 'Нештатная ситуация 25', 21),
	   (4026, 'Vzljot26MEmergencySituation26', 'Нештатная ситуация 26', 21),
	   (4027, 'Vzljot26MEmergencySituation27', 'Нештатная ситуация 27', 21),
	   (4028, 'Vzljot26MEmergencySituation28', 'Нештатная ситуация 28', 21),
	   (4029, 'Vzljot26MEmergencySituation29', 'Нештатная ситуация 29', 21),
	   (4030, 'Vzljot26MEmergencySituation30', 'Нештатная ситуация 30', 21),
	   -- журнал отказов
       (4031, 'Vzljot26MClockFailure', 'Отказ часов', 21),
	   (4032, 'Vzljot26MSettingsMemoryFailure', 'Отказ памяти настроек', 21),
	   (4033, 'Vzljot26MArchiveMemoryFailure', 'Отказ памяти архивов', 21),
	   (4034, 'Vzljot26MNoPower', 'Отсутствие питания', 21),
	   (4035, 'Vzljot26MDeviceConfigurationBroken', 'Разрушена конфигурация прибора', 21),
   -- журнал режимов (электронная пломба)
       (4036, 'Vzljot26MWork', 'Режим работы: "Работа"', 21),
	   (4037, 'Vzljot26MService', 'Режим работы: "Сервис"', 21),
	   (4038, 'Vzljot26MVerification', 'Режим работы: "Поверка"', 21),
	   (4039, 'Vzljot26MCalibration', 'Режим работы: "Калибровка"', 21),
	   (4040, 'Vzljot26MUnknownFailure', 'Отказ по неизвестной причине', 21),

-- ВКТ7
       (4100, 'SchemeTv1', 'СИ ТВ1', 1),
	   (4101, 'SchemeTv2', 'СИ ТВ2', 1),
	   (4102, 'Pipe3TargetTv1', 'Т3 ТВ1', 1),
	   (4103, 'Pipe3TargetTv2', 'Т3 ТВ2', 1),
	   (4104, 't5TargetTv1', 't5 ТВ1', 1),
	   (4105, 't5TargetTv2', 't5 ТВ2', 1)

--([Id],[Code],[Description],[DeviceId])
GO 

SET IDENTITY_INSERT [Dictionaries].[InternalDeviceEvent] OFF;
GO

