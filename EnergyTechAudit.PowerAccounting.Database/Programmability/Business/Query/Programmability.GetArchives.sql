-- ====================================================================================================
-- Author:  	Max
-- Create date: 10 July 2015
-- Description: Источник для построения таблицы архивных данных устройства (админская консоль)
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetArchives]
	@measurementDeviceId INT,
	@factoryNumber INT,
	@deviceId INT,
	@periodTypeId INT,
	@periodBegin DATETIME,
	@periodEnd DATETIME
AS
BEGIN
    SET DATEFORMAT dmy;
    SET NOCOUNT ON;

	SET @periodTypeId = IIF(@periodTypeId = 0, NULL, @periodTypeId);

	/* 1. Формирование имен резалтсетов для отчета*/
   DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
   INSERT INTO @resultSetName VALUES 
       (1, 'MainData')
      ,(2, 'ColumnCaption');

    SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	   FROM @resultSetName [ResultSetName]
	   
	SET @measurementDeviceId = IIF(@measurementDeviceId = 0, NULL, @measurementDeviceId)

	-- если пользователь не знает идентификатора, но знает заводской номер и тип прибора
	IF (@measurementDeviceId IS NULL AND @factoryNumber > 0 AND @deviceId > 0)
	BEGIN
	  SET @measurementDeviceId = 
    (
      SELECT [MeasurementDevice].[Id] 
	    FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)
	    WHERE [MeasurementDevice].[FactoryNumber] = @factoryNumber AND [MeasurementDevice].[DeviceId] = @deviceId
    );
	END;  

	DECLARE @count INT = (SELECT COUNT(*) [Count] FROM [Business].[Archive] [Archive] WITH(NOLOCK)
	WHERE [Archive].[MeasurementDeviceId] = @measurementDeviceId AND 
      ([Archive].[PeriodTypeId] = @periodTypeId OR @periodTypeId IS NULL) AND
	  [Archive].[Time] BETWEEN @periodBegin AND @periodEnd)

	/* 2. Основная выборка данных */ 
	IF (@count <= 5000)
	BEGIN
	SELECT 
	  [PeriodType].[Description] [PeriodDescription], 
	  [Archive].[Time], 
		[Archive].[Value] [Value], 
		[Dp].[Description] [ParameterDescription]
  FROM [Business].[Archive] [Archive] WITH(NOLOCK)
    INNER JOIN [Dictionaries].[PeriodType] [PeriodType] WITH (NOLOCK)
	    ON [Archive].[PeriodTypeId] = [PeriodType].[Id]
    INNER JOIN [Business].[MeasurementDevice] [Device] WITH (NOLOCK)
	    ON [Archive].[MeasurementDeviceId] = [Device].[Id]
    INNER JOIN [Dictionaries].[DeviceParameter] [Dp] WITH (NOLOCK)
	    ON [Dp].[Id] = [Archive].[DeviceParameterId]

	WHERE [Archive].[MeasurementDeviceId] = @measurementDeviceId AND 
      ([Archive].[PeriodTypeId] = @periodTypeId OR @periodTypeId IS NULL) AND 
	  [Archive].[Time] BETWEEN @periodBegin AND @periodEnd
	ORDER BY [Archive].[Time] DESC
     END
	 ELSE
	 BEGIN
	   ;THROW 500001, 'Число архивных записей превышает заданный предел. Измените критерии отбора', 1;
	 END

/* 3. Вспомогательная таблица с расшифровками столбцов */
   DECLARE @columnCaption [Programmability].[ColumnCaptionTableType] ;

   INSERT INTO @columnCaption 
   OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
   VALUES
      ('MainData', 'PeriodDescription', 'Период', 1, 1)
	   ,('MainData', 'Time', 'Время', 1, 2)
	   ,('MainData', 'ParameterDescription', 'Параметр', 1, 3) 
	   ,('MainData',  'Value', 'Значение', 1, 4)	   

END;