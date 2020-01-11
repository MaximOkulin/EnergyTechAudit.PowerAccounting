SET IDENTITY_INSERT [Dictionaries].[OrganizationType] ON;

INSERT INTO [Dictionaries].[OrganizationType] ([Id], [Code], [Description])
VALUES (1, 'Mc', 'Управляющая компания'), --Managment Company
       (2, 'Hsd', 'Жилищно-эксплуатационное управление'), --Housing Services Department
	   (3, 'Rsc', 'Ресурсоснабжающая компания'), --Resource Supplying Company
	   (4, 'Co', 'Расчетная организация'), -- Calculating Organization
	   (5, 'Mee', 'Мунициапальное педагогическое учреждение'), -- Municipal Education Establishment
	   (6, 'Hsc', 'Жилищный накопительный кооператив'), -- Housing Saving Cooperative
	   (7, 'Ltd', 'Общество с ограниченной ответственностью'),
	   (8, 'Ojsc', 'Открытое акционерное общество'),
	   (9, 'Ho','Товарищество собственников жилья'),-- HomeOwners
	   (10, 'Oo', 'Эксплуатационная организация') -- Operational Organization

SET IDENTITY_INSERT [Dictionaries].[OrganizationType] OFF;