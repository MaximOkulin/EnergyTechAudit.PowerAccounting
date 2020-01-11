-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-12-18
-- Description: Измерительные устройства, которые недоступны для конченого доступа 
-- (отсутствуют каналы, нет точки доступа, точка доступа не связана со строениями)  
-- ===================================================================================================

CREATE PROCEDURE Programmability.GetLostMeasurementDevices  
AS
BEGIN  

  SET NOCOUNT ON;
  
  /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
  DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

  INSERT INTO @resultSetName VALUES
	   (1, 'MainData'),		   -- стандартное имя набора для отображения в решетке
	   (2, 'ColumnCaption');	-- набор с необязательной расшифровкой расшифровка имен столбцов наборов
  
  SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	FROM @resultSetName [ResultSetName];

  /* 2. Основная выборка данных */
  SELECT 
    [MeasurementDevice].[Id] [Id],
    [MeasurementDevice].[FactoryNumber] [FactoryNumber],
    [MeasurementDevice].[Description] [Description],    
    N'Отсутствуют связанные каналы' [Mark]

    FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)

    WHERE NOT EXISTS 
    (
      SELECT [Channel].[MeasurementDeviceId] 
        FROM [Business].[Channel] [Channel] WITH(NOLOCK) 
        WHERE [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]
    )

UNION ALL

  SELECT 
    [MeasurementDevice].[Id] [Id],
    [MeasurementDevice].[FactoryNumber] [FactoryNumber],
    [MeasurementDevice].[Description] [Description],    
    N'Точка доступа не связана со строением' [Mark]

  FROM [Business].[AccessPoint] [AccessPoint] WITH(NOLOCK)
  
    INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK) 
    ON [MeasurementDevice].[AccessPointId] = [AccessPoint].[Id]
    WHERE NOT EXISTS 
    (
      SELECT [AccessPointId] 
      FROM [Business].[AccessPointLinkBuilding] [AccessPointLinkBuilding] WITH(NOLOCK) 
      WHERE [AccessPoint].[Id] = [AccessPointLinkBuilding].[AccessPointId]
    )

UNION ALL

  SELECT 
    [MeasurementDevice].[Id] [Id],
    [MeasurementDevice].[FactoryNumber] [FactoryNumber],
    [MeasurementDevice].[Description] [Description],    
    N'Устройство не связано с точкой доступа' [Mark]

  FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK) 

  WHERE [MeasurementDevice].[AccessPointId] IS NULL

UNION ALL

  SELECT 
    [Md].[Id] [Id],
    [Md].[FactoryNumber] [FactoryNumber],
    [Md].[Description] [Description],    
    'Точка доступа не соответствует привязке cвязанных каналов со строениями' [Mark]  
  
  FROM [Business].[MeasurementDevice] [Md] WITH(NOLOCK)

  WHERE EXISTS 
  ( 
    (
    /* Связи MeasurementDevice - Building (Channel) */
      SELECT   
        [Building].[Id] [BuildingId]
       
      FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)
    
      INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
        ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]
    
      INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK)
        ON [Placement].[Id] = [Channel].[PlacementId]
    
      INNER JOIN [Business].[Building] [Building] WITH(NOLOCK)
        ON [Building].[Id] = [Placement].[BuildingId]
    
      WHERE [MeasurementDevice].[Id] = [Md].[Id]
    )
    EXCEPT
    (        
        (
          /* Связи MeasurementDevice - Building (AccessPoint) */
          SELECT 
       
            [AccessPointLinkBuilding].[BuildingId] [BuildingId]
      
          FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)
        
          INNER JOIN [Business].[AccessPoint] [AccessPoint] WITH(NOLOCK)
            ON [AccessPoint].[Id] = [MeasurementDevice].[AccessPointId]
        
          INNER JOIN [Business].[AccessPointLinkBuilding] [AccessPointLinkBuilding] WITH(NOLOCK)
            ON [AccessPoint].[Id] = [AccessPointLinkBuilding].[AccessPointId]
          
          WHERE [MeasurementDevice].[Id] = [Md].[Id]
        )
        INTERSECT
        (
          /* Связи MeasurementDevice - Building (Channel) */
          SELECT   
            [Building].[Id] [BuildingId]
           
          FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)
        
          INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
            ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]
        
          INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK)
            ON [Placement].[Id] = [Channel].[PlacementId]
        
          INNER JOIN [Business].[Building] [Building] WITH(NOLOCK)
            ON [Building].[Id] = [Placement].[BuildingId]
        
          WHERE [MeasurementDevice].[Id] = [Md].[Id]
        )
     )
  )
  
  /**/

  /* 3. Вспомогательная таблица с расшифровками столбцов */
  DECLARE @columnCaption [Programmability].[ColumnCaptionTableType]; 
  
  INSERT INTO @columnCaption 
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
  VALUES  
  	  ('MainData', 'Id', 'Ид.', 1, 1)
      ,('MainData', 'FactoryNumber', 'Заводской номер', 1, 2)
  	  ,('MainData', 'Description', 'Наименование', 1, 3)  	 
  	  ,('MainData', 'Mark', 'Отметка', 1, 4)  	 
  /**/

END;
GO