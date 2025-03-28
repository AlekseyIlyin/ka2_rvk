
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляРегламентированныхДанных(Настройки);
КонецПроцедуры

#КонецОбласти

Процедура ПараметрыОбновленияИсточникаПодключаемыхХарактеристикЗарплатаКадры(ПараметрыОбновления) Экспорт
	
	ПараметрыОбновления.ИмяРегистра = "СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы";
	ПараметрыОбновления.ИдентификаторИсточника = "СтрСтатСоцСферы";
	ПараметрыОбновления.ИмяОбъекта = "Должность";
	
	ПараметрыОбновления.ОбновитьНаборХарактеристик = Истина;
	ПараметрыОбновления.ОбновлятьОпеределяемымиЗначениями = Истина;
	
	ПараметрыОбновления.ИмяПланаВидовХарактеристик = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ДолжностиБЗКРасширенный.ИмяПланаВидовПодключаемыхХарактеристикЗарплатаКадры());
	ПараметрыОбновления.ИмяПланаВидовХарактеристик.Добавить(Справочники.ШтатноеРасписание.ИмяПланаВидовПодключаемыхХарактеристикЗарплатаКадры());
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОбновитьПодключаемыеХарактеристики(ИспользоватьПодключаемыеХарактеристики, ПараметрыОбновления = Неопределено) Экспорт
	
	ИсточникиХарактеристик = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве("СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы");
	
	ПодключаемыеХарактеристикиЗарплатаКадры.ОбновитьНаборыПодключаемыхХарактеристик(
		ИспользоватьПодключаемыеХарактеристики, ИсточникиХарактеристик, ПараметрыОбновления);
	
КонецПроцедуры
	
