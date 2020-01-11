-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-07-16
-- Description: Выборка учетных записей владельцев квартир 
-- ====================================================================================================

CREATE PROCEDURE [Programmability].[GetFlatHolderAccounts]   
  @userName NVARCHAR(64),
  @organizationId INT,
  @isBeginBuildingWithNewPage BIT
WITH EXECUTE AS OWNER
AS
BEGIN   
   
   SET NOCOUNT ON;
   
   /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
   DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

   INSERT INTO @resultSetName VALUES
    (1, 'ReportParameter'),
	  (2, 'MainData'),		    
	  (3, 'ColumnCaption');	
  
   SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	 FROM @resultSetName [ResultSetName]

  /**/

  /* 2. Формирование таблицы параметрии отчета*/
    DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 
   
    INSERT INTO @reportParameter
        SELECT [Name], [Value]
        FROM
		    (SELECT                            
              CAST([Organization].[Description] AS NVARCHAR(128)) [OrganizationDescription],
              CAST([OrganizationType].[Description] AS NVARCHAR(128)) [OrganizationTypeDescription],
              CAST(@isBeginBuildingWithNewPage AS NVARCHAR(128)) [IsBeginBuildingWithNewPage]

		    FROM [Business].[Organization] [Organization] WITH(NOLOCK)

        INNER JOIN [Dictionaries].[OrganizationType] [OrganizationType] WITH(NOLOCK)		  
          ON [Organization].[OrganizationTypeId] = [OrganizationType].[Id]  
        
        WHERE [Organization].[Id] = @organizationId

        ) [ReportParameterInfo]
        UNPIVOT 
        (  
          [Value] FOR [Name] IN 
          (
            [OrganizationDescription], 
            [OrganizationTypeDescription],
            [IsBeginBuildingWithNewPage]
          ) 
        ) [ReportParameter];
                   
    SELECT 
        [ReportParameter].[Name], 
        [ReportParameter].[Value] 
    FROM @reportParameter [ReportParameter];

    /**/

  /*2.   Основная выборка */
   OPEN SYMMETRIC KEY  [EnergyTechAudit.PowerAccounting.Database.SymmetricKey] 
      DECRYPTION BY CERTIFICATE [EnergyTechAudit.PowerAccounting.Database.Certificate];

   SELECT 
      [Building].[FullAddress] [Address],
      [Placement].[Number] [FlatNumber],

      [UserAdditionalInfo].[LastName] [LastName],
      [UserAdditionalInfo].[FirstName] [FirstName],      
      [UserAdditionalInfo].[Patronimic] [Patronimic],

      [User].[UserName] [Login],
      CONVERT(NVARCHAR(32), DECRYPTBYKEY ([User].[EncryptedPassword])) [Password],
      [Building].[Id] [BuildingId]

      FROM [Admin].[User] [User] WITH (NOLOCK)
      
      INNER JOIN [Admin].[Role] [Role] WITH (NOLOCK)
        ON [User].[RoleId] = [Role].[Id] 
          AND [Role].[Code] = 'HOLDER'

      INNER JOIN [Business].[UserAdditionalInfo] [UserAdditionalInfo] WITH (NOLOCK)
        ON [User].[Id] = [UserAdditionalInfo].[Id]
      
      INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
        ON [Placement].[UserAdditionalInfoId] = [UserAdditionalInfo].[Id]

      INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
        ON [Building].[OrganizationId] = @organizationId 
          AND [Building].[Id] = [Placement].[BuildingId]

  CLOSE SYMMETRIC KEY [EnergyTechAudit.PowerAccounting.Database.SymmetricKey];

  /* 3. Вспомогательная таблица с расшифровками столбцов */
  DECLARE @columnCaption [Programmability].[ColumnCaptionTableType]; 
  
  INSERT INTO @columnCaption 
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
  VALUES  
  	('MainData', 'Address', 'Адрес', 1, 1)
  	,('MainData', 'FlatNumber', 'Квартира', 1, 2)

    ,('MainData', 'LastName', 'Фамилия', 1, 3)
  	,('MainData', 'FirstName', 'Имя', 1, 4)
  	,('MainData', 'Patronimic', 'Oтчество', 1, 5)
  	
  	,('MainData', 'Login', 'Логин', 1, 6)
  	,('MainData', 'Password', 'Пароль', 1, 7)
  	,('MainData', 'BuildingId', 'Ид строения', 1, 8)
  	  
  /**/

   RETURN 0;
END;
