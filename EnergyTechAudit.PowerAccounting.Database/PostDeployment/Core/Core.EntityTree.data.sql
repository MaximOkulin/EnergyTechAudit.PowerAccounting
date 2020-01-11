

SET IDENTITY_INSERT [Core].[EntityTree] ON;
GO

:setvar xmlQuote "'"

DECLARE @crLf NVARCHAR(2) = CHAR(10) + CHAR(13);


DECLARE @entityTree1 NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\EntityTrees\EntityTree1.xml
$(xmlQuote)

DECLARE @entityTree2 NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\EntityTrees\EntityTree2.xml
$(xmlQuote)

DECLARE @entityTree3 NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\EntityTrees\EntityTree3.xml
$(xmlQuote)

DECLARE @entityTree4 NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\EntityTrees\EntityTree4.xml
$(xmlQuote)

DECLARE @entityTree5 NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\EntityTrees\EntityTree5.xml
$(xmlQuote)

DECLARE @entityTree6 NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\EntityTrees\EntityTree6.xml
$(xmlQuote)

DECLARE @entityTree7 NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\EntityTrees\EntityTree7.xml
$(xmlQuote)

DECLARE @entityTree8 NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\EntityTrees\EntityTree8.xml
$(xmlQuote)

DECLARE @entityTree9 NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\EntityTrees\EntityTree9.xml
$(xmlQuote)

INSERT INTO [Core].[EntityTree] 
	(Id, [Code], [Description], [Template])
VALUES  
	(1,  'EntityTree.BPMd', 'По строениям и помещениям', @entityTree6), --

	(2,  'EntityTree.ApBPMd', 'По точкам доступа, строениям и помещениям', @entityTree5),

	(3,  'EntityTree.BPApMd', 'По строениям, помещениям и точкам доступа', @entityTree4), --

	(4,  'EntityTree.BPU', 'По строениям, помещениям и владельцам', @entityTree3),
	
	(5,  'EntityTree.BApMd', 'По строениям и точкам доступа', @entityTree2),

	(6,  'EntityTree.DBPMd', 'По районам и строениям (устройства)', @entityTree1),

	(7,  'EntityTree.DBPCh', 'По районам и строениям', @entityTree7), --  только канал

      (8,  'EntityTree.OBPCh', 'По организациям', @entityTree8),

      (9,  'EntityTree.BMd', 'Устройства в строениях', @entityTree9);

	
GO

SET IDENTITY_INSERT [Core].[EntityTree] OFF;
GO