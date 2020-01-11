CREATE TABLE [Core].[ReportSelector]
(        
   [SelectorReportId] INT NOT NULL,
   [TargetReportId] INT NOT NULL IDENTITY(1, 1),   
   [PredicateExpression] NVARCHAR(MAX) NOT NULL,    
   CONSTRAINT [PK_Core_ReportSelector_Id] PRIMARY KEY ([TargetReportId]),
   CONSTRAINT [FK_Core_ReportSelector_SelectorReportId] FOREIGN KEY ([SelectorReportId]) REFERENCES [Core].[Report] ([Id]),
   CONSTRAINT [FK_Core_ReportSelector_TargetReportId] FOREIGN KEY ([TargetReportId]) REFERENCES [Core].[Report] ([Id])
)
