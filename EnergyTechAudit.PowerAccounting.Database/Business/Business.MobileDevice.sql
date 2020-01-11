CREATE TABLE [Business].[MobileDevice]
(
	[Id] INT NOT NULL IDENTITY(1, 1),
    [UserId] INT NOT NULL, 
    [Imei] NVARCHAR(82) NOT NULL,
    [Model] NVARCHAR(256) NOT NULL,
    [Os] NVARCHAR(128) NOT NULL,
	[RegistrationDate] DATETIME NULL,
	[LastConnectionDate] DATETIME NULL,
	[FcmToken] NVARCHAR(256) NULL,
	[IsActive] BIT NOT NULL,

    CONSTRAINT [PK_Business_MobileDevice] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Business_MobileDevice_UserId_Admin_User_Id] FOREIGN KEY ([UserId]) REFERENCES [Admin].[User]([Id])
)
GO                          

CREATE NONCLUSTERED INDEX [IX_Business_MobileDevice_UserId]
    ON [Business].[MobileDevice]([UserId]);
GO
