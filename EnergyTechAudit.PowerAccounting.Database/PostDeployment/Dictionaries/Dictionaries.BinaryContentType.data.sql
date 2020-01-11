SET IDENTITY_INSERT [Dictionaries].[BinaryContentType] ON;
GO

INSERT INTO [Dictionaries].[BinaryContentType] ([Id], [Code], [Description])
VALUES
  (1, 'Pdf',  'application/pdf'),
  (2, 'Docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),  
  (3, 'Xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
  (4, 'Pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation'),
  (5, 'Rtf',  'application/rtf'),
  (6, 'Xps',  'application/vnd.ms-xpsdocument'),
  (7, 'Xml',  'application/soap+xml'),
  (8, 'Jpeg', 'image/jpeg'),
  (9, 'Png', 'image/png'),  
  (10, 'Bmp', 'image/bmp'),
  (11, 'Svg', 'image/svg+xml'),
  (12, 'Xml', 'text/xml'),
  (13, 'Txt', 'text/plain'),
  (14, 'Html', 'text/html'),
  (15, 'Mp3', 'audio/mpeg'),
  (16, 'Mp4', 'video/mp4')

GO

SET IDENTITY_INSERT [Dictionaries].[BinaryContentType] OFF;
GO