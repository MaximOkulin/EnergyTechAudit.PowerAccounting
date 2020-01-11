-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-03-19
-- Description: Возвращает системное сообщение SQL Server из таблицы sys.message по message_id и language_id 
-- ====================================================================================================

CREATE FUNCTION [Programmability].[GetSysMessage]
(
   @msgId INT,
   @sysLangId INT = 1049
)
RETURNS NVARCHAR(2048)
AS
BEGIN
   
   DECLARE @msg NVARCHAR(2048) = 
   (
      SELECT TOP(1) [text]
            FROM [sys].[messages] [Msg] 
            WHERE [Msg].[message_id] = @msgId AND [Msg].[language_id] = @sysLangId
   );

   RETURN @msg;   
END;
