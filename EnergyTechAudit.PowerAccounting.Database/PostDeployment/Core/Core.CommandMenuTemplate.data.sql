

SET IDENTITY_INSERT [Core].[CommandMenuTemplate] ON;
GO

:setvar xmlQuote "'"

DECLARE @crLf NVARCHAR(2) = CHAR(10) + CHAR(13);
DECLARE @empty NVARCHAR(1) = '';

DECLARE @formCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\FormCommandMenu.xml
$(xmlQuote)

SET @formCommandMenu = REPLACE (@formCommandMenu, @crLf, @empty);

DECLARE @alternateHeaderCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\AlternateHeaderCommandMenu.xml
$(xmlQuote)

SET @alternateHeaderCommandMenu = REPLACE (@alternateHeaderCommandMenu, @crLf, @empty);

DECLARE @gridCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\GridCommandMenu.xml
$(xmlQuote)

SET @gridCommandMenu = REPLACE (@gridCommandMenu, @crLf, @empty);

DECLARE @pivotCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\PivotCommandMenu.xml
$(xmlQuote)

SET @pivotCommandMenu = REPLACE (@pivotCommandMenu, @crLf, @empty);

DECLARE @queryCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\QueryCommandMenu.xml
$(xmlQuote)

SET @queryCommandMenu = REPLACE (@queryCommandMenu, @crLf, @empty);

DECLARE @reportCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\ReportCommandMenu.xml
$(xmlQuote)

SET @reportCommandMenu = REPLACE (@reportCommandMenu, @crLf, @empty);


DECLARE @readOnlyFormCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\ReadOnlyFormCommandMenu.xml
$(xmlQuote)

DECLARE @linkedEntityFormCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\LinkedEntityFormCommandMenu.xml
$(xmlQuote)

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

DECLARE @entityTreeCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\EntityTreeCommandMenu.xml
$(xmlQuote)

SET @entityTreeCommandMenu = REPLACE (@entityTreeCommandMenu, @crLf, @empty);

DECLARE @helpTreeViewCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\HelpTreeViewCommandMenu.xml
$(xmlQuote)

SET @helpTreeViewCommandMenu = REPLACE (@helpTreeViewCommandMenu, @crLf, @empty);

DECLARE @adminLayoutHeaderCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\AdminLayoutHeaderCommandMenu.xml
$(xmlQuote)

SET @adminLayoutHeaderCommandMenu = REPLACE (@adminLayoutHeaderCommandMenu, @crLf, @empty);


DECLARE @mapCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\MapCommandMenu.xml
$(xmlQuote)

SET @mapCommandMenu = REPLACE (@mapCommandMenu, @crLf, @empty);

DECLARE @chartCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\ChartCommandMenu.xml
$(xmlQuote)

SET @chartCommandMenu = REPLACE (@chartCommandMenu, @crLf, @empty);

DECLARE @dashboardCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\DashboardCommandMenu.xml
$(xmlQuote)

SET @dashboardCommandMenu = REPLACE (@dashboardCommandMenu, @crLf, @empty);


DECLARE @sendMailUserDialogCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\SendMailUserDialogCommandMenu.xml
$(xmlQuote)

SET @sendMailUserDialogCommandMenu = REPLACE (@sendMailUserDialogCommandMenu, @crLf, @empty);

DECLARE @entityTreeContextCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\EntityTreeContextCommandMenu.xml
$(xmlQuote)

SET @entityTreeContextCommandMenu = REPLACE (@entityTreeContextCommandMenu, @crLf, @empty);

DECLARE @measurementDeviceGridContextCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\MeasurementDeviceGridContextCommandMenu.xml
$(xmlQuote)

SET @measurementDeviceGridContextCommandMenu = REPLACE (@measurementDeviceGridContextCommandMenu, @crLf, @empty);

DECLARE @dashboardDiagrammDialogCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\DashboardDiagrammDialogCommandMenu.xml
$(xmlQuote)

SET @dashboardDiagrammDialogCommandMenu = REPLACE (@dashboardDiagrammDialogCommandMenu, @crLf, @empty);


DECLARE @dashboardDiagrammDialogContextCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\DashboardDiagrammDialogContextCommandMenu.xml
$(xmlQuote)

SET @dashboardDiagrammDialogContextCommandMenu = REPLACE (@dashboardDiagrammDialogContextCommandMenu, @crLf, @empty);

DECLARE @mapDiagrammDialogCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\MapDiagrammDialogCommandMenu.xml
$(xmlQuote)

SET @mapDiagrammDialogCommandMenu = REPLACE (@mapDiagrammDialogCommandMenu, @crLf, @empty);


DECLARE @mapDiagrammDialogContextCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\MapDiagrammDialogContextCommandMenu.xml
$(xmlQuote)

SET @mapDiagrammDialogContextCommandMenu = REPLACE (@mapDiagrammDialogContextCommandMenu, @crLf, @empty);


DECLARE @adminAreaNavBarContextCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\AdminAreaNavBarContextCommandMenu.xml
$(xmlQuote)

SET @adminAreaNavBarContextCommandMenu = REPLACE (@adminAreaNavBarContextCommandMenu, @crLf, @empty);


DECLARE @flatHolderDashboardCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\FlatHolderDashboardCommandMenu.xml
$(xmlQuote)

SET @flatHolderDashboardCommandMenu = REPLACE (@flatHolderDashboardCommandMenu, @crLf, @empty);

DECLARE @formJournalDialogMultipleToMultipleLinkEntityCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\FormJournalDialogMultipleToMultipleLinkEntityCommandMenu.xml
$(xmlQuote)

SET @formJournalDialogMultipleToMultipleLinkEntityCommandMenu = REPLACE (@formJournalDialogMultipleToMultipleLinkEntityCommandMenu, @crLf, @empty);

DECLARE @dynamicParameterValueParametricDialogCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\DynamicParameterValueParametricDialogCommandMenu.xml
$(xmlQuote)

SET @dynamicParameterValueParametricDialogCommandMenu = REPLACE (@dynamicParameterValueParametricDialogCommandMenu, @crLf, @empty);


DECLARE @formWithCreateLinkedEntityCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\FormWithCreateLinkedEntityCommandMenu.xml
$(xmlQuote)

SET @formWithCreateLinkedEntityCommandMenu = REPLACE (@formWithCreateLinkedEntityCommandMenu, @crLf, @empty);

DECLARE @dashboardIndividualAccountingCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\DashboardIndividualAccountingCommandMenu.xml
$(xmlQuote)

SET @dashboardIndividualAccountingCommandMenu = REPLACE (@dashboardIndividualAccountingCommandMenu, @crLf, @empty);

DECLARE @briefcaseCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\BriefcaseCommandMenu.xml
$(xmlQuote)

SET @briefcaseCommandMenu = REPLACE (@briefcaseCommandMenu, @crLf, @empty);

DECLARE @emergencySituationGridViewCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\EmergencySituationGridViewCommandMenu.xml
$(xmlQuote)

SET @emergencySituationGridViewCommandMenu = REPLACE (@emergencySituationGridViewCommandMenu, @crLf, @empty);

DECLARE @simpleGridViewCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\SimpleGridViewCommandMenu.xml
$(xmlQuote)

SET @simpleGridViewCommandMenu = REPLACE (@simpleGridViewCommandMenu, @crLf, @empty);

DECLARE @formJournalDialogServerTimeEntityCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\FormJournalDialogServerTimeEntityCommandMenu.xml
$(xmlQuote)

SET @formJournalDialogServerTimeEntityCommandMenu = REPLACE (@formJournalDialogServerTimeEntityCommandMenu, @crLf, @empty);

DECLARE @formJournalDialogCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\FormJournalDialogCommandMenu.xml
$(xmlQuote)

SET @formJournalDialogCommandMenu = REPLACE (@formJournalDialogCommandMenu, @crLf, @empty);

DECLARE @codeMirrorEditorDialogCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\CodeMirrorEditorDialogCommandMenu.xml
$(xmlQuote)

