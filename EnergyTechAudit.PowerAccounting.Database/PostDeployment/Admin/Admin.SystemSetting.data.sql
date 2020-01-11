
SET IDENTITY_INSERT [Admin].[SystemSetting]  ON;

:setvar xmlQuote "'"

DECLARE @template NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\SystemSettings\Template.json
$(xmlQuote)

INSERT INTO [Admin].[SystemSetting] 
(
  [Id],  
  [SystemName],

  [EmailAdminAddress],

  [EmailAddress],
  [EmailSmtpServer],
  [EmailSmtpPort],
  [EmailUserName],
  [EmailPassword],
  [EmailEnableSsl],

	[CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate],
	[CustomData]
)
VALUES
	(
    1,
    'Power Accounting System',

    'leonetx@yandex.ru',

    'eta.development.team@yandex.ru',
    'smtp.yandex.ru',
    587,
    'eta.development.team@yandex.ru',
    'gh8nc3pe4',
    1,
    'sys', 'sys', '2015-01-01', '2015-01-01',
	@template
  );
	
	
SET IDENTITY_INSERT [Admin].[SystemSetting]  OFF;
