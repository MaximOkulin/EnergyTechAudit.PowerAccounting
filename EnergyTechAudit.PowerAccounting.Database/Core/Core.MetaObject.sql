/*Описывает сущность, которая представляет описание программной 
 сущности доступной для пользователя (словаря, отчета, запроса)*/

CREATE TABLE [Core].[MetaObject]
(
	[Id] INT NOT NULL IDENTITY (1, 1),
	[MetaObjectTypeId] INT NOT NULL, 
	[DictionaryId] INT NULL,
	[PivotId] INT NULL,
	[ReportId] INT NULL,
	[QueryId] INT NULL,
	[FormId] INT NULL,
	[PivotDiagrammId] INT NULL, 
	[ProcessingId] INT NULL,
	[DiagrammId] INT NULL,

	[ParametricId] INT NULL,
	[SourceId] INT NULL,
	[IsNotInlineParametric] BIT NULL
    
	CONSTRAINT [PK_Core_MetaObject] PRIMARY KEY ([Id]), 
    
	CONSTRAINT [FK_Core_MetaObject_MetaObjectTypeId_Core_MetaObjectType_Id] FOREIGN KEY ([MetaObjectTypeId]) REFERENCES [Core].[MetaObjectType] ([Id]),	
	CONSTRAINT [FK_Core_MetaObject_DictionaryId_Core_Dictionary_Id] FOREIGN KEY ([DictionaryId]) REFERENCES [Core].[Dictionary] ([Id]),
	CONSTRAINT [FK_Core_MetaObject_PivotId_Core_Pivot_Id] FOREIGN KEY ([PivotId]) REFERENCES [Core].[Pivot] ([Id]),
	CONSTRAINT [FK_Core_MetaObject_QueryId_Core_Query_Id] FOREIGN KEY ([QueryId]) REFERENCES [Core].[Query] ([Id]),
	CONSTRAINT [FK_Core_MetaObject_ReportId_Core_Report_Id] FOREIGN KEY ([ReportId]) REFERENCES [Core].[Report] ([Id]),
	CONSTRAINT [FK_Core_MetaObject_FormId_Core_Form_Id] FOREIGN KEY ([FormId]) REFERENCES [Core].[Form] ([Id]),
	CONSTRAINT [FK_Core_MetaObject_PivotDiagrammId_Core_PivotDiagramm_Id] FOREIGN KEY ([PivotDiagrammId]) REFERENCES [Core].[PivotDiagramm] ([Id]),
	CONSTRAINT [FK_Core_MetaObject_ProcessingId_Core_Processing_Id] FOREIGN KEY ([ProcessingId]) REFERENCES [Core].[Processing] ([Id]),    
	CONSTRAINT [FK_Core_MetaObject_DiagrammId_Core_Diagramm_Id] FOREIGN KEY ([DiagrammId]) REFERENCES [Core].[Diagramm] ([Id]),    
	
	CONSTRAINT [FK_Core_MetaObject_ParametricId_Core_Parametric_Id] FOREIGN KEY ([ParametricId]) REFERENCES [Core].[Parametric] ([Id]),		
	CONSTRAINT [FK_Core_MetaObject_SourceId_Core_Source_Id] FOREIGN KEY ([SourceId]) REFERENCES [Core].[Source] ([Id]),		

	CONSTRAINT [CHK_Core_MetaObject] CHECK 
	(
		       ([DictionaryId] IS NOT NULL AND [PivotId] IS NULL AND ReportId IS NULL AND QueryId IS NULL AND FormId IS NULL AND [PivotDiagrammId] IS NULL AND [ProcessingId] IS NULL AND [DiagrammId] IS NULL)
			 OR ([DictionaryId] IS NULL AND [PivotId] IS NOT NULL AND ReportId IS NULL AND QueryId IS NULL AND FormId IS NULL AND [PivotDiagrammId] IS NULL AND [ProcessingId] IS NULL AND [DiagrammId] IS NULL)
	         OR ([DictionaryId] IS NULL AND [PivotId] IS NULL AND ReportId IS NOT NULL AND QueryId IS NULL AND FormId IS NULL AND [PivotDiagrammId] IS NULL AND [ProcessingId] IS NULL AND [DiagrammId] IS NULL)
	         OR ([DictionaryId] IS NULL AND [PivotId] IS NULL AND ReportId IS NULL AND QueryId IS NOT NULL AND FormId IS NULL AND [PivotDiagrammId] IS NULL AND [ProcessingId] IS NULL AND [DiagrammId] IS NULL)
	         OR ([DictionaryId] IS NULL AND [PivotId] IS NULL AND ReportId IS NULL AND QueryId IS NULL AND FormId IS NOT NULL AND [PivotDiagrammId] IS NULL AND [ProcessingId] IS NULL AND [DiagrammId] IS NULL)
	         OR ([DictionaryId] IS NULL AND [PivotId] IS NULL AND ReportId IS NULL AND QueryId IS NULL AND FormId IS NULL AND [PivotDiagrammId] IS NOT NULL AND [ProcessingId] IS NULL AND [DiagrammId] IS NULL)
	         OR ([DictionaryId] IS NULL AND [PivotId] IS NULL AND ReportId IS NULL AND QueryId IS NULL AND FormId IS NULL AND [PivotDiagrammId] IS NULL AND [ProcessingId] IS NOT NULL AND [DiagrammId] IS  NULL)           
	         OR ([DictionaryId] IS NULL AND [PivotId] IS NULL AND ReportId IS NULL AND QueryId IS NULL AND FormId IS NULL AND [PivotDiagrammId] IS NULL AND [ProcessingId] IS NULL AND [DiagrammId] IS NOT NULL)           
	) 
);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObject_MetaObjectTypeId] 
   ON [Core].[MetaObject] ([MetaObjectTypeId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObject_DictionaryId] 
   ON [Core].[MetaObject] ([DictionaryId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObject_PivotId] 
   ON [Core].[MetaObject] ([PivotId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObject_QueryId] 
   ON [Core].[MetaObject] ([QueryId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObject_ReportId] 
   ON [Core].[MetaObject] ([ReportId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObject_FormId] 
   ON [Core].[MetaObject] ([FormId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObject_PivotDiagrammId] 
   ON [Core].[MetaObject] ([PivotDiagrammId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObject_ParametricId] 
   ON [Core].[MetaObject] ([ParametricId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObject_SourceId] 
   ON [Core].[MetaObject] ([SourceId]);