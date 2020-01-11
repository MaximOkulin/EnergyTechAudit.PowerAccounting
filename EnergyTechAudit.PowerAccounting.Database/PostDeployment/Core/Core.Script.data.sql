SET IDENTITY_INSERT [Core].[Script] ON;

SET QUOTED_IDENTIFIER ON;

:setvar xmlQuote "'"

DECLARE @entityTree1 NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\EntityTrees\EntityTree1.py
$(xmlQuote)

DECLARE @entityTree2 NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\EntityTrees\EntityTree2.py
$(xmlQuote)

DECLARE @entityTree3 NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\EntityTrees\EntityTree3.py
$(xmlQuote)

DECLARE @entityTree4 NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\EntityTrees\EntityTree4.py
$(xmlQuote)

DECLARE @entityTree5 NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\EntityTrees\EntityTree5.py
$(xmlQuote)

DECLARE @entityTree6 NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\EntityTrees\EntityTree6.py
$(xmlQuote)

DECLARE @entityTree7 NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\EntityTrees\EntityTree7.py
$(xmlQuote)

DECLARE @entityTree8 NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\EntityTrees\EntityTree8.py
$(xmlQuote)

DECLARE @entityTree9 NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\EntityTrees\EntityTree9.py
$(xmlQuote)

INSERT INTO [Core].[Script] ([Id], [Code], [Language], [Template])
VALUES       	
	(1, NULL, 'Python', @entityTree1),	
	(2, NULL, 'Python', @entityTree2),	
	(3, NULL, 'Python', @entityTree3),	
	(4, NULL, 'Python', @entityTree4),	
	(5, NULL, 'Python', @entityTree5),	
	(6, NULL, 'Python', @entityTree6),	
	(7, NULL, 'Python', @entityTree7),
	(8, NULL, 'Python', @entityTree8),
	(9, NULL, 'Python', @entityTree9)

GO

DECLARE @measurementDeviceListForOperAdminQueryExtender NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Script\Python\QueryExtenders\MeasurementDeviceListForOperAdmin.py
$(xmlQuote)

INSERT INTO [Core].[Script] ([Id], [Code], [Language], [Template])
VALUES       		
	(10, 'MeasurementDeviceListForOperAdminQueryExtender', 'Python', @measurementDeviceListForOperAdminQueryExtender)
    
GO

SET QUOTED_IDENTIFIER ON;

SET IDENTITY_INSERT [Core].[Script] OFF;
GO