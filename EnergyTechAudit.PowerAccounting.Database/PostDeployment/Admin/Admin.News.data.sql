

SET IDENTITY_INSERT [Admin].[News] ON
GO

INSERT [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]) 

VALUES

(2, NULL, N'Старт разработки проекта', N'Старт разработки проекта', '2014-04-25 08:30:00.000', N'Стартовала разработка системы комплексной диспетчеризации широкого спектра приборов учета, установливаемых в узлах внутридомового и квартирного учета . Разработка ведется группой сертифицированных разработчиков компании ЭнергоТехАудит (г. Казань) с использованием современных технологий разработки программного обеспечения, которые включают в себя ультрасовременную IDE Microsoft Visual Studio 2013, Microsoft SQL Server 2014, компоненты DevExpress, генератор отчетов FastReport. По замыслу разработчиков, система позволит более эффективно учитывать и расходовать ресурсы, предоставляемые гражданам Российской Федерации.'
, 1, 0, 'sa', 'sa', '20150818', '20150818'),

(4, NULL, N'Atmel и Arduino представили микроконтроллерную плату Arduino Zero', N'Atmel и Arduino представили микроконтроллерную плату Arduino Zero', '2014-06-15 08:30:00.000', N'Сообщество Arduino совместно с компанией Atmel разработало новую простую и мощную микроконтроллерную плату Arduino Zero, которая является 32-битным расширением платформы Arduino Uno и, благодаря своим возможностям, может по праву считаться отладочной платой. Разработка Arduino Zero велась с целью обеспечения инженеров и творческих разработчиков потенциалом для реализации действительно инновационных идей и приложений в сфере Интернета вещей, развития технологии носимой электроники (wearable technology), высокотехнологичных систем автоматизации и роботов. Первые прототипы плат будут представлены на выставке Maker Faire Bay Area 2014 в Сан-Матео в павильонах Atmel, Arduino и ARM.'
, 2, 0, 'sa', 'sa', '20150818', '20150818'),

(5, NULL, N'Федеральный закон №261 об обязательной установке газовых счетчиков', N'Федеральный закон №261 об обязательной установке газовых счетчиков', '2014-06-13 14:35:00.000', N'Вступил в силу Федеральный закон №261 об обязательной установке газовых счетчиков. Федеральный закон Российской Федерации от 23 ноября 2009 г. N 261-ФЗ "Об энергосбережении и о повышении энергетической эффективности и о внесении изменений в отдельные законодательные акты Российской Федерации " 
						1. Перед покупкой счетчика позвоните в специализированную организацию (ООО "ГазСервис"): вам помогут определить тип счетчика, подходящий для установки. 
						2. Купив счетчик, сделайте заявку на его установку в специализированную организацию (ООО "ГазСервис"). 
					    3. Когда специалист установит счетчик, подпишите акт приемки выполненных работ. 
					    4. С полученным документом обратитесь в ресурсоснабжающую организацию (ООО "ГазСервис") 
              для опломбировки установленного счетчика (день выезда специалиста назначается по договоренности) 
              и внесения соответствующих изменений в абонентскую базу данных поставщика газа.'
, 3, 0, 'sa', 'sa', '20150818', '20150818'),

(6, NULL, N'Внедрение Danfoss ECL Comfort 210/310', N'Внедрение Danfoss ECL Comfort 210/310', '2015-04-10 11:30:00.000', N'Добавлена возможность просмотра в приборной панели текущих мгновенных параметров погодных регуляторов Danfoss ECL Comfort 210/310'
, 4, 0, 'sa', 'sa', '20150818', '20150818'),

(7, NULL, N'Аутентичность при входе в приложение', N'Аутентичность при входе в приложение', '2015-04-10 12:00:00.000', N'<p><b style="color:darkred">Внимание!</b> 
                      С целью обеспечения аутентичности работы приложения Power Accounting, ведения журнала активности и логирования нештаных ситуаций,
                       убедительная просьба осуществлять логический вход с <b>собственной учетной записью!</b></p>
                       <p>Для создания учетной записи и привязки к ней диспетчеризируемых устройств обратитесь к администратору системы.</p>
                       <br/><p>С <b>уважением</b>, группа разработчиков компании <b>ЭнергоТехАудит</b>.</p>'
, 5, 0, 'sa', 'sa', '20150818', '20150818'),

(8, NULL, N'Присоединение пользователей к каналам', N'Присоединение пользователей к каналам', '2015-06-08 11:00:00.000', N'<p><b style="color:darkred">Внимание!</b> 
					   <p>С настоящего момента назначение прав на доступ к измерительной информации в консоли операционного администратора
					   будет выполняться на основе привязки <b>измерительного канала</b> к учетной записи пользователя в роли "Операционный администратор"</p>
					   <p>Данный подход позволяет распределить права доступа в рамках одного прибора по типу ресурсной системы. Например, каналы прибора ВКТ-7,
					   обслуживающего три различных ресурсных системы: ГВС, ЦО и ХВС, могут независимо просматриваться различными пользователями.</p>
					   <br/><p>С <b>уважением</b>, группа разработчиков компании <b>ЭнергоТехАудит</b>.</p>'
, 6, 0, 'sa', 'sa', '20150818', '20150818'),

(9, NULL, N'Доска объявлений доступна в консоле операционного администратора', N'Доска объявлений доступна в консоле операционного администратора', '2015-08-08 19:15:00.000', N'<p>Доска объявлений предназначена для информирования пользователей о внедрении новых функциональных возможностей, критически важных обновлениях и предстоящих мероприятиях по администрированию системы. </p>'
, 9, 0, 'sa', 'sa', '20150818', '20150818'),

