CREATE TABLE [Business].[MobileGeolocationServicingMarker]
(
    [Id] INT NOT NULL IDENTITY(1,1),
    [UserId] INT NOT NULL,  
    [ChannelId] INT NOT NULL,      
    [Location] GEOGRAPHY NOT NULL,
    [Time] DATETIME NOT NULL,
    [ServerTime] DATETIME NOT NULL,
    [Distance] REAL NOT NULL,
    [IsValid]  BIT NOT NULL,

    CONSTRAINT [PK_Business_GeolocationServicingMarker] PRIMARY KEY (Id),

    CONSTRAINT [PK_Business_GeolocationServicingMarker_UserId_Admin_User_Id] 
        FOREIGN KEY ([UserId]) REFERENCES [Admin].[User]([Id]) ON DELETE CASCADE,

	CONSTRAINT [PK_Business_GeolocationServicingMarker_ChannelId_Business_Channel_Id] 
        FOREIGN KEY ([ChannelId]) REFERENCES [Business].[Channel]([Id]) ON DELETE CASCADE
)
