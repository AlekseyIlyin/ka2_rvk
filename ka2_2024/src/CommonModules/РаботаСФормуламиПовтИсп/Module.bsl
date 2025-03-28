#Область СлужебныеПроцедурыИФункции

#Область ОпределениеСвойствДополнительныхХарактеристик

// Возвращает описание поддерживаемых источников характеристик.
//
// Возвращаемое значение:
//  ТаблицаЗначений - таблица, описание поддерживаемых источников характеристик:
//    * МетаданныеИсточника - ОбъектМетаданных - Метаданные источника характеристик.
//    * ПрефиксТипаВидаХарактеристик - Строка - Идентификатор источника характеристик.
//    * ПолеИдентификатора - Строка -  Имя поля (реквизита) идентификатора (или наименования) вида характеристик.
//                           Например, "ИдентификаторДляФормул" для плана видов характеристик ДополнительныеРеквизитыИСведения.
//    * ПолеТипаЗначений   - Строка - Имя поля (реквизита), содержащее тип значения вида характеристик.
//    		Если указано выражение типа, то указание поля типа значения является не обязательным.
//    * ИспользуетсяВыражениеТипаЗначений - Булево - Флаг использования выражения типа значений, тогда вместо обращения
//    		к полю будет указано выражение.
//    		Например, для справочника ВидыКонтактнойИнформации.
//    * ВыражениеТипаЗначений - Строка - Выражение типа значений. Используется при отсутствии поля типа значений.
//    		Например, для справочника ВидыКонтактнойИнформации можно использовать
//    		выражение "ТИП(СТРОКА)".
//    * ПереопределениеВыраженияТипаЗначений - ОписаниеТипов - Содержит описание типов. Необходимо задавать всегда, когда нет реального поля,
//    		содержащего тип значения (не ПВХ, ИспользуетсяВыражениеТипаЗначений = Истина).
//    		Переопределение в методе НоваяСтрокаДереваПоПолюКомпоновки.
//    * УникальностьИмениВПределахВсейТаблицыХарактеристик - Булево - Если Истина, то идентификатор характеристики (поле имени) уникален
//    		во всей таблице характеристик. Например, значение поля "Имя" дополнительных реквизитов
//    		и сведений уникально во всей таблице ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения
//    		(т.к. один и тот же реквизит может входить в состав разных наборов).
//    		Если Ложь, то уникальность идентификатора характеристики (поле имени) не обеспечивается.
//    		Например, видов для контактной информации идентификатор "Телефон" будет использоваться
//    		в наборах "Контрагент" / "Организация" / "ФизическоеЛицо" и т.д.
//    		Если вид контактной информации указывается для одного типа, то мы можем точно определить
//    		параметры вида контактной информации (представление, тип). Если вид контактной информации
//    		указывается для составного типа, то параметры вида контактной информации (представление, тип)
//    		определяются так же как для обычных реквизитов (Представление берется с наименьшим значением,
//    		тип контактной информации указывается "прочее").
//
Функция СвойстваПоддерживаемыхИсточниковХарактеристик() Экспорт
	
	ОписаниеСтроки = Новый ОписаниеТипов("Строка",, Новый КвалификаторыСтроки(0, ДопустимаяДлина.Переменная));
	ТаблицаСвойств = Новый ТаблицаЗначений();
	ОписаниеБулево = Новый ОписаниеТипов("Булево");
	ТаблицаСвойств.Колонки.Добавить("МетаданныеИсточника");
	ТаблицаСвойств.Колонки.Добавить("ПрефиксТипаВидаХарактеристик", ОписаниеСтроки);
	ТаблицаСвойств.Колонки.Добавить("ПолеИдентификатора", ОписаниеСтроки);
	ТаблицаСвойств.Колонки.Добавить("ПолеТипаЗначений", ОписаниеСтроки);
	ТаблицаСвойств.Колонки.Добавить("ИспользуетсяВыражениеТипаЗначений", ОписаниеБулево);
	ТаблицаСвойств.Колонки.Добавить("ВыражениеТипаЗначений", ОписаниеСтроки);
	ТаблицаСвойств.Колонки.Добавить("ПереопределениеВыраженияТипаЗначений");
	ТаблицаСвойств.Колонки.Добавить("УникальностьИмениВПределахВсейТаблицыХарактеристик", ОписаниеБулево);
	
	Свойства = ТаблицаСвойств.Добавить();
	Свойства.МетаданныеИсточника = Метаданные.ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения;
	Свойства.ПрефиксТипаВидаХарактеристик = "ДР.";
	Свойства.ПолеИдентификатора = "ИдентификаторДляФормул";
	Свойства.ПолеТипаЗначений = "ТипЗначения";
	Свойства.ИспользуетсяВыражениеТипаЗначений = Ложь;
	Свойства.ВыражениеТипаЗначений = "";
	Свойства.УникальностьИмениВПределахВсейТаблицыХарактеристик = Истина;
	
	Свойства = ТаблицаСвойств.Добавить();
	Свойства.МетаданныеИсточника = Метаданные.Справочники.ВидыКонтактнойИнформации;
	Свойства.ПрефиксТипаВидаХарактеристик = "КИ.";
	Свойства.ПолеИдентификатора = "ИдентификаторДляФормул";
	Свойства.ПолеТипаЗначений = "";
	Свойства.ИспользуетсяВыражениеТипаЗначений = Истина;
	Свойства.ВыражениеТипаЗначений = "ТИП(СТРОКА)";
	Свойства.ПереопределениеВыраженияТипаЗначений = Новый ОписаниеТипов("Строка");
	Свойства.УникальностьИмениВПределахВсейТаблицыХарактеристик = Ложь;
	
	ТаблицаСвойств.Индексы.Добавить("МетаданныеИсточника");
	ТаблицаСвойств.Индексы.Добавить("ПрефиксТипаВидаХарактеристик");
	
	Возврат ТаблицаСвойств;
	
