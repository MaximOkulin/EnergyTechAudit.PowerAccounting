CREATE TABLE [Admin].[Faq]
(
	  [Id] INT IDENTITY(1,1), 
    [Caption] NVARCHAR(MAX) NOT NULL, 
    [Date] DATETIME NOT NULL, 
    [Number] INT, 
    [Question] NVARCHAR(MAX) NULL, 
	  [Answer] NVARCHAR(MAX) NULL, 
    [Categories] NVARCHAR(MAX) NULL, 
    [CreatedBy] NVARCHAR(32) NOT NULL , 
    [UpdatedBy] NVARCHAR(32) NOT NULL , 
    [CreatedDate] DATETIME NOT NULL , 
    [UpdatedDate] DATETIME NOT NULL , 
    
    CONSTRAINT PK_Admin_Faq PRIMARY KEY (Id)   
)
