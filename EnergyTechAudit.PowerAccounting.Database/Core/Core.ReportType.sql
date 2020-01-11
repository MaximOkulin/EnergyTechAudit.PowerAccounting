CREATE TABLE [Core].[ReportType]
(
    [Id] INT NOT NULL IDENTITY(1, 1), 
    [Code] NVARCHAR(32) NOT NULL, 
    [Description] NVARCHAR(128) NULL,
    CONSTRAINT [PK_Core_ReportType_Id] PRIMARY KEY ([Id])
)