КонецФункции

// Возвращает соответствие английских и русских имен стандартных реквизитов.
// 
// Возвращаемое значение:
// 	Соответствие - Соответствие английских и русских имен стандартных реквизитов.
//
Функция СоответствияИменСтандартныхРеквизитов() Экспорт
	
	СоответствиеИмен = Новый Соответствие;
	СоответствиеИмен.Вставить("DeletionMark", "ПометкаУдаления");
	СоответствиеИмен.Вставить("Owner", "Владелец");
	СоответствиеИмен.Вставить("Code", "Код");
	СоответствиеИмен.Вставить("Parent", "Родитель");
	СоответствиеИмен.Вставить("Predefined", "Предопределенный");
	СоответствиеИмен.Вставить("IsFolder", "ЭтоГруппа");
	СоответствиеИмен.Вставить("Description", "Наименование");
	СоответствиеИмен.Вставить("Ref", "Ссылка");
	СоответствиеИмен.Вставить("PredefinedDataName", "ИмяПредопределенныхДанных");
	СоответствиеИмен.Вставить("Date", "Дата");
	СоответствиеИмен.Вставить("Number", "Номер");
	СоответствиеИмен.Вставить("Posted", "Проведен");
	СоответствиеИмен.Вставить("ValueType", "ТипЗначения");
	СоответствиеИмен.Вставить("Type", "Вид");
	СоответствиеИмен.Вставить("Order", "Порядок");
	СоответствиеИмен.Вставить("ActionPeriodIsBasic", "Забалансовый");
	СоответствиеИмен.Вставить("HeadTask", "ВедущаяЗадача");
	СоответствиеИмен.Вставить("Completed", "Завершен");
	СоответствиеИмен.Вставить("Started", "Стартован");
	СоответствиеИмен.Вставить("BusinessProcess", "БизнесПроцесс");
	СоответствиеИмен.Вставить("Executed", "Выполнена");
	СоответствиеИмен.Вставить("RoutePoint", "ТочкаМаршрута");
	СоответствиеИмен.Вставить("SentNo", "НомерОтправленного");
	СоответствиеИмен.Вставить("ReceivedNo", "НомерПринятого");
	СоответствиеИмен.Вставить("ThisNode", "ЭтотУзел");
	
	
	// Обратное соответствие.
	Для каждого КлючИЗначение Из СоответствиеИмен Цикл
		СоответствиеИмен.Вставить(КлючИЗначение.Значение, КлючИЗначение.Ключ);
	КонецЦикла;
	
	Возврат СоответствиеИмен;
	
КонецФункции

#КонецОбласти

Функция ПолноеИмяТаблицыДанных(ПолноеИмяОбъектаМетаданных) Экспорт
	Возврат РаботаСФормулами.ПолноеИмяТаблицыДанных(ПолноеИмяОбъектаМетаданных);
КонецФункции


#Область МетодыДляОбновленияИнформационнойБазы


// Описание
// 
// Возвращаемое значение:
// 	Соответствие - соответствие представления и мест назначения характеристик:
// 	 *Ключ - Строка - Представление характеристики.
// 	 *Значение - Соответствие - соответствие типа объекта метаданных, которому принадлежит характеристика и ее параметров:
// 	        **Ключ - Тип - тип объекта метаданных, которому принадлежит характеристика. Одна характеристика может
// 	        				может быть указана нескольким типам.
// 	        **Значение - Структура - Параметры характеристики:
// 	             ***Характеристика - ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения, СправочникСсылка.ВидыКонтактнойИнформации - Ссылка на характеристику.
// 	             ***Идентификатор - Строка - Идентификатор характеристики вида {Префикс.Идентификатор}
// 	             ***ТипЗначения - ОписаниеТипов - Тип значения характеристики.
//
Функция ХарактеристикиПоПредставлениям() Экспорт
	
	ТипВсеСсылки = ОбщегоНазначения.ОписаниеТипаВсеСсылки();
	Возврат РаботаСФормулами.ХарактеристикиПоПредставлениям(ТипВсеСсылки);
	
КонецФункции

#КонецОбласти




#КонецОбласти