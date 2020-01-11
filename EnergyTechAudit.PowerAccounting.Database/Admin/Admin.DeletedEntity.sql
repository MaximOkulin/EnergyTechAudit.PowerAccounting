CREATE TABLE [Admin].[DeletedEntity]
(
    [Id] INT NOT NULL IDENTITY(1,1), 
    [EntityId] INT NOT NULL,
    [EntityTypeName] NVARCHAR(64) NOT NULL, 
    [EntityTypeDescription] NCHAR(10) NOT NULL, 
    [User] NVARCHAR(32) NOT NULL, 
    [DateTime] DATETIME NOT NULL,   
    CONSTRAINT PK_Admin_DeletedEntity PRIMARY KEY (Id)	    
)
