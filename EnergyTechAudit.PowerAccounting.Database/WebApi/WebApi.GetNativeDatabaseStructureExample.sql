-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20180402
-- Description: This stored procedure returns xml-package containing data example of structure of relations 
-- for some entity (it's developed only for Building entity). Besides the stored procedure forms section 
-- with content of the most valuable dictionaries. 
-- ===================================================================================================

CREATE PROCEDURE WebApi.GetNativeDatabaseStructureExample
	@userName NVARCHAR(32),
	@entityId INT, 
	@entityTypeName NVARCHAR(32),
	@actionUid UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
	SET NOCOUNT ON;	
	DECLARE @dateTime DATETIME = GETDATE();
	DECLARE @uid UNIQUEIDENTIFIER = NEWID();
	DECLARE @methodName VARCHAR(64) = 'NativeDatabaseStructureExample';
	DECLARE @error NVARCHAR(128); 
	SET @actionUid = @uid;

	BEGIN TRY
		-- for Building entity as origin
		IF( @entityTypeName = 'Building' )
		BEGIN
			SELECT 
			@dateTime [DateTime], 
			@uid [Uid],
			@methodName [MethodName],
			(
				SELECT 
				(
					SELECT [Building].[Id]
						  ,[Building].[Description]
						  ,[Building].[FullAddress]
						  ,[Building].[Square]
						  ,[Building].[BuildingPurposeId]
						  ,[Building].[CountFlats]
						  ,[Building].[Location].ToString()  [Location]
						  ,[Building].[OrganizationId]
						  ,[Building].[CreatedBy]
						  ,[Building].[UpdatedBy]
						  ,[Building].[CreatedDate]
						  ,[Building].[UpdatedDate]
						  ,[Building].[DistrictId]
						  ,(
								SELECT  
								(
									SELECT *,
									(
										SELECT *,
											(
												SELECT * FROM [Business].[Archive] [Archive] WITH (NOLOCK)
												WHERE 
													[Archive].[MeasurementDeviceId] = [MeasurementDevice].[Id] 
													AND [Archive].[TimeSignatureId] = [MeasurementDevice].[LastTimeSignatureId]
												FOR XML AUTO, ELEMENTS, TYPE, ROOT('Archives')
											) 
										FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)
										WHERE [MeasurementDevice].[AccessPointId] = [AccessPoint].[Id]
										FOR XML AUTO, ELEMENTS, TYPE, ROOT('MeasurementDevices')
									)
									FROM [Business].[AccessPoint] [AccessPoint] WITH (NOLOCK)
									WHERE [AccessPoint].[Id] = [AccessPointLinkBuilding].[AccessPointId]
									FOR XML AUTO, ELEMENTS, TYPE
								)
								FROM [Business].[AccessPointLinkBuilding] [AccessPointLinkBuilding] WITH (NOLOCK)
								WHERE [AccessPointLinkBuilding].[BuildingId] = [Building].[Id]
								FOR XML AUTO, ELEMENTS, TYPE, ROOT('AccessPointLinkBuildings')
							)
						   ,(
								SELECT *, 
								( 
									SELECT *,
									(
										SELECT *,
										(
											SELECT [User].[Id]
												  ,[User].[UserName]
												  ,[User].[Description]                                             
											FROM [Admin].[User] [User] 
											WHERE [User].[Id] = [UserLinkChannel].[UserId] 
											FOR XML AUTO, ELEMENTS, TYPE
										) 
										FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH (NOLOCK)
										WHERE [UserLinkChannel].[ChannelId] = [Channel].[Id]
										FOR XML AUTO, ELEMENTS, TYPE, ROOT('UserLinkChannels')
									)
									,(
										SELECT *,
										(
											SELECT * FROM [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH (NOLOCK)
											WHERE [ParameterMapDeviceParameter].[ChannelTemplateId] = [ChannelTemplate].[Id]
											FOR XML AUTO, ELEMENTS, TYPE, ROOT('ParameterMapDeviceParameters')	
										)
										FROM [Business].[ChannelTemplate] [ChannelTemplate] WITH (NOLOCK)
										WHERE [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId]
										FOR XML AUTO, ELEMENTS, TYPE                                     
									)
									FROM [Business].[Channel] [Channel] WITH (NOLOCK)
									WHERE [Channel].[PlacementId] = [Placement].[Id] 
									FOR XML AUTO, ELEMENTS, TYPE, ROOT('Channels') 
								)
								FROM [Business].[Placement] [Placement] WITH (NOLOCK)
								WHERE [Placement].[BuildingId] = [Building].[Id] FOR XML AUTO, ELEMENTS, TYPE, ROOT('Placements')
							)							  			  			  			  
					FROM [Business].[Building] [Building] WITH (NOLOCK)
					WHERE [Building].[Id] = @entityId 
					FOR XML AUTO, ELEMENTS, TYPE, ROOT('Buildings')
				) FOR XML PATH('Business'), ELEMENTS, TYPE
			),
			(
				SELECT 
					(SELECT * FROM [Dictionaries].[ResourceSystemType] [ResourceSystemType] WITH (NOLOCK) FOR XML AUTO,  ELEMENTS, TYPE, ROOT('ResourceSystemTypes')),
					(SELECT * FROM [Dictionaries].[Device] [Device] WITH (NOLOCK) FOR XML AUTO,  ELEMENTS, TYPE, ROOT('Devices')),
					(SELECT * FROM [Dictionaries].[DeviceParameter] [DeviceParameter] WITH (NOLOCK) FOR XML AUTO,  ELEMENTS, TYPE, ROOT('DeviceParameters')),                
					(SELECT * FROM [Dictionaries].[PeriodType] [PeriodType] WITH (NOLOCK) FOR XML AUTO,  ELEMENTS, TYPE, ROOT('PeriodTypes')),
					(SELECT * FROM [Dictionaries].[Parameter] [Parameter] WITH (NOLOCK) FOR XML AUTO,  ELEMENTS, TYPE, ROOT('Parameters')),	
					(SELECT * FROM [Dictionaries].[MeasurementUnit] [MeasurementUnit] WITH (NOLOCK) FOR XML AUTO,  ELEMENTS, TYPE, ROOT('MeasurementUnits')),
					(SELECT * FROM [Dictionaries].[Dimension] [Dimension] WITH (NOLOCK) FOR XML AUTO, ELEMENTS, TYPE, ROOT('Dimensions')), 
					(SELECT * FROM [Dictionaries].[PhysicalParameter] [PhysicalParameter] WITH (NOLOCK) FOR XML AUTO, ELEMENTS, TYPE, ROOT('PhysicalParameters')),		
					(SELECT * FROM [Dictionaries].[PlacementPurpose] [PlacementPurpose] WITH (NOLOCK) FOR XML AUTO, ELEMENTS, TYPE, ROOT('PlacementPurposes')),
					(SELECT * FROM [Dictionaries].[BuildingPurpose] [BuildingPurpose] WITH (NOLOCK) FOR XML AUTO,  ELEMENTS, TYPE, ROOT('BuildingPurposes'))		
				 FOR XML PATH('Dictionaries'), ELEMENTS, TYPE	
			)
			FOR XML PATH('Package'), ELEMENTS, TYPE;
		END
		ELSE 
		-- If necessary this method may be developed for another way of presentation database relationships   
		BEGIN
			SELECT 
				@dateTime [DateTime], 
				@uid [Uid],
				@methodName [MethodName], 
				'The database structure example didn''t implement for this entity.' [Message] 
			FOR XML PATH('Package'), ELEMENTS, TYPE;
		END;	
	END TRY
	BEGIN CATCH
		SET @error = 'There was internal query execution error. ' + ERROR_MESSAGE();
		SELECT 
			@dateTime [DateTime], 
			@uid [Uid],
			@methodName [MethodName],      
			@error [Message]             
		FOR XML PATH('Error'), ELEMENTS, TYPE;  
	END CATCH;

END;
GO