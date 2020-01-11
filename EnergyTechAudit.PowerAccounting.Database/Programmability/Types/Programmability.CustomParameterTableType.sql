
CREATE TYPE [Programmability].[CustomParameterTableType]
AS TABLE 
   (
      [Name] NVARCHAR(128) NOT NULL,
      [Value] NVARCHAR(128) NULL
   );

