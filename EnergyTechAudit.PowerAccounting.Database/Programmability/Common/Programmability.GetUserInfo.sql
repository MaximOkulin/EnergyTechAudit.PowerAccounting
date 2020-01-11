CREATE PROCEDURE [Programmability].[GetUserInfo]
  @userName NVARCHAR(64),
  @userId INT OUTPUT,
  @roleCode NVARCHAR(64) OUTPUT
AS
BEGIN
  
  SELECT TOP(1) 
      @userId = [User].[Id], 
      @roleCode = [Role].[Code]     
    FROM [Admin].[User] [User] 
      INNER JOIN [Admin].[Role] [Role] ON [User].[RoleId] = [Role].[Id]    
    WHERE [User].[UserName] = @userName;
  
  RETURN 0

END;