Процедура ОбновитьНаборыПодключаемыхХарактеристикОпределяемымиЗначениями(ИмяПланаВидовХарактеристик, ИспользоватьПодключаемыеХарактеристики = Истина, ТаблицаХарактеристик = Неопределено, Объекты = Неопределено, ПараметрыОтложенногоОбновления = Неопределено) Экспорт
	
	ИмяПВХДолжности =  ДолжностиБЗКРасширенный.ИмяПланаВидовПодключаемыхХарактеристикЗарплатаКадры();
	ИмяПВХПозиции =  Справочники.ШтатноеРасписание.ИмяПланаВидовПодключаемыхХарактеристикЗарплатаКадры();
	ТипОбъекта = Неопределено;
	Если ИмяПланаВидовХарактеристик = ИмяПВХДолжности Тогда
		ТипОбъекта = Тип("СправочникСсылка.Должности");
	ИначеЕсли ИмяПланаВидовХарактеристик = ИмяПВХПозиции Тогда
		ТипОбъекта = Тип("СправочникСсылка.ШтатноеРасписание");
	КонецЕсли;
	
	ИдентификаторыИсточника = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве("СтрСтатСо");
	ИдентификаторыВидовФормМониторинга = ИдентификаторыВидовФормМониторинга();
	Для Каждого ИдентификаторМониторинга Из ИдентификаторыВидовФормМониторинга Цикл
		Если ИдентификаторыИсточника.Найти(ИдентификаторМониторинга.Значение.ИдентификаторИсточника) = Неопределено Тогда
			ИдентификаторыИсточника.Добавить(ИдентификаторМониторинга.Значение.ИдентификаторИсточника);
		КонецЕсли;
	КонецЦикла;
	
	ФильтрОбъектов = Неопределено;
	Если Объекты <> Неопределено Тогда
		Если ТипЗнч(Объекты) <> Тип("Массив") Тогда
			Объекты = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Объекты);
		КонецЕсли;
		
		ФильтрОбъектов = Новый Массив;
		Для Каждого Объект Из Объекты Цикл
			Если ТипЗнч(Объект) = ТипОбъекта Тогда
				Если ФильтрОбъектов.Найти(Объект) = Неопределено Тогда
					ФильтрОбъектов.Добавить(Объект); 
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
		Если ФильтрОбъектов.Количество() = 0 Тогда
			Возврат
		КонецЕсли;
	КонецЕсли;
	
	
	Если ИспользоватьПодключаемыеХарактеристики Тогда
		
		СинонимСвойства = Метаданные.РегистрыСведений.СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.Ресурсы["СтрокаОтчетностиМониторингаРаботниковСоциальнойСферы"].Синоним;
	
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("ВсеОбъекты", ФильтрОбъектов = Неопределено);
		Запрос.УстановитьПараметр("ФильтрОбъектов", ФильтрОбъектов);
		Запрос.УстановитьПараметр("ИмяПВХДолжности", ДолжностиБЗКРасширенный.ИмяПланаВидовПодключаемыхХарактеристикЗарплатаКадры());
		Запрос.УстановитьПараметр("ИмяПВХПозиции", Справочники.ШтатноеРасписание.ИмяПланаВидовПодключаемыхХарактеристикЗарплатаКадры());
		Запрос.УстановитьПараметр("ТипОбъекта", ТипОбъекта);
		
		Запрос.Текст =
		"ВЫБРАТЬ
		|	СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.ВидФормыМониторинга КАК ВидФормыМониторинга,
		|	СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.Должность КАК Объект,
		|	СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.СтрокаОтчетностиМониторингаРаботниковСоциальнойСферы КАК Значение
		|ПОМЕСТИТЬ ВТЗаписиРегистра
		|ИЗ
		|	РегистрСведений.СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы КАК СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы
		|ГДЕ
		|	(&ВсеОбъекты
		|			ИЛИ СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.Должность В (&ФильтрОбъектов))
		|	И СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.ВидФормыМониторинга <> ЗНАЧЕНИЕ(Перечисление.ВидыФормМониторингаРаботниковСоциальнойСферы.ПустаяССылка)
		|	И ТИПЗНАЧЕНИЯ(СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.Должность) = &ТипОбъекта
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВЫБОР
		|		КОГДА ТИПЗНАЧЕНИЯ(ХарактеристикиФормДолжностей.Объект) = ТИП(Справочник.Должности)
		|			ТОГДА &ИмяПВХДолжности
		|		КОГДА ТИПЗНАЧЕНИЯ(ХарактеристикиФормДолжностей.Объект) = ТИП(Справочник.ШтатноеРасписание)
		|			ТОГДА &ИмяПВХПозиции
		|		ИНАЧЕ """"
		|	КОНЕЦ КАК ИмяПВХ,
		|	ХарактеристикиФормДолжностей.ВидФормыМониторинга КАК ВидФормыМониторинга,
		|	ХарактеристикиФормДолжностей.Объект КАК Объект,
		|	ХарактеристикиФормДолжностей.Значение КАК Значение,
		|	ВЫРАЗИТЬ("""" КАК СТРОКА(100)) КАК Свойство,
		|	ВЫРАЗИТЬ("""" КАК СТРОКА(9)) КАК ИдентификаторИсточника
		|ИЗ
		|	(ВЫБРАТЬ
		|		ЗаписиРегистра.ВидФормыМониторинга КАК ВидФормыМониторинга,
		|		ЗаписиРегистра.Объект КАК Объект,
		|		ЗаписиРегистра.Значение КАК Значение
		|	ИЗ
		|		ВТЗаписиРегистра КАК ЗаписиРегистра
		|	
		|	ОБЪЕДИНИТЬ ВСЕ
		|	
		|	ВЫБРАТЬ РАЗЛИЧНЫЕ
		|		СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.ВидФормыМониторинга,
		|		ЗаписиРегистра.Объект,
		|		ЗНАЧЕНИЕ(Справочник.СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.ПустаяССылка)
		|	ИЗ
		|		ВТЗаписиРегистра КАК ЗаписиРегистра
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы КАК СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы
		|			ПО (СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.ВидФормыМониторинга <> ЗаписиРегистра.ВидФормыМониторинга)
		|				И (СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.Должность <> ЗаписиРегистра.Объект)
		|				И (ТИПЗНАЧЕНИЯ(СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.Должность) = &ТипОбъекта)
		|			ЛЕВОЕ СОЕДИНЕНИЕ ВТЗаписиРегистра КАК ЗаписиРегистраПоФормам
		|			ПО (ЗаписиРегистраПоФормам.ВидФормыМониторинга = СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.ВидФормыМониторинга)
		|	ГДЕ
		|		НЕ &ВсеОбъекты
		|		И СтрокиОтчетностиМониторингаРаботниковСоциальнойСферы.ВидФормыМониторинга <> ЗНАЧЕНИЕ(Перечисление.ВидыФормМониторингаРаботниковСоциальнойСферы.ПустаяССылка)
		|		И ЗаписиРегистраПоФормам.ВидФормыМониторинга ЕСТЬ NULL) КАК ХарактеристикиФормДолжностей
		|
		|УПОРЯДОЧИТЬ ПО
		|	ХарактеристикиФормДолжностей.ВидФормыМониторинга,
		|	ХарактеристикиФормДолжностей.Объект";
		ТаблицаХарактеристик = Запрос.Выполнить().Выгрузить();
		Для Каждого Строка Из ТаблицаХарактеристик Цикл
			ИдентификаторМониторинга = ИдентификаторыВидовФормМониторинга[Строка.ВидФормыМониторинга];
			Если ИдентификаторМониторинга = Неопределено Тогда
				ИдентификаторМониторинга = Новый Структура("ИдентификаторИсточника, Представление", "СтрСтатСо", "");
			КонецЕсли;
			Строка.Свойство = СинонимСвойства + ?(ПустаяСтрока(ИдентификаторМониторинга.Представление), "", " по " + ИдентификаторМониторинга.Представление);
			Строка.ИдентификаторИсточника = ИдентификаторМониторинга.ИдентификаторИсточника;
		КонецЦикла;
		
	КонецЕсли;
	
	ПодключаемыеХарактеристикиЗарплатаКадры.ОбновитьНаборыПодключаемыхХарактеристикОпределяемымиЗначениями(
		ИдентификаторыИсточника,
		ИмяПланаВидовХарактеристик,
		ИспользоватьПодключаемыеХарактеристики,
		ТаблицаХарактеристик,
		ФильтрОбъектов,
		ПараметрыОтложенногоОбновления);
	
КонецПроцедуры

Функция ИдентификаторыВидовФормМониторинга()
	
	Идентификаторы = Новый Соответствие;
	
	Идентификаторы.Вставить(Перечисления.ВидыФормМониторингаРаботниковСоциальнойСферы.ЗПЗдрав, 
		Новый Структура("ИдентификаторИсточника, Представление", "СтрСтатСо", "ЗП-Здрав"));
	
	Идентификаторы.Вставить(Перечисления.ВидыФормМониторингаРаботниковСоциальнойСферы.ЗПКультура, 
		Новый Структура("ИдентификаторИсточника, Представление", "СтрСтатСо", "ЗП-Культура"));
	
	Идентификаторы.Вставить(Перечисления.ВидыФормМониторингаРаботниковСоциальнойСферы.ЗПНаука, 
		Новый Структура("ИдентификаторИсточника, Представление", "СтрСтатСо", "ЗП-Наука"));
		
	Идентификаторы.Вставить(Перечисления.ВидыФормМониторингаРаботниковСоциальнойСферы.ЗПОбразование, 
		Новый Структура("ИдентификаторИсточника, Представление", "СтрСтатСо", "ЗП-Образование"));
		
	Идентификаторы.Вставить(Перечисления.ВидыФормМониторингаРаботниковСоциальнойСферы.ЗПСоц, 
		Новый Структура("ИдентификаторИсточника, Представление", "СтрСтатСо", "ЗП-Соц"));
	
	Идентификаторы.Вставить(Перечисления.ВидыФормМониторингаРаботниковСоциальнойСферы.ЗПСоц, 
		Новый Структура("ИдентификаторИсточника, Представление", "СтрСтатСо", "ЗП-Соц"));
		
	Идентификаторы.Вставить(Перечисления.ВидыФормМониторингаРаботниковСоциальнойСферы.ЗПФизическаяКультураИСпорт, 
		Новый Структура("ИдентификаторИсточника, Представление", "СтрСтатСо", "ЗП-физическая культура и спорт"));
		
	Возврат Идентификаторы;
	
КонецФункции

#КонецОбласти

#КонецЕсли





