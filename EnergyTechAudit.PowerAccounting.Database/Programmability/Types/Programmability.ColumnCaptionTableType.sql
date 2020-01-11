CREATE TYPE [Programmability].[ColumnCaptionTableType]
AS TABLE 
  (
	  [Table] NVARCHAR(64) NOT NULL, 
  	[Name] NVARCHAR(64)  NOT NULL,
  	[Caption] NVARCHAR(64) NOT NULL,
    [Visible] [BIT],
    [Order] INT NULL
  );
