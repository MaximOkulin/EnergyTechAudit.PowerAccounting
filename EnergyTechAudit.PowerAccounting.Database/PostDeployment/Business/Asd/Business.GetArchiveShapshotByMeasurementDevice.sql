-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-01-28
-- Description: Выбирает данные из архивов по идентификатору измерительного устройста
-- например из боевой базы для последующего деплоя в тестовую БД  для разработки
-- ===================================================================================================


DECLARE @measurementDeviceId INT;
DECLARE @periodBegin DATETIME;
DECLARE @periodEnd DATETIME;
DECLARE @periodTypeId INT;

SET @measurementDeviceId = 4;
SET @periodBegin = '20150101' /*NULL*/;
SET @periodEnd = '20150131'   /*NULL*/;
SET @periodTypeId = 3         /*NULL*/;

SELECT [A].* FROM [Business].[Archive] [A] 
  INNER JOIN [Business].[Channel] [Ch] 
    ON [A].[ChannelId] = [Ch].[Id]
  INNER JOIN [Business].[MeasurementDevice] [Md] 
    ON [Md].[Id] = [Ch].[MeasurementDeviceId]
  WHERE [Md].[Id] = @measurementDeviceId 
   AND ([A].[PeriodTypeId] = @periodTypeId OR @periodTypeId IS NULL)
   AND (([A].[Time] >= @periodBegin AND [A].[Time] <= @periodEnd) OR @periodBegin IS NULL OR @periodEnd IS NULL)

SELECT * FROM [Business].[TimeSignature] [TimeSignature] WHERE [TimeSignature].[Id] IN 
  (
    SELECT [A].[TimeSignatureId] FROM [Business].[Archive] [A] 
    INNER JOIN [Business].[Channel] [Ch] 
      ON [A].[ChannelId] = [Ch].[Id]
    INNER JOIN [Business].[MeasurementDevice] [Md] 
      ON [Md].[Id] = [Ch].[MeasurementDeviceId]
    WHERE [Md].[Id] = @measurementDeviceId 
      AND ([A].[PeriodTypeId] = @periodTypeId OR @periodTypeId IS NULL)
      AND (([A].[Time] >= @periodBegin AND [A].[Time] <= @periodEnd) OR @periodBegin IS NULL OR @periodEnd IS NULL)
  );
