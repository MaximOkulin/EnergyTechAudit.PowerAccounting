CREATE TABLE [Core].[Menu]
(
	[Id] INT NOT NULL IDENTITY(1,1),	
	[Order] INT NOT NULL,
	[Title] NVARCHAR(32) NOT NULL, 
  [IconClass] NVARCHAR(128) NULL, 
  [DisplayInMainMenu] BIT NOT NULL, 
  [DisplayInNavbar] BIT NOT NULL,   
  CONSTRAINT [PK_Core_Menu] PRIMARY KEY ([Id])
);
GO

ALTER TABLE [Core].[Menu]
  ADD  CONSTRAINT [DF_Core_Menu_DisplayInMainMenu] DEFAULT 0 FOR [DisplayInMainMenu];
GO

ALTER TABLE [Core].[Menu]
  ADD  CONSTRAINT [DF_Core_Menu_DisplayInNavbar] DEFAULT 0 FOR [DisplayInNavbar];
GO