SET @codeMirrorEditorDialogCommandMenu = REPLACE (@codeMirrorEditorDialogCommandMenu, @crLf, @empty);

DECLARE @mnemoschemeImageDialogCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\MnemoschemeImageDialogCommandMenu.xml
$(xmlQuote)

SET @mnemoschemeImageDialogCommandMenu = REPLACE (@mnemoschemeImageDialogCommandMenu, @crLf, @empty);

DECLARE @dashboardPlacementLevelMnemoschemeCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\DashboardPlacementLevelMnemoschemeCommandMenu.xml
$(xmlQuote)

SET @dashboardPlacementLevelMnemoschemeCommandMenu = REPLACE (@dashboardPlacementLevelMnemoschemeCommandMenu, @crLf, @empty);

DECLARE @formPluginCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\FormPluginCommandMenu.xml
$(xmlQuote)

SET @formPluginCommandMenu = REPLACE (@formPluginCommandMenu, @crLf, @empty);

DECLARE @adminAreaMiniboardDialogCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\AdminAreaMiniboardDialogCommandMenu.xml
$(xmlQuote)

SET @adminAreaMiniboardDialogCommandMenu = REPLACE (@adminAreaMiniboardDialogCommandMenu, @crLf, @empty);

DECLARE @channelDeviceExtendedInfoViewCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\ChannelDeviceExtendedInfoViewCommandMenu.xml
$(xmlQuote)

SET @channelDeviceExtendedInfoViewCommandMenu = REPLACE (@channelDeviceExtendedInfoViewCommandMenu, @crLf, @empty);

DECLARE @emergencySituationMobileGridViewCommandMenu NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\CommandMenus\EmergencySituationMobileGridViewCommandMenu.xml
$(xmlQuote)

SET @emergencySituationMobileGridViewCommandMenu = REPLACE (@emergencySituationMobileGridViewCommandMenu, @crLf, @empty);


