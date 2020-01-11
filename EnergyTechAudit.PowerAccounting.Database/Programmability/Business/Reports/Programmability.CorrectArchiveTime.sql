-- ====================================================================================================
-- Author: Max
-- Create date: 28 August 2015
-- Description: Корректирует диапазон запрашиваемых архивных дат в представлении прибора
-- ====================================================================================================

CREATE PROCEDURE [Programmability].[CorrectArchiveTime]
    @periodTypeId INT,
	@deviceId INT,
	@measurementDeviceId INT,
	@periodBegin DATETIME OUTPUT,
	@periodEnd DATETIME OUTPUT
AS
BEGIN 
    SET NOCOUNT ON;
		
    BEGIN TRY

		DECLARE @expression NVARCHAR(MAX) = N'SELECT @resultOut =' + (SELECT [Expression] 
											FROM [Rules].[DeviceArchiveTimeConverter] WITH(NOLOCK)
											WHERE [DeviceId] = @deviceId AND [PeriodTypeId] = @periodTypeId);
        -- для суточных ТВ-7 смотрим в динамический параметр отчетного часа
        IF @deviceId = 27 AND @periodTypeId = 3
			BEGIN
				DECLARE @reportHour NVARCHAR(MAX) = (SELECT [DPV].[Value] FROM [Core].[DynamicParameterValue] [DPV] WITH(NOLOCK)
											           WHERE [DPV].[EntityId] = @measurementDeviceId AND [DPV].DynamicParameterId = 216)
	            IF @reportHour IS NOT NULL
                   BEGIN
						SET @expression = N'SELECT @resultOut = DATEADD(HOUR, '+ @reportHour +', @date)';
				   END
			END

    IF @expression IS NULL
		BEGIN
		     ;THROW 500077, N'Отсутствует правило преобразования архивных дат для данной модели прибора', 1;
		END

		
		DECLARE @date DATETIME = @periodBegin;
		DECLARE @paramDefinition NVARCHAR(128) = N'@date DATETIME, @resultOut DATETIME OUTPUT';

		EXEC dbo.sp_executesql @expression, @paramDefinition, @date, @resultOut = @periodBegin OUTPUT

		SET @date = @periodEnd;
		EXEC dbo.sp_executesql @expression, @paramDefinition, @date, @resultOut = @periodEnd OUTPUT
	   
	END TRY
	BEGIN CATCH
	    SET @periodBegin = @periodBegin;
		SET @periodEnd = @periodEnd;

	    DECLARE @lineFeed CHAR(1) = CHAR(13);
		DECLARE @parameterListTrace NVARCHAR(256) =
		  CONCAT
		  (
			'@deviceId: ', @deviceId, @lineFeed,
			'periodTypeId', @periodTypeId, @lineFeed
		  );

		DECLARE @errorMessage NVARCHAR(MAX) = 
         CONCAT
         (
            'ErrorNumber: ',     ERROR_NUMBER(), @lineFeed,
            'ErrorSeverity: ',   ERROR_SEVERITY(), @lineFeed,
            'ErrorState: ' ,     ERROR_STATE(), @lineFeed,
            'ErrorProcedure: ',  ERROR_PROCEDURE(), @lineFeed,
            'ErrorLine: ',       ERROR_LINE(), @lineFeed,
            'ErrorMessage: ',    ERROR_MESSAGE()
         );

		 INSERT INTO [Admin].[ErrorLogEntry] 
         (
            [Time], 
            [Exception], 
            [Message], 
            [UserName],
            [StackTrace]
         )
      VALUES
         (
            GETDATE(), 
            'InternalSqlServerException', 
            @errorMessage, 
            SUSER_NAME(),
           @parameterListTrace
         );
      
      THROW;
	END CATCH

END;
GO
