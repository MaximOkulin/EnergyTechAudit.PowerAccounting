﻿/*------------------------------------------------------------------------------
*<auto-generated>
*     This code was generated by a tool DeploymentSupport.linq.
*</auto-generated>
*------------------------------------------------------------------------------*/


SET IDENTITY_INSERT [Core].[EntityProperty] ON;


INSERT INTO [Core].[EntityProperty] ([Id], [EntityId], [PropertyName], [Description])
VALUES
(1, 1, 'BinaryContentTypeId', 'Ид'),
(2, 1, 'Data', 'Данные'),
(3, 1, 'Category', 'Категория'),
(4, 1, 'Id', 'Ид'),
(5, 1, 'Code', 'Код'),
(6, 1, 'Description', 'Наименование'),
(7, 2, 'Id', 'Ид'),
(8, 2, 'Code', 'Код'),
(9, 2, 'Description', 'Наименование'),
(10, 3, 'Id', 'Ид'),
(11, 3, 'Code', 'Код'),
(12, 3, 'Description', 'Наименование'),
(13, 4, 'Id', 'Ид'),
(14, 4, 'Code', 'Код'),
(15, 4, 'Description', 'Наименование'),
(16, 5, 'Id', 'Ид'),
(17, 5, 'Code', 'Код'),
(18, 5, 'Description', 'Наименование'),
(19, 6, 'Id', 'Ид'),
(20, 6, 'EntityId', 'Ид'),
(21, 6, 'DynamicParameterId', 'Ид'),
(22, 6, 'Value', 'Значение'),
(23, 7, 'Id', 'Ид'),
(24, 7, 'Code', 'Код'),
(25, 7, 'Description', 'Наименование'),
(26, 8, 'Id', 'Ид'),
(27, 8, 'EntityId', 'Ид'),
(28, 8, 'PropertyName', 'Название'),
(29, 8, 'Description', 'Наименование'),
(30, 9, 'Id', 'Ид'),
(31, 9, 'Code', 'Код'),
(32, 9, 'Description', 'Наименование'),
(33, 10, 'EntityTreeId', 'Ид'),
(34, 10, 'RoleId', 'Ид'),
(35, 11, 'Id', 'Ид'),
(36, 11, 'Code', 'Код'),
(37, 11, 'Description', 'Наименование'),
(38, 12, 'Id', 'Ид'),
(39, 12, 'Code', 'Код'),
(40, 12, 'Description', 'Наименование'),
(41, 13, 'Id', 'Ид'),
(42, 13, 'Code', 'Код'),
(43, 13, 'Description', 'Наименование'),
(44, 14, 'Id', 'Ид'),
(45, 14, 'Order', 'Порядок сортировки'),
(46, 14, 'Title', 'Заголовок'),
(47, 14, 'DisplayInMainMenu', 'Показывать в основном меню'),
(48, 14, 'DisplayInNavbar', 'Показывать в панели навигации'),
(49, 15, 'Id', 'Ид'),
(50, 15, 'MenuId', 'Ид меню'),
(51, 15, 'MetaObjectId', 'Ид метаобъекта'),
(52, 15, 'Order', 'Порядок сортировки'),
(53, 15, 'Title', 'Заголовок'),
(54, 15, 'Menu', 'Меню'),
(55, 15, 'MetaObject', 'Метаобъект'),
(56, 16, 'Id', 'Ид'),
(57, 16, 'MetaObjectTypeId', 'Ид'),
(58, 16, 'DictionaryId', 'Ид'),
(59, 16, 'PivotId', 'Ид'),
(60, 16, 'ReportId', 'Ид'),
(61, 16, 'QueryId', 'Ид'),
(62, 16, 'FormId', 'Ид'),
(63, 16, 'PivotDiagrammId', 'Ид'),
(64, 16, 'ProcessingId', 'Ид'),
(65, 16, 'DiagrammId', 'Ид'),
(66, 16, 'ParametricId', 'Ид'),
(67, 16, 'SourceId', 'Ид'),
(68, 16, 'MetaObjectType', 'Тип'),
(69, 17, 'MetaObjectId', 'Ид'),
(70, 17, 'DeviceId', 'Ид'),
(71, 18, 'MetaObjectId', 'Ид'),
(72, 18, 'RoleId', 'Ид'),
(73, 19, 'Id', 'Ид'),
(74, 20, 'Id', 'Ид'),
(75, 20, 'Code', 'Код'),
(76, 20, 'Description', 'Наименование'),
(77, 21, 'Id', 'Ид'),
(78, 21, 'Code', 'Код'),
(79, 21, 'Description', 'Наименование'),
(80, 22, 'Id', 'Ид'),
(81, 22, 'Code', 'Код'),
(82, 22, 'Description', 'Наименование'),
(83, 23, 'Id', 'Ид'),
(84, 23, 'Code', 'Код'),
(85, 23, 'Description', 'Наименование'),
(86, 24, 'Id', 'Ид'),
(87, 24, 'Code', 'Код'),
(88, 24, 'Description', 'Наименование'),
(89, 25, 'Id', 'Ид'),
(90, 25, 'Code', 'Код'),
(91, 25, 'Description', 'Наименование'),
(92, 26, 'Id', 'Ид'),
(93, 26, 'Description', 'Наименование'),
(94, 26, 'ScheduleTypeId', 'Ид'),
(95, 26, 'Enabled', 'Разрешен'),
(96, 26, 'PeriodBegin', 'Начало периода времени'),
(97, 26, 'PeriodEnd', 'Конец периода времени'),
(98, 26, 'EditableOrdinalNumberOfDay', 'Порядковый номер дня'),
(99, 27, 'Id', 'Ид'),
(100, 27, 'Code', 'Код'),
(101, 27, 'Description', 'Наименование'),
(102, 28, 'Id', 'Ид'),
(103, 28, 'Code', 'Код'),
(104, 28, 'Description', 'Наименование'),
(105, 29, 'IsAsync', 'Асихронная задача'),
(106, 29, 'Id', 'Ид'),
(107, 29, 'Code', 'Код'),
(108, 29, 'Description', 'Наименование'),
(109, 30, 'Id', 'Ид'),
(110, 30, 'ProcessingId', 'Ид'),
(111, 30, 'Parameters', 'Параметры задачи'),
(112, 30, 'ProcessingStatusId', 'Ид'),
(113, 31, 'Id', 'Ид'),
(114, 31, 'Message', 'Текст сообщения'),
(115, 31, 'Type', 'Тип'),
(116, 31, 'TimeOut', 'Таймаут'),
(117, 31, 'Title', 'Заголовок'),
(118, 31, 'ShowCloseButton', 'Показать кнопку "Закрыть"'),
(119, 31, 'Duration', 'Время анимации'),
(120, 31, 'PendingDate', 'Дата окончания'),
(121, 31, 'InjectCss', 'Инжектируемые стили'),
(122, 32, 'Id', 'Ид'),
(123, 32, 'Area', 'Область'),
(124, 32, 'Controller', 'Контроллер'),
(125, 32, 'Action', 'Действие'),
(126, 32, 'Time', 'Время'),
(127, 32, 'Elapsed', 'Время исполнения'),
(128, 32, 'UserId', 'Ид'),
(129, 32, 'ActionParams', 'Параметры действия'),
(130, 33, 'PropertyDescription', 'Наименование свойства'),
(131, 33, 'PropertyName', 'Ид свойства'),
(132, 33, 'OriginalValue', 'Исходное значение'),
(133, 33, 'CurrentValue', 'Текущее значение'),
(134, 33, 'Id', 'Ид'),
(135, 33, 'EntityId', 'Ид сущности'),
(136, 33, 'EntityTypeDescription', 'Наименование типа'),
(137, 33, 'EntityTypeName', 'Ид типа'),
(138, 33, 'DateTime', 'Дата и время'),
(139, 33, 'User', 'Пользователь'),
(140, 34, 'UserName', 'Пользователь'),
(141, 34, 'UserAgent', 'Браузер'),
(142, 34, 'RequestParams', 'Параметры запроса'),
(143, 34, 'Id', 'Ид'),
(144, 34, 'Time', 'Время'),
(145, 34, 'Exception', 'Исключение'),
(146, 34, 'Message', 'Сообщение'),
(147, 34, 'StackTrace', 'Трассировка стека'),
(148, 35, 'Number', 'Номер'),
(149, 35, 'Question', 'Вопрос'),
(150, 35, 'Answer', 'Ответ'),
(151, 35, 'Categories', 'Категории'),
(152, 35, 'Id', 'Ид'),
(153, 35, 'Caption', 'Заголовок'),
(154, 35, 'Date', 'Дата'),
(155, 36, 'FaqId', 'Ид'),
(156, 36, 'RoleId', 'Ид'),
(157, 37, 'Text', 'Текст'),
(158, 37, 'BinaryId', 'Ид'),
(159, 37, 'Id', 'Ид'),
(160, 37, 'Caption', 'Заголовок'),
(161, 37, 'Date', 'Дата'),
(162, 38, 'NewsId', 'Ид'),
(163, 38, 'RoleId', 'Ид'),
(164, 39, 'Id', 'Ид'),
(165, 39, 'UserName', 'Пользователь'),
(166, 39, 'ConnectionId', 'Соединение'),
(167, 39, 'RoleName', 'Роль'),
(168, 39, 'IpAddress', 'IP-адрес'),
(169, 39, 'UserAgent', 'Браузер'),
(170, 39, 'IssueDate', 'Время входа'),
(171, 39, 'ExpireDate', 'Время завершения сессии'),
(172, 40, 'Id', 'Ид'),
(173, 40, 'Code', 'Код'),
(174, 40, 'Description', 'Наименование'),
(175, 42, 'Description', 'Наименование'),
(176, 42, 'Id', 'Ид'),
(177, 42, 'RoleId', 'Ид'),
(178, 42, 'UserGroupId', 'Ид'),
(179, 42, 'UserName', 'Логин'),
(180, 42, 'Password', 'Пароль'),
(181, 42, 'EncryptedPassword', 'Хранимый пароль'),
(182, 42, 'Email', 'Электронная почта'),
(183, 42, 'CreateDate', 'Дата создания'),
(184, 42, 'ExpiredDate', 'Дата истечения срока'),
(185, 42, 'IsTemporary', 'Временный'),
(186, 42, 'IsApproved', 'Подтвержден'),
(187, 42, 'EditablePassword', 'Редактируемый пароль'),
(188, 43, 'Id', 'Ид'),
(189, 43, 'Description', 'Наименование'),
(190, 44, 'Id', 'Ид'),
(191, 44, 'Text', 'Текст сообщения'),
(192, 44, 'UserId', 'Ид'),
(193, 44, 'Date', 'Дата'),
(194, 45, 'Id', 'Ид'),
(195, 45, 'Identifier', 'Идентификатор'),
(196, 45, 'Description', 'Наименование'),
(197, 45, 'EditableNetAddress', 'Сетевой адрес'),
(198, 45, 'Port', 'Порт'),
(199, 45, 'NetPhone', 'Номер телефона'),
(200, 45, 'TransportTypeId', 'Ид'),
(201, 45, 'TransportServerModelId', 'Ид'),
(202, 45, 'DeviceReaderId', 'Ид'),
(203, 45, 'CsdModemId', 'Ид'),
(204, 45, 'ControllerAddress', 'Адрес контроллера'),
(205, 45, 'IsNeedToReconfigure', 'Конфигурировать при каждом подключении'),
(206, 45, 'LastConnectionTime', 'Время последнего опроса'),
(207, 45, 'SuccessConnectionPercent', 'Процент успешных соединений'),
(208, 45, 'LastStatusConnectionId', 'Ид'),
(209, 46, 'AccessPointId', 'Ид'),
(210, 46, 'BuildingId', 'Ид'),
(211, 47, 'Id', 'Ид'),
(212, 47, 'ConnectionTime', 'Время подключения'),
(213, 47, 'StatusConnectionId', 'Ид'),
(214, 47, 'AccessPointId', 'Ид'),
(215, 48, 'Id', 'Ид'),
(216, 48, 'Description', 'Описание'),
(217, 48, 'AgreementParameterTypeId', 'Ид'),
(218, 48, 'Value', 'Значение'),
(219, 49, 'Id', 'Ид'),
(220, 49, 'TimeSignatureId', 'Ид'),
(221, 49, 'PeriodTypeId', 'Ид'),
(222, 49, 'Time', 'Время'),
(223, 49, 'Value', 'Значение'),
(224, 49, 'IsValid', 'Корректность значения'),
(225, 49, 'MeasurementDeviceId', 'Ид'),
(226, 49, 'DeviceParameterId', 'Ид'),
(227, 50, 'Id', 'Ид'),
(228, 50, 'Description', 'Наименование'),
(229, 50, 'FullAddress', 'Полный адрес'),
(230, 50, 'Square', 'Площадь'),
(231, 50, 'BuildingPurposeId', 'Ид'),
(232, 50, 'DistrictId', 'Ид'),
(233, 50, 'CountFlats', 'Количество квартир'),
(234, 50, 'Location', 'Географические координаты'),
(235, 50, 'Geolocation', 'Геолокация'),
(236, 50, 'OrganizationId', 'Ид'),
(237, 50, 'UserAdditionalInfoId', 'Ид'),
(238, 51, 'Description', 'Наименование'),
(239, 51, 'Id', 'Ид'),
(240, 51, 'ResourceSystemTypeId', 'Ид'),
(241, 51, 'MeasurementDeviceId', 'Ид'),
(242, 51, 'PlacementId', 'Ид'),
(243, 51, 'Activated', 'Активен'),
(244, 51, 'ChannelTemplateId', 'Ид'),
(245, 51, 'MnemoschemeId', 'Ид'),
(246, 51, 'OrganizationId', 'Ид'),
(247, 51, 'TechnologicAdjunctionTypeId', 'Ид'),
(248, 51, 'ResourceSubsystemTypeId', 'Ид'),
(249, 51, 'LastEmergencyTimeSignatureId', 'Ид'),
(250, 51, 'HasDynamicData', 'Содержит динамические параметры'),
(251, 52, 'ChannelId', 'Ид'),
(252, 52, 'AgreementParameterId', 'Ид'),
(253, 53, 'Id', 'Ид'),
(254, 53, 'Description', 'Наименование'),
(255, 53, 'ResourceSystemTypeId', 'Ид'),
(256, 53, 'DeviceId', 'Ид'),
(257, 53, 'MnemoschemeId', 'Ид'),
(258, 53, 'Comment', 'Комментарий'),
(259, 53, 'ResourceSubsystemTypeId', 'Ид'),
(260, 54, 'Id', 'Ид'),
(261, 54, 'Description', 'Наименование'),
(262, 54, 'AccountNumber', 'Номер счета'),
(263, 54, 'OrganizationId', 'Ид'),
(264, 55, 'CheckingAccountId', 'Ид'),
(265, 55, 'PlacementId', 'Ид'),
(266, 56, 'Id', 'Ид'),
(267, 56, 'Description', 'Наименование'),
(268, 56, 'NetPhone', 'Номер телефона'),
(269, 56, 'ComPortId', 'Ид'),
(270, 56, 'DeviceId', 'Ид'),
(271, 57, 'Id', 'Ид'),
(272, 57, 'Time', 'Время возникновения'),
(273, 57, 'DeviceEventParameterId', 'Ид'),
(274, 57, 'MeasurementDeviceId', 'Ид'),
(275, 57, 'State', 'Состояние'),
(276, 58, 'DeviceId', 'Ид'),
(277, 58, 'DynamicParameterId', 'Ид'),
(278, 59, 'Id', 'Ид'),
(279, 59, 'Min', 'Мин. знач.'),
(280, 59, 'Max', 'Макс. знач.'),
(281, 59, 'WriteMethodName', 'Метод записи параметра'),
(282, 59, 'ValueTypeCode', 'Код типа значения'),
(283, 60, 'Id', 'Ид'),
(284, 60, 'Code', 'Код'),
(285, 60, 'Description', 'Наименование'),
(286, 60, 'UpdateConfigInterval', 'Интервал обновления конфигурации (мин.)'),
(287, 60, 'MaxThreadCount', 'Максимальное количество одновременных потоков опроса'),
(288, 60, 'QueuePollingInterval', 'Частота просмотра очереди потоков опроса (сек.)'),
(289, 60, 'HoveringTaskRemoveTime', 'Интервал времени снятия зависших потоков (мин.)'),
(290, 60, 'DeviceReaderTypeId', 'Ид'),
(291, 60, 'EditableSignalRNetAddress', 'IP-адрес SignalR'),
(292, 60, 'SignalRPort', 'Порт SignalR'),
(293, 60, 'SignalRHub', 'Хаб SignalR'),
(294, 60, 'TraceMethodTypeId', 'Ид'),
(295, 60, 'LogFolder', 'Папка логов'),
(296, 60, 'ServerCommunicatorNetAddress', 'Адрес IIS для коммуникаций'),
(297, 60, 'UserId', 'Ид'),
(298, 60, 'ServerCommunicatorController', 'Коммуникационный контроллер IIS'),
(299, 60, 'ServerCommunicatorReceiveAction', 'Дейстие контроллера'),
(300, 61, 'DeviceReaderId', 'Ид'),
(301, 61, 'MeasurementDeviceId', 'Ид'),
(302, 61, 'ErrorTypeId', 'Ид'),
(303, 61, 'Text', 'Доп. информация'),
(304, 61, 'Id', 'Ид'),
(305, 61, 'Time', 'Время'),
(306, 61, 'Exception', 'Исключение'),
(307, 61, 'Message', 'Сообщение'),
(308, 61, 'StackTrace', 'Трассировка стека'),
(309, 62, 'DeviceReaderId', 'Ид'),
(310, 62, 'ScheduleItemId', 'Ид'),
(311, 63, 'Id', 'Ид'),
(312, 63, 'Time', 'Время'),
(313, 63, 'NotificationTypeId', 'Ид'),
(314, 63, 'UserAdditionalInfoId', 'Ид'),
(315, 63, 'Text', 'Текст сообщения'),
(316, 63, 'EmergencyLogId', 'Ид'),
(317, 64, 'Id', 'Ид'),
(318, 64, 'Description', 'Наименование'),
(319, 64, 'SeasonTypeId', 'Ид'),
(320, 64, 'TurnOn', 'Включен'),
(321, 64, 'EmergencySituationParameterTemplateId', 'Ид'),
(322, 64, 'ChannelId', 'Ид'),
(323, 64, 'PredicateExpression', 'Условие'),
(324, 64, 'EntityTypeName', 'Название сущности'),
(325, 65, 'Id', 'Ид'),
(326, 65, 'Description', 'Описание'),
(327, 65, 'PredicateExpression', 'Условие'),
(328, 65, 'EntityTypeName', 'Название сущности'),
(329, 66, 'Id', 'Ид'),
(330, 66, 'Time', 'Время'),
(331, 67, 'Id', 'Ид'),
(332, 67, 'Description', 'Наименование'),
(333, 67, 'FactoryNumber', 'Заводской номер'),
(334, 67, 'ExternalNetAddress', 'Внешний IP-адрес (прошивка в приборе)'),
(335, 67, 'ExternalPort', 'Внешний порт (прошивка в приборе)'),
(336, 67, 'LocalNetAddress', 'Локальный IP-адрес (прослушивается сервером)'),
(337, 67, 'LocalPort', 'Локальный порт (прослушивается сервером)'),
(338, 67, 'Identifier', 'Сетевой идентификатор'),
(339, 67, 'DeviceReaderId', 'Ид'),
(340, 67, 'BuildingId', 'Ид'),
(341, 68, 'Id', 'Ид'),
(342, 68, 'MeasurementDeviceId', 'Ид'),
(343, 68, 'PeriodTypeId', 'Ид'),
(344, 68, 'DiffDeviceParameterId', 'Ид'),
(345, 69, 'SubModel', 'Модель исполнения'),
(346, 69, 'LastConnectionTime', 'Время последнего опроса'),
(347, 69, 'AutoDefTimeoutAnswer', 'Автоматический таймаут'),
(348, 69, 'AmountAttempt', 'Количество попыток подключения'),
(349, 69, 'PollingInterval', 'Интервал опроса (мин.)'),
(350, 69, 'ProtocolSubTypeId', 'Ид'),
(351, 69, 'ComPortId', 'Ид'),
(352, 69, 'BaudId', 'Ид'),
(353, 69, 'DataBitId', 'Ид'),
(354, 69, 'StopBitId', 'Ид'),
(355, 69, 'ParityId', 'Ид'),
(356, 69, 'Priority', 'Приоритет'),
(357, 69, 'SuccessConnectionPercent', 'Процент успешных соединений'),
(358, 69, 'NetworkAddress', 'Сетевой адрес'),
(359, 69, 'TurnOn', 'Прибор включен'),
(360, 69, 'LastSuccessConnectionTime', 'Время последнего успешного опроса'),
(361, 69, 'Firmware', 'Номер версии ПО'),
(362, 69, 'StartReadArchiveDate', 'Начальная дата архива'),
(363, 69, 'HubId', 'Ид'),
(364, 69, 'GiveCurrData', 'Мгновенные данные'),
(365, 69, 'GiveHArcData', 'Часовой архив'),
(366, 69, 'GiveDArcData', 'Дневной архив'),
(367, 69, 'GiveMArcData', 'Месячный архив'),
(368, 69, 'AccessPointId', 'Ид'),
(369, 69, 'LastStatusConnectionId', 'Ид'),
(370, 69, 'TypeConnectionId', 'Ид'),
(371, 69, 'PortTypeId', 'Ид'),
(372, 69, 'Id', 'Ид'),
(373, 69, 'FactoryNumber', 'Заводской номер'),
(374, 69, 'Description', 'Наименование'),
(375, 69, 'CurrentAccreditationDate', 'Дата действующей поверки'),
(376, 69, 'NextAccreditationDate', 'Дата следующей поверки'),
(377, 69, 'ManufacturingDate', 'Дата производства'),
(378, 69, 'DeviceId', 'Ид'),
(379, 70, 'Id', 'Ид'),
(380, 70, 'ConnectionTime', 'Время'),
(381, 70, 'MeasurementDeviceId', 'Ид'),
(382, 70, 'StatusConnectionId', 'Ид'),
(383, 71, 'Id', 'Ид'),
(384, 71, 'Time', 'Время'),
(385, 71, 'CityId', 'Ид'),
(386, 71, 'ParameterId', 'Ид'),
(387, 71, 'MeteoDataSourceTypeId', 'Ид'),
(388, 71, 'Value', 'Значение'),
(389, 71, 'MeasurementUnitId', 'Ид'),
(390, 71, 'DimensionId', 'Ид'),
(391, 72, 'Id', 'Ид'),
(392, 72, 'Description', 'Наименование'),
(393, 72, 'Zoom', 'Масштаб'),
(394, 72, 'MnemoschemeTypeId', 'Ид'),
(395, 73, 'Id', 'Ид'),
(396, 73, 'Description', 'Наименование'),
(397, 73, 'FullAddress', 'Полный адрес'),
(398, 73, 'OrganizationTypeId', 'Ид'),
(399, 73, 'Location', 'Географические координаты'),
(400, 73, 'Geolocation', 'Геолокация'),
(401, 74, 'Id', 'Ид'),
(402, 74, 'ParameterId', 'Ид'),
(403, 74, 'PeriodTypeId', 'Ид'),
(404, 74, 'MeasurementUnitId', 'Ид'),
(405, 74, 'DimensionId', 'Ид'),
(406, 74, 'DeviceParameterId', 'Ид'),
(407, 74, 'SubsystemTypeId', 'Ид'),
(408, 74, 'ParameterDictionaryId', 'Ид'),
(409, 74, 'ChannelTemplateId', 'Ид'),
(410, 74, 'Order', 'Порядок'),
(411, 75, 'Id', 'Ид'),
(412, 75, 'Description', 'Наименование'),
(413, 75, 'PlacementPurposeId', 'Ид'),
(414, 75, 'BuildingId', 'Ид'),
(415, 75, 'OrganizationId', 'Ид'),
(416, 75, 'MnemoschemeId', 'Ид'),
(417, 75, 'HasIndividualAccounting', 'Индивидуальный учет'),
(418, 75, 'Number', 'Номер'),
(419, 75, 'AmountRooms', 'Количество комнат'),
(420, 75, 'AmountPeople', 'Количество людей'),
(421, 75, 'FrontNumber', 'Подъезд'),
(422, 75, 'Comment', 'Комментарий'),
(423, 75, 'Area', 'Площадь'),
(424, 75, 'UserAdditionalInfoId', 'Ид'),
(425, 76, 'Id', 'Ид'),
(426, 76, 'MeasurementDeviceId', 'Ид'),
(427, 76, 'DeviceParameterId', 'Ид'),
(428, 76, 'DeviceValue', 'Значение устройства'),
(429, 76, 'UserValue', 'Значение пользователя'),
(430, 76, 'SyncDeviceTime', 'Время синхронизации'),
(431, 76, 'UpdateUserValueTime', 'Время обновления'),
(432, 77, 'Id', 'Ид'),
(433, 77, 'MeasurementDeviceId', 'Ид'),
(434, 77, 'Time', 'Время сервера'),
(435, 77, 'DeviceTime', 'Время устройства'),
(436, 77, 'PollingDuration', 'Общее время опроса (сек.)'),
(437, 78, 'Description', 'Наименование'),
(438, 78, 'Id', 'Ид'),
(439, 78, 'UserId', 'Ид'),
(440, 78, 'FirstName', 'Имя'),
(441, 78, 'LastName', 'Фамилия'),
(442, 78, 'Patronimic', 'Отчество'),
(443, 78, 'GenderId', 'Ид'),
(444, 78, 'BirthDay', 'Дата рождения'),
(445, 78, 'Phone', 'Телефон'),
(446, 78, 'Email', 'Электронная почта'),
(447, 79, 'UserAdditionalInfoId', 'Ид'),
(448, 79, 'ScheduleItemId', 'Ид'),
(449, 80, 'UserId', 'Ид'),
(450, 80, 'ChannelId', 'Ид'),
(451, 81, 'Id', 'Ид'),
(452, 81, 'Code', 'Код'),
(453, 81, 'Description', 'Наименование'),
(454, 82, 'PhysicalParameterId', 'Ид'),
(455, 82, 'ResourceSystemTypeId', 'Ид'),
(456, 82, 'Id', 'Ид'),
(457, 82, 'Code', 'Код'),
(458, 82, 'Description', 'Наименование'),
(459, 83, 'Id', 'Ид'),
(460, 83, 'Code', 'Код'),
(461, 83, 'Description', 'Наименование'),
(462, 84, 'Id', 'Ид'),
(463, 84, 'Code', 'Код'),
(464, 84, 'Description', 'Наименование'),
(465, 85, 'Id', 'Ид'),
(466, 85, 'Code', 'Код'),
(467, 85, 'Description', 'Наименование'),
(468, 86, 'Id', 'Ид'),
(469, 86, 'Code', 'Код'),
(470, 86, 'Description', 'Наименование'),
(471, 87, 'Id', 'Ид'),
(472, 87, 'Code', 'Код'),
(473, 87, 'Description', 'Наименование'),
(474, 88, 'Id', 'Ид'),
(475, 88, 'Code', 'Код'),
(476, 88, 'Description', 'Наименование'),
(477, 89, 'CalibrationInterval', 'Межповерочный интервал (мес.)'),
(478, 89, 'ArchiveDepthHour', 'Глубина часового архива'),
(479, 89, 'ArchiveDepthDay', 'Глубина суточного архива'),
(480, 89, 'ArchiveDepthMonth', 'Глубина месячного архива'),
(481, 89, 'ChannelsCount', 'Количество каналов'),
(482, 89, 'ShortName', 'Краткое наименование'),
(483, 89, 'HasDigitalInterface', 'Наличие цифрового интерфейса'),
(484, 89, 'TypeConnectionId', 'Ид'),
(485, 89, 'BaudId', 'Ид'),
(486, 89, 'DataBitId', 'Ид'),
(487, 89, 'StopBitId', 'Ид'),
(488, 89, 'ParityId', 'Ид'),
(489, 89, 'IsIntegralArchiveValue', 'Архивы накопительным итогом'),
(490, 89, 'Image', 'Изображение'),
(491, 89, 'Id', 'Ид'),
(492, 89, 'Code', 'Код'),
(493, 89, 'Description', 'Наименование'),
(494, 90, 'Id', 'Ид'),
(495, 90, 'Code', 'Код'),
(496, 90, 'Description', 'Наименование'),
(497, 91, 'DeviceId', 'Ид'),
(498, 91, 'Id', 'Ид'),
(499, 91, 'Code', 'Код'),
(500, 91, 'Description', 'Наименование'),
(501, 92, 'Id', 'Ид'),
(502, 92, 'Code', 'Код'),
(503, 92, 'Description', 'Наименование'),
(504, 93, 'Prefix', 'Префикс'),
(505, 93, 'Value', 'Коэффициент'),
(506, 93, 'Id', 'Ид'),
(507, 93, 'Code', 'Код'),
(508, 93, 'Description', 'Наименование'),
(509, 94, 'Id', 'Ид'),
(510, 94, 'CityId', 'Ид'),
(511, 95, 'EntityTypeName', 'Название сущности'),
(512, 95, 'Type', 'Тип данных'),
(513, 95, 'IsDefault', 'Обязательный'),
(514, 95, 'DefaultValue', 'Значение по умолчанию'),
(515, 95, 'IsReadOnly', 'Только для чтения'),
(516, 95, 'Descriptor', 'Json-описание'),
(517, 95, 'Id', 'Ид'),
(518, 95, 'Code', 'Код'),
(519, 95, 'Description', 'Наименование'),
(520, 96, 'Id', 'Ид'),
(521, 96, 'Code', 'Код'),
(522, 96, 'Description', 'Наименование'),
(523, 97, 'Id', 'Ид'),
(524, 97, 'Code', 'Код'),
(525, 97, 'Description', 'Наименование'),
(526, 98, 'PhysicalParameterId', 'Ид'),
(527, 98, 'Id', 'Ид'),
(528, 98, 'Code', 'Код'),
(529, 98, 'Description', 'Наименование'),
(530, 99, 'Settings', 'Настройки'),
(531, 99, 'IsUse', 'Использовать'),
(532, 99, 'Id', 'Ид'),
(533, 99, 'Code', 'Код'),
(534, 99, 'Description', 'Наименование'),
(535, 100, 'Id', 'Ид'),
(536, 100, 'Code', 'Код'),
(537, 100, 'Description', 'Наименование'),
(538, 101, 'Id', 'Ид'),
(539, 101, 'Code', 'Код'),
(540, 101, 'Description', 'Наименование'),
(541, 102, 'PhysicalParameterId', 'Физическая величина'),
(542, 102, 'ResourceSystemTypeId', 'Тип ресурсной системы'),
(543, 102, 'ShortDescription', 'Краткое описание'),
(544, 102, 'Id', 'Ид'),
(545, 102, 'Code', 'Код'),
(546, 102, 'Description', 'Наименование'),
(547, 103, 'Id', 'Ид'),
(548, 103, 'Code', 'Код'),
(549, 103, 'Description', 'Наименование'),
(550, 104, 'Value', 'Значение'),
(551, 104, 'DeviceId', 'Ид'),
(552, 104, 'ParameterDictionaryId', 'Ид'),
(553, 104, 'Id', 'Ид'),
(554, 104, 'Code', 'Код'),
(555, 104, 'Description', 'Наименование'),
(556, 105, 'Id', 'Ид'),
(557, 105, 'Code', 'Код'),
(558, 105, 'Description', 'Наименование'),
(559, 106, 'Id', 'Ид'),
(560, 106, 'Code', 'Код'),
(561, 106, 'Description', 'Наименование'),
(562, 107, 'Order', 'Порядок следования'),
(563, 107, 'Id', 'Ид'),
(564, 107, 'Code', 'Код'),
(565, 107, 'Description', 'Наименование'),
(566, 108, 'Id', 'Ид'),
(567, 108, 'Code', 'Код'),
(568, 108, 'Description', 'Наименование'),
(569, 109, 'Id', 'Ид'),
(570, 109, 'Code', 'Код'),
(571, 109, 'Description', 'Наименование'),
(572, 110, 'Id', 'Ид'),
(573, 110, 'Code', 'Код'),
(574, 110, 'Description', 'Наименование'),
(575, 111, 'ShortName', 'Короткое наименование'),
(576, 111, 'Id', 'Ид'),
(577, 111, 'Code', 'Код'),
(578, 111, 'Description', 'Наименование'),
(579, 112, 'Id', 'Ид'),
(580, 112, 'Code', 'Код'),
(581, 112, 'Description', 'Наименование'),
(582, 113, 'Id', 'Ид'),
(583, 113, 'Code', 'Код'),
(584, 113, 'Description', 'Наименование'),
(585, 114, 'Id', 'Ид'),
(586, 114, 'Code', 'Код'),
(587, 114, 'Description', 'Наименование'),
(588, 115, 'Id', 'Ид'),
(589, 115, 'Code', 'Код'),
(590, 115, 'Description', 'Наименование'),
(591, 116, 'Id', 'Ид'),
(592, 116, 'Code', 'Код'),
(593, 116, 'Description', 'Наименование'),
(594, 117, 'Id', 'Ид'),
(595, 117, 'Code', 'Код'),
(596, 117, 'Description', 'Наименование'),
(597, 118, 'Id', 'Ид'),
(598, 118, 'Code', 'Код'),
(599, 118, 'Description', 'Наименование'),
(600, 119, 'Id', 'Ид'),
(601, 119, 'Code', 'Код'),
(602, 119, 'Description', 'Наименование'),
(603, 120, 'Id', 'Ид'),
(604, 120, 'Code', 'Код'),
(605, 120, 'Description', 'Наименование'),
(606, 121, 'Id', 'Ид'),
(607, 121, 'Code', 'Код'),
(608, 121, 'Description', 'Наименование')
GO

SET IDENTITY_INSERT [Core].[EntityProperty] OFF;