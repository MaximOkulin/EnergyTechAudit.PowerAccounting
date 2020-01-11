CREATE TABLE [Core].[ScheduleItem]
(
    [Id] INT NOT NULL IDENTITY(1, 1), 
    [Description] NVARCHAR(256) NULL,

    [Enabled] BIT NOT NULL,

    [ScheduleTypeId] INT NOT NULL,     
    
    [PeriodBegin] TIME(0) NULL, 
    [PeriodEnd] TIME(0) NULL,
    
    [OrdinalNumberOfDay] INT NULL,
    
    CONSTRAINT [PK_Core_ScheduleItem_Id] PRIMARY KEY ([Id]),
        
    CONSTRAINT [FK_Core_ScheduleItem_ScheduleTypeId_Dictionaries_ScheduleType_Id] 
      FOREIGN KEY ([ScheduleTypeId]) REFERENCES [Dictionaries].[ScheduleType]([Id]) ON DELETE CASCADE,

    CONSTRAINT [CHK_Core_ScheduleItem_PeriodBegin_PeriodEnd] CHECK ([PeriodBegin] < [PeriodEnd])
)

GO
ALTER TABLE [Core].[ScheduleItem] 
  ADD CONSTRAINT [DF_Core_ScheduleItem_PeriodBegin] DEFAULT '00:00:00' FOR [PeriodBegin];

GO
ALTER TABLE [Core].[ScheduleItem]
  ADD CONSTRAINT [DF_Core_ScheduleItem_PeriodEnd] DEFAULT '23:59:59' FOR [PeriodEnd];

GO
ALTER TABLE [Core].[ScheduleItem] 
  ADD CONSTRAINT [DF_Core_ScheduleItem_Enabled] DEFAULT 0 FOR [Enabled];