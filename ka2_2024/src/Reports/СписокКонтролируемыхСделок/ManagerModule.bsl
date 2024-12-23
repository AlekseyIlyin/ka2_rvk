#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

// Функция возвращает параметры отчета, см. БухгалтерскиеОтчетыВызовСервера.СформироватьОтчет
// Возвращаемое значение:
//	Структура
//
Функция ПолучитьПараметрыИсполненияОтчета() Экспорт
	
	СтруктураВозврата = Новый Структура;
	СтруктураВозврата.Вставить("ИспользоватьПередКомпоновкойМакета", Истина);
	СтруктураВозврата.Вставить("ИспользоватьПослеКомпоновкиМакета", Истина);
	СтруктураВозврата.Вставить("ИспользоватьПослеВыводаРезультата", Истина);
	СтруктураВозврата.Вставить("ИспользоватьДанныеРасшифровки", Истина);
	СтруктураВозврата.Вставить("ИспользоватьПривилегированныйРежим", Истина);
	Возврат СтруктураВозврата;
							
КонецФункции

// Функция возвращает заголовок отчета, см. БухгалтерскиеОтчетыВызовСервера.ВывестиЗаголовокОтчета
// Возвращаемое значение:
//	Строка
//
Функция ПолучитьТекстЗаголовка(ПараметрыОтчета, ОрганизацияВНачале = Истина) Экспорт 
	
	Возврат НСтр("ru = 'Сведения о контролируемых сделках'");
	
КонецФункции

// В процедуре можно доработать компоновщик перед выводом в отчет
// Изменения сохранены не будут.
Процедура ПередКомпоновкойМакета(ПараметрыОтчета, Схема, КомпоновщикНастроек) Экспорт
	
	КомпоновщикНастроек.Настройки.Структура.Очистить();
	КомпоновщикНастроек.Настройки.Выбор.Элементы.Очистить();
	
	Если ЗначениеЗаполнено(ПараметрыОтчета.ОтчетныйГод) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", НачалоГода(Дата(ПараметрыОтчета.ОтчетныйГод,1,1)));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ОкончаниеПериода", КонецГода(Дата(ПараметрыОтчета.ОтчетныйГод,1,1)));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "Уведомление", ПараметрыОтчета.Уведомление);
	КонецЕсли;
	
	Таблица = КомпоновщикНастроек.Настройки.Структура.Добавить(Тип("ТаблицаКомпоновкиДанных"));
	
	Поле = Таблица.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
	Поле.Использование = Истина;
	Поле.Поле = Новый ПолеКомпоновкиДанных("СуммаБезНДС");
	
	Поле = Таблица.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
	Поле.Использование = Истина;
	Поле.Поле = Новый ПолеКомпоновкиДанных("СуммаНДС");
	
	Поле = Таблица.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
	Поле.Использование = Истина;
	Поле.Поле = Новый ПолеКомпоновкиДанных("Всего");
	
	
	Структура =  Новый Структура("Структура",Таблица.Строки);	
	
	Если ПараметрыОтчета.Группировка.Количество() > 0 Тогда
		
		Для Каждого ПолеВыбраннойГруппировки Из ПараметрыОтчета.Группировка Цикл 
			Если ПолеВыбраннойГруппировки.Использование Тогда
				Структура = Структура.Структура.Добавить();
				
				ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
				ПолеГруппировки.Использование  = Истина;
				ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных(ПолеВыбраннойГруппировки.Поле);
				
				Если ПолеВыбраннойГруппировки.ТипГруппировки = 1 Тогда
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Иерархия;
				ИначеЕсли ПолеВыбраннойГруппировки.ТипГруппировки = 2 Тогда
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.ТолькоИерархия;
				Иначе
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
				КонецЕсли;
				
				Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
				Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));
				
			КонецЕсли;
		КонецЦикла;
		
	Иначе
		Структура = Структура.Структура.Добавить();
		
		ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
		ПолеГруппировки.Использование  = Истина;
		ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных("ПредметСделки");
		
		ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
		
		Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
		Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));
	КонецЕсли;
	
	
	
	// Дополнительные данные
	БухгалтерскиеОтчетыВызовСервера.ДобавитьДополнительныеПоля(ПараметрыОтчета, КомпоновщикНастроек);
					
КонецПроцедуры

// Процедура выполняет обработку компоновки макета отчета, см. БухгалтерскиеОтчетыВызовСервера.СформироватьОтчет.
//
Процедура ПослеКомпоновкиМакета(ПараметрыОтчета, МакетКомпоновки) Экспорт
		
	Для Каждого ЭлементТелаМакета Из МакетКомпоновки.Тело Цикл 
		Если ТипЗнч(ЭлементТелаМакета) = Тип("ТаблицаМакетаКомпоновкиДанных") Тогда
			ПараметрыОтчета.Вставить("ВысотаШапки", МакетКомпоновки.Макеты[ЭлементТелаМакета.МакетШапки].Макет.Количество()); 
			Прервать;	
		КонецЕсли;
	КонецЦикла;
			
КонецПроцедуры

// Процедура выполняет обработку результата отчета, см. БухгалтерскиеОтчетыВызовСервера.СформироватьОтчет.
//
Процедура ПослеВыводаРезультата(ПараметрыОтчета, Результат) Экспорт
	
	БухгалтерскиеОтчетыВызовСервера.ОбработкаРезультатаОтчета(ПараметрыОтчета.ИдентификаторОтчета, Результат);

	Если Результат.Области.Найти("Заголовок") = Неопределено Тогда
		Результат.ФиксацияСверху = ПараметрыОтчета.ВысотаШапки;
	Иначе
		Результат.ФиксацияСверху = Результат.Области.Заголовок.Низ + ПараметрыОтчета.ВысотаШапки;
	КонецЕсли;
	
	Результат.ФиксацияСлева = 0;
	
КонецПроцедуры

// Функция возвращает показатели отчета, см. БухгалтерскиеОтчетыВызовСервера.ОбработкаПроверкиЗаполнения
// Возвращаемое значение:
//	Массив - массив значений строкового типа.
//
Функция ПолучитьНаборПоказателей() Экспорт
	
	НаборПоказателей = Новый Массив;
	НаборПоказателей.Добавить("БУ");
	НаборПоказателей.Добавить("НУ");
	НаборПоказателей.Добавить("ПР");
	НаборПоказателей.Добавить("ВР");
	
	Возврат НаборПоказателей;
	
КонецФункции

#КонецОбласти

#КонецЕсли