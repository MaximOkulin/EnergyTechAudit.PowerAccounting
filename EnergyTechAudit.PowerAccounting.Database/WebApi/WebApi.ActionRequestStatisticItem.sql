CREATE TABLE [WebApi].[ActionRequestStatisticItem]
(
    [Id] INT NOT NULL IDENTITY(1,1), 
    [ArchiveDownloaderId] INT NOT NULL, 
    [ActionName] VARCHAR(64) NOT NULL,
    [Time] DATETIME NOT NULL, 
    [DataSize] BIGINT NOT NULL, 
    [ActionRequestStatisticInfo] XML NULL,   
         
    [Uid] VARCHAR(64) NULL, 
    CONSTRAINT [PK_WebApi_ActionRequestStatisticItem_Id] PRIMARY KEY ([Id]),

    CONSTRAINT [FK_WebApi_ActionRequestStatisticItem_ArchiveDownloaderId_WebApi_ArchiveDownloader_Id] 
      FOREIGN KEY([ArchiveDownloaderId]) REFERENCES [WebApi].[ArchiveDownloader] ON DELETE CASCADE 
 );
GO

CREATE NONCLUSTERED INDEX [IX_WebApi_ActionRequestStatisticItem_ArchiveDownloader_Id]
  ON [WebApi].[ActionRequestStatisticItem] ([ArchiveDownloaderId]);

GO
