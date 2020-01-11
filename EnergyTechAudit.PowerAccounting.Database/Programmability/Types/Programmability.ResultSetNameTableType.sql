CREATE TYPE [Programmability].[ResultSetNameTableType] 
AS TABLE
   (
      [Order] INT,
      [Name] NVARCHAR(64) NOT NULL,
      PRIMARY KEY CLUSTERED  ([Order] ASC)
   );
