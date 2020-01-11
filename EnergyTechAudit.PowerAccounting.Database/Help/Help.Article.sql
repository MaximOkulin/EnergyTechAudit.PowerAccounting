CREATE TABLE [Help].[Article]
(
	[Id] INT NOT NULL IDENTITY(1,1), 
    [ParentId] INT NOT NULL, 
	[Title] NVARCHAR(MAX) NULL,
    [Html] NVARCHAR(MAX) NULL, 
    
	CONSTRAINT PK_Help_Article PRIMARY KEY (Id),
)
