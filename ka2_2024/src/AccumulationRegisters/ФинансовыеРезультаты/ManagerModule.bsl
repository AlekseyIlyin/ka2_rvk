
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область Проведение

// Формирует параметры для проведения документа по регистрам учетного механизма через общий механизм проведения.
//
// Параметры:
//  Документ - ДокументОбъект - записываемый документ
//  Свойства - См. ПроведениеДокументов.СвойстваДокумента
//
// Возвращаемое значение:
//  Структура - См. ПроведениеДокументов.ПараметрыУчетногоМеханизма
//
Функция ПараметрыДляПроведенияДокумента(Документ, Свойства) Экспорт
	
	Параметры = ПроведениеДокументов.ПараметрыУчетногоМеханизма();
	
	// Проведение
	Если Свойства.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		
		Параметры.ПодчиненныеРегистры.Добавить(Метаданные.РегистрыНакопления.ФинансовыеРезультаты);
		
	КонецЕсли;
	
	Возврат Параметры;
	
КонецФункции

// Возвращает тексты запросов для сторнирования движений при исправлении документов
// 
// Параметры:
// 	МетаданныеДокумента - ОбъектМетаданныхДокумент - Метаданные документа, который проводится.
// 
// Возвращаемое значение:
// 	Соответствие - Соответствие полного имени регистра тексту запроса сторнирования
//
Функция ТекстыЗапросовСторнирования(МетаданныеДокумента) Экспорт
	
	ТекстыЗапросов = Новый Соответствие();
	
	Возврат ТекстыЗапросов;
	
КонецФункции

// Процедура формирования движений по регистру.
//
// Параметры:
//   ТаблицыДляДвижений - Структура - таблицы данных документа
//   Движения - КоллекцияДвижений - коллекция наборов записей движений документа
//   Отказ - Булево - признак отказа от проведения документа.
//
Процедура ОтразитьДвижения(ТаблицыДляДвижений, Движения, Отказ) Экспорт
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ПроведениеДокументов.ОтразитьДвижения(ТаблицыДляДвижений, Движения, "ФинансовыеРезультаты");
	
КонецПроцедуры

// Дополняет текст запроса механизма проверки даты запрета по таблице изменений.
// 
// Параметры:
// 	Запрос - Запрос - используется для установки параметров запроса.
// 
// Возвращаемое значение:
//	Соответствие - соответствие имен таблиц изменения регистров и текстов запросов.
//	
Функция ТекстыЗапросовКонтрольДатыЗапретаПоТаблицеИзменений(Запрос) Экспорт

	СоответствиеТекстовЗапросов = Новый Соответствие();
	Возврат СоответствиеТекстовЗапросов;
	
КонецФункции

#КонецОбласти

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// Параметры:
//   Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(Подразделение)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли
