SET IDENTITY_INSERT [Dictionaries].[ErrorType] ON;
GO

INSERT INTO [Dictionaries].[ErrorType] ([Id], [Code], [Description])
VALUES 
  (1, 'Unknown', 'Неизвестный'),
  (2, 'ErrorDeviceResponse', 'Ответный пакет прибора содержит ошибку'),
  (3, 'OpenSerialPortError', 'Ошибка открытия последовательного порта'),
  (4, 'TransportServerConfigurationError', 'Ошибка конфигурации транспортного сервера'),
  (5, 'ConnectionError', 'Ошибка соединения'),
  (6, 'MissingAccessPoint', 'Отсутствует точка доступа'),
  (7, 'ManualResetPolling', 'Ручное прерывание опроса прибора'),
  (8, 'WrongMakeCallException', 'Неудачное выполнение звонка'),
  (9, 'WrongFactoryNumberException', 'Неверный заводской номер'),
  (10, 'SpecificDeviceError', 'Специфичная ошибка прибора'),
  (11, 'StartSignalrError', 'Ошибка старта SignalR'),
  (12, 'AssemblyNotFound', 'Сборка не найдена'),
  (13, 'ServerDispatcherInitError', 'Ошибка инициализации серверного диспетчера'),
  (14, 'PollingError', 'Ошибка опроса'),
  (15, 'MissingUnitConverter', 'Отсутствует правило преобразования единиц измерения'),
  (16, 'DbTransactionReadUncommitted', 'Ошибка чтения данных в транзакции Read Uncommitted'),
  (17, 'Vkt7SaveArchiveError', 'Ошибка сохранения архива ВКТ-7'),
  (18, 'Esko06WrongResponseCommand', 'Неправильный код команды в ответе прибора'),
  (19, 'Ecl300ErrorResponse', 'Ошибка в ответе ECL 200/300'),
  (20, 'MagikaOldGateVersion', 'Обнаружена старая версия программы шлюза'),
  (21, 'MagikaGateVersionWithBugs', 'Обнаружена версия программы шлюза с ошибками в шаблоне'),
  (22, 'MagikaTemplateDeviceParameterNotFound', 'Отсутствует девайсовый параметр, который присутствует в шаблоне архива'),
  (23, 'Mercury230WrongDayStartValues', 'Некорректные значения энергии на начало текущих суток')

GO

SET IDENTITY_INSERT [Dictionaries].[ErrorType] OFF;
GO