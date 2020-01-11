-- ===================================================================================================
-- Author:  	  Leo
-- Create date: unknown
-- Description: Реализует проверку соответствия между единицами измерения физической величине в таблице [Rules].[MeasurementUnitConverter]
-- ===================================================================================================
CREATE FUNCTION [Programmability].[CheckMeasurementUnitConverter] 
  (
    @physicalParameterId INT,  
    @measurementUnit1Id INT,  
    @measurementUnit2Id INT
  )
RETURNS BIT
AS
BEGIN
	  DECLARE @physicalParameter1Id INT =
      (
      	SELECT [Pp].[Id] FROM [Dictionaries].[MeasurementUnit] [Mu1]
          INNER JOIN [Dictionaries].[PhysicalParameter] [Pp] ON [Mu1].[PhysicalParameterId] = [Pp].[Id]
          WHERE [Mu1].[Id] = @measurementUnit1Id
      );

    DECLARE @physicalParameter2Id INT =
      (
        SELECT [Pp].[Id] FROM [Dictionaries].[MeasurementUnit] [Mu2]
          INNER JOIN [Dictionaries].[PhysicalParameter] [Pp] ON [Mu2].[PhysicalParameterId] = [Pp].[Id]
          WHERE [Mu2].[Id] = @measurementUnit2Id
      );

    DECLARE @result  BIT = 
      (CASE 
        WHEN ((@physicalParameter1Id = @physicalParameterId) AND (@physicalParameter2Id = @physicalParameterId)) 
          THEN 1
          ELSE 0
      END);

    RETURN @result;
END;
