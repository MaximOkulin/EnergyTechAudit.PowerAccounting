CREATE PROCEDURE [WebApi].[GetSchema]
(
  @userName NVARCHAR(64),
  @actionUid UNIQUEIDENTIFIER OUTPUT
)
AS
BEGIN
   SET NOCOUNT ON;
   DECLARE @uid UNIQUEIDENTIFIER = NEWID();
   SET @actionUid = @uid;

   DECLARE @schema XML = 
   (
    SELECT TOP(1) CONVERT(XML, [Binary].[Data])
    FROM [Core].[Binary] [Binary] 
    WHERE [Binary].[Id] = 1000
   );

   SELECT @schema FOR XML PATH('');
END;
GO