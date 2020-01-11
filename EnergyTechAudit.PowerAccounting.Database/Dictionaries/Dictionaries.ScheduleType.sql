CREATE TABLE [Dictionaries].[ScheduleType]
(
  [Id] INT NOT NULL IDENTITY(1, 1),
  [Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(32) NOT NULL,  
  CONSTRAINT [Dictionaries_ScheduleType_Id] PRIMARY KEY ([Id]) 
)
