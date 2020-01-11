
 ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_DeviceId_Dictionaries_Device_Id] 
      FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id])

 ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_AccessPointId_Business_AccessPointId] 
      FOREIGN KEY ([AccessPointId]) REFERENCES  [Business].[AccessPoint]([Id]) ON DELETE CASCADE;

 ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_TypeConnectionId_Dictionaries_TypeConnection_Id] 
  FOREIGN KEY ([TypeConnectionId]) REFERENCES [Dictionaries].[TypeConnection]([Id])

  ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_LastStatusConnectionId_Dictionaries_StatusConnection_Id] 
      FOREIGN KEY ([LastStatusConnectionId]) REFERENCES [Dictionaries].[StatusConnection]([Id])

ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_ParityId_Dictionaries_Parity_Id] 
  FOREIGN KEY ([ParityId]) REFERENCES [Dictionaries].[Parity]([Id])

ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_BaudId_Dictionaries_Baud_Id] 
  FOREIGN KEY ([BaudId]) REFERENCES [Dictionaries].[Baud]([Id])

 ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_ComPortId_Dictionaries_ComPort_Id] 
  FOREIGN KEY ([ComPortId]) REFERENCES [Dictionaries].[ComPort]([Id])

ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_StopBitId_Dictionaries_StopBit_Id] 
  FOREIGN KEY ([StopBitId]) REFERENCES [Dictionaries].[StopBit]([Id])

ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_DataId_Dictionaries_DataBit_Id]
   FOREIGN KEY ([DataBitId]) REFERENCES [Dictionaries].[DataBit]([Id])

ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_PortTypeId_Dictionaries_PortType_Id]
  FOREIGN KEY ([PortTypeId]) REFERENCES [Dictionaries].[PortType]([Id])

ALTER TABLE [Business].[MeasurementDevice]
    ADD CONSTRAINT [FK_Business_MeasurementDevice_HubId_Business_Hub_Id] 
  FOREIGN KEY ([HubId]) REFERENCES [Business].[Hub]([Id]) ON DELETE CASCADE

  ALTER TABLE [Business].[MeasurementDevice]
    ADD  CONSTRAINT [FK_Business_MeasurementDevice_ProtocolSubTypeId_Dictionaries_ProtocolSubType_Id] 
	FOREIGN KEY ([ProtocolSubTypeId]) REFERENCES [Dictionaries].[ProtocolSubType]([Id])