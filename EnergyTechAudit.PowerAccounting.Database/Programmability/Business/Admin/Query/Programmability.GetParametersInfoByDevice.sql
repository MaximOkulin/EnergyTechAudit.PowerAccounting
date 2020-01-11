-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-01-23
-- Description: Возвращает набор данных  c таблицей соотвествий параметров типам приборов, 
-- включая расшифровки единиц измерения параметров  
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetParametersInfoByDevice]
  @deviceId INT
AS
BEGIN
  SET DATEFORMAT dmy;
  SET LANGUAGE N'русский';
  SET NOCOUNT ON;

  /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
  DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

  INSERT INTO @resultSetName VALUES
	(1, 'MainData'),		-- стандартное имя набора для отображения в решетке
	(2, 'ColumnCaption');	-- набор с необязательной расшифровкой расшифровка имен столбцов наборов

  SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	FROM @resultSetName [ResultSetName]
  /**/


  /* 2. Таблица с агрегированными кодами единиц измерения*/
  DECLARE @unitCodesTable TABLE 
    (
      [PhysicalParameterId] INT NOT NULL,  
      [Description] NVARCHAR(128) NULL, 
      [UnitCodes] NVARCHAR(128) NULL
    );
  
  INSERT INTO @unitCodesTable SELECT 
      [PhysicalParameter].[Id] [PhysicalParameterId], 
      [PhysicalParameter].[Description] [Description], 
      LEFT([MeasurementUnit].[Codes], LEN([MeasurementUnit].[Codes]) - 1) [UnitCodes]

      FROM [Dictionaries].[PhysicalParameter] [PhysicalParameter] WITH(NOLOCK)
          INNER JOIN (SELECT DISTINCT([Mu1].[PhysicalParameterId])[PhysicalParameterId],
                  (SELECT CONCAT('[', [Mu2].[Description], '], ')  AS [text()]
                    FROM [Dictionaries].[MeasurementUnit] [Mu2] WITH(NOLOCK)
                    WHERE [Mu1].[PhysicalParameterId] = [Mu2].[PhysicalParameterId]
                    ORDER BY [Mu2].[PhysicalParameterId]
                    FOR XML PATH ('')) [Codes] 
          
                    FROM [Dictionaries].[MeasurementUnit] [Mu1] WITH(NOLOCK)) [MeasurementUnit] 
          ON [PhysicalParameter].[Id] = [MeasurementUnit].[PhysicalParameterId];
   /**/

  /* 3. Основная выборка*/
  SET @deviceId = IIF(@deviceId = 0 /*ALL*/, NULL, @deviceId);

  SELECT
		ROW_NUMBER() OVER(ORDER BY [Device].[Id]) [RowNumber],
		[Device].[Code] [DeviceCode], 
		[Parameter].[Code] [ParameterCode], 
      [PeriodType].[Code] [PeriodTypeCode],
		[PhysicalParameter].[Description] [PhysicalParameterDescription],
		[Parameter].[Description] [ParameterDescription],
		[Unit].[UnitCodes] [UnitCodes]
    FROM [Business].[ParameterMapDeviceParameter] [Map] WITH(NOLOCK)

    INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH (NOLOCK)
      ON [DeviceParameter].[Id] = [Map].[DeviceParameterId] 

    INNER JOIN [Dictionaries].[Device] [Device] WITH(NOLOCK)
		  ON [Device].[Id] = [DeviceParameter].[DeviceId]

    INNER JOIN [Dictionaries].[Parameter] [Parameter] WITH(NOLOCK)
		  ON [Map].[ParameterId] =[Parameter].[Id]
    
    INNER JOIN [Dictionaries].[PeriodType] [PeriodType] WITH(NOLOCK)
      ON [Map].[PeriodTypeId] = [PeriodType].[Id]

	  INNER JOIN [Dictionaries].[PhysicalParameter] [PhysicalParameter] WITH(NOLOCK)
		  ON [PhysicalParameter].[Id] = [Parameter].[PhysicalParameterId]
   
    INNER JOIN @unitCodesTable [Unit] 
     ON [Unit].[PhysicalParameterId] = [PhysicalParameter].[Id]
      
  WHERE ([Device].[Id] = @deviceId OR @deviceId IS NULL)
  /**/

  /* 4. Вспомогательная таблица с расшифровками столбцов */
  DECLARE @columnCaption [Programmability].[ColumnCaptionTableType]; 
  
  INSERT INTO @columnCaption 
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
  VALUES
  	 ('MainData', 'RowNumber', '№', 1, 1)
  	,('MainData', 'DeviceCode', 'Код устройства', 1, 2)
  	,('MainData', 'ParameterCode', 'Код параметра', 1, 3)
  	,('MainData', 'PeriodTypeCode', 'Код периода', 1, 4)
  	,('MainData', 'ParameterDescription', 'Наименование параметра', 1, 5)
   ,('MainData', 'PhysicalParameterDescription', 'Физическая величина', 1, 6)
   ,('MainData', 'UnitCodes', 'Единицы измерения', 1, 7)
    
  /**/

END;
GO