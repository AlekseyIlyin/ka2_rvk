#Область ПрограммныйИнтерфейс

//++ Локализация
#Область Фискализация

// Возвращает таблицу товаров для заполнения позиций строк в параметрах чека
//
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ для получения товарных позиций
// Возвращаемое значение:
// 	ТаблицаЗначений - Таблицу с товарными позициями с количественными и суммовыми показателями
Функция ПозицииНоменклатурыПоДокументу(ДокументСсылка) Экспорт

	РеквизитыДокумента = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ДокументСсылка, "Дата, Валюта, Организация");

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаДокумента.НомерСтроки КАК НомерСтроки,
	|	ТаблицаДокумента.Номенклатура КАК Номенклатура,
	|	ТаблицаДокумента.Характеристика КАК Характеристика,
	|	ТаблицаДокумента.Упаковка КАК Упаковка,
	|	ТаблицаДокумента.КоличествоУпаковок КАК Количество,
	|	ТаблицаДокумента.Цена КАК Цена,
	|	ТаблицаДокумента.СуммаСНДС КАК Сумма,
	|	ТаблицаДокумента.СтавкаНДС КАК СтавкаНДС,
	|	ТаблицаДокумента.СуммаНДС КАК СуммаНДС,
	|	ТаблицаДокумента.Ссылка.Валюта КАК Валюта,
	|	ТаблицаДокумента.Ссылка.ЦенаВключаетНДС КАК ЦенаВключаетНДС
	|ПОМЕСТИТЬ ТаблицаНоменклатуры
	|ИЗ
	|	Документ.ЗаказПоставщику.Товары КАК ТаблицаДокумента
	|ГДЕ
	|	ТаблицаДокумента.Ссылка = &Ссылка
	|;
	|
	|/////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КурсВалюты.Валюта КАК Валюта,
	|	КурсВалюты.КурсЧислитель * КурсВалютыДокумента.КурсЗнаменатель / (КурсВалюты.КурсЗнаменатель * КурсВалютыДокумента.КурсЧислитель) КАК КоэффициентПересчета
	|ПОМЕСТИТЬ КурсыВалют
	|ИЗ
	|	РегистрСведений.ОтносительныеКурсыВалют.СрезПоследних(&ДатаДокумента, БазоваяВалюта = &БазоваяВалюта) КАК КурсВалюты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ОтносительныеКурсыВалют.СрезПоследних(&ДатаДокумента, Валюта = &ВалютаДокумента И БазоваяВалюта = &БазоваяВалюта) КАК КурсВалютыДокумента
	|		ПО (ИСТИНА)
	|ГДЕ
	|	КурсВалюты.КурсЗнаменатель <> 0
	|	И КурсВалютыДокумента.КурсЧислитель <> 0
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Валюта
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаНоменклатуры.Количество             КАК Количество,
	|	ТаблицаНоменклатуры.Сумма * ЕСТЬNULL(КурсыВалют.КоэффициентПересчета, 1) КАК Сумма,
	|	ТаблицаНоменклатуры.СтавкаНДС              КАК СтавкаНДС,
	|	ТаблицаНоменклатуры.СуммаНДС * ЕСТЬNULL(КурсыВалют.КоэффициентПересчета, 1) КАК СуммаНДС,
	|	ТаблицаНоменклатуры.Валюта                 КАК Валюта,
	|	ВЫРАЗИТЬ(ВЫБОР
	|		КОГДА ТаблицаНоменклатуры.ЦенаВключаетНДС ТОГДА
	|			ТаблицаНоменклатуры.Цена
	|		КОГДА ТаблицаНоменклатуры.Количество = 0 ТОГДА
	|			ТаблицаНоменклатуры.Сумма
	|		ИНАЧЕ
	|			ТаблицаНоменклатуры.Сумма / ТаблицаНоменклатуры.Количество
	|	КОНЕЦ * ЕСТЬNULL(КурсыВалют.КоэффициентПересчета, 1) КАК ЧИСЛО(31,2)) КАК Цена,
	|
	|	ВЫБОР
	|		КОГДА ТИПЗНАЧЕНИЯ(ТаблицаНоменклатуры.Номенклатура) = ТИП(Строка) ТОГДА
	|			ТаблицаНоменклатуры.Номенклатура
	|		ИНАЧЕ
	|			ТаблицаНоменклатуры.Номенклатура.НаименованиеПолное
	|	КОНЕЦ КАК НоменклатураНаименование,
	|	ЕСТЬNULL(ТаблицаНоменклатуры.Характеристика.НаименованиеПолное, """") КАК ХарактеристикаНаименование,
	|	ТаблицаНоменклатуры.Упаковка               КАК Упаковка,
	|	ТаблицаНоменклатуры.Упаковка               КАК УпаковкаНаименование
	|
	|ИЗ
	|	ТаблицаНоменклатуры КАК ТаблицаНоменклатуры
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ КурсыВалют
	|		ПО ТаблицаНоменклатуры.Валюта = КурсыВалют.Валюта
	|
	|УПОРЯДОЧИТЬ ПО
	|	ТаблицаНоменклатуры.НомерСтроки
	|";
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	Запрос.УстановитьПараметр("ДатаДокумента", РеквизитыДокумента.Дата);
	Запрос.УстановитьПараметр("ВалютаДокумента", РеквизитыДокумента.Валюта);
	Запрос.УстановитьПараметр("БазоваяВалюта", ЗначениеНастроекПовтИсп.ВалютаРегламентированногоУчетаОрганизации(РеквизитыДокумента.Организация));

	Возврат Запрос.Выполнить().Выгрузить();

КонецФункции

#КонецОбласти
//-- Локализация

#Область Проведение

// Описывает учетные механизмы используемые в документе для регистрации в механизме проведения.
//
// Параметры:
//  МеханизмыДокумента - Массив - список имен учетных механизмов, для которых будет выполнена
//              регистрация в механизме проведения.
//
Процедура ЗарегистрироватьУчетныеМеханизмы(МеханизмыДокумента) Экспорт
	
	//++ Локализация
	
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти



#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиСобытий

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый документ.
//  Отказ - Булево - Признак проведения документа.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то проведение документа выполнено не будет.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ОбработкаПроведения(Объект, Отказ, РежимПроведения) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то будет выполнен отказ от продолжения работы после выполнения проверки заполнения.
//  ПроверяемыеРеквизиты - Массив - Массив путей к реквизитам, для которых будет выполнена проверка заполнения.
//
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект.
//  ДанныеЗаполнения - Произвольный - Значение, которое используется как основание для заполнения.
//  СтандартнаяОбработка - Булево - В данный параметр передается признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, СтандартнаяОбработка) Экспорт
	
	//++ Локализация
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.КоммерческоеПредложениеПоставщика") Тогда
		
		ЗаполнитьДокументНаОснованииКоммерческогоПредложенияПоставщика(Объект, ДанныеЗаполнения);
		
	КонецЕсли;
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//
Процедура ОбработкаУдаленияПроведения(Объект, Отказ) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//  РежимЗаписи - РежимЗаписиДокумента - В параметр передается текущий режим записи документа. Позволяет определить в теле процедуры режим записи.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ПередЗаписью(Объект, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	//++ Локализация
	Объект.ЕстьКиЗГИСМ = ИнтеграцияГИСМ_УТ.ЕстьКиЗГИСМ(Объект.Товары);
	//-- Локализация
	Возврат;
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина, то запись выполнена не будет и будет вызвано исключение.
//
Процедура ПриЗаписи(Объект, Отказ) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  ОбъектКопирования - ДокументОбъект.ЗаказНаВнутреннееПотребление - Исходный документ, который является источником копирования.
//
Процедура ПриКопировании(Объект, ОбъектКопирования) Экспорт
	
	//++ Локализация
	Объект.ЕстьКиЗГИСМ = Ложь;
	//-- Локализация
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

//++ Локализация

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьДокументНаОснованииКоммерческогоПредложенияПоставщика(Объект, Знач КоммерческоеПредложение)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	КоммерческоеПредложениеПоставщика.Ссылка                КАК ДокументОснование,
	|	КоммерческоеПредложениеПоставщика.Поставщик             КАК Партнер,
	|	КоммерческоеПредложениеПоставщика.Контрагент            КАК Контрагент,
	|	КоммерческоеПредложениеПоставщика.КонтактноеЛицо        КАК КонтактноеЛицо,
	|	КоммерческоеПредложениеПоставщика.Валюта                КАК Валюта,
	|	КоммерческоеПредложениеПоставщика.СуммаДокумента        КАК СуммаДокумента,
	|	КоммерческоеПредложениеПоставщика.Организация           КАК Организация,
	|	КоммерческоеПредложениеПоставщика.ЦенаВключаетНДС       КАК ЦенаВключаетНДС,
	|	КоммерческоеПредложениеПоставщика.Налогообложение       КАК НалогообложениеНДС,
	|	КоммерческоеПредложениеПоставщика.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	НЕ КоммерческоеПредложениеПоставщика.Проведен           КАК ЕстьОшибкиПроведен
	|ИЗ
	|	Документ.КоммерческоеПредложениеПоставщика КАК КоммерческоеПредложениеПоставщика
	|ГДЕ
	|	КоммерческоеПредложениеПоставщика.Ссылка = &Основание
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	КоммерческоеПредложениеПоставщикаТовары.НомерСтроки       КАК НомерСтроки,
	|	КоммерческоеПредложениеПоставщикаТовары.Номенклатура      КАК Номенклатура,
	|	КоммерческоеПредложениеПоставщикаТовары.Характеристика    КАК Характеристика,
	|	КоммерческоеПредложениеПоставщикаТовары.ЕдиницаИзмерения  КАК Упаковка,
	|	КоммерческоеПредложениеПоставщикаТовары.Количество        КАК КоличествоУпаковок,
	|	КоммерческоеПредложениеПоставщикаТовары.Количество * ВЫБОР
	|		КОГДА КоммерческоеПредложениеПоставщикаТовары.ЕдиницаИзмерения = ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка)
	|			ТОГДА 1
	|		ИНАЧЕ &ТекстЗапросаКоэффициентУпаковки
	|	КОНЕЦ                                                  КАК Количество,
	|	КоммерческоеПредложениеПоставщикаТовары.ВидЦеныПоставщика КАК ВидЦеныПоставщика,
	|	КоммерческоеПредложениеПоставщикаТовары.Цена              КАК Цена,
	|	КоммерческоеПредложениеПоставщикаТовары.ПроцентСкидки     КАК ПроцентРучнойСкидки,
	|	КоммерческоеПредложениеПоставщикаТовары.СуммаСкидки       КАК СуммаРучнойСкидки,
	|	КоммерческоеПредложениеПоставщикаТовары.СтавкаНДС         КАК СтавкаНДС,
	|	КоммерческоеПредложениеПоставщикаТовары.СуммаНДС          КАК СуммаНДС,
	|	КоммерческоеПредложениеПоставщикаТовары.СуммаСНДС         КАК СуммаСНДС,
	|	КоммерческоеПредложениеПоставщикаТовары.Сумма             КАК Сумма
	|ИЗ
	|	Документ.КоммерческоеПредложениеПоставщика.Товары КАК КоммерческоеПредложениеПоставщикаТовары
	|ГДЕ
	|	КоммерческоеПредложениеПоставщикаТовары.Ссылка = &Основание";

	Запрос.УстановитьПараметр("Основание",КоммерческоеПредложение);
	Запрос.УстановитьПараметр("ТекущаяДата", ТекущаяДатаСеанса());
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст,
		"&ТекстЗапросаКоэффициентУпаковки",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
		"КоммерческоеПредложениеПоставщикаТовары.ЕдиницаИзмерения",
		"КоммерческоеПредложениеПоставщикаТовары.Номенклатура"));
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	
	// Заполнение шапки
	
	ВыборкаШапка = РезультатЗапроса[0].Выбрать();
	ВыборкаШапка.Следующий();
	
	МассивДопустимыхСтатусов = Новый Массив();
	МассивДопустимыхСтатусов.Добавить(Перечисления.СтатусыКоммерческихПредложенийКлиентам.Действует);
	
	ОбщегоНазначенияУТ.ПроверитьВозможностьВводаНаОсновании(
		ВыборкаШапка.ДокументОснование,
		Неопределено,
		ВыборкаШапка.ЕстьОшибкиПроведен);
	
	ЗаполнитьЗначенияСвойств(Объект, ВыборкаШапка);
	
	Если ВыборкаШапка.ХозяйственнаяОперация = Перечисления.ВидыОперацийКоммерческихПредложений.ЗакупкаУПоставщика Тогда
		Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ЗакупкаУПоставщика;
	ИначеЕсли ВыборкаШапка.ХозяйственнаяОперация = Перечисления.ВидыОперацийКоммерческихПредложений.ПриемНаКомиссию Тогда
		Объект.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПриемНаКомиссию;
	КонецЕсли;
		
	Если ПолучитьФункциональнуюОпцию("ИспользоватьСоглашенияСКлиентами") Тогда
		
		РеквизитыДляОтбора = Новый Структура;
		РеквизитыДляОтбора.Вставить("Партнер",         Объект.Партнер);
		РеквизитыДляОтбора.Вставить("Валюта",          Объект.Валюта);
		РеквизитыДляОтбора.Вставить("ЦенаВключаетНДС", Объект.ЦенаВключаетНДС);
		
		ОписаниеРеквизитов = Новый Структура;
		Параметры = ЗаполнениеОбъектовПоСтатистике.ПараметрыЗаполняемыхРеквизитов();
		Параметры.РазрезыСбораСтатистики.ИспользоватьВсегда = "Партнер, Валюта, ЦенаВключаетНДС";
		ЗаполнениеОбъектовПоСтатистике.ДобавитьОписаниеЗаполняемыхРеквизитов(ОписаниеРеквизитов, "Соглашение", Параметры);
		
		ЗаполнениеОбъектовПоСтатистике.ЗаполнитьРеквизитыОбъекта(Объект, РеквизитыДляОтбора, ОписаниеРеквизитов);
		
	КонецЕсли;
	
	Параметры = ЗакупкиСервер.ДополнительныеПараметрыОтбораДоговоров();
	Параметры.ВалютаВзаиморасчетов = Объект.Валюта;
	
	Объект.Договор = ЗакупкиСервер.ПолучитьДоговорПоУмолчанию(Объект, Объект.ХозяйственнаяОперация, Параметры);
	
	Если ЗначениеЗаполнено(Объект.Договор) Тогда
		ЗакупкиВызовСервера.ЗаполнитьБанковскиеСчетаПоДоговору(Объект.Договор, Объект.БанковскийСчет);
	Иначе
		СтруктураПараметров = ДенежныеСредстваСервер.ПараметрыЗаполненияБанковскогоСчетаОрганизацииПоУмолчанию();

		СтруктураПараметров.Организация             = Объект.Организация;
		СтруктураПараметров.ФормаОплаты             = Объект.ФормаОплаты;
		СтруктураПараметров.НаправлениеДеятельности = Объект.НаправлениеДеятельности;

		Объект.БанковскийСчет = ЗначениеНастроекПовтИсп.ПолучитьБанковскийСчетОрганизацииПоУмолчанию(СтруктураПараметров);
	КонецЕсли;
		
	// Заполнение табличной части товаров
	
	ТаблицаТовары = РезультатЗапроса[1].Выгрузить();
	
	ТаблицаТовары.Сортировать("НомерСтроки Возр");
	
	Объект.Товары.Загрузить(ТаблицаТовары);
	
	НоменклатураПартнеровСервер.ЗаполнитьНоменклатуруПартнераПоНоменклатуреПриИзмененииПартнера(Объект.Товары, Объект.Партнер);

КонецПроцедуры

#КонецОбласти

//-- Локализация

