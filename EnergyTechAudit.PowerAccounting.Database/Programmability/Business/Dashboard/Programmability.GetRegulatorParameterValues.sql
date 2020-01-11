-- ====================================================================================================
-- Author: Leo
-- Create date: 2015-11-10
-- Description: Возвращает значения регуляционных параметров 
-- для виджета "Параметры регулирования"
-- ===================================================================================================

CREATE PROCEDURE Programmability.GetRegulatorParameterValues 
  @entityId INT,
  @entityTypeName NVARCHAR(64)
AS
BEGIN
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  /* Проверка пользователя на предмет принадлежности канала */
  /* Проверка канала на предмет шаблона с типом "Мониторинг" */

  DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
  
  INSERT INTO @resultSetName OUTPUT inserted.[Order], inserted.[Name]
  VALUES
  	   (1, 'MainData'),		    
  	   (2, 'ColumnCaption');	

  BEGIN TRY
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;  
    BEGIN TRANSACTION;

    WITH 
    /* Шаблон канала */
    [Channel]
    AS
    (
      SELECT

        /* Информация о помещении и его владельще */
        [Placement].[Id] [PlacementId],
        [Placement].[Number] [PlacementNumber],
        [PlacementPurpose].[Description] [PlacementPurposeDescription],

        COALESCE([UserAdditionalInfo].[Description], [Organization].[FullAddress]) [PlacementHolderDescription],
        /**/

        [Channel].[Id] [ChannelId],
        [Channel].[MeasurementDeviceId] [MeasurementDeviceId],
        [Channel].[ChannelTemplateId] [ChannelTemplateId]       
      FROM [Business].[Channel] [Channel] 

        INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate]
        ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId] AND 
           [ChannelTemplate].[ResourceSystemTypeId] = 6 /* Система регулирования */

        INNER JOIN [Business].[Placement] [Placement] 
        ON [Placement].[Id] = [Channel].[PlacementId]
          
        INNER JOIN [Business].[Building]  [Building]
        ON [Building].[Id] = [Placement].[BuildingId]

        INNER JOIN [Dictionaries].[PlacementPurpose] [PlacementPurpose]
        ON  [PlacementPurpose].[Id] = [Placement].[PlacementPurposeId]

        /**/
        LEFT JOIN [Business].[UserAdditionalInfo] [UserAdditionalInfo] 
        ON [Placement].[UserAdditionalInfoId] = [UserAdditionalInfo].[Id]

        LEFT JOIN  [Business].[Organization] [Organization]
        ON [Placement].[OrganizationId] = [Organization].[Id]  

      WHERE 
        ([Channel].[Id] = @entityId OR @entityTypeName = 'Building') AND 
        (([Building].[Id] = @entityId AND [Placement].[HasIndividualAccounting] = 1) OR @entityTypeName = 'Channel') AND

        [Channel].[ResourceSystemTypeId] = 6
    ),
    /* Матрица сопоставления по шаблону */
    [ParameterMapDeviceParameter] 
    AS
    (
      SELECT 
        
        [Channel].[ChannelId] [ChannelId],
        [Channel].[MeasurementDeviceId] [MeasurementDeviceId],

        /* Информация о помещении и владельце*/
        [PlacementId],
        [PlacementHolderDescription],
        [PlacementNumber],
        [PlacementPurposeDescription],
        /**/

        /* идентификатор из матрицы сопоставления */
        [ParameterMapDeviceParameter].[Id] [Id],
        [ParameterMapDeviceParameter].[ParameterId] [ParameterId],

        [RegulatorParameterValue].[Id] [RegulatorParameterValueId],
        [Parameter].[Description] [ParameterDescription],      
        [ParameterMapDeviceParameter].[Order],
      
        /* размерность и единицы измерения */
        [Dimension].[Prefix] [DimensionPrefix],
        [MeasurementUnit].[Description] [MeasurementUnitDescription],
        [PhysicalParameter].[Code] [PhysicalParameterCode],
        [PhysicalParameter].[Id] [PhysicalParameterId],

        /* значения параметра регулирования */
        [RegulatorParameterValue].[DeviceValue] [DeviceValue],      
        [RegulatorParameterValue].[UserValue] [UserValue],
      
        [DeviceParameterSetting].[ValueTypeCode],
        [DeviceParameterSetting].[Min],
        [DeviceParameterSetting].[Max], 

        [ParameterDictionary].[Id] [ParameterDictionaryId],
        [ParameterDictionary].[Code] [ParameterDictionaryCode],
      
        [RegulatorParameterValue].[SyncDeviceTime] [SyncDeviceTime],
        [RegulatorParameterValue].[UpdateUserValueTime] [UpdateUserValueTime],

        /* для построения групп по типу подсистемы */
        [SubsystemType].[Id] [SubsystemTypeId],
        [SubsystemType].[Description] [SubsystemTypeDescription], 

        [RegulatorParameterValue].[UpdatedBy] [UpdatedBy]
        
      FROM [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter]
        
      INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter]
        ON [DeviceParameter].[Id] = [ParameterMapDeviceParameter].[DeviceParameterId]
    
      LEFT JOIN [Business].[DeviceParameterSetting] [DeviceParameterSetting]
        ON [DeviceParameterSetting].[Id] = [DeviceParameter].[Id]

      LEFT JOIN [Business].[RegulatorParameterValue] [RegulatorParameterValue]
        ON [ParameterMapDeviceParameter].[DeviceParameterId] = [DeviceParameter].[Id] 
        AND [ParameterMapDeviceParameter].[DeviceParameterId] = [RegulatorParameterValue].[DeviceParameterId] 

      INNER JOIN [Dictionaries].[Parameter] [Parameter]
        ON [Parameter].[Id] = [ParameterMapDeviceParameter].[ParameterId]

      INNER  JOIN [Dictionaries].[Dimension] [Dimension] 
        ON [Dimension].[Id] = [ParameterMapDeviceParameter].[DimensionId]

      INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit]
        ON [MeasurementUnit].[Id] = [ParameterMapDeviceParameter].[MeasurementUnitId]

      INNER JOIN [Dictionaries].[SubsystemType] [SubsystemType]
        ON [SubsystemType].[Id] = [ParameterMapDeviceParameter].[SubsystemTypeId]

      LEFT JOIN [Dictionaries].[PhysicalParameter] [PhysicalParameter] 
        ON [PhysicalParameter].[Id] = [Parameter].[PhysicalParameterId] AND 
           [PhysicalParameter].[Id] = [MeasurementUnit].[PhysicalParameterId]
      
     INNER JOIN [Dictionaries].[ParameterDictionary] [ParameterDictionary]
          ON [ParameterDictionary].[Id] = [ParameterMapDeviceParameter].[ParameterDictionaryId]
    
     INNER JOIN [Channel] 
        ON [Channel].[ChannelTemplateId] = [ParameterMapDeviceParameter].[ChannelTemplateId] AND 
          [Channel].[MeasurementDeviceId] = [RegulatorParameterValue].[MeasurementDeviceId]
         
      WHERE [ParameterMapDeviceParameter].[PeriodTypeId] = 7 /* Без периода */           
    )

    SELECT    
      [ChannelId],
      [MeasurementDeviceId],
      
           
      /* Информация о помещении и владельце*/
      [PlacementId],
      [PlacementHolderDescription],
      [PlacementNumber],
      [PlacementPurposeDescription],
      /**/  

      [Id],
	  [ParameterId],

      [RegulatorParameterValueId],
      [ParameterDescription],
      [Order],
    
      [PhysicalParameterCode],
      [DimensionPrefix],
      [MeasurementUnitDescription],    
      [ParameterDictionaryCode], 
      [ParameterDictionaryId],   
      [PhysicalParameterId],

      [Min],
      [Max],
      [ValueTypeCode],
    
      [DeviceValue],
      [UserValue],

      [SyncDeviceTime],
      [UpdateUserValueTime],

      [SubsystemTypeId],
      [SubsystemTypeDescription],

      [UpdatedBy]
    FROM
      [ParameterMapDeviceParameter] ORDER BY [Order];
    
    COMMIT TRANSACTION;

    DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];
  
    /* Список столбцов для визуальной решетки */
    INSERT INTO @columnCaption   
      OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]

    VALUES

      ('MainData', 'Id', 'Ид', 0, 0)
      ,('MainData', 'PlacementNumber', 'Помещение', 0, 0)
      ,('MainData', 'PlacementPurposeDescription', 'Назначение помещения', 0, 0)
      ,('MainData', 'PlacementHolderDescription', 'Владелец', 0, 1) 

      ,('MainData', 'ParameterDescription', 'Параметр', 1, 1)

      ,('MainData', 'Order', 'Порядок', 0, 1)
    
      ,('MainData', 'DimensionPrefix', 'Размерность', 0, 1)
      ,('MainData', 'MeasurementUnitDescription', 'Ед. измерения', 0, 1)
      ,('MainData', 'PhysicalParameterCode', 'Физическая величина', 0, 1)
      ,('MainData', 'ParameterDictionaryCode', 'Код словаря', 0, 1)

      ,('MainData', 'DeviceValue', 'Значение устройства', 1, 1)
      ,('MainData', 'UserValue', 'Значение пользователя', 1, 1)

      ,('MainData', 'SyncDeviceTime', 'Время синхронизации', 1, 1)
      ,('MainData', 'UpdateUserValueTime', 'Время обновления', 1, 1)

      ,('MainData', 'SubsystemTypeId', 'Ид. подсистемы', 0, 1)
      ,('MainData', 'SubsystemTypeDescription', 'Подсистема', 0, 1)

      ,('MainData', 'UpdatedBy', 'Обновлено пользователем', 1, 20)

      COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    IF (XACT_STATE()) = -1
    BEGIN       
      ROLLBACK TRANSACTION;
    END;
    IF (XACT_STATE()) = 1
    BEGIN      
      COMMIT TRANSACTION;   
    END;

    RETURN (3); 
  END CATCH;

END;
GO