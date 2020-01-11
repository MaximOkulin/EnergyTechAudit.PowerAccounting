CREATE TABLE [Admin].[Role]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
	[StartupRoute] NVARCHAR(256) NOT NULL, 
	[MobileDeviceStartupRoute] NVARCHAR(256)  NULL, 
	CONSTRAINT PK_Admin_Role_Id PRIMARY KEY (Id) 
)