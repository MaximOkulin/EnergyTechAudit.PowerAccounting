CREATE TRIGGER [Admin].[User_InstedOf_Update]
	ON [Admin].[User]
	INSTEAD OF UPDATE
	NOT FOR REPLICATION
	AS
	BEGIN	
	  IF NOT EXISTS (SELECT * FROM inserted)
		BEGIN
		  RETURN;
		END
		OPEN SYMMETRIC KEY  [EnergyTechAudit.PowerAccounting.Database.SymmetricKey]
      DECRYPTION BY CERTIFICATE [EnergyTechAudit.PowerAccounting.Database.Certificate];

		UPDATE [Admin].[User] SET 		  
	    [RoleId] = [User].[RoleId], 
	    [UserName] = [User].[UserName], 
      [Email] = [User].[Email], 	
      [Password] = [User].[Password], 
      [EncryptedPassword] = CONVERT(NCHAR(512), ENCRYPTBYKEY(KEY_GUID(N'[EnergyTechAudit.PowerAccounting.Database.SymmetricKey]'), [User].[Password])), 
      [CreateDate] = [User].[CreateDate], 
	    [ExpiredDate] = [User].[ExpiredDate], 
	    [IsTemporary] = [User].[IsTemporary], 
      [IsApproved] = [User].[IsApproved], 
	    [IsOnline] = [User].[IsOnline], 
	    [Description] = [User].[Description],

	    [CreatedBy] = [User].[CreatedBy],
	    [UpdatedBy] = [User].[UpdatedBy],
	    [CreatedDate] = [User].[CreatedDate],
	    [UpdatedDate] = [User].[UpdatedDate]

	  FROM inserted [User] WHERE [Admin].[User].[Id] = [User].[Id];
		
    CLOSE SYMMETRIC KEY  [EnergyTechAudit.PowerAccounting.Database.SymmetricKey];
    					
		SELECT [Id] FROM [Admin].[User] WHERE @@ROWCOUNT > 0 AND [Id] = scope_identity();			
END