CREATE TABLE [WebApi].[ArchiveDownloaderLinkScheduleItem]
(
    [ArchiveDownloaderId] INT NOT NULL,
    [ScheduleItemId] INT NOT NULL, 
    
    CONSTRAINT PK_WebApi_ArchiveDownloaderLinkScheduleItem_ScheduleItemId_ArchiveDownloaderId 
      PRIMARY KEY ([ScheduleItemId], [ArchiveDownloaderId]),

    CONSTRAINT [FK_WebApi_ArchiveDownloaderLinkScheduleItem_ArchiveDownloaderId_WebApi_ArchiveDownloader_Id] 
      FOREIGN KEY ([ArchiveDownloaderId]) REFERENCES [WebApi].[ArchiveDownloader]([Id]) ON DELETE CASCADE,

	  CONSTRAINT [FK_WebApi_ArchiveDownloaderLinkScheduleItem_ScheduleItemId_Core_ScheduleItem_Id]
      FOREIGN KEY ([ScheduleItemId]) REFERENCES [Core].[ScheduleItem]([Id]) ON DELETE CASCADE
)
