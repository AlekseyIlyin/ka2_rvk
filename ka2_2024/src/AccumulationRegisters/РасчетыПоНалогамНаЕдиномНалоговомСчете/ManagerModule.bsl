#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

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
	|	ЗначениеРазрешено(Организация)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбработчикиОбновления

Процедура ЗаполнитьГоловнуюОрганизацию() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	РасчетыПоНалогамНаЕдиномНалоговомСчете.Регистратор КАК Регистратор,
	|	РасчетыПоНалогамНаЕдиномНалоговомСчете.Организация КАК Организация,
	|	РасчетыПоНалогамНаЕдиномНалоговомСчете.Организация.ГоловнаяОрганизация КАК ГоловнаяОрганизация
	|ИЗ
	|	РегистрНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете КАК РасчетыПоНалогамНаЕдиномНалоговомСчете
	|ГДЕ
	|	РасчетыПоНалогамНаЕдиномНалоговомСчете.ГоловнаяОрганизация = ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)
	|
	|СГРУППИРОВАТЬ ПО
	|	РасчетыПоНалогамНаЕдиномНалоговомСчете.Регистратор,
	|	РасчетыПоНалогамНаЕдиномНалоговомСчете.Организация,
	|	РасчетыПоНалогамНаЕдиномНалоговомСчете.Организация.ГоловнаяОрганизация";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		НачатьТранзакцию();
		НаборЗаписейРегистра = РегистрыНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете.СоздатьНаборЗаписей();
		ОтборПоРегистратору = НаборЗаписейРегистра.Отбор.Регистратор;
		ОтборПоРегистратору.Установить(Выборка.Регистратор);
		НаборЗаписейРегистра.Прочитать();
		ТаблицаЗаписей = НаборЗаписейРегистра.Выгрузить();
		ТаблицаЗаписей.ЗаполнитьЗначения(Выборка.ГоловнаяОрганизация, "ГоловнаяОрганизация");
		НаборЗаписейРегистра.Загрузить(ТаблицаЗаписей);
		Попытка
			ОбновлениеИнформационнойБазы.ЗаписатьНаборЗаписей(НаборЗаписейРегистра);
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			ШаблонСообщения = НСтр("ru = 'Не выполнено обновление записей регистра накопления ""Расчеты по налогам на едином налоговом счете""
			|%1'");
			ТекстСообщения = СтрШаблон(ШаблонСообщения, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(
				ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
				УровеньЖурналаРегистрации.Ошибка,
				Метаданные.РегистрыНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете,,
				ТекстСообщения);
			Продолжить;
		КонецПопытки;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// Параметры:
// 	Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "РегистрыНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Версия = "2.5.20.26";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("89bfbc07-ce5f-45d9-906e-86eeb790849e");
	Обработчик.Многопоточный = Истина;
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Комментарий = НСтр("ru = 'Заменяет значение ""Налог"" с типом ""Перечисление.УдалитьТипыНалогов"" на значение с типом ""Справочник.ВидыНалоговВзносов"".'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.РегистрыНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
КонецПроцедуры

// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра	= "РегистрНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете";
	
	ПараметрыВыборки = Параметры.ПараметрыВыборки;
	ПараметрыВыборки.ПолныеИменаРегистров = ПолноеИмяРегистра;
	ПараметрыВыборки.ПоляУпорядочиванияПриРаботеПользователей.Добавить("Период УБЫВ");
	ПараметрыВыборки.ПоляУпорядочиванияПриОбработкеДанных.Добавить("Период УБЫВ");
	ПараметрыВыборки.СпособВыборки = ОбновлениеИнформационнойБазы.СпособВыборкиРегистраторыРегистра();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	РасчетыПоНалогамНаЕдиномНалоговомСчете.Регистратор КАК Ссылка
	|ИЗ
	|	РегистрНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете КАК РасчетыПоНалогамНаЕдиномНалоговомСчете
	|ГДЕ
	|	РасчетыПоНалогамНаЕдиномНалоговомСчете.Налог ССЫЛКА Перечисление.УдалитьТипыНалогов";
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(Параметры, Регистраторы, ПолноеИмяРегистра);
	
КонецПроцедуры

// Обработчик обновления
// 
// Параметры:
// 	Параметры - См. ОбновлениеИнформационнойБазы.ДополнительныеПараметрыВыборкиДанныхДляМногопоточнойОбработки 
//
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = Метаданные.РегистрыНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете.ПолноеИмя();
	
	ОбновляемыеДанные = ОбновлениеИнформационнойБазы.ДанныеДляОбновленияВМногопоточномОбработчике(Параметры);
	Если ОбновляемыеДанные.Количество() = 0 Тогда
		Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(
			Параметры.Очередь, ПолноеИмяРегистра);
		Возврат;
	КонецЕсли;
	
	Для Каждого ТекущиеДанные Из ОбновляемыеДанные Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			
			ЭлементБлокировки = Блокировка.Добавить("РегистрНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете.НаборЗаписей");
			ЭлементБлокировки.УстановитьЗначение("Регистратор", ТекущиеДанные.Регистратор);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			
			Блокировка.Заблокировать();
			
			НаборЗаписей = РегистрыНакопления.РасчетыПоНалогамНаЕдиномНалоговомСчете.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Регистратор.Установить(ТекущиеДанные.Регистратор);
			НаборЗаписей.Прочитать();
			
			Для каждого Запись Из НаборЗаписей Цикл
				Запись.Налог = Перечисления.УдалитьТипыНалогов.СсылкаВидыНалоговВзносовПоТипуНалогов(Запись.Налог);
			КонецЦикла;
			
			Если НаборЗаписей.Модифицированность() Тогда
				ОбновлениеИнформационнойБазы.ЗаписатьДанные(НаборЗаписей);
			Иначе
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(НаборЗаписей);
			КонецЕсли;
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			ОтменитьТранзакцию();
			ОбновлениеИнформационнойБазыУТ.СообщитьОНеудачнойОбработке(ИнформацияОбОшибке(), ТекущиеДанные.Регистратор);
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, ПолноеИмяРегистра);
	
КонецПроцедуры

#КонецОбласти


#КонецОбласти

#КонецЕсли