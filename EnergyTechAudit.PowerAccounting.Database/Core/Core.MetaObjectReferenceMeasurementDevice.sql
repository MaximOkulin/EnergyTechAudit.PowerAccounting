-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20141030
-- Description: Указывает, что метаобъект должен обрабатываться 
-- только в контексте привязки к конкретному устройству
-- ====================================================================================================


CREATE TABLE [Core].[MetaObjectReferenceMeasurementDevice]
(
	[Id] INT NOT NULL,     
	CONSTRAINT PK_Core_MetaObjectReferenceMeasurementDevice PRIMARY KEY([Id]),
	CONSTRAINT [FK_Core_MetaObjectReferenceMeasurementDevice_Id_Core_MetaObject_Id] FOREIGN KEY ([Id]) REFERENCES [Core].[MetaObject]([Id]),	
);