(10, NULL, N'Цветовая подсветка маркеров карты',  N'Цветовая подсветка маркеров карты', '2015-08-10 13:00:00.000', N'<p style=''margin-bottom: 15px''>Теперь карты в консоле операционного администратора поддерживают цветовую подсветку маркеров строений в соответствии с состоянием связи точек доступа и измерительных устройств связанных со строением.</p>
<p>
<ul style=''list-style-position: inside; list-style-type: none; vertical-align: center''>
<li><p style=''margin-left: 10px''><img src=''/Content/Images/Gmap/SmallMarkers/green.png'' /> Все точки доступа и измерительные устройства на связи</p></li>

<li><p style=''margin-left: 10px''><img src=''/Content/Images/Gmap/SmallMarkers/yellow.png'' />По меньшей мере одна точка доступа или измерительное устройво  не вышли на связь в ходе последнего сеанса опроса </p></li>

<li><p style=''margin-left: 10px''><img src=''/Content/Images/Gmap/SmallMarkers/red.png'' /> Отсутствует связь со всеми точками доступа</p></li>
</ul>
</p> ', 10, 0, 'sa', 'sa', '20150818', '20150818'),

(11, NULL, N'Пространственная кластеризация маркеров карты', N'Пространственная кластеризация маркеров карты', '2015-08-10 15:00:00.000', N'<p style=''margin-bottom: 15px''>В картах реализовано переключение в режим пространственной кластеризации маркеров. В данном режиме отображения маркеры строений группируются в визуальные кластеры в зависимости от текущего масштаба и <a href="javascript:;" data-core-entity-id="12" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image> настроек</a> сетки кластеризации.</p>'
, 11, 0,'sa', 'sa', '20150818', '20150818'),

(12, NULL, N'Удаление точки c недостоверными данными на графике', N'Удаление точки c недостоверными данными на графике', '2015-08-12 15:20:00.000', N'<p style=''text-indent: 20px''>В простроителе графиков параметров прибора в приборной панели реализована функция <span style=''color: darkred''>удаления выбранной точки</span>. Данная возможность  требуется для устранения выбросов на графике, когда с точкой на графике ассоциированы <a href="javascript:;" data-core-entity-id="16" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>некорректные данные</a> полученные от прибора. В результате операции удаления <b>выделенной точки</b> выполняется удаление кортежа связанных архивных значений из таблицы БД с типом периода "Мгновенное значение" и "Текущее итоговое значение" и динамическое перестроение <a href="javascript:;" data-core-entity-id="15" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>скорректированного графика</a>. </p> 

<p style=''text-indent: 20px''><span style=''color: darkred''>Обратите внимание</span>, что удаление точек на графике приводит к безвозвратной потере небольшого количества хранимых в БД мгновенных и текущих итоговых архивных данных из кортежа связанных с временной сигнатурой параметров  (порядка 15-35 значений). </p> 

<p style=''margin-top:10px;''><span style=''color: darkred''>Будьте внимательны, не удаляйте корректные данные! Операция подвергается протоколированию.</span></p>

', 14, 0, 'sa', 'sa', '20150818', '20150818'),

(13, NULL, N'Проверка связи с ВКТ-7', N'Проверка связи с ВКТ-7', '2015-08-13 10:55:00.000', N'<p style=''text-indent: 20px''>Проверка соединения  с тепловычислителем ВКТ-7 теперь наряду с заводским номером, качеством соединения и информацией о задействованных тепловых вводах, также выдает информацию <a href="javascript:;" data-core-entity-id="18" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>о версии ПО прибора</a>, отчетном дне и текущем времени прибора.</p> '
, 19, 0, 'sa', 'sa', '20150818', '20150818'),

(44, NULL, N' Создание и редактирование температурного графика', N' Создание и редактирование температурного графика', '2016-11-08 16:49:37.197', N'<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 500;''>
  	Реализована возможность создания, редактирования и присоединения температурного графика к ресурсоснабжающей организации
	</i>
</p>
<p style=''line-height: 1.5; text-indent: 20px;''>
  Температурный график является разновидностью динамического параметра, присоединяемого к основной целевой сущности, в данном случае, к экземпляру сущности "Организация". К конкретной записи (ресурсоснабжающей организации) можно присоединить два температурных графика: "Температурный график для подающего трубопровода" и "Температурный график для обратного трубопровода". Значения температурных графиков задаются в виде <a href="javascript:;" data-core-entity-id="2016" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>таблицы</a>, в которой приводятся в соответствие значения температуры наружнего воздуха и температры теплоносителя в подающем и отратном трубопроводе теплосистемы.
</p>
<p style=''line-height: 1.5; text-indent: 20px; margin-bottom: 5px; text-align: justify''>
  Создание и присоединение к ресурсоснабжающей организации температурных графиков позволит задействовать отслеживание нештатных ситуаций, связанных с отклонением температуры теплоносителя от значений определенных в соответствиющем температурном графике.
</p>  ', 2015, 0, N'sa', N'sa', '20161108', '20161109')

GO
SET IDENTITY_INSERT [Admin].[News] OFF
GO

SET IDENTITY_INSERT [EnergyTechAudit.PowerAccounting.Database].Admin.News ON
GO
EXEC(N'INSERT [EnergyTechAudit.PowerAccounting.Database].Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (45, NULL, N''Развитие функциональных возможностей мнемосхем'', N''Развитие функциональных возможностей мнемосхем'', ''2016-11-09 16:45:24.987'', N''
<script>
  (function()
   {    	
  		jQuery(document).ready(function()
  		{	          		
          	var jQContext = jQuery(".admin-area-news-body[data-core-entityTypeName=''''News''''][data-core-entityId=''''45'''']");
          	jQuery(".admin-area-news-body-caption", jQContext).prepend
            (
				jQuery("i[data-core-entity-id=''''2010'''']", jQContext).show()
            );
          
    		jQuery("td.admin-area-news-body-image", jQContext).append
            (
              	jQuery("img[data-core-entity-id=''''2019'''']", jQContext).show()
            );          
  		});  
  })();  
</script>
<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-id="2018" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?id=2018"/>


<!--кэш картинок-->
<i style="margin-right: 20px; float: left;  color: darkred; display: none; font-size: 1em" class="font-icon-news indent-right-10px" data-core-entity-id=''''2010''''></i>

<!--img style=''''display: none; float: left; margin-right: 10px; width: 30px'''' src="/eta_bin.axd?id=2010" /-->


<p style=''''line-height: 1.5; margin-bottom: 10px''''>
  	<i style=''''font-weight: 600;''''>
  	Добавлены новые функциональные возможности мнемосхем
	</i>
</p>

<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-id="2020" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: right; cursor: pointer; width: 250px" src="\eta_bin.axd?id=2020"/>

<p style=''''line-height: 1.5; text-indent: 20px;''''>
  Получили существенное развитие встроенные инструменты <a href="javascript:;" data-core-entity-id="2019" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>редактирования</a>, <a href="javascript:;" data-core-entity-id="2017" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>отображения</a> и кастомизации мнемосхем - средств графического представления измерительной системы.  
</p>


<p style=''''line-height: 1.5; text-indent: 20px; margin-bottom: 5px; text-align: justify''''>
  <b style=''''color: darkred''''>Самое важное</b>, что сейчас в системе реализована поддержка <a href="javascript:;" data-core-entity-id="2017" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>мнемосхем уровня помещения</a>, которые позволяют графически представить измерительную систему состоящую из произвольной совокупности измерительных приборов и их каналов. Примерами объектов диспетчеризации, для которых целесообразно применять мнемосхемы уровня помещения являются котельные и/или центральные тепловые пункты (ЦТП), измерительные системы которых оснащаются большим количеством разнообразных приборов начиная от тепловычислителей, электросчетчиков и заканчивая датчиками загазованности и охранными системами.
</p>  

<p style=''''line-height: 1.5; text-indent: 20px;''''>В частности, при просмотре мнемосхемы в консоли операционного администратора теперь имеется возможность масштабировать и выполнять прокрутку изображения, что актуально в случае если мнемосхема имеет большие размеры и/или большое число структурных элементов.</p>


<p style=''''line-height: 1.5; text-indent: 20px;''''><a href="javascript:;" data-core-entity-id="2018" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>Текстовые элементы</a>, предназначенные для отображения актуальных параметров измерительной системы, позволя'
+ N'ют получить полную расшифровку своего наименования и времени получения значения параметра от измерительного прибора. Выбор пиктограммы <a data-core-entity-id="1012" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image><i style="display: inline; margin-left: 5px" class="font-icon-Temper"></i></a> на всплывающем окне с описанием параметра мнемосхемы позволяет перейти к графику временной зависимости параметра</p>



<p style=''''margin-top: 10px; line-height: 1.5; text-indent: 20px; margin-bottom: 5px; text-align: justify''''>
  <span style=''''color: darkred''''>Новые мнемосхемы</span> - это очередной важнейшый этап развития системы!
</p>  

<style>
	.admin-area-news-body[data-core-entityTypeName=''''News''''][data-core-entityId=''''45'''']
  	.admin-area-news-body-caption
  	{
      font-weight: 600;
      color: darkred;
      margin-top: 3px;
  	}
  	.admin-area-news-body[data-core-entityTypeName=''''News''''][data-core-entityId=''''45''''] i.font-icon-Temper
    {
      font-size: 0.9em;
      color: #0000FF;
    }
  	.admin-area-news-body[data-core-entityTypeName=''''News''''][data-core-entityId=''''45''''] i.font-icon-Temper:hover
  	{
      color: red;
  	}  	
</style>
'', NULL, 0,  N''eta.sys.leo'', N''eta.sys.leo'', ''2016-11-09 16:49:33.030'', ''2017-08-15 12:38:18.513'')')
GO
GO

INSERT [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]) 
VALUES (48, N'O5E2b8G0n7DwA4Vt', N'Сводный отчет по вводным приборам учета по содержимому портфеля', N'Сводный отчет по вводным приборам учета по содержимому портфеля', '2017-03-13 11:16:53.047', N'<style>
  	.admin-area-news-body[data-core-entityTypeName=''News''][data-core-entity-code=''O5E2b8G0n7DwA4Vt'']
  	.admin-area-news-body-caption
  	{
      font-weight: 600;
      color: darkred;
      margin-top: 3px;
  	}
</style>
<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="sOr6Xe5mWnIc8Y1h" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=sOr6Xe5mWnIc8Y1h"/>

<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred''>
  	Расширены возможности формирования сводного отчета по вводным приборам учета
	</i>
</p>

<p style=''line-height: 1.5; text-indent: 20px;''>
  На основании анализа требований по дальнейшему развитию системы, а также статистики активного использования портфелей сущностей была реализована возможность формирования <i style=''font-weight: bold;''><a href="javascript:;" data-core-entity-code="O5H2uQw7vXp8lNs4" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>cводного отчета</a> по вводным приборам учета</i> на основе отобранного списка отдельных измерительных каналов.  
</p>

<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Данное решение обеспечивает возможность более быстрого получения <i style=''font-weight: bold;''>максимально компактной аналитической выборки</i> на основании предварительно подготовленного целевого списка измерительных каналов, что в свою очередь существенно ускоряет оперативный анализ и своевременное принятие решений.</p>', 
NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-03-13 11:17:47.800', '2017-03-13 15:35:07.750')
GO

INSERT [EnergyTechAudit.PowerAccounting.Database].Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (49, N'Nv4Y2hPbO5x3k8a7', N'Протоколы работы системы', N'<span style=''color: darkred; font-weight: 600;''><i style=''color: darkred; margin-right: 10px;'' class=''font-icon-pyramid-eye''></i>
  Протоколы работы системы
</span>', '2017-03-14 11:22:21.073', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="r6LbO4Tp0u3y5w7h" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=r6LbO4Tp0u3y5w7h"/>

<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Превращаем данные в мудрость!
	</i>
</p>
<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Очередной этап развития системы потребовал детального понимания того, какие изменения происходят в конфигурации системы, кем и когда создаются, изменяются и удаляются сущности системы и связи между ними. Несомненно, весьма значительный интерес имеет представление о  различных активностях в системе, в частности: логический вход и выход пользователей, генерация программных ошибок и исключений, включение и отключение служб считывателей и многое, многое другое.</p>
<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>С целью решения этого широкого спектра задач нами был разработан <i style=''font-weight: 600;''>комбинированный аналитический мультитабличный запрос</i> <i style=''color: darkred; font-weight: 600;''><i style = ''color: darkred; font-size: 1.4em; display: inline; margin: 0 5px 0 5px; line-height: 1;'' class = ''font-icon-history''></i>"Протоколы системы"</i>, инструментарий которого позволяет эффективно, с минимальными временными затратами решать значительный перечень задач, которые связаны с наблюдением за изменениями, происходящими в системе.</p>
', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-03-14 11:22:57.153', '2017-03-15 10:03:44.377')
GO

INSERT [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate])
VALUES (50, N'Ok5uH3x7sLj8V6nD', N'Быстрое перестроение отчетов и запросов', N'<span style=''color: darkred;font-weight: 600;''><i style=''color: darkred; margin-right: 10px;'' class=''font-icon-rebuild''></i>Быстрое перестроение отчетов и запросов</span>
', '2017-03-29 09:06:17.603', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="J3iTnHw5x4Q8Ur7d" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=J3iTnHw5x4Q8Ur7d"/>

<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Повышаем эффективность вашей работы!
	</i>
</p>

<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Наряду с уже применяемыми <i style=''font-weight: 600;''>уникальными</i> возможностями <i style=''font-weight: 600;''>групповой печати</i>, нами продолжается создание и развитие программных средств обеспечивающих максимальную эффективность вашей работы.</p>

<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>В настоящий момент, реализована очередная новая возможность - <i style=''font-weight: 600;''>выполнение быстрого повторного формирования</i> отчета или запроса с измененными параметрами непосредственно из палитры инструментов области просмотра, с помощью команды <b style=''font-weight: 600;''>Перестроение</b> <i style=''text-indent: initial;'' class=''font-icon-rebuild font-icon-darkgreen''></i>.</p>', 
NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-03-29 09:07:23.213', '2017-03-29 10:19:41.520')
GO

INSERT [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]) VALUES (51, NULL, N'Актуальный список активных пользователей системы', N'<span style=''color: darkred;font-weight: 600;''><i style=''color: darkred; margin-right: 10px;'' class=''font-icon-group''></i>Актуальный список активных пользователей</span>
', '2017-03-29 11:40:35.457', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="J3BoC0Pw8I5vL7X4" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=J3BoC0Pw8I5vL7X4"/>

<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Мы рядом и всегда готовы помочь!
	</i>
</p>

<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Задачи связанные с обеспечением <i style=''font-weight: 600;''>безопасности данных</i> и требования своевременного реагирования на возникающие <i style=''font-weight: 600;''>нештатные ситуации в работе системы</i> являются фундаментально важными слагаемыми эффективного развития ее программной инфраструктуры.</p>

<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Для более <i style=''font-weight: 600;''>детального понимания особенностей функционирования системы</i> и, в первую очередь, для облегчения работы администраторов нами были доработаны ранее существовавшие средства получения актуального списка онлайн-пользователей системы.</p>
', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-03-29 11:41:41.043', '2017-03-29 12:16:23.907')
GO

INSERT [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]) VALUES (52, N'O5rNe4B1XuP0i3s7', N'Редактирование наименования сущности Измерительный канал', N'<span style=''color: darkred;font-weight: 600;''><i style=''color: darkred; margin-right: 10px;'' class=''font-icon-channel''></i>Наименование измерительного канала</span>', '2017-04-04 11:28:52.550', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="P5a0r7xVkNyFd2t8" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=P5a0r7xVkNyFd2t8"/>
<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Всегда прислушиваемся в вашему мнению и изменяем мир к лучшему! 
	</i>
</p>

<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''><i style=''font-weight: 600;''>Индивидуализация поведения</i> проектируемых и реализуемых программных средств имеет для нас огромное значение, поскольку позволяет с наибольшей эффективностью решать повседневные задачи потребителей нашего продукта и одновременно обеспечивает конкурентное преимущество предлагаемых решений благодаря созданию их <i style=''font-weight: 600;''>максимально высокой ценности</i>.</p>
<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Несмотря на то, что изначально в системе был заложен и продолжает действовать <i style=''font-weight: 600;''>уникальный  механизм</i> контекстуального автоматизированного именования сущностей предметной области, нами дополнительно реализована возможность произвольно изменять автоматически сформированное наименование сущности. В частности, в настоящее время такая возможность доступна для сущности <i style=''text-indent: initial;'' class=''font-icon-channel font-icon-darkgreen''></i> <i style=''font-weight: 600;''>"Измерительный канал".</i></p>', 
NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-04-04 11:29:51.613', '2017-04-04 12:27:16.400')
GO

INSERT INTO [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]) VALUES(53, N'2Gp5Om7r6yI8T4nS', N'Результаты выполнения обработки', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin-right: 10px;'' class=''font-icon-processing''></i>Результаты выполнения обработки</span>', '2017-04-13 14:55:00.000', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="1e7t0gBa3q6Jw4Lm" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=1e7t0gBa3q6Jw4Lm"/>
<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Нам важно показать суть вещей! 
	</i>
</p>

<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Стремление к представлению <i style=''font-weight: 600;''>данных</i> формируемых в ходе работы нашего приложения в виде <i style=''font-weight: 600;''>информации</i>, допускающей детальную интерпретацию, требует от нас постоянного совершенствования алгоритмов и применения ранее недоступных технических и архитектурных решений.</p>

<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Необходимость <i style=''font-weight: 600;''>автоматизации ряда трудоемких бизнес-процессов</i>, реализуемых системой уже на начальном этапе проектирования потребовало разработки простой подсистемы выполнения <i style=''font-weight: 600;''>задач</i> <i style=''text-indent: initial;'' class=''font-icon-processing font-icon-darkgreen''></i> массовой обработки (на примере <i style=''color: darkred; font-weight: 600;''>"Присоединить каналы к пользователю"</i>). В первоначальном варианте, такая подсистема была способна возвращать информацию только о количестве обработанных элементов.</p>
<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>На настоящий момент, нами были усовершенствованы механизмы сеансовой регистрации изменений производимых в ходе выполнения обработки записей базы данных с возможностью ее последующего экспорта, детального анализа и/или хранения вне системы. Наряду с этим, разработан новый элемент обработки <i style=''color: darkred; font-weight: 600;''>"Изменить интервал опроса устройств"</i>, который обеспечивает возможность массового назначения интервала опроса устройства на основании его типа и некоторых других критериев.</p>
', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-04-13 14:57:20.080', '2017-04-13 17:04:53.940')
GO

INSERT [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]) VALUES (54, N'x8i2bH0j3C6Tm4y5', N'Счетчик-импульсов регистратор Пульсар', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin-right: 10px;'' class=''font-icon-measurementdevice''></i>Cчетчик-импульсов регистратор Пульсар</span>', '2017-04-19 17:30:59.807', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="L4D1U3C0BmAi2eJo" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=L4D1U3C0BmAi2eJo"/>
<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Продолжаем развиваться! 
	</i>
</p>
<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>В настоящий момент система поддерживает свыше 40 различных <i style=''text-indent: initial;'' class=''font-icon-measurementdevice font-icon-darkslateblue''></i> измерительных устройств, <i style=''text-indent: initial;'' class=''font-icon-accesspoint font-icon-darkred''></i>коммуникационных устройств (точек доступа), а также <i style=''text-indent: initial;'' class=''font-icon-regulator3 font-icon-lightblue''></i>многофункциональных регуляторов и простых коммутаторов.</p>
<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Одним из наших очередных достижений является успешное внедрение электронного счетчика-импульсов регистратора  Пульсар <img style="display: inline; cursor: pointer; width: 70px; height: 12px; vertical-align: middle;" src="\eta_bin.axd?code=wJ8Y3qH5LdO1E4I7"/> выпускаемого компанией «Тепловодохран». Для  наглядного графического представления показаний соответствующего счетчика-импульсов нами также разработана <i style=''text-indent: initial;'' class=''font-icon-mnemoscheme font-icon-red''></i> визуальная мнемопанель измерительного устройства.</p> 
', NULL, 0,  N'eta.sys.leo', N'eta.sys.leo', '2017-04-19 17:33:02.980', '2017-04-26 10:31:11.360')
GO

INSERT [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]) VALUES(55, N'P5a0U7eM8Co1yS6F', N'Новые возможности работы с картами', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin-right: 10px;'' class=''font-icon-location-map''></i>Карты в консоли операционного администратора</span>', '2017-04-28 09:47:59.657', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="x8kE3tWv1l7F4Sj6" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=x8kE3tWv1l7F4Sj6"/>
<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Производительность имеет решающее значение! 
	</i>
</p>
<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>Представление и использование картографических данных о локализации объектов учета представляет собой важнейшую функциональную часть нашей системы диспетчеризации.</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">В ряде реальных применений, когда число отображаемых на карте меток строений составляло <a href="javascript:;" data-core-entity-code="1e8X2b5l7h6f3Pt0" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image >свыше одной тысячи</a>, могла наблюдаться некоторая потеря производительности работы браузера при первоначальном отображении виджета "Карта объектов".</p>
<p style=''line-height: 1.5; text-indent: 20px; margin-top: 10px''>На настоящий момент, нам удалось значительно, <i style=''color: darkred; font-weight: 600;''> более чем в несколько раз, повысить скорость начального отображения карты</i> при существенно большем количестве меток строений. Одновременно с этим, виджет Приборной панели дополнен <i style=''color: darkred; font-weight: 600;''>новой возможностью
быстрого просмотра </i> на карте <a href="javascript:;" data-core-entity-code="x8kE3tWv1l7F4Sj6" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image >местоположения</a> соответствующего строения (объекта учета).</p> ', 
NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-04-28 09:48:56.280', '2017-04-28 10:54:55.747')
GO

INSERT [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]) VALUES (56, N'1f6C5Q4sMeLn0BuY', N'Выборочное отображение параметров регуляторов', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin-right: 10px;'' class=''font-icon-regulator3''></i>Селективное отображение параметров регуляторов</span>', '2017-05-15 15:46:12.633', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="sUl6kI3X4Fe1bC7M" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=sUl6kI3X4Fe1bC7M"/>
<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Компактно представляем некомпактные множества!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Поддерживаемые нашей системой погодозависимые регуляторы отопления и горячего водоснабжения, как правило, имеют <i style=''color: darkred; font-weight: 600;''>чрезвычайно большое количество (свыше 30 или более) доступных параметров регулирования</i>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Для обеспечения более компактного отображения перечня наиболее актуальных параметров регуляторного виджета нами доработана возможность индивидуальной настройки списка для каждого отдельного вида шаблона регуляторного измерительного канала.
</p>', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-05-15 15:47:05.450', '2017-05-15 16:45:33.223')
GO

INSERT INTO [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(57, N't6d8S7Y1j2Gh3c4K', N'Новые приборы в системе диспетчеризации', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin-right: 10px;'' class=''font-icon-measurementdevice''></i>Новые приборы в системе диспетчеризации</span>', '2017-05-30 11:51:54.177', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="K3Vp5A7r0c6N1eS4" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=K3Vp5A7r0c6N1eS4"/>
<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Приборы под контролем!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Появилась возможность осуществлять опрос электронного газового корректора <i style=''color: darkred; font-weight: 600;''>EK 270</i> и ультразвукового расходомера сточных вод <i style=''color: darkred; font-weight: 600;''>ЭХО-Р-02</i> ПНП Сигнур.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  Газовый корректор измеряет потребленные объемы газа при стандартных и рабочих условиях. Также существует возможность генерировать посуточные и почасовые ведомости потребленного газа. Это позволит проводить анализ расхода газа на квартальных и районных котельных. Конечной целью является уменьшение потребления газа.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
 Ультразвуковой расходомер ЭХО-Р-02 предназначен для измерения объемного расхода (количества) жидкости, в том числе сточных вод, в открытых каналах шириной до 4-х метров, и в безнапорных трубопроводах диаметром 100 мм и более.
</p>', NULL, 0, N'eta.sys.max', N'eta.sys.max', '2017-05-30 11:53:22.140', '2017-05-30 12:00:34.053')
GO


INSERT [Admin].[News]([Id], [Code], [Description], [Caption], [Date], [Text], [BinaryId], [ViewCounter], [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate]) VALUES (58, N'0B4D2Q8P5Kg3N7Hx', N'Объединенные ведомости учета параметров', N'<span style=''display: block; color: darkred; font-weight: 600;''>Объединенные ведомости учета параметров</span>', '2017-06-09 12:02:16.140', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="y8B1N4f0M3j6Da2k" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=y8B1N4f0M3j6Da2k"/>
<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Объединяя необъятное, отодвигаем грани разумного!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
 Несмотря на то, что в системе уже реализованы <i style=''color: darkred; font-weight: 600;''>универсальные ведомости учета </i>параметров потребляемых ресурсов, наша команда стремится максимально полно удовлетворить требования наших заказчиков.  Для этого, в частности, мы развиваем наш программный комплекс за счет разработки новых отчетных ведомостей и прочих инструментов анализа и представления информации.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
С целью более компактного и сравнительного представления данных о совокупном потреблении ресурсов, в рамках нескольких ресурсных подсистем, нами разработана <i style=''color: darkred; font-weight: 600;''>объединенная ведомость учета</i> для нескольких измерительных каналов типичного центрального и/или индивидуального теплового пункта строения.
</p>', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-06-09 12:05:17.820', '2017-06-09 13:07:34.423')
GO

INSERT INTO [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(59, N'2Fk3Xt8L4IbUqC7j', N'Тепловычислитель ЭЛЬФ', N'<span style=''display: block; color: darkred; font-weight: 600;''>Тепловычислитель ЭЛЬФ</span>', '2017-07-04 14:43:50.217', N'<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
В систему диспетчеризации добавлен <i style=''color: darkred; font-weight: 600;''>тепловычислитель ЭЛЬФ</i> производства НПО КАРАТ / НПП "Уралтехнология" (Екатеринбург).
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  Вычислитель ЭЛЬФ предназначен для коммерческого и технологического учёта энергетических ресурсов в системах отопления, горячего водоснабжения, холодного водоснабжения, электроснабжения в которых он проводит измерение.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  Область применения вычислителя: узлы учета тепловой энергии теплоносителя и электрической энергии в индивидуальных и центральных тепловых пунктах, информационно-измерительные системы учёта, контроля и управления энергетическими ресурсами на объектах жилищно-коммунального хозяйства и промышлености.
</p>', 3070, 0, N'eta.sys.max', N'eta.sys.max', '2017-07-04 14:44:44.897', '2017-07-04 14:49:26.887')
GO

INSERT INTO [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(60, N'Np4jY5R3qK8Ef7T0', N'Счётчик электрической энергии СЭТ-4ТМ.03М', N'<span style=''display: block; color: darkred; font-weight: 600;''>Счётчик электрической энергии СЭТ-4ТМ.03М</span>', '2017-08-09 14:20:50.057', N'<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
В систему диспетчеризации добавлен <i style=''color: darkred; font-weight: 600;''>счетчик электрической энергии СЭТ-4ТМ.03М</i> производства Нижегородского НПО имени М.В.Фрунзе.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Счетчик предназначен для многотарифного учета активной и реактивной энергии (в том числе и с учетом потерь), введения массивов профиля мощности нагрузки с программируемым временем интегрирования, измерения параметров трехфазной сети.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
В системе существует возможность генерации ведомости посуточного потребления энергии. Для этого во время генерации ведемости учета необходимо выбрать Тип периода: <i>"Дневное архивное значение"</i>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  Кроме того, можно сгенерировать ведомость <i>"Почасовые профили мощности"</i>. В этом случае надо выбирать Тип периода: <i>"Часовое архивное значение"</i>. С помощью данной ведомости можно отслеживать суммарное потребление за сутки, а также находить часы, в которые наблюдался максимум потребления электрической энергии.
</p>', 3071, 0,  N'eta.sys.max', N'eta.sys.max', '2017-08-09 14:32:24.563', '2017-08-09 14:38:36.213')
GO

INSERT [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (61, N'0B4D2Q8P5Kg3N7Hx', N'Приборная панель на картах объектов', N'<span style=''display: block; color: darkred; font-weight: 600;''>Приборная панель на картах объектов</span>', '2017-11-14 15:48:00.000', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="v7L4A1kD2t3OiF8Y" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=v7L4A1kD2t3OiF8Y"/>
<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Приборная панель везде!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
 Важным этапом на пути совершенствования функциональных возможностей предлагаемого нами продукта стало <i style=''color: darkred; font-weight: 600;''>значительное улучшение</i> пользовательского интерфейса подсистемы "Карты объектов" в консоли операционного администратора. </p>
  <p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">В частности, информационное окно маркера карты для выбранного измерительного канала обеспечивает оперативный доступ к <i style=''color: darkred; font-weight: 600;''>текущим итоговым и мгновенным результатам измерения параметров</i> в виде подобном как это реализовано в подсистеме "Приборной панели", а также  к функции формирования графического представления временной зависимости измеряемых параметров прибора.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Таким образом, функциональный модуль "Карты объектов" из статичного инструмента отображения геолокационной матрицы объектов учета постепенно превращается в многофункциональный компонент <i style=''color: darkred; font-weight: 600;''>активной диспетчеризации</i> приборов учета.
</p>', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-11-14 12:59:59.247', '2017-11-14 15:48:32.677')
GO

INSERT INTO [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(62, N'wJ7kLx3b8m4NdU0r', N'Теплосчетчик ТЭМ-104', N'<span style=''display: block; color: darkred; font-weight: 600;''>Теплосчетчик ТЭМ-104</span>', '2017-11-20 14:58:23.800', N'<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
В систему диспетчеризации добавлен <i style=''color: darkred; font-weight: 600;''>теплосчетчик ТЭМ-104</i> производства группы компаний "ТЭМ".
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Теплосчетчик предназначен для измерений и регистрации с целью коммерческого и технологического учета значений потребленного (отпущенного) количества теплоты, теплоносителя и других параметров систем теплоснабжения и горячего водоснабжения.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Теплосчетчик позволяет одновременно проводить измерения в системах количеством до четырех</i>.
</p>', 3079, 0, N'eta.sys.max', N'eta.sys.max', '2017-11-20 14:59:11.133', '2017-11-20 15:01:36.853')
GO

INSERT [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (63, N'1F5HoN2k3R4Xl6V8', N'Приборная панель в конфигураторе системы', N'<span style=''display: block; color: darkred; font-weight: 600;''>Приборная панель в конфигураторе системы</span>', '2017-11-22 11:00:00', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="0B3K5Q2IcL4P6Af8" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 20px" src="\eta_bin.axd?code=0B3K5Q2IcL4P6Af8"/>
<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Приборная панель везде!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
 Наш программный комплекс построен на основе концепции <i style=''color: darkred; font-weight: 600;''>раздельного</i> от функций диспетчеризации <i style=''color: darkred; font-weight: 600;''>администрирования системы</i>. На основании этого в нем существует отдельный функционально развитый блок администрирования - <i style=''color: darkred; font-weight: 600;''>Конфигуратор</i>. Конфигуратор позволяет решать задачи создания и настройки многочисленных структурных элементов предметной области (сущностей). В свою очередь, задачи диспетчеризации решаются самостоятельным модулем, получившим название <i style=''color: darkred; font-weight: 600;''>Консоль</i> операционного администратора. 
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
В процессе эволюции, на основании анализа прецедентов взаимодействия, Конфигуратор все в большей степени стал наделен функциями первичной диагностики состояния измерительных приборов и точек доступа. </p>
  <p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
 На настоящий момент, в состав его программных средств был включен  модуль, реализующий также функции <i style=''color: darkred; font-weight: 600;''>Приборной панели</i>, подобно консоли операционного администратора. В результате, администраторы получили теперь возможность иметь доступ к данным не только в виде архива измерительного устройства, но и к информации более высокого канального уровня с учетом шаблонов сопоставления для заданной ресурсной системы.
</p>', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-11-21 19:13:00.017', '2017-11-22 10:34:56.660')
GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(64, N'J3GpMo5Ux4V2A8nT', N'Ведомость учета параметров для EK270 в стиле ПО "СОДЭК"', N'<span style=''display: block; color: darkred; font-weight: 600;''>Ведомость учета параметров для EK270 в стиле ПО "СОДЭК"</span>', '2017-11-24 13:14:33.737', N'<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Для газовых корректоров EK270 разработана новая ведомость учета параметров потребления газа. Она представляет собой аналог ведомости, которая используется в заводском программном комплексе "СОДЭК" компании "ЭЛЬСТЕР Газэлектроника".
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Ключевой особенностью данного отчета является то, что суточное потребление рассчитывается в рамках так называемого <i>"газового дня"</i>. "Газовый день" начинается в определенный час суток, который указан в настройках прибора учёта, и продолжается 24 часа. Например, если "газовый день" начинается в 10 часов утра, то для 15 октября "газовый день" будет начинаться в 10 часов утра 15 октября и заканчиваться 10 часами утра 16 октября.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Изменения затронули и почасовую ведомость: она теперь тоже учитывает "начало газового дня".  <i style=''color: darkred; font-weight: 600;''>Если прибор учета работал в течение суток корректно, то итоги потребления почасовой ведомости за конкретные сутки, должны совпадать с потреблением за эти сутки в посуточной ведомости</i>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  <b style=''color: darkred; font-weight: 600;''>Следует отметить один немаловажный момент:</b> если попытаться сгенерировать суточную ведомость с диапазоном дат, включающую предыдущие сутки, но при этом отчетный час в приборе ещё не наступил, то потребление за предыдущие сутки не попадёт в ведомость, так как необходимо дождаться завершения "газового дня".
</p>', 3081, 0, N'eta.sys.max', N'eta.sys.max', '2017-11-24 13:15:54.007', '2017-11-24 13:28:32.073')
GO

INSERT [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (65, N'J3H2YlAvIpN8R0S7', N'Нештатные ситуации на картах', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin-right: 5px;'' class=''font-icon-location-map''></i> Уведомление о нештатной ситуации на карте объектов</span>', '2017-11-28 14:32:00.000', N'
<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="x8JhKyM2Nr3Vu6Ps" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=x8JhKyM2Nr3Vu6Ps"/>

<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Раскрываем вам карты!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  Пользователи нашего программного комплекса все более широко внедряют в своей повседневной работе действующий функционал аналитической машины расчета возникновения различных <i style=''color: darkred; font-weight: 600;''><i style = ''color: darkred; font-size: 1.4em; display: inline; margin: 0 5px 0 5px; line-height: 1;'' class = ''font-icon-emergency''></i>нештатных ситуаций</i> на объектах диспетчеризации.
  </p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  В связи с этим, важными становятся вопросы контекстуального <i style=''color: darkred; font-weight: 600;''>аудиовизуального представления</i> нештатной ситуации в различных виджетах консоли операционного администратора.
  Нами уже была реализована поддержка отображения целевого уведомления непосредственного на<i style=''color: darkred; font-weight: 600;''><i style = ''color: darkred; font-size: 1.4em; display: inline; margin: 0 5px 0 5px; line-height: 1;'' class = ''font-icon-mnemoscheme''></i> мнемосхемах</i> как уровня одиночного измерительного канала, так и <a href="javascript:;" data-core-entity-code="0b6t1E3O5JaCdP8Y" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>мнемосхемах</a> уровня помещения. Последнее имеет большое значение для диспетчеризации крупных комплексных узлов учета таких, как центральные тепловые пункты и районные котельные.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
	В свою очередь, <i style=''color: darkred; font-weight: 600;''><i style = ''color: darkred; font-size: 1.4em; display: inline; margin: 0 5px 0 5px; line-height: 1;'' class = ''font-icon-map''></i>геолокационные карты</i> объектов диспетчеризации становятся все более востребованным и интенсивно используемым компонентом интерфейса системы. В результате, возникла потребность непосредственного отображения уведомления о нештатной ситуации в виде информационного окна над маркером карты, с функцией автоматического раскрытия узла сущностного дерева до уровня списка измерительных каналов.
</p>', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-11-28 09:21:23.450', '2017-11-28 11:03.607')
GO

INSERT INTO [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(66, N'L4mDxY1V7jR2c0N3', N'Отчёт "График потребления активной и реактивной мощности в рабочий день"', N'<span style=''display: block; color: darkred; font-weight: 600;''>Отчёт "График потребления активной и реактивной мощности в рабочий день"</span>', '2017-11-30 10:54:41.087', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="MsP4U6qD3kLi7E1N" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=MsP4U6qD3kLi7E1N"/>

<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Новый отчет для приборов учета электрической энергии!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
С учетом пожеланий сотрудников АО "Альметьевские тепловые сети" был разработан отчет, позволяющий отображать и анализировать часовые профили потребленной электрической мощности за конкретные сутки.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Отчет протестирован для приборов Меркурий-230 и СЭТ-4ТМ.03М, и становится доступным в меню "Отчеты" при выборе каналов этих моделей. В меню он называется  <a href="javascript:;" data-core-entity-code="s6P5HwL2I3D1JeQ8" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>"Потребление в рабочий день"</a>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
После вызова пункта меню "Потребление в рабочий день" появляется окно <a href="javascript:;" data-core-entity-code="2Gk3tU7B0C1j5vQd" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>"Параметры"</a>, которое содержит четыре поля:
  	<ul style=''list-style-position: inside; line-height: 2;''>
      <li><i style=''color: darkred; font-weight: 600;''>Канал</i> (заполняется автоматически значением канала, который в данный момент выбран в дереве);</li>
      <li><i style=''color: darkred; font-weight: 600;''>Дата</i> (сутки, за которые необходимо выполнить анализ);</li>
      <li><i style=''color: darkred; font-weight: 600;''>Часы максимального потребления</i> (здесь указывается диапазон часов, в которых выполняется поиск максимального значения потребленной мощности. Если используется один диапазон, то он записывается в виде "5-7" и в этом случае поиск максимального значения осуществляется с 5 до 7 часов утра. Если требуется выполнять поиск в двух и более диапазонах, следует перечислить их через запятую: "5-7,17-22". Если оставить это поле пустым или записать строку в некорректном формате, то поиск будет осуществляться по всем 24 часам);</li>
      <li><i style=''color: darkred; font-weight: 600;''>Учитывать расчетный коэффициент</i> (бывают ситуации, когда прибор подключен не напрямую, а через трансформаторы тока и напряжения. В этом случае для получения реального значения потребленной мощности необходимо умножить измеренное значение на расчетный коэффициент. Расчетный коэффициент задается администратором системы в динамических параметрах прибора. Если устаночить галочку, то каждое измеренное значение часового профиля будет умножено на расчетный коэффициент).</li>
</ul>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  В отчете отображаются две таблицы: потребление <i>активной (прямой)</i> и <i>реактивной (прямой)</i> мощности за каждый час выбранных суток.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  В таблице активной нагрузки <b>полужирным шрифтом</b> отображается максимальная мощность.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
Для активной нагрузки производится расчет следующих параметров: суточный расход, средняя мощность, максимальная мощность и отношение средней мощности к максимальной.
</p>', NULL, 0, N'eta.sys.max', N'eta.sys.max', '2017-11-30 10:55:58.497', '2017-11-30 11:23:30.410')

GO

INSERT [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (67, N'2f8y7uC0a4lIb1w5', N'Новый журнал нештатных ситуаций', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin: 0 5px 5px 3px;'' class=''font-icon-emergency''></i>Новый журнал нештатных ситуаций</span>', '2017-12-12 09:32:00.000', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="1e7U3f2k4n8xHy5W" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=1e7U3f2k4n8xHy5W"/>

<p style=''line-height: 1.5; margin-bottom: 5px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	  Воплощение ваших идей!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
   Мы постоянно находимся в процессе исследования многочисленных прецедентов взаимодействия пользователя с элементами нашего приложения. Это позволяет по мере эволюции системы совершенствовать ее программные механизмы и вырабатывать новые удобные сценарии использования <i style=''color: darkred; font-weight: 600;''>человеко-машинного интерфейса</i>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
   Ключевой особенностью комплексов диспетчеризации измерительных систем является необходимость обработки больших объемов данных и формирования <i style=''color: darkred; font-weight: 600;''>компактного информационного поля</i> для конечного пользователя. Типичным примером этого в системе является<i style = ''color: darkred; font-size: 1.2em; display: inline; margin: 0 0px 0 3px; line-height: 1;'' class = ''font-icon-emergency''></i> <i style=''color: darkred; font-weight: 600;''>журнал нештатных ситуаций</i>, доступный ранее во вкладке основной рабочей области консоли операционного администратора.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">На основе <i style=''color: darkred; font-weight: 600;''>анализа статистики использования</i> нами принято решение о переносе журнала из области статичной вкладки в область всплывающего диалогового немодального окна. Такое решение позволит свести к минимуму переключения между различными виджетами приложения (<i style = ''color: darkred; font-size: 1.2em; display: inline; margin: 0 0px 0 3px; line-height: 1;'' class = ''font-icon-dashboard''></i> Приборная панель, <i style = ''color: darkred; font-size: 1.2em; display: inline;  line-height: 1; margin: 0 0px 0 3px;'' class = ''font-icon-map''></i> Карта объектов) и <i style=''color: darkred; font-weight: 600;''>существенно повысит скорость и удобство использования журнала</i> как инструмента активной диспетчеризации.
</p>', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-12-12 08:13:27.710', '2017-12-12 10:45:38.267')
GO

INSERT INTO [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(68, NULL, N'Дайджест последних обновлений', N'<span style=''display: block; color: darkred; font-weight: 600;''>Дайджест последних обновлений</span>', '2017-12-18 19:31:57.180', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="DigestOne" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=DigestOne"/>

<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Будьте в курсе изменений!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  <i style=''color: darkred; font-weight: 600;''>Электросчетчик Меркурий-234.</i> В систему добавлена возможность диспетчеризации электросчетчика Меркурий-234. Движок опроса во многом схож с Меркурием-230. Отличительной особенностью является наличие более глубого архива профилей мощности. В Меркурии-230 глубина архива мощностей составляет 4096 записей; в Меркурии-234 - 8192 запись, то есть в два раза больше.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  <i style=''color: darkred; font-weight: 600;''>Архивы-интеграторы в приборах "Взлёт".</i> На протяжении длительного времени оставалась нерешенной проблема отсутствия показаний счетчиков в ведомости учета параметров и сводных отчетах для определенных моделей теплосчетчиков "Взлёт". В частности, это касалось моделей: Взлёт-24, Взлёт-24М, Взлёт-24М+, Взлёт-26М, Взлёт-22(23). Проблема заключась в том, что в архивах этих приборов отсутствуют накопительные итоги. Лишь Взлёт-24М архивирует интегратор потребленной теплоты. Однако, это проблему не решает, так как требуются итоги для массы, объема и времени наработки. Заводские отчеты также не предоставляют полную информацию об интеграторах.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  В связи с этим был разработан специализированный алгоритм расчета архивных интеграторов, который опирается на текущие итоговые значения. Также были переработаны все шаблоны измерительных каналов для моделей, которых касается это изменение.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  <i style=''color: darkred; font-weight: 600;''>Новые шаблоны.</i> В системе появились 8 новых шаблонов измерительных каналов:
  	<ul style=''list-style-position: inside; line-height: 2;''>
      <li>5 для регуляторов Danfoss ECL 210/310 (система регулирования: ключ А368.1, ГВС, контур 2; ключ А368.3, ГВС, контур 2; ключ А368.3, ЦО, контур 1 / система мониторинга: ключ А368.1 - ЦО+ГВС; ключ А368.3 - ЦО +ГВС);</li>
      <li>ТЭМ-106 (система теплоснабжения, система 1, тр1-тр2);</li>
      <li>ТЭМ-104 (ГВСЦ, система тр1-тр2)</li>
      <li>Меркурий-234 (учет активной и реактивной энергии по 2 тарифам с расчетным коэффициентом).</li>
</ul>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  <i style=''color: darkred; font-weight: 600;''>Новые мнемосхемы.</i> Были обновлены мнемосхемы для ключей A368.1 и A368.3 погодного регулятора Danfoss ECL 210/310.
</p>
', NULL, 0,  N'eta.sys.max', N'eta.sys.max', '2017-12-18 19:32:23.230', '2017-12-18 19:49:26.240')
GO

INSERT [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (69, N'K3G7c0Vn4x2s6w8l', N'Новые функции портфеля сущностей в конфигураторе', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin: 0 5px 5px 3px;'' class=''font-icon-briefcase''></i>Новые функции портфеля сущностей в конфигураторе</span>', '2017-12-22 07:00:00.000', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="0BdP5L6s8K4xM3I7" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=0BdP5L6s8K4xM3I7"/>

<p style=''line-height: 1.5; margin-bottom: 5px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	  Наши идеи для достижения вашего успеха! 
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
   Портфель сущностей<i style=''display: inline; margin: 3px 3px 3px 3px; line-height: 1.5; color: black;'' class=''font-icon-briefcase''></i>активно применяется в повседневной работе наших пользователей для выборочной групповой печати и хранения ссылок на сущностные элементы. Основным его назначением является функция долговременного <i style=''color: darkred; font-weight: 600;''>структурированного хранения набора ссылок на различные сущности</i> доступные пользователю. Для операционного администратора <i style=''display: inline; margin: 0 3px 0 3px; line-height: 1;'' class="font-icon-user-leadoperadmin"></i> это в первую очередь являются каналы <i style=''display: inline; margin: 0 3px 0 3px; line-height: 1;'' class="font-icon-channel font-icon-x1_1 font-icon-darkgreen"></i> и строения <i style=''display: inline; margin: 0 0px 0 3px; line-height: 1;'' class="font-icon-building font-icon-x1_1 font-icon-color-metrohover"></i>, которые доступны в сущностном дереве.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
   Портфель сущностей изначально был доступен также в конфигураторе системы и имел полностью аналогичные возможности что и в консоли операционного администратора. Однако, он не нашел такого широкого применения, ввиду того, что его навигационные свойства были ограничены только сущностным деревом.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">С настоящего времени, в конфигураторе системы портфель получил<i style=''color: darkred; font-weight: 600;''> дополнительные возможности</i> по навигации между элементами проекта. Выбор элемента в списке теперь позволяет выполнить <i style=''color: darkred; font-weight: 600;''>переход на соответствующую форму для редактирования сущности</i>. В свою очередь, появилась функция добавлять ссылку на элемент в активный портфель непосредственно из формы редактирования. Кроме того, как и многие диалоговые окна  окно портфеля было дополнено средствами  быстрого сворачивания <i style=''display: inline; margin: 0 3px 0 3px; line-height: 1;'' class="font-icon-collapsed font-icon-darkgreen"></i>.
</p>', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2017-12-21 19:07:22.807', '2017-12-21 19:48:34.310')
GO

INSERT [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) 
    VALUES (70, N'N4A0Iv3j1gFx7CyT', N'Разноформатный экспорт при групповой печати отчетов', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin: 0 5px 5px 3px;'' class=''font-icon-report''></i>Разноформатный экспорт результатов групповой печати</span>', '2018-01-29 12:00:00.000', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="M4kE2F0RhG5TaP7d" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=M4kE2F0RhG5TaP7d"/>

<p style=''line-height: 1.5; margin-bottom: 5px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	  Еще недоступное другим, уже доступно вам!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
   Групповое формирование некоторых видов отчетов является <i style=''color: darkred; font-weight: 600;''>одной из уникальных возможностей нашего продукта</i>. Эта функция, как уже известно, позволяет сформировать объединенные в единый документ отдельные однотипные отчеты с идентичными критериями отбора данных. Такая функция работает в неблокирующем интерфейс режиме,<i style=''color: black; font-weight: 600;''> и предполагала ранее</i> экспортирование отчета только в документ <i style=''color: darkred; font-weight: 600;''>Portable Document Format</i> (PDF). 
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px"> Для многих наших пользователей значительный интерес представляет возможность постобработки результатов групповой печати в одном из доступных редактируемых форматов, особенно <i style=''color: darkred; font-weight: 600;''>в формате электронных таблиц табличного процессора Microsoft Excel</i>.  В частности, это связано с элементами интеграции нашего продукта с бухгалтерскими и биллинговыми системами.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">В результате анализа ваших требований и выполнения модернизации потоковой машины конвейера отчетов мы уже сегодня готовы предложить вам дополнительные возможности также <i style=''color: black; font-weight: 600;''>недоступные в сторонних продуктах</i>, в частности, экспорт результатов групповой печати в таких форматах как <i style=''color: darkred; font-weight: 600;''>XLS, XLSX, RTF, DOCX  и PPTX</i>.</p>',
NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2018-01-29 11:14:16.143', '2018-01-29 12:40:00.693')
GO

INSERT [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (71, N'M4v1Ch2Ku7F5NqT6', N'Временной срез по контроллерам погодного регулирования', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin: 0 10px 5px 3px;'' class=''font-icon-analitics''></i>Новые аналитические инструменты:</span>
<span style=''display: block; color: darkred; font-size: 0.8em''>Отчет "Временной срез по контроллерам погодного регулирования"</span>', '2018-03-01 13:00:00.000', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="N4AwO0y8r7kU2cIx" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=N4AwO0y8r7kU2cIx"/>

<p style=''line-height: 1.5; margin-bottom: 5px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>  	 
     Проникая в природу вещей!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
   На пути развития нашего программного комплекса  мы сталкиваемся с решением сложных многокритериальных задач для обеспечения наших пользователей необходимыми <i style=''color: darkred; font-weight: 600;''>аналитическими инструментами</i>, которые обеспечивали бы надежную и эффективную диспетчеризацию. Наличие таких инструментов является одним из наиболее ценных свойств любой АСКУЭ, позволяя получать <i style=''color: darkred; font-weight: 600;''>экономический эффект от ее внедрения</i>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">В нашем ПО реализован единый интерфейсный модуль для взаимодействия пользователя с различными <a href="javascript:;"  data-core-command-show-image data-core-entity-code="M4tB0A7Jc3u2KnQi" data-core-entity-type-name="Binary" data-core-entity-property-name="Data">регуляторными и управляющими устройствами</a>, а службы считывателей устройств реализуют аппаратно-зависимые функции для их удаленного управления. В частности,  обеспечивается поддержка нескольких видов <i style=''color: darkred; font-weight: 600;''>погодозависимых регуляторов</i>.</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px"> 
  
  Мы реализовали для вас специальный отчет <i style=''color: darkred; font-weight: 600;''>"Временной срез по контроллерам погодного регулирования"</i>, который предоставляет сводную информацию по всем мониторинговым каналам погодозависимых регуляторов. Этот отчет компактно представляет информацию о фактических и расчетных температурах для ресурсных систем центрального отопления и горячего водоснабжения, а также абсолютное отклонение от расчетного значения как для ЦО, так и ГВС. Данный отчет позволяет быстро определить объекты с установленными погодозависимыми регуляторами, которые имеют  отклонения температур от расчетных значений больше, чем заданные, и принять меры по устранению причин посредством <a href="javascript:;"  data-core-command-show-image data-core-entity-code="M4tB0A7Jc3u2KnQi" data-core-entity-type-name="Binary" data-core-entity-property-name="Data">удаленного регулирования</a> параметров тепловой системы.</p>
', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2018-03-01 09:53:14.473', '2018-03-01 12:17:50.103')
GO

/*
INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(72, N'0c8X7tU1p5k3aSb6', N'Удалено поле "Тип соединения"', N'<span style=''display: block; color: darkred; font-weight: 600;''>Удалено поле "Тип соединения"</span>', '2018-03-11 19:31:57.180', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="PrtB0A7Jc127KnQi" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=PrtB0A7Jc127KnQi"/>

<p style="line-height: 1.5; text-indent: 20px; margin-top: 10px">
  Поле <i style=''color: darkred; font-weight: 600;''>"Тип соединения"</i>, которое присутствовало в сущностях <i style=''color: darkred; font-weight: 600;''>"Измерительное устройство"</i> и <i style=''color: darkred; font-weight: 600;''>"Модель измерительного устройства"</i>, было удалено. Удаление связано с тем, что данное поле перестало носить смысл с момента разделения служб считывателей по типу опроса: клиент или сервер. Кроме того, достаточно часто неправильное выставление значения этого поля в настройках измерительного устройства приводило к остановке опроса прибора.
</p>', NULL, N'eta.sys.max', N'eta.sys.max', '2018-03-11 11:53:13.793', '2018-03-11 12:05:55.443')
GO
*/

INSERT [Admin].[News](Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (73, N'v7dJ3e1U4LnB0Xs8', N'Расширенные возможности по присоединению каналов пользователям', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin: 0 10px 5px 3px;'' class=''font-icon-channel''></i>Расширенные возможности по присоединению каналов:</span>
<span style=''display: block; color: darkred; font-size: 0.8em''>Использование портфелей и новые команды управления ссылками на каналы</span>', '2018-03-26 13:00:00.000', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="J3O5Kx1E0aV7L2bD" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=J3O5Kx1E0aV7L2bD"/>

<p style=''line-height: 1.5; margin-bottom: 5px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>  	 
     Формируем актуальные связи!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
   Одной из наиболее важных задач, которые решаются в рамках современных систем диспетчеризации является обеспечение аутентичности пользователей по отношению к получаемой  информации от различных каналов измерительных приборов. В соответствии с многоканальной структурой большинства комбинированных приборов учета в нашей системе реализуется авторизация пользователя уровня отдельного<i style=''color: darkred; margin: 0 0px 5px 0px;'' class=''font-icon-channel''></i> <i style=''color: darkred; font-weight: 600;''>измерительного канала</i>, что позволяется строить гибкие схемы доступа к информации. В то же время подобный подход всегда приводит к сложностям сопровождения и требует усилий со стороны администраторов.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">С целью обеспечения более эффективного администрирования в дополнение к уже существовавшим средствам группового присоединения каналов нами были разработаны новые функциональные возможности этого инструмента. В частности, в диалоговом окне параметрии теперь обеспечивается  <i style=''color: darkred; font-weight: 600;''>поиск по всем элементам фильтров</i>; добавлена <i style=''color: darkred; font-weight: 600;''>команда отсоединения всех неактивных каналов</i> от группы пользователей, а также <i style=''color: darkred; font-weight: 600;''>команда отсоединения всех каналов</i> от одной учетной записи и, наконец, обеспечивается возможность присоединения/отсоединения <i style=''color: darkred; font-weight: 600;''>списка каналов, содержащихся в портфеле</i> для группы учетных записей.</p>
', NULL, 0,  N'eta.sys.leo', N'eta.sys.leo', '2018-03-26 12:45:06.350', '2018-03-26 14:24:59.843')
GO

EXEC(N'INSERT [EnergyTechAudit.PowerAccounting.Database].Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (75, N''2g8yB1Ex0K4L7N3F'', N''Анализ потребления тепловой энергии на нужды отопления'', N''<span style=''''display: block; color: darkred; font-weight: 600;''''><i style=''''color: darkred; margin: 0 15px 5px 3px;'''' class=''''font-icon-analitics2''''></i>Новые аналитические инструменты:</span>
<span style=''''display: block; color: darkred; font-size: 0.8em''''>Отчет "Анализ потребления тепловой энергии на нужды отопления"</span>'', ''2018-04-28 13:00:00.000'', N''<div style=''''marging-right: 10px; float: left; width: 250px; height: 170px'''' id="gallery2g8yB1Ex0K4L7N3F_IPreviewMutator"></div>

<p style=''''line-height: 1.5; margin-bottom: 5px''''>
  	<i style=''''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''''>  	 
     Взгляд в будущее!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
   Мы продолжает следовать по пути планомерного совершенствования существующих и создания новых <i style=''''color: darkred; font-weight: 600;''''>аналитических инструментов</i>, которые предоставляли бы <i style=''''color: darkred; font-weight: 600;''''>высокий уровень информационного обеспечения</i> для принятия решения об эффективности использования энергетических ресурсов. Существование и повседневное использование таких инструментов безусловно позволяет получать существенный <i style=''''color: darkred; font-weight: 600;''''>экономических эффект</i> от внедрения АСКУЭ.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">На основе исследования актуальных задач реального применения нашей системы нами разработан и находится на стадии активного внедрения специализированный аналитический отчет <i style=''''color: darkred; font-weight: 600;''''>"Анализ потребления тепловой энергии на нужды отопления"</i>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px"> 
  Целью анализа выполняемого в рамках формирования данного отчета является определение эффективности работы системы теплоснабжения, соответствия нормативного и фактического теплопотребления. Отчет дает возможность определить: фактическое потребление тепловой энергии в течении заданного периода времени, нормативное потребление тепловой энергии для конкретного температурного режима, получить сопоставление нормативного и фактического потребления в относительном и фактическом выражении.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
  <i style=''''color: darkred; font-weight: 600;''''>Исходными данными для анализа являются:</i>
 </p>
  <ul style="line-height: 1.5; text-indent: 20px; margin-top: 3px; list-style-type: none;">
    <li style="line-height: 1.5;">
      1.а.&nbsp;В случае использования общедомового теплосчетчика, учитывающего только теплопотребление на нужны отопления — потребление тепловой энергии за период и посуточно Qфакт;
     </li>
    <li>
      1.б.&nbsp;В случае использования общедомового теплосчетчика, учитывающего теплопотребление на нужны отопления и ГВС и при наличии учета потребления тепловой энергии системы ГВС — потребление тепловой энергии за вычетом потребления тепла на нужды системы ГВС. Тогда, фактическое потребление может быть рассчитано как Qфакт = Qобщ - Qгвс;
	</li>
    <li>
        1.в.&nbsp;В случае использования общедомового теплосчетчика, учитывающего теплопотребление на нужны отопления и ГВС и при наличии учета только холодной воды на нужны ГВС —   потребление тепловой энергии за вычетом расчетного потребления тепла на нужды системы ГВС, полученного с применением коэффициента подогрева q [Гкал/м3]. Данный коэффициент может быть определен с помощью инструментального аудита, либо применен определяемый постановлением исполком города. В этом случае Qфакт = Qобщ - Vгвс * q;	      
    </li>
    <li>
      
    2.&nbsp;Для выполнения анализа в рамках данного отчета необходимо за'
+ N'дать целый ряд параметров, в частности. Расчетную температура внутреннего воздуха помещения tпом, которая задается непосредственного в диалоговом окне параметрии отчета;
    </li>
    <li>
	3.&nbsp;Тариф на тепловую энергию Т[руб./Гкал] который, задается также непосредственного в диалоговом окне параметрии отчета;
      </li>    
    <li>
	4.&nbsp;<a href="javascript:;" data-core-entity-code="N4E1kC0b8x6wQl7s" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>Нормативное максимальное часовое потребление</a> тепловой энергии qнорм [Гкал/час]. Данный параметр задается в качестве дополнительного поля (динамического) для сущности "Строение" с использованием команды "Динамические параметры". При отсутствии назначенного динамического параметра для данного строения, его значение будет взято из диалогового окна параметрии отчета, заданного по умолчанию;      
     </li>    
    <li>
	5.&nbsp;Минимальная температура самой холодной пятидневки с обеспеченностью 0,92 по строительной климатологии tmin. Это значение может быть установлено на постоянной основе в словаре "Населенные пункты" для каждого отдельно взятого населенного пункта. При отсутствии этого значения в словаре оно будет взято из диалогового <a href="javascript:;" data-core-entity-code="2h7d5v8pF4wY0n6E" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>окна параметрии отчета</a>, также заданного по умолчанию;
      </li>    
    <li>
      6.&nbsp;Указание на применения учета потребления на нужды ГВС в соответствии с п 1.в. может быть задано в качестве динамического параметра для конкретного строения, а в случае отсутствия будет непосредственного взято из окна параметрии;
    </li>
    <li>
	7.&nbsp;Средняя температура наружного воздуха за рассматриваемый период и посуточно tнар.ср. вычисляется на основе среднесуточных значений температуры хранимых в системе метеоданных;      
     </li>    
    <li>
      8.&nbsp;Средняя температура теплоносителя в подающем трубопроводе за рассматриваемый период и посуточно tпод.ср., которая также вычисляется на основе хранимых архивных данных для указанного канала прибора;
     </li>
    <li>
      9.&nbsp;Средняя температура теплоносителя в обратном трубопроводе за рассматриваемый период и посуточно tобр.ср., также вычисляемая на основе хранимых архивных данных для указанного канала прибора;
    </li>
    <li>
      10.&nbsp;Средняя расчетная температура теплоносителя в подающем трубопроводе tрасч.под.ср. рассчитывается на основе соответствующего температурного графика, который должен быть задан в виде табличного динамического параметра для соответствующей ресурсоснабжающей организации (сущность "Организации");
      </li>
    <li>
      11.&nbsp;Средняя расчетная температура теплоносителя в обратном трубопроводе, полученная с применением температурного графика, за рассматриваемый период и посуточно tрасч.обр.ср. аналогично п.8. Если температурные графики для подающего и обратного трубопроводов не заданы, то отчет не может быть сформирован.
      </li>    
  </ul>
<p style="line-height: 1.5; text-indent: 20px; margin: 10px 0 10px 0">
  <i style=''''color: darkred; font-weight: 600;''''>Первая часть отчета</i> визуализирует набор данных из фактических и нормативных значений потребления за сутки и за период, а также вычисляет расчетные максимальную и фактическую нагрузку. Данные по потреблению тепловой энергии, в первую очередь, представляется в виде двух графиков временных зависимостей для фактического и нормативного потребления.
</p>
  <img style="display: block; margin-left: auto; margin-right: auto; width: 450px; cursor: pointer;" src="\eta_bin.axd?code=uSo7Qr3b6Jd2Va0l" data-core-command-show-image data-core-entity-code="uSo7Qr3b6Jd2Va0l" data-core-entity-type-name="Binary" data-core-entity-property-name="Data"\>

<p style="line-height: 1.5; text-indent: 20px; margin: 10px 0 10px 0">
Кроме того, графики сопровождаются таблич'
+ N'ным представлением соответствующих зависимостей, что позволяет наряду с качественным анализом текущего потребления тепловой энергии получить более детальное представление о посуточном фактическом и нормативном потреблении (в примере приведена только некоторая часть таблицы).
</p>
<table style="width: 450px; margin-left: auto; margin-right: auto;" class="simple-grid">
    <thead>
      <tr style="height:19px;">
      <th>Дата</th>
      <th>Qнорм, ГКал</th>
      <th>Qфакт, ГКал</th>   
    </tr>
      </thead>
    <tbody>  
    <tr style="height:19px;">
      <td>01.03.2018</td>
      <td>7.99</td>
      <td>8.24</td>
    </tr>
    <tr style="height:19px;">
      <td>02.03.2018</td>
      <td>7.77</td>
      <td>7.18</td>
    </tr>
    <tr style="height:19px;">
      <td>03.03.2018</td>
      <td>8.00</td>
      <td>7.37</td>
    </tr>
    <tr style="height:19px;">
      <td>04.03.2018</td>
      <td>7.06</td>
      <td>7.28</td>
    </tr>
    <tr style="height:19px;">
      <td>05.03.2018</td>
      <td>5.43</td>
      <td>5.53</td>
    </tr>
    <tr style="height:19px;">
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr style="height:19px;">
      <td>07.03.2018</td>
      <td>7.15</td>
      <td>6.85</td>
    </tr>
    <tr style="height:19px;">
      <td>08.03.2018</td>
      <td>6.86</td>
      <td>6.86</td>
    </tr>
    <tr style="height:19px;">
      <td>09.03.2018</td>
      <td>7.07</td>
      <td>6.89</td>
    </tr>
    <tr style="height:19px;">
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr style="height:19px;">
      <td style="text-align: center"><b>Итого</b></td>
      <td><b>198.21</b></td>
      <td><b>192.72</b></td>
    </tr>
      <tr>
          <td>Θфакт, ГКал/ч</td>			
          <td style="text-align: center" colspan="2">0.43</td>		      	
      </tr>
      <tr>
          <td>Θнорм, ГКал/ч</td>			
          <td style="text-align: center" colspan="2">0.4429</td>		      	
      </tr>
      <tr>
          <td>Экономия, Гкал</td>			
          <td style="text-align: center" colspan="2">5.49</td>		      	
      </tr>
      <tr>
          <td>Текущий тариф, руб/Гкал</td>			
          <td style="text-align: center"colspan="2">1 710.00</td>		      	
      </tr>
      <tr>
          <td >Экономия, руб</td>			
          <td style="text-align: center" colspan="2">9 390.97</td>		      	
      </tr>
    </tbody>
  </table> 

<p>В качестве заключения данного раздела приводятся выводы о соотношении фактического и нормативного потребления. Так, для приведенного примера, фактическое потребление повпадает с нормативным (Qфакт = Qнорм) с точность до 5%. Предельное отклонение, также как и некоторые другие параметры, указываются в окне параметрии отчета. В этом случае система теплоснабжения здания (строения) работает корректно.
</p>

<p style="clear: left; line-height: 1.5; text-indent: 20px; margin: 20px 0 10px 0">
  <i style=''''color: darkred; font-weight: 600;''''>Во второй части отчета</i> визуализируется набор данных из фактических и расчетных значений температур подачи и обратки за сутки и за рассматриваемый период. Как и в первой части отчета, данные представлены для быстрого качественного анализа ситуации в виде временной (посуточной) графической зависимости соответствующих параметров.
</p>

<img style="display: block; margin-left: auto; margin-right: auto; width: 450px; cursor: pointer;" src="\eta_bin.axd?code=wM8j4bStK3L0vU6y" data-core-command-show-image data-core-entity-code="wM8j4bStK3L0vU6y" data-core-entity-type-name="Binary" data-core-entity-property-name="Data"\>

<p style="line-height: 1.5; text-indent: 20px; margin: 10px 0 10px 0">
  Для возможного  более детального количественного анализа, во второй части, также имеет место табличное представление соответствующих данных, графики сопровождаются табличным представлением соответствующих зависимостей, что позволяет наряду с качественным анализом текущего потребления тепловой энергии получить более дета'
+ N'льное представления о посуточном фактическом и нормативном потреблении.
</p>

<table style="width: 450px; margin-left: auto; margin-right: auto;" class="simple-grid">
  <thead>
    <tr>
      <th>Дата</th>
      <th>Tн ср.,°С</th>
      <th>Tп ср.,°С</th>
      <th>Tп расч.ср.,°С</th>
      <th >ΔTп,°С</th>
      <th>Tоср.,°С</th>
      <th>Tо расч.ср.,°С</th>
      <th>ΔTо,°С</th>
    </tr>
  </thead>
 <tbody>
 <tr>
  <td>01.03.2018</td>
  <td>-18.34</td>
  <td>97.93</td>
  <td>92.95</td>
  <td>4.98</td>
  <td>58.35</td>
  <td>59.84</td>
  <td >-1.49</td>
 </tr>
 <tr>
  <td>02.03.2018</td>
  <td>-17.28</td>
  <td>97.76</td>
  <td>91.18</td>
  <td>6.58</td>
  <td>52.04</td>
  <td>58.92</td>
  <td>-6.88</td>
 </tr>
 <tr>
  <td>03.03.2018</td>
  <td>-18.39</td>
  <td>97.55</td>
  <td>93.02</td>
  <td>4.53</td>
  <td>51.56</td>
  <td>59.89</td>
  <td>-8.33</td>
 </tr>
 <tr>
  <td>04.03.2018</td>
  <td>-13.88</td>
  <td>97.04</td>
  <td>85.5</td>
  <td>11.54</td>
  <td>49.94</td>
  <td>56.19</td>
  <td>-6.25</td>
 </tr>
 <tr>
  <td>05.03.2018</td>
  <td>-6.06</td>
  <td>91.93</td>
  <td>72.2</td>
  <td>19.73</td>
  <td>42.59</td>
  <td>49.65</td>
  <td>-7.06</td>
 </tr>
 <tr>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
 </tr>
 <tr>
  <td>07.03.2018</td>
  <td>-14.31</td>
  <td>94.53</td>
  <td>86.23</td>
  <td>8.3</td>
  <td>49.68</td>
  <td>56.55</td>
  <td>-6.87</td>
 </tr>
 <tr>
  <td>08.03.2018</td>
  <td>-12.9</td>
  <td>93.81</td>
  <td>83.82</td>
  <td>9.99</td>
  <td>49.64</td>
  <td>55.32</td>
  <td>-5.67</td>
 </tr>
 <tr>
  <td>09.03.2018</td>
  <td>-13.91</td>
  <td>94.17</td>
  <td>85.55</td>
  <td>8.63</td>
  <td>51.91</td>
  <td>56.22</td>
  <td>-4.31</td>
 </tr>
 <tr>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
  <td>...</td>
 </tr>
  <tr>
  <td>Среднее / макс.отклонение</td>
  <td>-9.72</td>
  <td>91.13</td>
  <td>78.39</td>
  <td>24.66</td>
  <td>46.3</td>
  <td>52.67</td>
  <td>8.57</td>
 </tr>
</tbody></table>

<p style="line-height: 1.5; text-indent: 20px; margin: 10px 0 0 0">Заключение второй части отчета, дает резюме о максимальных отклонениях температур теплоносителя в подающем и обратном трубопроводах от заданных температурных графиков. Например, для приведенного случая выводы второй части отчета имеют следующий вид.</p>
<p style="text-indent: 20px; line-height: 1.5;">Максимальное отклонение за период от температурного графика по температуре в подающем трубопроводе составляет ±24.66 °С. Температурный график тепловой сети не соблюдается. Максимальное отклонение за период от температурного графика по температуре в обратном трубопроводе составляет ±8.57 °С. Температурный график тепловой сети не соблюдается.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin: 10px 0 0 0">Таким образом, данный отчет предоставляет результаты <i style=''''color: darkred; font-weight: 600;''''>комплексного аналза</i> эффективности работы системы теплоснабжения, соответствия нормативного и фактического теплопотребления, дает возможность сделать выводы на предмет соответствия температурного графика теплоносителя, что является одним их важнейших показателей соблюдения отопительных норм.</p><script data-core-entity=''''News''''>    
	// Pay attention that an object with the identifier of gallerySetting has been declared in the global area of a browser
  	var gallerySetting = jQuery.extend(Core.Resources.Internal.dxDefaultNewsImageGallerySetting, 
	{
		dataSource: 
        [
            {code: ''''Q5oG0A2p3BwE1J8x''''}, 
            {code: ''''uSo7Qr3b6Jd2Va0l''''},
            {code: ''''M4C1K3Ne5I6GoU2L''''}, 
            {code: ''''wM8j4bStK3L0vU6y''''}
        ]
    });                                                
    jQuery("#gallery2g8yB1Ex0K4L7N3F_IPreviewMutator").dxGallery(gallerySetting);      
</script> '', NULL, 0, N''eta.sys.leo'', N''eta.sys.leo'', ''2018-04-28 10:08:16.977'', ''2018-05-16 09:58:58.357'')')



GO
INSERT Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (77, N'K3H5J2pA0X1EbT6g', N'Мобильная версия консоли операционного администратора', N'<span style=''display: block; color: darkred; font-weight: 600;font-size: 0.9em''><i style=''color: darkred; margin: 0 5px 5px 3px;'' class=''font-icon-mobile''></i>Мобильная версия консоли операционного администратора</span>', '2018-07-09 9:00:00.000', N'<div style=''marging-right: 10px; float: left; width: 250px; height: 170px'' id="galleryK3H5J2pA0X1EbT6g_IPreviewMutator"></div>

<p style=''line-height: 1.5; margin-bottom: 5px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>  	 
     Еще один шаг вперед!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
   Браузеры и веб быстро становятся мобильной операционной системой будущего! Наши пользователи давно ожидают выпуска <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>мобильного браузерного приложения</i> для операционных администраторов, которое обеспечивало бы доступ к базовым функциональным возможностям, таким как поиск <i style=''text-indent: 0; color: darkred; font-weight: 600;''><i style=''text-indent: 0; margin: 0 5px 0px 0px;'' class=''font-icon-building font-icon-color-metrohover''></i>объекта диспетчеризации</i>, выбор <i style=''text-indent: 0; color: darkred; font-weight: 600;''><i style=''margin: 0 5px 0px 0px;'' class=''font-icon-channel font-icon-darkgreen''></i>канала измерительного устройства</i>, просмотр <i style=''text-indent: 0;color: darkred; font-weight: 600;''><i style=''color: darkred; margin: 0 5px 0px 0px;'' class=''font-icon-dashboard''></i>результатов измерения</i> и проверка связи с устройством.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">На настоящий момент нами был разработан прототип мобильной браузерной версии консоли операционного администратора, который обеспечивает доступ к перечисленным выше функциям.</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">Приложение доступно для относительно <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>современных мобильных телефонов</i>, которые поддерживают последние обновления браузеров, которые в свою очередь обеспечивают поддержку последних спецификаций JavaScript (ECMAScript 6). На основе предварительного анализа к таким мобильным платформам относятся устройства категорий Grade A и Grade B на базе операционных систем Android 4.3+ и iPhone OS 7.1+. Для нормального <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>функционирования приложения</i> обязательно воспользуйтесь функцией сброса браузерного кэша вашего мобильного телефона.</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">Мы предлагаем вам данный прототип мобильной части нашего приложения для тестирования и ждем ваших <i style=''text-indent: 0;color: darkred; margin: 0 5px 0px 0px;'' class=''font-icon-send''></i> отзывов, предложений и замечаний. Ваше мнение имеет огромное значение для развития нашего приложения! <i style=''text-indent: 0px; color: darkred; font-weight: 600;''></p>

<script data-core-entity=''News''>    
  	var gallerySetting = jQuery.extend(Core.Resources.Internal.dxDefaultNewsImageGallerySetting, 
	{
		dataSource: 
        [
            {code: ''It3r6x5P8F2VbUe0''}, 
            /*{code: ''vNr7Q5D1B4I0J6m2''},*/
            {code: ''u7h2K3Yp6ItNfJ4d''}, 
            {code: ''v7e1w8Yx2GiD4h6F''},          
          	{code: ''q6b2iG4lH3V5Pk8x''},
          	/*{code: ''M4G2J7W1F5D6pS0a''}          	*/
        ]
    });                                                
    jQuery("#galleryK3H5J2pA0X1EbT6g_IPreviewMutator").dxGallery(gallerySetting);      
</script> ', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2018-07-09 08:39:07.033', '2018-07-09 08:39:07.033')

GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(78, N'J3g2y8Vb6q1iDp5U', N'Новые возможности мобильной версии консоли операционного администратора ', N'<span style=''display: block; color: darkred; font-weight: 600;font-size: 0.85em''><i style=''color: darkred; margin: 0 5px 5px 3px;'' class=''font-icon-mobile''></i>Развитие мобильной версии консоли операционного администратора</span>', '2018-11-26 16:53:42.570', N'<div style=''marging-right: 10px; float: left; width: 250px; height: 170px'' id="galleryJ3g2y8Vb6q1iDp5U_IPreviewMutator"></div>

<p style=''line-height: 1.5; margin-bottom: 5px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>  	 
     Открываем новые измерения!
	</i>
</p>

<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
   <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>Чрезвычайно высокая степень востребованности</i> и многочисленные положительные отзывы о практическом применении <i style=''display: initial; font-size: 1.3em; margin: 0 5px 0px 0px;'' class=''font-icon-mobile font-icon-black''></i><i style=''text-indent: 0px; color: black; font-weight: 600;''>мобильной версии</i> консоли операционного администратора придали новый импульс для дальнейшего развития данной функциональной области нашего программного комплекса.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">В результате анализа требований нами был реализован следующий перечень наиболее значимых и востребованных функциональных возможностей:  
</p>
 <ul style=''line-height: 1.5; text-indent: 20px; margin-top: 3px; list-style-type: none;  margin-bottom: 5px''>
    <li style=''margin-top: 5px;''>
      <i style=''display: initial; font-size: 1.2em; margin: 0 5px 0px 0px;'' class=''font-icon-filter font-color-Unknown''></i> фильтрация списка каналов измерительных устройств по <a href="javascript:;" data-core-entity-code="0C5b4LkMsYn1VdGh" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>признаку статуса</a> последнего подключения к устройству службой считывателя устройств;
    </li>
    <li style=''margin-top: 5px;''>
      <i style=''display: initial; font-size: 1.2em; margin: 0 5px 0px 0px;'' class=''font-icon-regulator3 font-icon-color-darkred''></i>
  виджет дашборда канала <a href="javascript:;" data-core-entity-code="0a8X4N7v1e2Lw6h3" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>регуляторного типа</a> функциональные возможности, которого полностью соответствуют десктопной версии, в частности, в нем обеспечивается изменение параметра регулятора для пользователя в роли "Ответственный операционный администратор";
    </li>
    <li style=''margin-top: 5px;''>
      <i style=''display: initial; font-size: 1.2em; margin: 0 5px 0px 0px;'' class=''font-icon-expanded font-icon-darkgreen''></i>
  дочерний вид (detail view) записи в главном списке измерительных каналов, который содержит <a href="javascript:;" data-core-entity-code="1F5IcY3o8P7UjN0d" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>дополнительную информацию</a> о статистике подключений к точке доступа и устройству, процент успешных подключений, а также дублирующие команды проверки связи;
    </li>
   <li style=''margin-top: 5px;''>
      <i style=''display: initial; font-size: 1.2em; margin: 0 5px 0px 0px;'' class=''font-icon-charts font-icon-x1_2 font-icon-lightblue''></i>
  построение графиков <a href="javascript:;" data-core-entity-code="s6i1m0B7CdUp5v3o" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>временных зависимостей</a> измерительных параметров с поддержкой функций их масштабирования, экспорта изображений в формат SVG, экспорта координатной таблицы в формате XLSX, а также получения данных о значении измерительного параметра на графике в каждой отдельной его точке;
    </li>
   <li style=''margin-top: 5px;''>
      <i style=''display: initial; font-size: 1.2em; margin: 0 5px 0px 0px;'' class=''font-icon-map font-icon-x1_2 font-icon-red''></i>
  отображение маркера <a href="javascript:;" data-core-entity-code="w8C0l5r1h2Ot7aEg" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>местоположения</a> связанного объекта диспетчеризации на карте, с возможностью перехода в режим Street View.
    </li>
</ul>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">Таким образом, <i style=''display: initial; font-size: 1.3em; margin: 0'' class=''font-icon-mobile font-icon-black''></i> мобильная версия консоли операционного администратора шаг за шагом приближается по своим функциональным возможностям к полноценному мобильному приложению, позволяющему решать все более широкий спектр задач диспетчеризации, которые ранее были доступны только для настольных приложений.</p>

<script data-core-entity=''News''>    
  	var gallerySetting = jQuery.extend(Core.Resources.Internal.dxDefaultNewsImageGallerySetting, 
	{
		dataSource: 
        [
          	{code: ''s6i1m0B7CdUp5v3o''},
            {code: ''0C5b4LkMsYn1VdGh''},         
            {code: ''1D4M7u5o6sCi3LvR''}, 
            {code: ''0a8X4N7v1e2Lw6h3''},          
          	{code: ''1F5IcY3o8P7UjN0d''},          	
          	{code: ''w8C0l5r1h2Ot7aEg''}
        ]
    });                                                
    jQuery("#galleryJ3g2y8Vb6q1iDp5U_IPreviewMutator").dxGallery(gallerySetting);      
</script> ', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2018-11-26 16:59:54.107', '2018-11-27 16:28:07.133')

GO
INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(79, N'DanfossMCXNews', N'Danfoss MCX', N'<span style=''display: block; color: darkred; font-weight: 600;''>Погодный регулятор Danfoss MCX</span>
<span style=''display: block; color: darkred; font-size: 0.8em''>Добавлена новая модель прибора</span>', '2018-11-28 14:06:27.797', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="DanfossMCX" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=DanfossMCX"/>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
   В системе диспетчеризации стал доступен новый погодный регулятор - <i style=''color: darkred; font-weight: 600;''>контроллер Danfoss MCX</i>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
   Контроллер осуществляет управление электроприводом регулирующего клапана на греющем контуре ввода тепловой сети для обеспечения требуемой температуры в подающем трубопроводе нагреваемого контура согласно установленного графика.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
  Контроллер обладает богатым функционалом, который включает в себя:
  	<ul style=''list-style-position: inside; line-height: 2;''>
      <li>возможность программирования недельного режима работы: комфорт/эконом;</li>
      <li>ручное управление циркуляционным насосом;</li>
      <li>управление циркуляционным насосом в зависимости от температуры наружного воздуха прекращения отопительного сезона;</li>
      <li>поочередное включение подпиточных насосов и т.д.</li>
   </ul>
</p>', NULL, 0, N'eta.sys.max', N'eta.sys.max', '2018-11-28 14:07:40.747', '2018-11-28 14:18:15.283')
GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, [ViewCounter], CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) 
VALUES(80, N'v7g2i8hR3uXdY6cS', N'Приборная панель в конфигураторе системы', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin: 0 5px 5px 3px;'' class=''font-icon-dashboard''></i>Новые функции приборной панели конфигуратора системы</span>', '2018-11-28 15:33:48.050', N'<div style=''marging-right: 10px; float: left; width: 250px; height: 170px'' id="galleryv7g2i8hR3uXdY6cS_IPreviewMutator"></div>

<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Взаимное проникновение идей!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
 Практика применения показывает, что эффективность решения задач конфигурирования измерительных приборов и каналов требует получения доступа к измерительной информации верхнего уровня. Такая возможность была ранее реализована в конфигураторе системы на основе аналога <a href="javascript:;" data-core-entity-code="0B3K5Q2IcL4P6Af8" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>приборной панели</a> (миниборд).
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
  Идея получила свое дальнейшее развитие в связи с необходимостью графического представления временных зависимостей измерительных параметров непосредственно в конфигураторе. В результате приборная панель в конфигураторе была наделена функцией <a href="javascript:;" data-core-entity-code="P5I2mWv4F8UxQ1o7" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>отображения графиков</a>. 
 </p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
  Другим важным усовершенствованием приборной панели конфигуратора стало реализация полноценной мультиприборной <a href="javascript:;" data-core-entity-code="v7h2e1r0T6a8Si4C" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>регуляторной панели</a>, которая, как и ее аналог в консоли операционного администратора обеспечивает доступ к изменению регуляторных параметров измерительных приборов и регуляторов.
 </p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
Таким образом, анализ прецедентов использования конфигуратора доказывает потребность не только в функциях диагности прибора при его первичном конфигурировании, но и получении измерительной информации верхнего абстрактного (шаблонизированного) уровня.
</p>
  
<script data-core-entity=''News''>    
  	var gallerySetting = jQuery.extend(Core.Resources.Internal.dxDefaultNewsImageGallerySetting, 
	{
		dataSource: 
        [
          {code: ''P5I2mWv4F8UxQ1o7''},   
          {code: ''v7h2e1r0T6a8Si4C''}            
        ]
    });                                                
    jQuery("#galleryv7g2i8hR3uXdY6cS_IPreviewMutator").dxGallery(gallerySetting);      
</script> ', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2018-11-28 16:34:14.783', '2018-11-29 10:50:53.367')
GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate, ViewCounter) 
VALUES(81, N'2I3J6Rc0EwN5Ug1K', N'Упорядочивание каналов', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin: 0 5px 5px 3px;'' class=''font-icon-channel-asc''></i>Инструменты организации  порядка перечисления каналов</span>', '2018-12-04 09:45:00.147', N'<div style=''marging-right: 10px; float: left; width: 250px; height: 170px'' id="gallery2I3J6Rc0EwN5Ug1K_IPreviewMutator"></div>

<p style=''line-height: 1.5; margin-bottom: 10px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>
  	Создавайте собственный порядок!
	</i>
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">
  <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>Порядок следования каналов</i> на основе их идентификаторов, который действует по умолчанию в сущностном дереве консоли операционного администратора и списке объектов диспетчеризации мобильного клиента не всегда соответствует логике предметной области.
</p>
<p style=''display: none''>Возможный лексикографический порядок их перечисления на основе наименования также не может быть эффективно использован.</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">В соответствии  с вашими предложениями нами был разработан простой и эффективный инструмент выстраивания порядка в списке каналов, связанных с выбранным строением. Диалоговое окно нового <a href="javascript:;" data-core-entity-code="1E4L2Ft3k7a0V6x8" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>плагина</a> "Порядок каналов" доступно для вызова из палитры инструментов формы "Строения".</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">Применяя операцию "перетаскивания", можно быстро построить необходимый <a href="javascript:;" data-core-entity-code="0bY8Un7p4c6k1r2f" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" data-core-command-show-image>порядок следования</a>, который может быть зафиксирован на постоянной основе сохранением в базе данных. Для восстановления исходного порядка в соответствии с идентификаторами каналов имеется команда сброса ранее установленного произвольного порядка. Инструмент позволяет устанавливать порядок каналов в целом по строению, так и в соответствии с группировкой по помещениям. </p>
<script data-core-entity=''News''>    
  	var gallerySetting = jQuery.extend(Core.Resources.Internal.dxDefaultNewsImageGallerySetting, 
	{
		dataSource: 
        [
          {code: ''1E4L2Ft3k7a0V6x8''},   
          {code: ''0bY8Un7p4c6k1r2f''}            
        ]
    });                                                
    jQuery("#gallery2I3J6Rc0EwN5Ug1K_IPreviewMutator").dxGallery(gallerySetting);      
</script> ', NULL, N'eta.sys.leo', N'eta.sys.leo', '2018-12-04 09:45:42.350', '2018-12-04 11:31:33.657', 0)

GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate, ViewCounter) VALUES(82, N'DanfossECL210NewKeyA217', N'Danfoss ECL A217.3', N'<span style=''display: block; color: darkred; font-weight: 600;''>Новый ключ регулятора Danfoss ECL210/310 - A217.3</span>
<span style=''display: block; color: darkred; font-size: 0.8em''>Добавлена поддержка нового приложения A217.3</span>', '2018-12-07 15:00:27.797', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="DanfossECL210" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=DanfossECL210"/>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
  Датская компания <i style=''color: darkred; font-weight: 600;''>Danfoss A/S</i> не стоит на месте и продолжает развивать свои приложения для популярного погодного регулятора ECL 210/310. На этот раз в систему диспетчеризации добавлена возможность работы с новым ключом <i style=''color: darkred; font-weight: 600;''>A217.3</i>. 
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
  Данное приложение позволяет поддерживать заданную температуру в системе горячего водоснабжения. В соответствии с недельным расписанием (до 3 периодов в комфортном режиме в день) контур ГВС может быть переключен в комфортный режим или в режим сниженного энергопотребления. Регулятор позволяет управлять циркуляционным насосом, который работает по отдельному недельному расписанию (до 3 периодов в комфортном режиме в день).
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
  Дополнительно может быть подсоединен датчик протока, сигнал от которого может быть выдан для нагрева ГВС по требованию (распределение ГВС / отвод ГВС). Приложение поддерживает работу как с теплообменниками, так и с баками-аккумуляторами.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
  В системе диспетчеризации появились два новых шаблона для работы с данным видом приложений: <i style=''color: darkred; font-weight: 600;''>"ECL310 - "Система мониторинга" (A217.3 - ГВС)"</i> - мониторинговый канал и <i style=''color: darkred; font-weight: 600;''>"ECL310 - "Система регулирования" (A217.3, ГВС)"</i> - регуляционный канал.
</p>', NULL, N'eta.sys.max', N'eta.sys.max', '2018-12-07 14:36:57.217', '2018-12-07 15:49:22.633', 1)
GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate, ViewCounter) VALUES(83, N'DanfossECL300_C66RS485', N'Danfoss ECL C66 RS485', N'<span style=''display: block; color: darkred; font-weight: 600;''>Ключ регулятора Danfoss ECL 200/300 - С66 RS485</span>
<span style=''display: block; color: darkred; font-size: 0.8em''>Добавлена поддержка приложения C66 через RS485</span>', '2018-12-12 18:00:27.797', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="ECL300C66" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=ECL300C66"/>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
  Мы продолжаем развивать наш программный продукт и стремимся поддерживать не только новейшие приборы, но также и устаревшие версии, которые продолжают использоваться нашими заказчиками. Ранее система диспетчеризации поддерживала работу с картой C66 для регуляторов ECL 200/300, подключенных через RS-232. Эта карта использует устаревший протокол компании Danfoss. Однако, параллельно с версией для RS-232, существовала версия, поддерживающая протокол Modbus.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
  Теперь появилась возможность использовать карту C66 для Modbus. Она обладает более богатым набором функций и возможностей для регулирования, нежели карта, работающая через RS-232. Данная карта явила собой предтечу для появления современных новых ключей-приложений, которые теперь повсеместно используются в регуляторах Danfoss ECL 210/310.
</p>', NULL, N'eta.sys.max', N'eta.sys.max', '2018-12-12 17:45:11.450', '2018-12-12 17:56:35.350', 1)
GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate, ViewCounter) VALUES(84, N'PSCH_4TM_05MK', N'Счетчик электричества ПСЧ-4ТМ.05МК', N'<span style=''display: block; color: darkred; font-weight: 600;''>Новый прибор - ПСЧ-4ТМ.05МК</span>
<span style=''display: block; color: darkred; font-size: 0.8em''>Мы продолжаем пополнять список поддерживаемых приборов!</span>', '2018-12-26 13:00:27.797', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="PSCH4TM05MK" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=PSCH4TM05MK"/>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
  В системе диспетчеризации появился новый прибор производства Нижегородского научно-производственного объединения имени М.В.Фрунзе - <i style=''color: darkred; font-weight: 600;''>ПСЧ-4ТМ.05МК</i>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
 Как и предыдущий счетчик СЭТ-4ТМ.03М, добавленный в систему в 2017 году, он предназначен для многотарифного учета активной и реактивной энергии. Тарификатор прибора может содержать 4 тарифные зоны, против 8 тарифных зон у СЭТ-4ТМ.03М.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
 Прибор содержит 2 независимых массивов профиля мощности, которые могут заполняться значениями с временем интегрирования от 1 до 60 минут. <i style=''color: darkred; font-weight: 600;''>ПСЧ-4ТМ.05МК</i> выдает огромный массив разнообразной информации о текущих измеряемых параметрах: мгновенные фазные напряжения и токи, мгновенная активная, реактивная и полная мощность, различные коэффициенты искажения и прочее.
</p>', NULL, N'eta.sys.max', N'eta.sys.max', '2018-12-26 12:38:29.647', '2018-12-26 12:44:08.157', 1)
GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate, ViewCounter) VALUES(85, N'ECL110_130', N'Danfoss ECL Comfort 110', N'<span style=''display: block; color: darkred; font-weight: 600;''>Поддержка Danfoss ECL Comfort 110</span>
', '2019-03-11 15:00:27.797', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="ECL110_130" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=ECL110_130"/>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
 Теперь система диспетчеризации также поддерживает регуляторы <i style=''color: darkred; font-weight: 600;''>Danfoss ECL Comfort 110</i>.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
ECL Comfort 110 - электронный контроллер применяемый в одноконтурных системах централизованного теплоснабжения и ГВС. Электронный регулятор имеет функцию погодной компенсации для системы отопления или поддержания постоянной температуры в системе ГВС.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
 Возможно переключение регулятора на другие задачи с помощью чипа и коммуникационного интерфейса.
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
 В данный момент реализована поддержка <i style=''color: darkred; font-weight: 600;''>ключа-приложения 130</i>.
</p>', NULL, N'eta.sys.max', N'eta.sys.max', '2019-03-11 14:25:20.693', '2019-03-11 14:29:39.470', 2)
GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate, ViewCounter) VALUES(86, N'0BlR4kWi3E6YjOt1', N'Термоконтроллер "ПРАМЕР-710"', N'<span style=''display: block; color: darkred; font-weight: 600;''><i style=''color: darkred; margin: 0 5px 5px 3px;''></i>Термоконтроллер "ПРАМЕР-710"</span>', '2019-04-02 10:11:53.910', N'<div style=''marging-right: 10px; float: left; width: 250px; height: 170px'' id="galleryCipkaPupka_IPreviewMutator"></div>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">Появилась возможность диспетчеризировать термоконтроллер "ПРАМЕР-710". С помощью данного прибора можно контролировать работу системы отопления, а также управлять системой ГВС. Основной принцип управления системой отопления заключается в автоматическом изменении температуры подающего теплоносителя для поддержания заданной температуры в помещениях объекта управления.</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">В контроллере реализован гибкий алгоритм управления с учетом ограничений по двум основным критериям управления:</p>
<p style="line-height: 1.5; text-indent: 25px; margin-top: 5px">1. Вычисление и поддержание температуры теплоносителя Тпод на подаче в контур отопления в зависимости от температуры наружного воздуха Тнар и заданной температуры в помещении (температуры комфорта);</p>
<p style="line-height: 1.5; text-indent: 25px; margin-top: 5px">2. Вычисление и поддержание температуры теплоносителя Тпод на подаче в контур отопления в зависимости от температуры наружного воздуха и заданной граничной температуры обратного теплоносителя Тобр.</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">Для работы с контроллером были реализованы шаблоны каналов "Pramer710 - "Система мониторинга" (Id=213) и "Pramer710 - "Система регулирования" (Id=214). С помощью канала мониторинга можно отслеживать показания температур в подаче, обратке, помещении и наружного воздуха, а также положение заслонки (клапана). Канал регулирования позволяет задавать точки температурного графика, требуемые температуры и прочее.</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 5px">Более подробно об основных возможностях работы с "ПРАМЕР-710" можно увидеть на нашем <a href="https://www.youtube.com/watch?v=2uYMb1CbAn8" target="_blank">Youtube-канале</a></p>

<script data-core-entity=''News''>    
  	var gallerySetting = jQuery.extend(Core.Resources.Internal.dxDefaultNewsImageGallerySetting, 
	{
		dataSource: 
        [
          {code: ''Pramer710''},   
          {code: ''Pramer710Report''}            
        ]
    });                                                
    jQuery("#galleryCipkaPupka_IPreviewMutator").dxGallery(gallerySetting);      
</script> ', NULL, N'eta.sys.max', N'eta.sys.max', '2019-04-02 10:13:44.033', '2019-04-02 10:30:52.763', 1)
GO

INSERT Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, ViewCounter, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (90, N'vP7lNdH4W1R2y8F3', N'Уведомления о нештатных ситуациях в мобильной версии приложения', N'<span title=''Уведомления о нештатных ситуациях в мобильной версии приложения'' style=''display: block; color: darkred; font-weight: 600;font-size: 0.9em''><i style=''color: darkred; margin: 0 5px 5px 3px;'' class=''font-icon-emergency''></i>Уведомления о нештатных ситуациях в мобильной версии приложения</span>', '2019-11-08 09:00:00.000', N'<div style=''marging-right: 10px; float: left; width: 250px; height: 170px'' id="galleryvP7lNdH4W1R2y8F3_IPreviewMutator"></div>


<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
   Инструменты веб-аналитики показывают устойчивую тенденцию  на увеличение числа пользователей, которые постоянно применяют при работе с нашим программным комплексом  мобильные телефоны (по данным Google Analitics 40.9%). В связи с этим, мы рады сообщить, что нами продолжает развиваться функциональный набор мобильной части нашего приложения.
</p>

<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">На этот раз была реализована поддержка (в тестовом режиме) Push Notifications (уведомлений) при получении сообщений о <i style=''text-indent: 0px;line-height: 1;margin-right: 0px;'' class=''font-icon-x1_2 font-icon-orangered font-icon-emergency''></i> нештатных ситуациях. Технология Push Notifications позволяют принимать уведомления браузерами мобильных устройств в реальном времени даже в случае нахождения телефона в неактивном состоянии.</p>

<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">На настоящий момент Push-уведомления доступны только пользователям, использующим сайты с приложениеми развернутыми <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>на вер-серверах с валидным SSL сертификатом</i> (только по протоколу HTTPS) и, которые применяют в своей работе ОС <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>Android</i> (версий от 4.4 и выше) с мобильными браузерами <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>Google Chrome for Android, Opera for Android и Samsung Internet</i> (по данным Google Analitics 73.1% от всей аудитории пользователей мобильной версии приложения).</p>

<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">Мы предлагаем вам принять участие в тестировании Push-уведомлений и ждем ваших отзывов (<a style=''text-decoration: none'' href="mailto:eta.development.team@gmail.com">eta.development.team@gmail.com</a>), предложений и замечаний. Ваше мнение имеет огромное значение для развития нашего приложения!</p>

<script data-core-entity=''News''>    
  	var gallerySetting = jQuery.extend(Core.Resources.Internal.dxDefaultNewsImageGallerySetting, 
	{
      	height: 240,
		dataSource: 
        [
            {code: ''w8f7Uo5CkTi3l6Px''},             
            {code: ''tX7oN2J0B1H6G4fD''}, 
            {code: ''w8Sp6H5j0Rf4y1Qd''},
          	{code: ''tWkO6Q8r3lF5Vs1e''},
          	{code: ''r6A3e2J1i8oTyC0h''},
            {code: ''r6d7Vu1m4Il2cO5S''}          	
        ]
    });                                                
    jQuery("#galleryvP7lNdH4W1R2y8F3_IPreviewMutator").dxGallery(gallerySetting);      
</script> ', NULL, 16, N'eta.sys.leo', N'eta.sys.leo', '2019-11-07 15:37:05.013', '2019-11-07 19:59:58.640')
GO

INSERT INTO Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, ViewCounter, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES(91, N'VISTNEWS', N'VIST', N'<span style=''display: block; color: darkred; font-weight: 600;''>Теплосчетчик ВИС.Т</span>', '2019-12-04 17:44:02.790', N'<img class="dxeImage admin-area-news-body-image" data-core-command-show-image data-core-entity-code="VIST" data-core-entity-type-name="Binary" data-core-entity-property-name="Data" style="float: left; cursor: pointer; width: 250px; margin-right: 10px" src="\eta_bin.axd?code=VIST"/>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
 В системе диспетчеризации появилась возможность снимать показания с теплосчетчиков <i style=''color: darkred; font-weight: 600;''>ВИС.Т</i> НПО "Тепловизор".
</p>
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
 Он предназначен для измерения, вычисления, архивации, индикации и вывода на внешние устройства количества тепловой энергии (теплоты) и параметров теплоносителя в любых системах теплопотребления. При этом теплосчётчик может обслуживать одновременно до 3-х теплосистем произвольной конфигурации с индивидуальным набором параметров. Прибор может быть установлен как у потребителей, так и у производителей тепловой энергии, позволяя кардинальным образом сократить количество теплосчетчиков на узлах с большим числом труб. Это идеальное решение для всех случаев, в которых прежде приходилось ставить более одного теплосчетчика.
</p>
', NULL, 1, N'eta.sys.max', N'eta.sys.max', '2019-12-04 17:44:29.933', '2019-12-04 17:46:48.700')
GO

INSERT Admin.News(Id, Code, Description, Caption, Date, Text, BinaryId, ViewCounter, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) VALUES (92, N'0A4YnH8Q2Rm5Px6L', N'Усовершенствования интерфейса мобильного приложения', N'<span title=''Усовершенствования интерфейса мобильного приложения'' style=''display: block; color: darkred; font-weight: 600;font-size: 0.9em''><i style=''color: darkred; margin: 0 5px 5px 3px;'' class=''font-icon-mobile''></i>Усовершенствования интерфейса мобильного приложения</span>', '2019-12-10 11:41:06.787', N'<div style=''marging-right: 10px; float: left; width: 250px; height: 170px'' id="gallery0A4YnH8Q2Rm5Px6L_IPreviewMutator"></div>

<p style=''line-height: 1.5; margin-bottom: 5px''>
  	<i style=''font-weight: 600; font-size: 12pt; color: darkred; letter-spacing: 1.5px''>  	 
     Адаптивность к новому!
	</i>
</p>

<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">
   В последнем выпуске мобильного приложения системы диспетчеризации <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>ЭТА24™</i> нами были разработаны новые усовершенствованные навигационные элементы управления и применены на всех четырех основных страницах приложения. Классическое меню было заменено на, так называемую,  <i style=''text-indent: 0px; color: darkred; font-weight: 600;''>боковую панель меню (drawer)</i> - более удобный и получающий все большее распространение в адаптивных макетах мобильных веб-приложений новый элемент управления <i style=''text-indent: 0px;line-height: 1;margin-right: 0px;'' class="dx-icon-menu dx-icon"></i> .
</p>

<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">Применение нового элемента интерфейса позволит в дальнейшем расширить функциональный состав мобильного приложения путем добавление потенциального неограниченного множества элементов (menu items), обеспечивающих доступ к новым функциям, виджетам и командам.</p>
  
<p style="line-height: 1.5; text-indent: 20px; margin-top: 3px">Мы предлагаем вам принять участие в тестировании новых функциональных элементов и ждем ваших отзывов (<a style=''text-decoration: none'' href="mailto:eta.development.team@gmail.com">eta.development.team@gmail.com</a>, <a style=''text-decoration: none'' href="mailto:eta.development.leo@outlook.com">eta.development.leo@outlook.com</a>) предложений о доработках мобильного приложения. Ваше мнение имеет огромное значение для развития нашего приложения!</p>

<script data-core-entity=''News''>    
  	var gallerySetting = jQuery.extend(Core.Resources.Internal.dxDefaultNewsImageGallerySetting, 
	{
      	height: 240,
		dataSource: 
        [
            {code: ''Nx4s8f2Gc6H5MiP3''},             
            {code: ''s6qWy8dF5J3UlHnP''}, 
            {code: ''Jt3s1d0aBg7h2oV6''}          	 	
        ]
    });                                                
    jQuery("#gallery0A4YnH8Q2Rm5Px6L_IPreviewMutator").dxGallery(gallerySetting);      
</script> ', NULL, 0, N'eta.sys.leo', N'eta.sys.leo', '2019-12-10 11:43:30.047', '2019-12-10 14:37:48.267')


SET IDENTITY_INSERT [Admin].[News] OFF
GO