CREATE TABLE [Core].[Report]
(
	[Id] INT NOT NULL IDENTITY (1,1),
	[Code] NVARCHAR(64)  NOT NULL,
	[Description] NVARCHAR(128),	
	[File] VARBINARY(MAX) NULL,
	[ReportTypeId] INT NOT NULL,    
	[HasPluginProcessing] BIT NOT NULL, 
	CONSTRAINT [PK_Core_Report_Id] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Core_Report_ReportTypeId] FOREIGN KEY ([ReportTypeId]) REFERENCES [Core].[ReportType] ([Id])     
);

GO
