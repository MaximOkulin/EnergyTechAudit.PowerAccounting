CREATE TRIGGER [Business].[ChannelTemplate_AfterUpdate]
   ON [Business].[ChannelTemplate]
   AFTER UPDATE
AS
BEGIN
   SET NOCOUNT ON;

   /* Обновление типа ресурсной системы или типа устройства */
   IF(UPDATE([ResourceSystemTypeId]) OR UPDATE([DeviceId]))
   BEGIN
   /* Снос связаной матрицы сопоставления */
      DELETE [Map] FROM [Business].[ParameterMapDeviceParameter] [Map]
      WHERE [Map].[ChannelTemplateId] IN (SELECT inserted.[Id] FROM inserted)
   END;
END;

GO

DISABLE TRIGGER [Business].[ChannelTemplate_AfterUpdate] ON [Business].[ChannelTemplate];