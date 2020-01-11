CREATE TABLE [Core].[Dictionary]
(
	[Id] INT NOT NULL IDENTITY (1,1),
	[Code] NVARCHAR(64)  NOT NULL,
	[Description] NVARCHAR(128),
	[UpdateOnly] BIT NOT NULL, 
  CONSTRAINT [PK_Core_Dictionary] PRIMARY KEY (Id)	
);

GO
ALTER TABLE [Core].[Dictionary] 
  ADD CONSTRAINT [DF_Core_Dictionary_UpdateOnly] DEFAULT 0 FOR [UpdateOnly];
