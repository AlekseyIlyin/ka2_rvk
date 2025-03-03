#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	ИнициализироватьДокумент();
	
	ТипДанныхЗаполнения = ТипЗнч(ДанныеЗаполнения);
	
	Если ТипДанныхЗаполнения = Тип("Структура") Тогда
		ЗаполнитьДокументПоОтбору(ДанныеЗаполнения, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ИнициализироватьДокумент();
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	НепроверяемыеРеквизиты = Новый Массив;

	Если НЕ РежимИсправленияСПрошлойДаты Тогда
		НепроверяемыеРеквизиты.Добавить("ДатаСнятияСРегистрации");
	КонецЕсли;

	ПроверитьРегистрацию(Отказ);
	ПроверитьДатуСнятияСРегистрации(Отказ);
		
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, НепроверяемыеРеквизиты);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	ПроведениеДокументов.ПередЗаписьюДокумента(ЭтотОбъект, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Документы.СнятиеСРегистрацииТранспортныхСредств.ПроверитьБлокировкуВходящихДанныхПриОбновленииИБ(
		НСтр("ru = 'Отмена регистрации земельных участков'"));
	
	ПроведениеДокументов.ОбработкаПроведенияДокумента(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	ПроведениеДокументов.ОбработкаУдаленияПроведенияДокумента(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПроведениеДокументов.ПриЗаписиДокумента(ЭтотОбъект, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ИнициализироватьДокумент()
	
	Ответственный = Пользователи.ТекущийПользователь();
	
	Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
	
КонецПроцедуры

Процедура ПроверитьРегистрацию(Отказ)

	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ТаблицаОС.НомерСтроки КАК НомерСтроки,
	|	ТаблицаОС.ОсновноеСредство КАК ОсновноеСредство
	|ПОМЕСТИТЬ ТаблицаОС
	|ИЗ
	|	&ТаблицаОС КАК ТаблицаОС
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ОсновноеСредство
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаОС.НомерСтроки КАК НомерСтроки,
	|	ВЫРАЗИТЬ(ТаблицаОС.ОсновноеСредство КАК Справочник.ОбъектыЭксплуатации).Представление КАК ОсновноеСредствоПредставление
	|ИЗ
	|	ТаблицаОС КАК ТаблицаОС
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПараметрыНачисленияТранспортногоНалога.СрезПоследних(
	|				&Дата,
	|				ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
	|					И Регистратор <> &Регистратор
	|					И Организация = &Организация
	|					И ОсновноеСредство В
	|						(ВЫБРАТЬ
	|							ТаблицаОС.ОсновноеСредство
	|						ИЗ
	|							ТаблицаОС)) КАК Регистрация
	|		ПО (Регистрация.ОсновноеСредство = ТаблицаОС.ОсновноеСредство)
	|ГДЕ
	|	ЕСТЬNULL(Регистрация.ВидЗаписи, НЕОПРЕДЕЛЕНО) <> ЗНАЧЕНИЕ(Перечисление.ВидЗаписиОРегистрации.Регистрация)
	|	И ТаблицаОС.ОсновноеСредство <> ЗНАЧЕНИЕ(Справочник.ОбъектыЭксплуатации.ПустаяСсылка)
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Регистратор", Ссылка);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ТаблицаОС", ОС.Выгрузить());
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Путь = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ОС", Выборка.НомерСтроки, "ОсновноеСредство");
	
		ТекстСообщения = НСтр("ru = 'Для основного средства ""%1"" отсутствует регистрация на %2'");
		ТекстСообщения = СтрШаблон(ТекстСообщения, Выборка.ОсновноеСредствоПредставление, Формат(Дата, "ДЛФ=D"));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, Путь,, Отказ);
	
	КонецЦикла;
	
КонецПроцедуры

Процедура ПроверитьДатуСнятияСРегистрации(Отказ)
	
	Если НЕ РежимИсправленияСПрошлойДаты
		ИЛИ НЕ ЗначениеЗаполнено(ДатаСнятияСРегистрации) Тогда
		Возврат
	КонецЕсли;
	
	Если ДатаСнятияСРегистрации >= НачалоМесяца(Дата)
		И ЗначениеЗаполнено(Дата) Тогда
		ТекстСообщения = НСтр("ru = 'Дата снятия с регистрации должна быть раньше начала месяца, в котором оформлен документ'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "ДатаСнятияСРегистрации",, Отказ);
	ИначеЕсли НЕ ВнеоборотныеАктивы.ИспользуетсяУправлениеВНА_2_4(ДатаСнятияСРегистрации) Тогда
		ТекстСообщения = НСтр("ru = 'Дата снятия с регистрации должна быть не раньше начала учета внеоборотных активов версии 2.4'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "ДатаСнятияСРегистрации",, Отказ);
	КонецЕсли;
	
КонецПроцедуры 

Процедура ЗаполнитьДокументПоОтбору(Основание, СтандартнаяОбработка)

	Если Основание.Свойство("ОсновноеСредство") Тогда
		
		ЗаполнитьНаОснованииОбъектаЭксплуатации(Основание.ОсновноеСредство);
		
	КонецЕсли;

	Если Основание.Свойство("РежимИсправленияСПрошлойДаты") Тогда
		
		РежимИсправленияСПрошлойДаты = Истина;
		
		Если Основание.Свойство("ПериодИсправления") Тогда
			ПериодИсправления = Основание.ПериодИсправления; // СтандартныйПериод
			Если ПериодИсправления.ДатаНачала < НачалоМесяца(ТекущаяДатаСеанса()) Тогда
				ДатаСнятияСРегистрации = ПериодИсправления.ДатаНачала;
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьНаОснованииОбъектаЭксплуатации(Основание)
	
	Если НЕ ЗначениеЗаполнено(Основание) Тогда
		Возврат;
	КонецЕсли;
	
	РеквизитыОснования = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Основание, "ЭтоГруппа,ГруппаОС");
	
	Если РеквизитыОснования.ЭтоГруппа Тогда
		
		ТекстСообщения = НСтр("ru = 'Оформление документа для группы ОС невозможно.
			|Выберите ОС. Для раскрытия группы используйте клавиши Ctrl и стрелку вниз.'");
		ВызватьИсключение(ТекстСообщения);
		
	КонецЕсли;

	Если РеквизитыОснования.ГруппаОС <> Перечисления.ГруппыОС.ТранспортныеСредства
		И РеквизитыОснования.ГруппаОС <> Перечисления.ГруппыОС.МашиныИОборудование Тогда
		ТекстСообщения = НСтр("ru = 'Оформление документа доступно только для транспортных средств.'");
		ВызватьИсключение(ТекстСообщения);
	КонецЕсли;

	ПервоначальныеСведения = Справочники.ОбъектыЭксплуатации.ПервоначальныеСведения(Основание, Дата);
	
	Организация = ПервоначальныеСведения.Организация;
	
	СтрокаТабличнойЧасти = ОС.Добавить();
	СтрокаТабличнойЧасти.ОсновноеСредство = Основание;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
