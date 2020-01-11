CREATE TABLE [Dictionaries].[Dimension]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(32) NOT NULL,
  [Prefix] NVARCHAR(4),
	[Value] DECIMAL(20, 7) NOT NULL,

	CONSTRAINT PK_Dictionaries_Dimension PRIMARY KEY([Id]),
	CONSTRAINT [UQ_Dictionaries_Dimension_Value] UNIQUE ([Value])
);
GO

ALTER  TABLE [Dictionaries].[Dimension]
  ADD CONSTRAINT [DF_Dictionaries_Dimension_Prefix] DEFAULT '' FOR  [Prefix];
GO
