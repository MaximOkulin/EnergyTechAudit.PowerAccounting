
CREATE PROCEDURE [Programmability].[GetPhysicalParameter]
	@physicalParameterId INT NULL
AS
BEGIN
	SET @physicalParameterId = IIF(@physicalParameterId = 0, NULL, @physicalParameterId);
	
   /*1. Формирование имен резалтсетов для отчета*/
   DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
   INSERT INTO @resultSetName VALUES 
      (1, 'MainData');

   SELECT [ResultSetName].[Order], [ResultSetName].[Name] FROM @resultSetName [ResultSetName];
   /**/

   /* 2. Основная выборка */
   SELECT 
      [Unit].[Id]
      ,[Unit].[Code]
		,[Unit].[Description]
		,[Parameter].[Description] [PhysicalParameter]
      ,[Parameter].[Id] [PhysicalParameterId]

   FROM [Dictionaries].[MeasurementUnit] [Unit]

   INNER JOIN Dictionaries.PhysicalParameter Parameter	
      ON [Unit].[PhysicalParameterId] = [Parameter].[Id] 

   WHERE [Parameter].[Id] = @physicalParameterId OR @physicalParameterId IS NULL;
   /**/
END;
