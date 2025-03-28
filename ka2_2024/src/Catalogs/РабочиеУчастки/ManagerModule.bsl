#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт

КонецПроцедуры

// Возвращает имена блокируемых реквизитов для механизма блокирования реквизитов БСП.
//
// Возвращаемое значение:
//	Массив - имена блокируемых реквизитов.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт

	Результат = Новый Массив;
	
	Результат.Добавить("Владелец");
 	Результат.Добавить("Помещение");

	Возврат Результат;

КонецФункции

// Возвращает рабочий участок, если он один в справочнике
//
// Параметры:
//  Склад		 - СправочникСсылка.Склады			 - склад, по которому нужно найти рабочий участок
//  Помещение	 - СправочникСсылка.СкладскиеПомещения	 - помещение, по которому нужно найти рабочий участок
//  	если по складу не ведется учет по складским помещениям, нужно передать пустую ссылку.
// 
// Возвращаемое значение:
//  СправочникСсылка.РабочиеУчастки - ссылка на рабочий участок склада по умолчанию.
//
Функция РабочийУчастокПоУмолчанию(Склад,Помещение) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 2
	|	СпрУчастки.Ссылка КАК Участок
	|ИЗ
	|	Справочник.РабочиеУчастки КАК СпрУчастки
	|ГДЕ
	|	(НЕ СпрУчастки.ПометкаУдаления)
	|	И СпрУчастки.Владелец = &Склад
	|	И СпрУчастки.Помещение = &Помещение");
	
	Запрос.УстановитьПараметр("Склад", Склад);
	Запрос.УстановитьПараметр("Помещение", Помещение);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Количество() = 1 
	   И Выборка.Следующий()
	Тогда
		Участок = Выборка.Участок;
	Иначе
		Участок = Справочники.РабочиеУчастки.ПустаяСсылка();
	КонецЕсли;
	
	Возврат Участок;

КонецФункции

// Возвращает имена реквизитов, которые не должны отображаться в списке реквизитов обработки ГрупповоеИзменениеОбъектов.
//
//	Возвращаемое значение:
//		Массив - массив имен реквизитов.
//
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	НеРедактируемыеРеквизиты = Новый Массив;
	НеРедактируемыеРеквизиты.Добавить("Владелец");
	НеРедактируемыеРеквизиты.Добавить("Помещение");
	
	Возврат НеРедактируемыеРеквизиты;
	
КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// Параметры:
//   Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Владелец)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли