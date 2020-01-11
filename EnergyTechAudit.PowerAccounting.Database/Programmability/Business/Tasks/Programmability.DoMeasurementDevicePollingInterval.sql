CREATE PROCEDURE [Programmability].[DoMeasurementDevicePollingInterval]
   @userName NVARCHAR(32),
   @operationUniqueId UNIQUEIDENTIFIER,   

   @deviceIdArray NVARCHAR(1024), 
   @districtIdArray NVARCHAR(1024),
   @pollingInterval INT,    
   @showOutputLinksInfo BIT = 1
AS
BEGIN
   SET NOCOUNT ON;
    
	/* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
	DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

	INSERT INTO @resultSetName VALUES
		(1, 'MainData'),			-- стандартное имя набора для отображения в решетке
		(2, 'ColumnCaption');		-- набор с необязательной расшифровкой расшифровка имен столбцов наборов

	SELECT [ResultSetName].[Order], [ResultSetName].[Name]
		FROM @resultSetName [ResultSetName]
	/**/

	/* 2. Выполнение задачи  */
	DECLARE @rowCountAffected INT = 0;
	DECLARE @statusMessage NVARCHAR(128) = N'Задача не была выполнена';
	DECLARE @errorMessage NVARCHAR(1024) = N'';  
	DECLARE @deliter VARCHAR(4) = ',';

	DECLARE @taskOperation TABLE 
	(
		[Id] INT NOT NULL PRIMARY KEY,
		[StatusMessage] NVARCHAR(128),
		[RowCountAffected] INT,
		[ErrorMessage] NVARCHAR(1024)
	);
     
	 IF(OBJECT_ID('[tempdb].[guest].[DoMeasurementDevicePollingInterval]') IS NULL)
	 BEGIN 
		CREATE TABLE [tempdb].[guest].[DoMeasurementDevicePollingInterval]
		(
			 [Id] INT IDENTITY (1, 1) NOT NULL,

			 [OperationUniqueId] UNIQUEIDENTIFIER NOT NULL,
			 [Reguestor] NVARCHAR(32) NOT NULL,

			 [MeasurementDeviceId] INT NOT NULL,

			 [OriginalValue] INT  NOT NULL,
			 [CurrentValue] INT  NOT NULL,

			 CONSTRAINT PK_Guest_DoMeasurementDevicePollingIntervalOutput_Id PRIMARY KEY ([Id])   
		) ;
	 END;

	-- получим уид последней операции текущего реквестора
	DECLARE @lastOperationUniqueId UNIQUEIDENTIFIER =
    (
		SELECT TOP 1 [OperationUniqueId] 
		FROM [tempdb].[guest].[DoMeasurementDevicePollingInterval] WITH(NOLOCK)
		WHERE [Reguestor] = @userName
    );

	-- уид последней операции найден
	IF (@lastOperationUniqueId IS NOT NULL)
	BEGIN  
		-- если уид последней операции не совпадает с уид-ом текущей операции (формируется на стороне клиента)
		IF (@lastOperationUniqueId <> @operationUniqueId)
		BEGIN
			-- сброс таблицы последних результатов для текущего реквестора			
			DELETE FROM [tempdb].[guest].[DoMeasurementDevicePollingInterval]
			WHERE [Reguestor] = @userName;
		END
		ELSE
		BEGIN
			-- если уид не менялся, то обработка повторно не выполняется, 
			-- но возвращаются результаты предыдущей операции
			GOTO ToOut; 
		END;
	END;
     
  BEGIN TRAN

  BEGIN TRY
	SET NOCOUNT OFF;     
     
    UPDATE [MeasurementDevice] SET [PollingInterval] = @pollingInterval
        
	OUTPUT @operationUniqueId, @userName, inserted.[Id], deleted.[PollingInterval], inserted.[PollingInterval]
    INTO [tempdb].[guest].[DoMeasurementDevicePollingInterval]

	FROM [Business].[MeasurementDevice] [MeasurementDevice]

	WHERE 
		[MeasurementDevice].[DeviceId] IN
		(
			SELECT CONVERT(INT, [Item]) [DeviceId]
			FROM [Business].[StringSplitToArray]  (@deviceIdArray, @deliter)
		) 
		AND 		
		ISNULL([MeasurementDevice].[AccessPointId], 0) IN 
		(
			SELECT DISTINCT([AccessPointLinkBuilding].[AccessPointId]) 
			FROM [Business].[Building] [Building] WITH(NOLOCK)

			INNER JOIN [Business].[AccessPointLinkBuilding] [AccessPointLinkBuilding] WITH(NOLOCK)
				ON [Building].[Id] = [AccessPointLinkBuilding].[BuildingId] 

			WHERE [Building].[DistrictId] IN 
			(
				SELECT CONVERT(INT, [Item]) [DistrictId]
				FROM [Business].[StringSplitToArray]  (@districtIdArray, @deliter)
			)  
		)
           
	SET @rowCountAffected = @@ROWCOUNT;
	COMMIT TRAN;
	SET @statusMessage = 'Задача успешно выполнена';      
	SET NOCOUNT ON;
   END TRY
   BEGIN CATCH       
      IF(@@TRANCOUNT > 0) ROLLBACK TRAN;
      SET @errorMessage = ERROR_MESSAGE();
   END CATCH;
   /**/
  
  ToOut: 

   /* Вспомогательная таблица с расшифровками столбцов */
	DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

   /* 3. Формирование статусной информации задачи */

   IF (@showOutputLinksInfo = 0)
   BEGIN
     
      /* Краткий статус операции (сколько записей затронуто операцией) */
      INSERT INTO @taskOperation 
      VALUES (1, @statusMessage, @rowCountAffected, @errorMessage);
   
      SELECT 
        [TaskOperation].[Id], 
        [TaskOperation].[StatusMessage], 
        [TaskOperation].[RowCountAffected], 
        [TaskOperation].[ErrorMessage]  

      FROM @taskOperation [TaskOperation];

      INSERT INTO @columnCaption 
      OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
      VALUES  
		 ('MainData', 'Id', 'Ид', 1, 1)
        ,('MainData', 'StatusMessage', 'Статус', 1, 2)
        ,('MainData', 'RowCountAffected', 'Затронуто записей', 1, 3)
        ,('MainData', 'ErrorMessage', 'Ошибка', 1, 4)
   END
   ELSE
   BEGIN

    /* Список устройств затронутых изменениями */
	SELECT 
		ROW_NUMBER() OVER (ORDER BY [ProcessingResult].[MeasurementDeviceId]) [Id],
		[ProcessingResult].[MeasurementDeviceId] [MeasurementDeviceId],

		[City].[Description] [CityDescription],
		[District].[Description] [DistrictDescription],
		[Building].[FullAddress] [BuildingDescription],
		[MeasurementDevice].[Description] [MeasurementDeviceDescription],
		
		[ProcessingResult].[OriginalValue] [OriginalValue],
		[ProcessingResult].[CurrentValue] [CurrentValue]

	FROM  [tempdb].[guest].[DoMeasurementDevicePollingInterval] [ProcessingResult] WITH(NOLOCK) 
		
	INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)
		ON [MeasurementDevice].[Id] = [ProcessingResult].[MeasurementDeviceId]

	INNER JOIN [Business].[AccessPoint] [AccessPoint] WITH(NOLOCK) 
		ON [AccessPoint].[Id] = [MeasurementDevice].[AccessPointId]

	INNER JOIN [Business].[AccessPointLinkBuilding] [AccessPointLinkBuilding] WITH(NOLOCK)
		ON [AccessPointLinkBuilding].[AccessPointId] = [AccessPoint].[Id]

	INNER JOIN [Business].[Building] [Building] WITH(NOLOCK)
		ON [Building].[Id] = [AccessPointLinkBuilding].[BuildingId]

	INNER JOIN [Dictionaries].[District] [District] WITH(NOLOCK)
		ON [District].[Id] = [Building].[DistrictId]
	
	INNER JOIN [Dictionaries].[City] [City] WITH(NOLOCK)
		ON [City].[Id] = [District].[CityId]

	WHERE 
		[ProcessingResult].[OperationUniqueId] = @operationUniqueId AND 
		[ProcessingResult].[Reguestor] = @userName;

    INSERT INTO @columnCaption 
      OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
      VALUES  
        ('MainData', 'Id', 'Ид', 0, 1),		    
        ('MainData', 'MeasurementDeviceId', 'Ид. устройства', 0, 2),  
		      
        ('MainData', 'CityDescription', 'Населенный пункт', 1, 3),
        ('MainData', 'DistrictDescription', 'Район', 1, 4),
        ('MainData', 'BuildingDescription', 'Строение', 1, 5),
		('MainData', 'MeasurementDeviceDescription', 'Устройство', 1, 6),

        ('MainData', 'OriginalValue', 'Исходное значение', 1, 7),
        ('MainData', 'CurrentValue', 'Текущее значение', 1, 8);        
  END;
  	  			
END;
