CREATE FUNCTION [Programmability].[GetUserLinkChannel]
(
  @userName NVARCHAR(32)  
)
RETURNS @userLinkTable TABLE
(
      [ChannelId] INT,
      [UserId] INT
)
AS
BEGIN
  
  DECLARE @userId INT;
  DECLARE @roleCode NVARCHAR(64);

  SELECT TOP(1) 
      @userId = [User].[Id], 
      @roleCode = [Role].[Code]     
  FROM [Admin].[User] [User] WITH (NOLOCK)
      INNER JOIN [Admin].[Role] [Role] WITH (NOLOCK) ON [User].[RoleId] = [Role].[Id]    
  WHERE [User].[UserName] = @userName;

   
   IF (@roleCode = N'OPERADMIN' OR @roleCode = N'LEADOPERADMIN')
   BEGIN
   -- для OPERADMIN - его натуральные линки
      INSERT INTO @userLinkTable 
      SELECT 
         [UserLink].[ChannelId], 
         [UserLink].[UserId]
      FROM [Business].[UserLinkChannel] [UserLink] WITH (NOLOCK)
      WHERE [UserLink].[UserId] = @userId
   END       
   ELSE IF (@roleCode = N'ADMIN')
   BEGIN
   -- для ADMIN все приборы
      INSERT INTO @userLinkTable 
      SELECT 
         [UserLink].[Id] [ChannelId], 
         NULL [UserId]
      FROM [Business].[Channel] [UserLink] WITH (NOLOCK)
   END;

   RETURN;
END;
