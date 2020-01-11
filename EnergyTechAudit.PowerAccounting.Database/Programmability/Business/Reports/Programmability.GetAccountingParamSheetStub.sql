-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2017-06-15
-- Update date: 2017-06-15
-- ====================================================================================================

CREATE PROC [Programmability].[GetAccountingParamSheetStub]      
    @periodTypeId INT,
    @channelTemplateId INT
AS
BEGIN    
    DECLARE @parameterCodePull [Programmability].[CodePullTableType];
                
    INSERT INTO @parameterCodePull 		    
        SELECT   
            [Parameter].[Id] [Id],
            [Parameter].[Code] [Code]
        FROM [Dictionaries].[Parameter] [Parameter] WITH (NOLOCK)
        
        INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH (NOLOCK)    
            ON [Parameter].[Id] = [ParameterMapDeviceParameter].[ParameterId] AND [ParameterMapDeviceParameter].[PeriodTypeId] = @periodTypeId 
    
        INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH (NOLOCK)
            ON [ChannelTemplate].[Id] = [ParameterMapDeviceParameter].[ChannelTemplateId] AND [ChannelTemplate].[Id] = @channelTemplateId
             
    DECLARE @parameterCodeFields NVARCHAR(MAX) = '';
    
    SELECT @parameterCodeFields =  CONCAT(@parameterCodeFields, 'CAST(NULL AS DECIMAL(19, 7)) [', [ParameterCodePull].[Code], '], ')  
        FROM @parameterCodePull [ParameterCodePull];
    
    SET @parameterCodeFields = LEFT(@parameterCodeFields, LEN(@parameterCodeFields) - 1);
    
    SET @parameterCodeFields = CONCAT( N'SELECT CAST(NULL AS BIT) [IsValidRowState], CAST(NULL AS DATETIME) [Time], ',  @parameterCodeFields, ' WHERE NULL IS NOT NULL');
    
    EXEC [sys].[sp_executesql] @parameterCodeFields;

END;

GO