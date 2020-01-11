-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2014-12-27
-- Description: Описывает задачу - некоторое действие
-- в отношении данных (возвращающее, изменяющее или создающее)
-- ===================================================================================================

CREATE TABLE [Core].[Processing]
(
	[Id] INT NOT NULL IDENTITY(1,1), 
	[Code] NVARCHAR(64) NOT NULL, 
	[Description] NVARCHAR(128) NULL,
	[IsAsync] BIT NOT NULL,
   
  CONSTRAINT [PK_Core_Processing] PRIMARY KEY ([Id])   
);
GO

ALTER TABLE [Core].[Processing]
  ADD CONSTRAINT [DF_Core_Processing_IsAsync] DEFAULT 0 FOR [IsAsync];
