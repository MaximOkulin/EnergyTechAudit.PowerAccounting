CREATE TABLE [Admin].[News]
(
	[Id] INT IDENTITY(1,1),     
    [Code] NVARCHAR(64) NULL,
    [Description] NVARCHAR(128) NOT NULL,

    [Caption] NVARCHAR(MAX) NOT NULL, 
    [Date] DATETIME NOT NULL, 
    [Text] NVARCHAR(MAX) NULL, 
	[BinaryId] INT NULL, 
    [CreatedBy] NVARCHAR(32) NOT NULL , 
    [UpdatedBy] NVARCHAR(32) NOT NULL , 
    [CreatedDate] DATETIME NOT NULL , 
    [UpdatedDate] DATETIME NOT NULL , 
	[ViewCounter] INT NOT NULL,

    CONSTRAINT PK_Admin_News PRIMARY KEY (Id),
    CONSTRAINT	FK_Admin_News_Core_Binary_Id FOREIGN KEY ([BinaryId]) REFERENCES [Core].[Binary]([Id])
)