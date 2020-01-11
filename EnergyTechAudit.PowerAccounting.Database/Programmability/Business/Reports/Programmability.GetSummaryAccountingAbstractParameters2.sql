-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2016-02-20
-- ====================================================================================================

CREATE FUNCTION Programmability.GetSummaryAccountingAbstractParameters2
(
  @periodTypeId INT,
  @resourceSystemTypeId INT,
  @userId INT  
)
RETURNS  TABLE
AS
RETURN 
  SELECT [Id], [Code] 
  FROM
  (
  	    SELECT 
          ROW_NUMBER() OVER (PARTITION BY [Parameter].[Id] ORDER BY [Parameter].[Id]) Num,
          [Parameter].[Id] [Id], 
          [Parameter].[Code] [Code]
  
        FROM [Dictionaries].[Parameter] [Parameter]
  
  			INNER JOIN [Business].[ParameterMapDeviceParameter] [Map] 
  				ON [Parameter].[Id] = [Map].[ParameterId] AND [Map].[PeriodTypeId] = @periodTypeId 
  
        INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] 
  				ON [ChannelTemplate].[Id] = [Map].[ChannelTemplateId] AND [ChannelTemplate].[ResourceSystemTypeId] = @resourceSystemTypeId
  
        INNER JOIN [Business].[Channel]  
  				ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id]
  			
  			/* фильтр по принадлежности пользователю и по принадлежности к району */
  			INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel] 
  				ON [UserLinkChannel].[ChannelId] = [Channel].[Id] 
  					AND [UserLinkChannel].[UserId] = @userId
  		  			     
  ) [A]
  WHERE [Num] = 1;
GO