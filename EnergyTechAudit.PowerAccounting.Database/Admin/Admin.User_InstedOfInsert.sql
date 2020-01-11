CREATE TRIGGER [Admin].[User_InstedOf_Insert]
	ON [Admin].[User]
	INSTEAD OF INSERT
	NOT FOR REPLICATION
	AS
	BEGIN	
	  IF NOT EXISTS (SELECT * FROM inserted)
		BEGIN
		  RETURN;
		END
		OPEN SYMMETRIC KEY  [EnergyTechAudit.PowerAccounting.Database.SymmetricKey]
      DECRYPTION BY CERTIFICATE [EnergyTechAudit.PowerAccounting.Database.Certificate];

    INSERT INTO	[Admin].[User]
    (  		  
	    [RoleId], 
	    [UserName], 
      [Email], 	
      [Password], 
      [EncryptedPassword], 
      [CreateDate], 
	    [ExpiredDate], 
	    [IsTemporary], 
      [IsApproved], 
	    [IsOnline], 
	    [Description],

	    [CreatedBy],
	    [UpdatedBy],
	    [CreatedDate],
	    [UpdatedDate]
    )
    SELECT 
      inserted.[RoleId], 
	    inserted.[UserName], 
      inserted.[Email], 	
      inserted.[Password], 
      CONVERT(NCHAR(512), ENCRYPTBYKEY(KEY_GUID(N'[EnergyTechAudit.PowerAccounting.Database.SymmetricKey]'), inserted.[Password])), 
      inserted.[CreateDate], 
	    inserted.[ExpiredDate], 
	    inserted.[IsTemporary], 
      inserted.[IsApproved], 
	    inserted.[IsOnline], 
	    inserted.[Description],

	    inserted.[CreatedBy],
	    inserted.[UpdatedBy],
	    inserted.[CreatedDate],
	    inserted.[UpdatedDate]

      FROM inserted;
	  
		SELECT [Id] FROM [Admin].[User] WHERE @@ROWCOUNT > 0 AND [Id] = scope_identity();			

    CLOSE SYMMETRIC KEY  [EnergyTechAudit.PowerAccounting.Database.SymmetricKey];
    					
		
END