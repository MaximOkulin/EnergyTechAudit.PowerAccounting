

SET IDENTITY_INSERT [Core].[MapInfoWindow] ON;
GO

SET QUOTED_IDENTIFIER ON;

:setvar xmlQuote "'"

DECLARE @buildingInfoWindow NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\MapInfoWindow\BuildingInfoWindow.xml
$(xmlQuote)

DECLARE @placementInfoWindow NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\MapInfoWindow\PlacementInfoWindow.xml
$(xmlQuote)

DECLARE @channelInfoWindow NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\MapInfoWindow\ChannelInfoWindow.xml
$(xmlQuote)

INSERT INTO [Core].[MapInfoWindow] 
	(Id, Code, [Description], [Template])
VALUES
	(1, 'Building', 'Инфоокно карты для строений', @buildingInfoWindow),
	(2, 'Placement', 'Инфоокно карты для помещений', @placementInfoWindow),
	(3, 'Channel', 'Инфоокно карты для каналов', @channelInfoWindow)
	
GO

SET IDENTITY_INSERT [Core].[MapInfoWindow] OFF;
GO