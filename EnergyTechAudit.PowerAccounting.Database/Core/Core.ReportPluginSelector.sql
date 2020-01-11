CREATE TABLE [Core].[ReportPluginSelector]
(
	[Id] INT NOT NULL IDENTITY (1,1),
	[ReportId] INT NOT NULL,
	[PredicateExpression] NVARCHAR(MAX) NOT NULL,
	[TypeName] NVARCHAR(256) NOT NULL,

	CONSTRAINT [PK_Core_ReportPluginSelector_Id] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Core_ReportPluginSelector_ReportId_Core_Report_Id] FOREIGN KEY ([ReportId]) REFERENCES [Core].[Report]([Id])
);

GO

CREATE NONCLUSTERED INDEX [IX_Core_ReportPluginSelector_ReportId]
   ON [Core].[ReportPluginSelector] ([ReportId]);

