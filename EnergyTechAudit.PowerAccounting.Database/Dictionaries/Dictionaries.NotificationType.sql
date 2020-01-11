CREATE TABLE [Dictionaries].[NotificationType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
  [IsActive] BIT NOT NULL

	CONSTRAINT [PK_Dictionaries_NotificationType] PRIMARY KEY ([Id])
)