INSERT INTO [Core].[CommandMenuTemplate] (Id, [Code], [Description], [Template])
VALUES

  (47, 'EmergencySituationMobileGridView.CommandMenu', 'Меню расширителя списка каналов в мобильном клиенте', @emergencySituationMobileGridViewCommandMenu),

  (46, 'ChannelDeviceExtendedInfoView.CommandMenu', 'Меню расширителя списка каналов в мобильном клиенте', @channelDeviceExtendedInfoViewCommandMenu),

  (45, 'AdminAreaMiniboardDialog.CommandMenu',  'Меню миниборда на форме каналов', @adminAreaMiniboardDialogCommandMenu),

  (44, 'FormPlugin.CommandMenu', 'Меню плагина форм', @formPluginCommandMenu),

  (43, 'DashboardPlacementLevelMnemoscheme.CommandMenu', 'Меню приборной панели мнемосхемы уровня помещения', @dashboardPlacementLevelMnemoschemeCommandMenu),

  (42, 'MnemoschemeImageDialog.CommandMenu', 'Меню окна просмотра мнемосхемы', @mnemoschemeImageDialogCommandMenu),

  (41, 'CodeMirrorDialogEditor.CommandMenu', 'Меню редактора с подсветкой', @codeMirrorEditorDialogCommandMenu),

  (40, 'FormJournalDialog.CommandMenu', 'Командное меню журнала', @formJournalDialogCommandMenu),

  (39, 'FormJournalDialogServerTimeEntity.CommandMenu', 'Командное меню журнала сущности IServerTimeSignatureEntity', @formJournalDialogServerTimeEntityCommandMenu),

  (38, 'SimpleGridView.CommandMenu', 'Командное меню простой решетки', @simpleGridViewCommandMenu),

  (37, 'EmergencySituationGridView.CommandMenu', 'Командное меню решетки нештатных ситуаций ', @emergencySituationGridViewCommandMenu),

  (36, 'Briefcase.CommandMenu', 'Командное меню портфелей', @briefcaseCommandMenu),

  (35, 'DashboardIndividualAccounting.CommandMenu', 'Командное меню виджета индивидуального учета',  @dashboardIndividualAccountingCommandMenu),

  (34, 'FormWithCreateLinkedEntity.CommandMenu', 'Командное меню формы при создании связанной записи',  @formWithCreateLinkedEntityCommandMenu),

  (33, 'DynamicParameterValueParametricDialog.CommandMenu', 'Командное меню параметрика динамических параметров',  @dynamicParameterValueParametricDialogCommandMenu),

  (32, 'FormJournalDialogMultipleToMultipleLinkEntity.CommandMenu', 'Командное меню журнала форм для ссылочных сущностей', @formJournalDialogMultipleToMultipleLinkEntityCommandMenu),

  (31, 'FlatHolderDashboard.CommandMenu', 'Командное меню приборной панели собственника помещений', @flatHolderDashboardCommandMenu),

  (30, 'AdminAreaNavBarContext.CommandMenu', 'Контекстное меню панели навигации',  @adminAreaNavBarContextCommandMenu), 

  (29, 'MapDiagrammDialogContext.CommandMenu', 'Контекстное меню диагового окна сводных диаграмм карты',  @mapDiagrammDialogContextCommandMenu), 

  (28, 'MapDiagrammDialog.CommandMenu', 'Командное меню диалогового окна сводных диаграмм карты',  @mapDiagrammDialogCommandMenu), 

  (27, 'DashboardDiagrammDialogContext.CommandMenu', 'Контекстное меню диагового окна диаграмм приборной панели',  @dashboardDiagrammDialogContextCommandMenu), 

  (26, 'DashboardDiagrammDialog.CommandMenu', 'Командное меню диалогового окна диаграмм приборной панели',  @dashboardDiagrammDialogCommandMenu), 

  (25, 'MeasurementDeviceGridContext.CommandMenu', 'Контектное меню решетки Измерительные устройства в КОА', @measurementDeviceGridContextCommandMenu),

  (24, 'EntityTreeContext.CommandMenu', 'Контектное меню сущностного дерева в КОА', @entityTreeContextCommandMenu),
   
	(23, 'SendMailUserDialog.CommandMenu', 'Командное меню диалогового окна отправки сообщения пользователю', @sendMailUserDialogCommandMenu),

	(22, 'Dashboard.CommandMenu', 'Командное меню панели', @dashboardCommandMenu),

	(21, 'Chart.CommandMenu', 'Командное меню диаграммы', @chartCommandMenu),

	(20, 'Map.CommandMenu', 'Командное меню карты консоли оператора', @mapCommandMenu),

	(19, 'AdminLayoutHeader.CommandMenu', 'Командное меню заголовка конфигуратора', @adminLayoutHeaderCommandMenu),

	(18, 'HelpTreeView.CommandMenu', 'Командное меню дерева справки', @helpTreeViewCommandMenu),

	(13, 'EntityTree.CommandMenu', 'Командное меню дерева сущностей', @entityTreeCommandMenu),

	(9, 'CommandMenu.ReadOnlyForm', 'Меню форм для чтения', @readOnlyFormCommandMenu),

	(17, 'CommandMenu.LinkedEntityForm', 'Меню форм для чтения', @linkedEntityFormCommandMenu),

	(8, 'CommandMenu.Form', 'Командное меню форм', @formCommandMenu),

	(7, 'CommandMenu.Admin.Altern', 'Альтернативное меню заголовка конфигуратора',	@alternateHeaderCommandMenu),

	(1, 'CommandMenu.Grid', 'Командное меню решетки словаря', @gridCommandMenu),

	(2, 'CommandMenu.Report', 'Командное меню отчетов', @reportCommandMenu),

	(3, 'CommandMenu.Query', 'Командное меню решетки запроса', @queryCommandMenu),

	(4, 'CommandMenu.Pivot', 'Командное меню сводных таблиц', @pivotCommandMenu)

GO
SET IDENTITY_INSERT [Core].[CommandMenuTemplate] OFF;
GO