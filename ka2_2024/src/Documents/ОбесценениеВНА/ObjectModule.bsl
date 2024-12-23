#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ИнициализироватьДокумент();
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ИнициализироватьДокумент();
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Дата <> КонецМесяца(Дата) Тогда
		Дата = КонецМесяца(Дата);
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	ПроведениеДокументов.ПередЗаписьюДокумента(ЭтотОбъект, РежимЗаписи, РежимПроведения);
	
	ПроверитьВНАНаВхождениеВСоставЕГДС(Отказ, РежимЗаписи);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПроведениеДокументов.ПриЗаписиДокумента(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ПроверитьАктуальностьОбесценения(Отказ);
	 
	Если Не Отказ Тогда
		
		ПроведениеДокументов.ОбработкаПроведенияДокумента(ЭтотОбъект, Отказ);

		СформироватьЗаданиеКЗакрытиюМесяца();
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	ПроведениеДокументов.ОбработкаУдаленияПроведенияДокумента(ЭтотОбъект, Отказ);
	
	СформироватьЗаданиеКЗакрытиюМесяца();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Проверить ВНА на вхождение в состав ЕГДС.
// ВНА входящие в ЕГДС нельзя обесценивать отдельно от ЕГДС.
// 
// Параметры:
//  Отказ - Булево - Отказ
//  РежимЗаписи - РежимЗаписиДокумента - Режим записи
Процедура ПроверитьВНАНаВхождениеВСоставЕГДС(Отказ, РежимЗаписи)
	
	Если РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения Тогда
		Возврат;
	КонецЕсли;
	
	ТаблицаОС  = ОсновныеСредства.Выгрузить(,"ОсновноеСредство,НомерСтроки");
	ТаблицаНМА = НематериальныеАктивы.Выгрузить(,"НематериальныйАктив,НомерСтроки");
	
	Запрос = Новый Запрос;
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ОС.ОсновноеСредство КАК ВнеоборотныйАктив,
		|	ОС.НомерСтроки      КАК НомерСтроки
		|ПОМЕСТИТЬ ВТОС
		|ИЗ
		|	&ТаблицаОС КАК ОС
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	ВнеоборотныйАктив
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	НМА.НематериальныйАктив КАК ВнеоборотныйАктив,
		|	НМА.НомерСтроки         КАК НомерСтроки
		|ПОМЕСТИТЬ ВТНМА
		|ИЗ
		|	&ТаблицаНМА КАК НМА
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	ВнеоборотныйАктив
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТОС.ВнеоборотныйАктив КАК ВнеоборотныйАктив,
		|	ВТОС.НомерСтроки       КАК НомерСтроки
		|ПОМЕСТИТЬ ВНАБезЕГДС
		|ИЗ
		|	ВТОС КАК ВТОС
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ВТНМА.ВнеоборотныйАктив КАК ВнеоборотныйАктив,
		|	ВТНМА.НомерСтроки       КАК НомерСтроки
		|ИЗ
		|	ВТНМА КАК ВТНМА
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	ВнеоборотныйАктив
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	СоставЕГДССрезПоследних.ВнеоборотныйАктив КАК ВнеоборотныйАктив,
		|	СоставЕГДССрезПоследних.ЕГДС КАК ЕГДС,
		|	СоставЕГДССрезПоследних.Период КАК Дата,
		|	ВНАБезЕГДС.НомерСтроки КАК НомерСтроки,
		|	ВЫБОР
		|		КОГДА СоставЕГДССрезПоследних.ВнеоборотныйАктив ССЫЛКА Справочник.ОбъектыЭксплуатации
		|			ТОГДА &ИмяТЧОС
		|		КОГДА СоставЕГДССрезПоследних.ВнеоборотныйАктив ССЫЛКА Справочник.НематериальныеАктивы
		|			ТОГДА &ИмяТЧНМА
		|	КОНЕЦ КАК ИмяТЧ
		|ИЗ
		|	РегистрСведений.СоставЕГДС.СрезПоследних(&ГраницаДокумента, Организация = &Организация
		|	И ВнеоборотныйАктив В
		|		(ВЫБРАТЬ
		|			ВНАБезЕГДС.ВнеоборотныйАктив
		|		ИЗ
		|			ВНАБезЕГДС КАК ВНАБезЕГДС)) КАК СоставЕГДССрезПоследних
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВНАБезЕГДС КАК ВНАБезЕГДС
		|		ПО СоставЕГДССрезПоследних.ВнеоборотныйАктив = ВНАБезЕГДС.ВнеоборотныйАктив
		|ГДЕ
		|	СоставЕГДССрезПоследних.ЕГДС <> ЗНАЧЕНИЕ(Справочник.ЕдиницыГенерирующиеДенежныеСредства.ПустаяСсылка)
		|
		|УПОРЯДОЧИТЬ ПО
		|	ИмяТЧ УБЫВ,
		|	НомерСтроки";
		
	Запрос.УстановитьПараметр("ГраницаДокумента", Новый Граница(Дата, ВидГраницы.Включая));
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ТаблицаОС",  ТаблицаОС);
	Запрос.УстановитьПараметр("ТаблицаНМА", ТаблицаНМА);
	
	Запрос.УстановитьПараметр("ИмяТЧОС" , НСтр("ru = 'Основные средства'"));
	Запрос.УстановитьПараметр("ИмяТЧНМА", НСтр("ru = 'Нематериальные активы'"));
	
	РезультатПроверки = Запрос.Выполнить();
	
	Если РезультатПроверки.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	// Обнаружены ВНА, входящие в ЕГДС, и упомянутые в табличных частях самостоятельных ВНА.
	ОбщегоНазначения.СообщитьПользователю(
				НСтр("ru = 'Обнаружены внеоборотные активы, входящие в состав ЕГДС.'"),
				Ссылка,
				,
				,
				Отказ);
	Отказ = Истина;
	
	ШаблонТекстаОшибки = НСтр("ru = '%1, строка %2: %3 входит в состав ЕГДС %4 с %5.'");
	
	ВНАИзСоставаЕГДС = РезультатПроверки.Выбрать();
	
	Пока ВНАИзСоставаЕГДС.Следующий() Цикл
		
		ТекстОшибки = СтрШаблон(ШаблонТекстаОшибки,
									ВНАИзСоставаЕГДС.ИмяТЧ,
									ВНАИзСоставаЕГДС.НомерСтроки,
									ВНАИзСоставаЕГДС.ВнеоборотныйАктив,
									ВНАИзСоставаЕГДС.ЕГДС,
									Формат(ВНАИзСоставаЕГДС.Дата,"ДЛФ=D;"));
		
		ОбщегоНазначения.СообщитьПользователю(
				ТекстОшибки,
				Ссылка,
				,
				,
				Отказ);

	КонецЦикла;
	
КонецПроцедуры


Процедура ИнициализироватьДокумент()
	
	Дата = КонецМесяца(ТекущаяДатаСеанса());
	Ответственный = Пользователи.ТекущийПользователь();
	Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
	
КонецПроцедуры

Процедура ПроверитьАктуальностьОбесценения(Отказ)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ОбесценениеВНАПред.Ссылка КАК ДокументОбесценения,
		|	ОбесценениеВНАПред.ЕГДС КАК ВНА,
		|	""ЕдиницыГенерирующиеДенежныеСредства"" КАК ТЧ
		|ИЗ
		|	Документ.ОбесценениеВНА.ЕдиницыГенерирующиеДенежныеСредства КАК ОбесценениеВНАПред
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ОбесценениеВНА.ЕдиницыГенерирующиеДенежныеСредства КАК ОбесценениеВНАТек
		|		ПО (ОбесценениеВНАТек.ЕГДС = ОбесценениеВНАПред.ЕГДС)
		|ГДЕ
		|	ОбесценениеВНАПред.Ссылка.Дата МЕЖДУ &НачалоПериода И &КонецПериода
		|	И ОбесценениеВНАПред.Ссылка.Организация = &Организация
		|	И ОбесценениеВНАПред.Ссылка.Проведен
		|	И ОбесценениеВНАПред.Ссылка <> &ТекущийДокумент
		|	И ОбесценениеВНАТек.Ссылка = &ТекущийДокумент
		|
		|СГРУППИРОВАТЬ ПО
		|	ОбесценениеВНАПред.Ссылка,
		|	ОбесценениеВНАПред.ЕГДС
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ОбесценениеВНАПред.Ссылка,
		|	ОбесценениеВНАПред.ОсновноеСредство,
		|	""ОсновныеСредства""
		|ИЗ
		|	Документ.ОбесценениеВНА.ОсновныеСредства КАК ОбесценениеВНАПред
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ОбесценениеВНА.ОсновныеСредства КАК ОбесценениеВНАТек
		|		ПО (ОбесценениеВНАТек.ОсновноеСредство = ОбесценениеВНАПред.ОсновноеСредство)
		|ГДЕ
		|	ОбесценениеВНАПред.Ссылка.Дата МЕЖДУ &НачалоПериода И &КонецПериода
		|	И ОбесценениеВНАПред.Ссылка.Организация = &Организация
		|	И ОбесценениеВНАПред.Ссылка.Проведен
		|	И ОбесценениеВНАПред.Ссылка <> &ТекущийДокумент
		|	И ОбесценениеВНАТек.Ссылка = &ТекущийДокумент
		|
		|СГРУППИРОВАТЬ ПО
		|	ОбесценениеВНАПред.Ссылка,
		|	ОбесценениеВНАПред.ОсновноеСредство
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ОбесценениеВНАПред.Ссылка,
		|	ОбесценениеВНАПред.НематериальныйАктив,
		|	""НематериальныеАктивы""
		|ИЗ
		|	Документ.ОбесценениеВНА.НематериальныеАктивы КАК ОбесценениеВНАПред
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ОбесценениеВНА.НематериальныеАктивы КАК ОбесценениеВНАТек
		|		ПО (ОбесценениеВНАТек.НематериальныйАктив = ОбесценениеВНАПред.НематериальныйАктив)
		|ГДЕ
		|	ОбесценениеВНАПред.Ссылка.Дата МЕЖДУ &НачалоПериода И &КонецПериода
		|	И ОбесценениеВНАПред.Ссылка.Организация = &Организация
		|	И ОбесценениеВНАПред.Ссылка.Проведен
		|	И ОбесценениеВНАПред.Ссылка <> &ТекущийДокумент
		|	И ОбесценениеВНАТек.Ссылка = &ТекущийДокумент
		|
		|СГРУППИРОВАТЬ ПО
		|	ОбесценениеВНАПред.Ссылка,
		|	ОбесценениеВНАПред.НематериальныйАктив";
	
	Запрос.УстановитьПараметр("ТекущийДокумент", Ссылка);
	Запрос.УстановитьПараметр("НачалоПериода", НачалоМесяца(Дата));
	Запрос.УстановитьПараметр("КонецПериода", КонецМесяца(Дата));
	Запрос.УстановитьПараметр("Организация", Организация);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если Не РезультатЗапроса.Пустой() Тогда
		
		Отказ = Истина;
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

		ШаблонПути = "Объект.%1";
		ТекстСообщения = НСтр("ru = 'Для объекта %1 в данном периоде уже введен документ %2. Необходимо отменить проведение предыдущего документа'");
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			
			ОбщегоНазначения.СообщитьПользователю(
				СтрШаблон(ТекстСообщения, ВыборкаДетальныеЗаписи.ВНА, ВыборкаДетальныеЗаписи.ДокументОбесценения)
				,,СтрШаблон(ШаблонПути, ВыборкаДетальныеЗаписи.ТЧ),,Отказ);
			
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура СформироватьЗаданиеКЗакрытиюМесяца()

	МассивОрганизаций = Новый Массив();
	МассивОрганизаций.Добавить(Организация);
	
	РегистрыСведений.ЗаданияКЗакрытиюМесяца.СоздатьЗаписьРегистра(
			НачалоМесяца(Дата), Ссылка, Организация, Перечисления.ОперацииЗакрытияМесяца.ОбесценениеВНА);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли