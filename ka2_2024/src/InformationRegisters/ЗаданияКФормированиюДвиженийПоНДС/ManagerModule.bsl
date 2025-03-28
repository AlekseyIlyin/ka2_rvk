#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает имя константы, хранящей номер задания для данного регистра.
// 
// Возвращаемое значение:
//	Строка - Строковое предствление имени константы НомерЗаданияКФормированиюДвиженийПоНДС.
Функция ИмяКонстантыНомераЗадания() Экспорт
	
	Возврат Метаданные.Константы.НомерЗаданияКФормированиюДвиженийПоНДС.Имя;
	
КонецФункции

// Увеличивает значение номера задания в константе.
//
// Возвращаемое значение:
//	Число - Новый номер задания из константы НомерЗаданияКФормированиюДвиженийПоНДС.
//
Функция УвеличитьНомерЗадания() Экспорт
	
	Возврат ЗакрытиеМесяцаСервер.УвеличитьНомерЗадания(ИмяКонстантыНомераЗадания());
	
КонецФункции

// Возвращает значение номера задани из константы.
//
// Возвращаемое значение:
//	Число - Номер текущего задания из константы НомерЗаданияКФормированиюДвиженийПоНДС.
//
Функция ПолучитьНомерЗадания() Экспорт
	
	Возврат ЗакрытиеМесяцаСервер.ТекущийНомерЗадания(ИмяКонстантыНомераЗадания());
	
КонецФункции

// Метод создает запись регистра с заданными параметрами.
//
// Параметры:
//	ПериодЗадания   - Дата - Начало периода, для которого необходимо зарегистрировать задание к расчету
//	СчетФактура - ДокументСсылка - документ регистратор создавший движение в зависимых регистрах
//	Организация - СправочникСсылка.Организации - организация, по которой необходим перерасчет
//  НомерЗадания - Число - номер задания; если не задано, то будет установлено значение из соответствующей константы.
//
Процедура СоздатьЗаписьРегистра(ПериодЗадания, СчетФактура, Организация, НомерЗадания = Неопределено) Экспорт
	
	Если ПланыОбмена.ГлавныйУзел() <> Неопределено Тогда
		// В РИБ данный регистр обрабатывается только в главном узле.
		Возврат;
	КонецЕсли;
	
	Если НомерЗадания = Неопределено Тогда
		НомерЗадания = ПолучитьНомерЗадания();
	КонецЕсли;
	
	НачатьТранзакцию();
	Попытка
		
		НаборЗаписей = РегистрыСведений.ЗаданияКФормированиюДвиженийПоНДС.СоздатьМенеджерЗаписи();
		НаборЗаписей.Месяц        = НачалоМесяца(ПериодЗадания);
		НаборЗаписей.СчетФактура  = СчетФактура;
		НаборЗаписей.Организация  = Организация;
		НаборЗаписей.НомерЗадания = НомерЗадания;
		НаборЗаписей.Записать(Истина);
		
		ЗафиксироватьТранзакцию();
	
	Исключение
		
		ОтменитьТранзакцию();
		ТекстОшибки = ОбработкаОшибок.СообщениеОбОшибкеДляПользователя(ИнформацияОбОшибке());
		ВызватьИсключение ТекстОшибки;
	
	КонецПопытки;
	
КонецПроцедуры

// Метод создает записи регистра с параметрами, полученными запросом.
//
// Параметры:
//	Выборка - ВыборкаИзРезультатаЗапроса - выборка, содержащая данные для формирования записей.
//  НомерЗадания - Число - номер задания; если не задано, то будет установлено значение из соответствующей константы.
//
Процедура СоздатьЗаписиРегистраПоДаннымВыборки(Выборка, НомерЗадания = Неопределено) Экспорт
	
	Если ПланыОбмена.ГлавныйУзел() <> Неопределено Тогда
		// В РИБ данный регистр обрабатывается только в главном узле.
		Возврат;
	КонецЕсли;
	
	Если Выборка.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	НачатьТранзакцию();
	
	Попытка
		СтруктураПолей = Новый Структура("Месяц, Организация, СчетФактура");
		
		Если НомерЗадания = Неопределено Тогда
			НомерЗадания = ПолучитьНомерЗадания();
		КонецЕсли;
		
		Пока Выборка.Следующий() Цикл
			
			ЗаполнитьЗначенияСвойств(СтруктураПолей, Выборка);
			
			Если ЗначениеЗаполнено(СтруктураПолей.Организация) Тогда
				СоздатьЗаписьРегистра(СтруктураПолей.Месяц, СтруктураПолей.СчетФактура, СтруктураПолей.Организация, НомерЗадания);
			КонецЕсли;
			
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		
		ТекстОшибки    = ОбработкаОшибок.СообщениеОбОшибкеДляПользователя(ИнформацияОбОшибке());
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Не удалось сформировать задание к формированию движений по НДС за %1 в организации %2 по причине: %3'"),
			Выборка.Месяц,
			Выборка.Организация,
			ТекстОшибки);
			
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Учет НДС'", ОбщегоНазначения.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка, , , ТекстСообщения);
		
		ВызватьИсключение ТекстОшибки;
		
	КонецПопытки;
	
КонецПроцедуры

// Возвращает перечень объектов метаданных, на основании данных которых формируются записи в регистре.
//
//Возвращаемое значение:
// Массив из ОбъектМетаданных
Функция ВходящиеДанныеМеханизма() Экспорт
	
	ВходящиеДанные = УчетНДСУПСлужебный.ВходящиеДанныеМеханизма();
	
	Возврат ВходящиеДанные;
	
КонецФункции

#КонецОбласти

#КонецЕсли
