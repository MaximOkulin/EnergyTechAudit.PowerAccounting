/*CREATE TRIGGER [Business].[Channel_InstedOf_Update]
	ON [Business].[Channel]
	INSTEAD OF UPDATE
	NOT FOR REPLICATION
	AS
	BEGIN	
	    IF NOT EXISTS (SELECT * FROM inserted)
		BEGIN
		  RETURN;
		END
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
			UPDATE [Business].[Channel] SET 
					[Description] = [CH].[Description],
					[ChannelTemplateId] = [CH].[ChannelTemplateId],
					[ResourceSystemTypeId] = [CH].[ResourceSystemTypeId],
					[MeasurementDeviceId] = [CH].[MeasurementDeviceId],
						[PlacementId] = [CH].[PlacementId],						
						[MnemoschemeId] = [CH].[MnemoschemeId],
						[CreatedBy] = [CH].[CreatedBy],
						[UpdatedBy] = [CH].[UpdatedBy], 
						[CreatedDate] = [CH].[CreatedDate], 
						[UpdatedDate] = [CH].[UpdatedDate] 

						FROM inserted CH WHERE [Business].[Channel].[Id] = [CH].[Id];
							
				SELECT Id from [Business].[Channel] WHERE @@ROWCOUNT > 0 and Id = scope_identity();
			
		END	
		ELSE
		BEGIN		
			RAISERROR (N'Выбираемое помещение не соответствует исходной привязке измерительного устройства', 16, 1);
		END
END;

GO

DISABLE TRIGGER [Channel_InstedOf_Update] ON [Business].[Channel];
*/