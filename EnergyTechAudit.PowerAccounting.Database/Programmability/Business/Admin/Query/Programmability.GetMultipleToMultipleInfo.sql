-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-04-08
-- Description: Анализ связей сущностей с типом связи многие-ко-многим 
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetMultipleToMultipleInfo] 
  @linkName NVARCHAR(128),
  @direction NVARCHAR(32)
AS
BEGIN 

  DECLARE @linkScheme NVARCHAR(128) = [Programmability].[GetSchemaTableByName](@linkName); 

  SET @linkName = REPLACE(@linkName, 'Link', N'|');

  DECLARE @leftName NVARCHAR(128) = LEFT(@linkName, CHARINDEX(N'|', @linkName) - 1);
  DECLARE @rightName NVARCHAR(128) = RIGHT(@linkName, LEN(@linkName) - CHARINDEX(N'|', @linkName));

  DECLARE @leftScheme NVARCHAR(128) = [Programmability].[GetSchemaTableByName](@leftName);
  DECLARE @rightScheme NVARCHAR(128) = [Programmability].[GetSchemaTableByName](@rightName);

  DECLARE @leftNameFull NVARCHAR(128) = CONCAT('[', @leftScheme, '].', '[', @leftName, ']');
  DECLARE @rightNameFull NVARCHAR(128) = CONCAT('[', @rightScheme, '].', '[', @rightName, ']');

  DECLARE @query NVARCHAR(MAX) = '';
  DECLARE @temp NVARCHAR(MAX);

  DECLARE @link NVARCHAR(MAX) = CONCAT(@leftName, 'Link', @rightName);
  SET @linkName = CONCAT('[', @linkScheme, '].', '[', @link, ']');

  DECLARE @queryBase NVARCHAR(MAX) = 

  'SELECT  
    ''{LEFT} -> {RIGHT}'' [Direction],
    [R].[C] [CountId],      
    CONCAT(''{LEFT}Id: '', [R].[LeftId]) [Ld],
    CONCAT(''{RIGHT}Id: '', [R].[RightId]) [Rd],
    [R].[LeftDescription] [LeftDescription],       
    [R].[RightDescription] [RightDescription]
  FROM
    (  
      SELECT         
          COUNT(*) OVER(PARTITION BY [Left].[Id] ORDER BY [Left].[Id]) [C],
          [Left].[Id] [LeftId],
          [Right].[Id] [RightId],
          [Left].[Description] [LeftDescription],
          [Right].[Description] [RightDescription]
      FROM {LINK} [Link] WITH (NOLOCK)   
        INNER JOIN {LEFT_FULL} [Left] WITH (NOLOCK) ON [Link].[{LEFT}Id] = [Left].[Id]
        INNER JOIN {RIGHT_FULL} [Right] WITH (NOLOCK) ON [Link].[{RIGHT}Id] = [Right].[Id]
    ) [R]  WHERE [R].[C] > 1';

  SET @queryBase = REPLACE(@queryBase, '{LINK}', @linkName);

  IF(@direction = 'Both')
  BEGIN
    SET @temp = REPLACE(@queryBase, '{LEFT}', @leftName);
    SET @temp = REPLACE(@temp, '{RIGHT}', @rightName);
    SET @temp = REPLACE(@temp, '{LEFT_FULL}', @leftNameFull);
    SET @temp = REPLACE(@temp, '{RIGHT_FULL}', @rightNameFull);
  
    SET @query = CONCAT(@query, @temp);
    SET @query = CONCAT(@query, ' UNION ALL ');
  
    SET @temp = REPLACE(@queryBase, '{RIGHT}', @leftName);
    SET @temp = REPLACE(@temp, '{LEFT}', @rightName);
    SET @temp = REPLACE(@temp, '{LEFT_FULL}', @rightNameFull);
    SET @temp = REPLACE(@temp, '{RIGHT_FULL}', @leftNameFull);      
  END
  ELSE 
  BEGIN
    IF(@direction = 'Right')
    BEGIN
    	  DECLARE @swap NVARCHAR(128);

        SET @swap = @leftName;
        SET @leftName = @rightName;
        SET @rightName = @swap;

        SET @swap = @leftNameFull;
        SET @leftNameFull = @rightNameFull;
        SET @rightNameFull = @swap;
    END;
         
	  SET @temp = REPLACE(@queryBase, '{LEFT}', @leftName);
    SET @temp = REPLACE(@temp, '{RIGHT}', @rightName);
    SET @temp = REPLACE(@temp, '{LEFT_FULL}', @leftNameFull);
    SET @temp = REPLACE(@temp, '{RIGHT_FULL}', @rightNameFull);     
  END;

  /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
   DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

   INSERT INTO @resultSetName VALUES
	   (1, 'MainData'),		    -- стандартное имя набора для отображения в решетке
	   (2, 'ColumnCaption');	-- набор с необязательной расшифровкой расшифровка имен столбцов наборов
  
   SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	FROM @resultSetName [ResultSetName]

  /* Основная выборка*/
  SET @query = CONCAT(@query, @temp);
  EXEC sp_executesql @query;

  /* Вспомогательная таблица с расшифровками столбцов */
	DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

	INSERT INTO @columnCaption 
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
  VALUES
     ('MainData', 'Direction', 'Направление', 1, 1)
    ,('MainData', 'CountId', 'Количество', 1, 2)
    ,('MainData', 'Ld', 'Левая', 1, 3)     
	  ,('MainData', 'Rd', 'Правая', 1, 4)    
    ,('MainData', 'LeftDescription', 'Наименование левой', 1, 5)
	  ,('MainData', 'RightDescription', 'Наименование правой', 1, 6)	  		
	/**/
END;
