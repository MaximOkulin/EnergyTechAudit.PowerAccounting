/*CREATE TRIGGER [Business]	.[Channel_InstedOf_Insert]
	ON [Business].[Channel]
	INSTEAD OF INSERT
	NOT FOR REPLICATION
	AS
	BEGIN		
		/* соотвествие помещения канала и точки доступа через измерительное устройство*/	
		IF EXISTS (SELECT [BL].[Id] FROM [Business].[MeasurementDevice] [MD] WITH(NOLOCK)

			INNER JOIN [Business].[AccessPoint] AP WITH(NOLOCK) ON [MD].[AccessPointId] = [AP].[Id]
			INNER JOIN [Business].[AccessPointLinkBuilding] APBL WITH(NOLOCK) ON [AP].[Id] = [APBL].[AccessPointId]
			INNER JOIN [Business].[Building] BL WITH(NOLOCK) ON [BL].[Id] = APBL.[BuildingId] 
			INNER JOIN inserted CH WITH(NOLOCK) ON CH.[MeasurementDeviceId] = [MD].[Id]
		WHERE BL.Id IN 

		(SELECT PL.BuildingId FROM [Business].[Placement] PL WITH(NOLOCK)  

				INNER JOIN [Business].[Building] BL2 WITH(NOLOCK) ON [BL2].[Id] = [PL].[BuildingId] 
				INNER JOIN inserted CH2 WITH(NOLOCK) ON [CH2].[PlacementId] =[PL].[Id]) 
		) 
		/*соответствие помещения канала и концентратора*/
		OR EXISTS (SELECT [BL].[Id] FROM [Business].[MeasurementDevice] [MD] WITH(NOLOCK) 											
				INNER JOIN [Business].[Hub] [HD] WITH(NOLOCK)  ON [MD].[HubId] = [HD].[Id] 
				INNER JOIN [Business].[Building] [BL] WITH(NOLOCK)  ON [HD].[BuildingId] = [BL].[Id]
				INNER JOIN inserted CH WITH(NOLOCK) ON CH.[MeasurementDeviceId] = [MD].[Id]			
			WHERE [BL].[Id] IN 
			
			(SELECT PL.BuildingId FROM [Business].[Placement] PL WITH(NOLOCK)  

				INNER JOIN [Business].[Building] BL2 WITH(NOLOCK) ON [BL2].[Id] = [PL].[BuildingId] 
				INNER JOIN inserted CH2 WITH(NOLOCK) ON [CH2].[PlacementId] =[PL].[Id]) 
			)
        
		BEGIN
			INSERT INTO [Business].[Channel](
				  [Description],
				  [ChannelTemplateId] ,	
					[ResourceSystemTypeId] ,
					[MeasurementDeviceId] ,
					[PlacementId] ,							
          [MnemoschemeId],
					
					[CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]
				) SELECT 
					inserted.[Description],
					inserted.[ChannelTemplateId] ,	
					inserted.[ResourceSystemTypeId] ,
					inserted.[MeasurementDeviceId] ,
					inserted.[PlacementId] ,					
					inserted.[MnemoschemeId],
					inserted.[CreatedBy], inserted.[UpdatedBy], inserted.[CreatedDate], inserted.[UpdatedDate]									
				FROM inserted
	
			SELECT Id from [Business].[Channel] WHERE @@ROWCOUNT > 0 and Id = scope_identity();			
		END		
		ELSE
		BEGIN
			RAISERROR (N'Выбираемое помещение не соответствует исходной привязке измерительного устройства', 16, 1);			
		END
	END;


DISABLE TRIGGER [Channel_InstedOf_Insert] ON [Business].[Channel];
*/