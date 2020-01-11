CREATE TABLE [Admin].[Alert]
(
   [Id] INT NOT NULL IDENTITY(1, 1),
   [Message] NVARCHAR(MAX) NOT NULL,
   [Type] NVARCHAR(32), 
   [TimeOut] INT NOT NULL, 
   [Duration] INT NULL, 
   [ShowCloseButton] BIT NULL, 
   [InjectCss] NVARCHAR(MAX) NULL, 
   [Title] NVARCHAR(64) NULL, 
   [PendingDate] DATE NOT NULL,       
   [CreatedBy] NVARCHAR(32) NOT NULL, 
   [UpdatedBy] NVARCHAR(32) NOT NULL, 
   [CreatedDate] DATETIME NOT NULL, 
   [UpdatedDate] DATETIME NOT NULL, 
    
   CONSTRAINT [PK_Admin_Alert_Id] PRIMARY KEY ([Id])
)
GO

ALTER TABLE [Admin].[Alert]
  ADD CONSTRAINT [DF_Admin_Alert_Type] DEFAULT 'info' FOR [Type]
GO

ALTER TABLE [Admin].[Alert]
  ADD CONSTRAINT [DF_Admin_Alert_Duration] DEFAULT 500 FOR [Duration]
GO  

ALTER TABLE [Admin].[Alert]
  ADD CONSTRAINT [DF_Admin_Alert_ShowCloseButton] DEFAULT 1 FOR [ShowCloseButton]
GO 
