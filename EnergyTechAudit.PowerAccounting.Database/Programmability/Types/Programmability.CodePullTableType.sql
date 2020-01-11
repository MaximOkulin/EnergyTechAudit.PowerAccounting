
CREATE TYPE [Programmability].[CodePullTableType]
AS TABLE   
   (
      [Id] INT NOT NULL PRIMARY KEY,
      [Code] NVARCHAR(64) NOT NULL
   );
