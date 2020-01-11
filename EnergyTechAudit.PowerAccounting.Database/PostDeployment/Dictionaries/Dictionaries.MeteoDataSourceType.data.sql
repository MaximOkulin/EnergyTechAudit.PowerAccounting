SET IDENTITY_INSERT [Dictionaries].[MeteoDataSourceType] ON;

:setvar xmlQuote "'"

DECLARE @openWeatherSettings NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\MeteoDataSourceType\OpenWeatherSettings.json
$(xmlQuote)

INSERT INTO [Dictionaries].[MeteoDataSourceType] ([Id],[Code],[Description],[Settings],[IsUse])
VALUES
     (1, 'OpenWeather', 'OpenWeatherMap', @openWeatherSettings, 0)
GO

SET IDENTITY_INSERT [Dictionaries].[MeteoDataSourceType] OFF;
   