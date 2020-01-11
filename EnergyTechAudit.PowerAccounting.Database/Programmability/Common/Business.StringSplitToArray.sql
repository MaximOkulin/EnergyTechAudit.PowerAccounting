CREATE FUNCTION [Business].[StringSplitToArray]
(
      @input NVARCHAR(1024),
      @delimiter VARCHAR(4)
)

RETURNS @Items TABLE 
(
      Item NVARCHAR(1024)
)

AS
BEGIN
  SET @input = REPLACE(@input, '"', '');
  SET @input = REPLACE(@input, '[', '');
  SET @input = REPLACE(@input, ']', '');
  SET @input = REPLACE(@input, ' ', '');

  IF (@delimiter IS NULL OR @delimiter = '')
  BEGIN
    SET @delimiter = ',';
  END
           
  DECLARE @item NVARCHAR(1024)
  DECLARE @itemList NVARCHAR(1024)
  DECLARE @delimIndex INT

  SET @itemList = @input;
  SET @delimIndex = CHARINDEX(@delimiter, @itemList, 0);
      
  WHILE (@delimIndex != 0)
  BEGIN
            SET @item = SUBSTRING(@itemList, 0, @delimIndex)
            INSERT INTO @Items VALUES (@item)
            
            SET @itemList = SUBSTRING(@itemList, @delimIndex + 1, LEN(@itemList) - @delimIndex);
            SET @delimIndex = CHARINDEX(@delimiter, @itemList, 0);
  END 

  IF @item IS NOT NULL
  BEGIN
    SET @item = @itemList
    INSERT INTO @Items VALUES (@item)
  END     
  ELSE 
  BEGIN
    INSERT INTO @Items VALUES (@input)      	
  END
        
  RETURN
END 
GO