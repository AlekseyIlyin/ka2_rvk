#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Примечание:
// В источнике данных СведенияОбОрганизации признак использования УСН реализован несколькими полями:
//	- УСН (булево)
//	- УСНОтметкаСтрокой (строка) - если УСН=Истина, то "X" (лат), иначе "";
//	- НеУСНОтметкаСтрокой (строка) - если УСН=Истина, то "", иначе "X" (лат);
//	- УСНГалка (строка) - если УСН=Истина, то "V" (лат), иначе "";
//	- НеУСНГалка (строка) - если УСН=Истина, то "", иначе "V" (лат);
//	Это связано с тем, что в различных формах отчетности (например, ПМ, МП-сп, 1-предприниматель).
//	признак использования УСН заполняется по-разному (в виде "X", "V", Да/Нет в отдельных полях).

// Функция возвращает схему компоновки данных соответствующую переданному значению перечисления.
//
// Параметры:
// 	ИсточникДанных - ПеречислениеСсылка.ИсточникиДанныхСтатистическихПоказателей - Источник.
//	РазделИсточникаДанных - Строка - Имя специализированной схемы СКД источника.
//
// Возвращаемое значение: 
//  СхемаКомпоновкиДанных - СКД, соответствующая (одноименная) значению перечисления.
// 	Если схема не найдена, возвращается пустая схема компоновки данных.
//
Функция СхемаКомпоновкиДанных(ИсточникДанных, РазделИсточникаДанных = "") Экспорт
	
	Если Не ПустаяСтрока(РазделИсточникаДанных) Тогда
		ИмяСхемы = РазделИсточникаДанных;
	Иначе
	
		Если Не ЗначениеЗаполнено(ИсточникДанных) Тогда
			Возврат Новый СхемаКомпоновкиДанных;
		КонецЕсли;
		
		ИмяСхемы = ИсточникДанных.Метаданные().ЗначенияПеречисления.Получить(Индекс(ИсточникДанных)).Имя;
		
	КонецЕсли;
	
	Если ИсточникДанных.Метаданные().Макеты.Найти(ИмяСхемы) = Неопределено Тогда
		Возврат Новый СхемаКомпоновкиДанных;		
	Иначе
		Возврат ПолучитьМакет(ИмяСхемы);
	КонецЕсли;
	
КонецФункции	

// Возвращает имя специализированной СКД для источника.
//
// Параметры:
//  ИсточникДанных - ПеречислениеСсылка.ИсточникиДанныхСтатистическихПоказателей.
//  Характеристика - Строка - имя поля источника данных показателя (СКД)
//
// Возвращаемое значение:
//	Строка - Имя макета схемы компоновки данных, которой выбираются данные показателя.
//	Если возвращена пустая строка, то СКД определяется по значению ИсточникДанных
//
Функция РазделИсточникаДанных(ИсточникДанных, Знач Характеристика) Экспорт
	
	Если Не ЗначениеЗаполнено(ИсточникДанных) Тогда
		Возврат "";
	КонецЕсли;
	
	Характеристика = СтрЗаменить(Характеристика, "НачальныйОстаток", "");
	
	Если ИсточникДанных = ФинансовоеСостояние 
		Или ИсточникДанных = ОперацииСКонтрагентами Тогда
		
		Если Характеристика = "ПрибыльУбыток"
			Или Характеристика = "Выручка"
			Или Характеристика = "СебестоимостьПродаж"
			Или Характеристика = "КосвенныеРасходы"
			Или Характеристика = "ПрочиеДоходыОС"
			Или Характеристика = "СписаниеКредиторскойЗадолженности"
			Или Характеристика = "СписаниеДебиторскойЗадолженности"
			Или Характеристика = "ПрочиеРасходыПроценты" Тогда
			
			Возврат "ПрибыльУбыток";
			
		ИначеЕсли Характеристика = "КредиторскаяЗадолженность"
			Или Характеристика = "ЗадолженностьПоставщикам"
			Или Характеристика = "ЗадолженностьПередБюджетом"
			Или Характеристика = "ЗадолженностьВФедеральныйБюджет"
			Или Характеристика = "ЗадолженностьВРегиональныйБюджет"
			Или Характеристика = "ЗадолженностьВФонды" 
			Или Характеристика = "ВекселяВыданные" Тогда

			Возврат "КредиторскаяЗадолженность";
			
		ИначеЕсли Характеристика = "КапиталИРезервы" 
			Или Характеристика = "НераспределеннаяПрибыль"
			Или Характеристика = "СобственныеАкции"
			Или Характеристика = "Капитал"
			Или Характеристика = "УставныйКапитал"
			Или Характеристика = "Страна"
			Или Характеристика = "КодСтраныПартнера" Тогда
			
			Возврат "КапиталИРезервы";
			
		ИначеЕсли Характеристика = "ОборотныеАктивы"
			Или Характеристика = "ДебиторскаяЗадолженность"
			Или Характеристика = "ЗадолженностьПокупателей" 
			Или Характеристика = "ЗадолженностьПокупателейПросроченная"
			Или Характеристика = "ВекселяПолученные"  
			Или Характеристика = "Запасы"
			Или Характеристика = "ПроизводственныеЗапасы"
			Или Характеристика = "ПроизводственныеЗапасыНачальныйОстаток"
			Или Характеристика = "НЗП"
			Или Характеристика = "НЗПНачальныйОстаток"
			Или Характеристика = "Продукция"
			Или Характеристика = "ПродукцияНачальныйОстаток"
			Или Характеристика = "Товары"
			Или Характеристика = "ТоварыНачальныйОстаток"
			Или Характеристика = "НДСПоПриобретеннымЦенностям"
			Или Характеристика = "ФинансовыеВложения"
			Или Характеристика = "ДенежныеСредства" Тогда
			
			Возврат "ОборотныеАктивы";
			
		ИначеЕсли Характеристика = "ЗадолженностьПоКредитамИЗаймам"
			Или Характеристика = "ЗадолженностьПоКраткосрочнымКредитамИЗаймам" Тогда
			
			Возврат "КредитыИЗаймы";
			
		ИначеЕсли Характеристика = "ВнеоборотныеАктивы"
			Или Характеристика = "НМА"
			Или Характеристика = "ОС"
			Или Характеристика = "НезавершенноеСтроительство" Тогда
			
			Возврат "ВнеоборотныеАктивы";
			
		ИначеЕсли Характеристика = "ОбъемОтгруженныхТоваров" Тогда
			
			Возврат "ОбъемОтгруженныхТоваров";
			
		Иначе
			
			Возврат Характеристика;
			
		КонецЕсли;
		
	ИначеЕсли ИсточникДанных = ЗакупкиИЗатраты 
		И Характеристика = "ЗадолженностьПоставщикам" Тогда
			
		Возврат "КредиторскаяЗадолженность";
		
	Иначе
		// У остальных источников нет разделов
		Возврат "";
	КонецЕсли;
	
КонецФункции

// Процедура обрабатывает показатели с источником данных "ОперацииСКонтрагентами":
// добавляет в настройки показателя отбор по контрагентам на основании настроек, установленных пользователем
//
// Параметры:
//	Показатели - ТаблицаЗначений - См. ЗаполнениеФормСтатистики.НовыйОписаниеПоказателей.
//
Процедура ДобавитьОтборПоАдресамКонтрагентов(Показатели) Экспорт
	
	ОтборПоказателейСАдресами = Новый Структура("ИсточникДанных", ОперацииСКонтрагентами);
	
	ПоказателиСАдресами = Показатели.НайтиСтроки(ОтборПоказателейСАдресами);
	
	Если ПоказателиСАдресами.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОбъектыСАдресами = Новый Соответствие;
	Для Каждого Показатель Из ПоказателиСАдресами Цикл
		
		ПоказателиОбъекта = ОбъектыСАдресами[Показатель.ОбъектНаблюдения];
		
		Если ПоказателиОбъекта = Неопределено Тогда
			ПоказателиОбъекта = Новый Массив;
			ОбъектыСАдресами.Вставить(Показатель.ОбъектНаблюдения, ПоказателиОбъекта);
		КонецЕсли;
		
		ПоказателиОбъекта.Добавить(Показатель);
		
	КонецЦикла;
	
	СхемаКомпоновки = ПолучитьМакет("ОперацииСКонтрагентами");
	
	КомпоновщикНастроек = Новый КомпоновщикНастроекКомпоновкиДанных;
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаКомпоновки));
	КомпоновщикНастроек.ЗагрузитьНастройки(СхемаКомпоновки.НастройкиПоУмолчанию);
	
	Для Каждого ОписаниеОбъектаНаблюдения Из ОбъектыСАдресами Цикл
		
		// Получим список стран
		// Можно оптимизировать и для России получать список не российских контрагентов, а иностранных
		
		ОбъектНаблюдения = ОписаниеОбъектаНаблюдения.Ключ;
		ЗаполнениеФормСтатистики.ЗагрузитьНастройку(КомпоновщикНастроек, ОбъектНаблюдения.Настройка);
		НастройкиДляКомпоновкиМакета = КомпоновщикНастроек.ПолучитьНастройки();
		
		// Получим данные
		КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
		МакетКомпоновки   = КомпоновщикМакета.Выполнить(
			СхемаКомпоновки,
			НастройкиДляКомпоновкиМакета,
			, // ДанныеРасшифровки
			, // МакетОформления
			Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
			
		ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
		ПроцессорКомпоновки.Инициализировать(МакетКомпоновки);
		
		ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
		РезультатЗапроса = ПроцессорВывода.Вывести(ПроцессорКомпоновки);
		Контрагенты = Новый СписокЗначений;
		Контрагенты.ЗагрузитьЗначения(РезультатЗапроса.ВыгрузитьКолонку("Контрагент"));
		
		// Передадим список стран в настройки показателей
		Для Каждого Показатель Из ОписаниеОбъектаНаблюдения.Значение Цикл
			ЗаполнениеФормСтатистики.ДобавитьОтборВСериализованнуюНастройку(
				Показатель.Настройка, 
				"Контрагент", 
				Контрагенты, 
				ВидСравненияКомпоновкиДанных.ВСписке);
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

// Процедура обрабатывает показатели с источником данных "ГруппаПоказателей":
// подменяет в каждом таком показателе (точнее, удаляет исходный и добавляет новый) 
// источник данных на источник из родительского объекта наблюдения
// и при этом уточняет отбор источника данных значением аналитики, установленным в настройках показателя.
//
// Параметры:
//	Показатели - ТаблицаЗначений - См. ЗаполнениеФормСтатистики.НовыйОписаниеПоказателей.
//
Процедура СгруппироватьПоказатели(Показатели) Экспорт
	
	// В результирующие показатели включим некоторое подмножество элементарных показателей.
	// Результирующие показатели идентифицируются источником данных "ГруппаПоказателей".
	// Элементарные показатели идентифицируются объектом наблюдения: это должен быть родитель объекта результирующего показателя
	
	// Подготовим коллекцию, которая описывает набор результирующих показателей.
	// Каждый элемент коллекции характеризует (содержит)
	// 1. набор элементарных показателей, отобранные одним и тем же способом
	// 2. набор результирующих показателей, в каждый из которых нужно включить одинаковый набор элементарных показателей
	// Это нужно, чтобы сократить количество запросов: избежать выполнения запросов, которые вернут заведомо одинаковый результат
	Группировки = Показатели.СкопироватьКолонки("ОбъектНаблюдения, ИсточникДанных, ОбщаяНастройка, Организация");
	Группировки.Колонки.Добавить("РезультирующиеПоказатели", Новый ОписаниеТипов("Массив"));// Массив ссылок на элементы коллекции Показатели
	Группировки.Колонки.Добавить("ЭлементарныеПоказатели",   Новый ОписаниеТипов("Массив"));// Массив ссылок на элементы коллекции Показатели
	КлючевыеПоляГруппировки = "ОбъектНаблюдения, Организация"; // ИсточникДанных и ОбщаяНастройка определяются ОбъектомНаблюдения
	Группировки.Индексы.Добавить(КлючевыеПоляГруппировки);
	
	// Заполним эту коллекцию
	ОтборГруппировок = Новый Структура(КлючевыеПоляГруппировки);
	Для Каждого Показатель Из Показатели.НайтиСтроки(Новый Структура("ИсточникДанных", ГруппаПоказателей)) Цикл
		
		ЗаполнитьЗначенияСвойств(ОтборГруппировок, Показатель);
		НайденныеГруппировки = Группировки.НайтиСтроки(ОтборГруппировок);
		
		Если НайденныеГруппировки.Количество() > 0 Тогда
			Группировка = НайденныеГруппировки[0];
		Иначе
			Группировка = Группировки.Добавить();
			ЗаполнитьЗначенияСвойств(Группировка, Показатель);
		КонецЕсли;
		
		Группировка.РезультирующиеПоказатели.Добавить(Показатель);
		
	КонецЦикла;
	
	// Определим перечень элементарных показателей.
	СхемаКомпоновки = ПолучитьМакет("ГруппаПоказателей");
	КомпоновщикНастроек = Новый КомпоновщикНастроекКомпоновкиДанных;
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаКомпоновки));
	
	ЭлементарныеПоказатели = Показатели.Скопировать(,"Аналитика,ОбъектНаблюдения");// См. схему
	ЭлементарныеПоказатели.Колонки.Добавить("Индекс", Новый ОписаниеТипов("Число"));
	Для Каждого Показатель Из ЭлементарныеПоказатели Цикл
		Показатель.Индекс = ЭлементарныеПоказатели.Индекс(Показатель);
	КонецЦикла;
	
	ВнешниеДанные = Новый Структура("Показатели", ЭлементарныеПоказатели);
	
	Для Каждого Группировка Из Группировки Цикл
		
		КомпоновщикНастроек.ЗагрузитьНастройки(СхемаКомпоновки.НастройкиПоУмолчанию);
		ЗаполнениеФормСтатистики.ЗагрузитьНастройку(КомпоновщикНастроек, Группировка.ОбщаяНастройка); // Как правило, отбор по полю Аналитика
		
		БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(
			КомпоновщикНастроек.Настройки.Отбор, 
			"ОбъектНаблюдения",
			Группировка.ОбъектНаблюдения.Родитель,
			ВидСравненияКомпоновкиДанных.Равно);
		
		НастройкиДляКомпоновкиМакета = КомпоновщикНастроек.ПолучитьНастройки();
		
		// Получим данные
		КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
		МакетКомпоновки   = КомпоновщикМакета.Выполнить(
			СхемаКомпоновки,
			НастройкиДляКомпоновкиМакета,
			, // ДанныеРасшифровки
			, // МакетОформления
			Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
			
		ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
		ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, ВнешниеДанные);
		
		ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
		РезультатЗапроса = ПроцессорВывода.Вывести(ПроцессорКомпоновки);
		
		Для Каждого ЭлементарныйПоказатель Из РезультатЗапроса Цикл
			 Группировка.ЭлементарныеПоказатели.Добавить(Показатели[ЭлементарныйПоказатель.Индекс]);
		КонецЦикла;
		
	КонецЦикла;
	
	// Соединим списки результирующих и элементарных показателей
	// Из элементарных показателей возьмем значения полей:
	ПоляЭлементарныхПоказателей = "ОбъектНаблюдения, ИсточникДанных, ОбщаяНастройка, Настройка, Аналитика, Детализировать";
	// Остальные поля возьмем из результирующих показателей
	
	Для Каждого Группировка Из Группировки Цикл
		Для Каждого РезультирующийПоказатель Из Группировка.РезультирующиеПоказатели Цикл
			// Создадим показатели "на пересечении"
			ПозицияНовогоПоказателя = Показатели.Индекс(РезультирующийПоказатель) + 1; // Соблюдаем порядок
			Для Каждого ЭлементарныйПоказатель Из Группировка.ЭлементарныеПоказатели Цикл
				НовыйПоказатель = Показатели.Вставить(ПозицияНовогоПоказателя);
				ЗаполнитьЗначенияСвойств(НовыйПоказатель, РезультирующийПоказатель, , ПоляЭлементарныхПоказателей);
				ЗаполнитьЗначенияСвойств(НовыйПоказатель, ЭлементарныйПоказатель, ПоляЭлементарныхПоказателей);
				ПозицияНовогоПоказателя = ПозицияНовогоПоказателя + 1;
			КонецЦикла;
			// Служебная строка более не нужна
			Показатели.Удалить(РезультирующийПоказатель);
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

// Функция возвращает имя варианта настроек СКД для расшифровки показателя.
//
// Параметры:
//	ИсточникДанных - ПеречислениеСсылка.ИсточникиДанныхСтатистическихПоказателей.
//	РазделИсточникаДанных - Строка - дополнительный указатель на схему-источник данных показателя.
//									 См. РазделИсточникаДанных().
//	Характеристика - Строка - имя поля источника данных показателя (СКД).
//
// Возвращаемое значение:
//   - Строка - имя варианта настроек СКД.
//
Функция ИмяНастроекРасшифровки(ИсточникДанных, РазделИсточникаДанных = "", Характеристика) Экспорт
	
	// Если в схеме один вариант настроек расшифровки 
	// для всех характеристик, то он называется "Расшифровка"
	ИмяНастроек = "Расшифровка";
	
	Если Не ПустаяСтрока(РазделИсточникаДанных) Тогда
		ИмяСхемы = РазделИсточникаДанных;
	Иначе
		
		Если Не ЗначениеЗаполнено(ИсточникДанных) Тогда
			Возврат Новый СхемаКомпоновкиДанных;
		КонецЕсли;
		
		ИмяСхемы = ИсточникДанных.Метаданные().ЗначенияПеречисления.Получить(Индекс(ИсточникДанных)).Имя;
		
	КонецЕсли;
	
	Если ИмяСхемы = "ЗакупкиИЗатраты" Тогда
		
		Если Характеристика = "ЗатратыНаСтроительствоХозспособом" Тогда
			
			ИмяНастроек = "ЗатратыНаСтроительство";
			
		ИначеЕсли Характеристика = "КоличествоПриобретено" Тогда
			
			ИмяНастроек = "Приобретение";
			
		ИначеЕсли Характеристика = "ЗатратыМатериалы" Тогда
			
			ИмяНастроек = "ЗатратыМатериалы";
			
		ИначеЕсли Характеристика = "ЗатратыТопливо" Тогда
			
			ИмяНастроек = "ЗатратыТопливо";
			
		ИначеЕсли Характеристика = "ЗатратыУслуги" 
			  ИЛИ Характеристика = "ЗатратыАренда"
			  ИЛИ Характеристика = "ЗатратыКомандировки"
			  ИЛИ Характеристика = "ЗатратыПредставительские"
			  ИЛИ Характеристика = "ЗатратыСтрахование" Тогда
			
			ИмяНастроек = "ЗатратыУслуги";
			
		ИначеЕсли Характеристика = "ЗатратыНалоги" Тогда
			
			ИмяНастроек = "ЗатратыНалоги";
			
		ИначеЕсли Характеристика = "Затраты" Тогда
			
			ИмяНастроек = "Затраты";
			
		КонецЕсли;
		
	ИначеЕсли ИмяСхемы = "ОборотныеАктивы" Тогда
		
		Если Характеристика = "ЗадолженностьПокупателей" 
		 ИЛИ Характеристика = "ЗадолженностьПокупателейПросроченная" Тогда
			
			ИмяНастроек = "ЗадолженностьПокупателейПоставщиков";
								
		ИначеЕсли Характеристика = "ПроизводственныеЗапасы" 
			  ИЛИ Характеристика = "Товары" 
			  ИЛИ Характеристика = "Продукция" 
			  ИЛИ Характеристика = "ТоварыНачальныйОстаток" 
			  ИЛИ Характеристика = "ПродукцияНачальныйОстаток" Тогда
			
			ИмяНастроек = "Запасы";
			
		ИначеЕсли Характеристика = "РБПИРасходыПоСтрахованиюОтнесенныеКЗапасам" Тогда

			ИмяНастроек = "ЗадолженностьБудущихПериодов";
			
		КонецЕсли;
		
	ИначеЕсли ИмяСхемы = "ПроизводствоИПродажи" Тогда
		
		Если Характеристика =    "ОстатокВЕдиницахСтатистическогоУчета"
			ИЛИ Характеристика = "ОбъемПроизводстваВЕдиницахСтатистическогоУчета"
			ИЛИ Характеристика = "ОбъемРеализацииВЕдиницахСтатистическогоУчета"
			ИЛИ Характеристика = "ОбъемРозничныхПродажВЕдиницахСтатистическогоУчета"
			ИЛИ Характеристика = "ОстатокВРозницеВЕдиницахСтатистическогоУчета"
			ИЛИ Характеристика = "ОбъемРеализацииБезНДСВЕдиницахСтатистическогоУчета"
			ИЛИ Характеристика = "ОбъемРеализацииВключаяНДСВЕдиницахСтатистическогоУчета"
			ИЛИ Характеристика = "СтоимостьПроданныхНаСторону" Тогда
			
			ИмяНастроек = Характеристика;
			
		КонецЕсли;
		
	ИначеЕсли ИмяСхемы = "ОсновныеФонды" Тогда
		Если Характеристика = "ПолнаяУчетнаяСтоимостьОС"
			ИЛИ Характеристика = "ПолнаяУчетнаяСтоимостьНМА"
			ИЛИ Характеристика = "ПолнаяУчетнаяСтоимостьПолностьюСамортизированныхОС"
			ИЛИ Характеристика = "ПолнаяУчетнаяСтоимостьПолностьюСамортизированныхНМА"
			ИЛИ Характеристика = "ПолнаяУчетнаяСтоимостьНеАмортизируемыхОС"
			ИЛИ Характеристика = "ПолнаяУчетнаяСтоимостьНеАмортизируемыхНМА"
			ИЛИ Характеристика = "ОстаточнаяСтоимостьОС"
			ИЛИ Характеристика = "СуммаРеализацииОС"
			ИЛИ Характеристика = "СуммаРеализацииНМА" Тогда
			
			ИмяНастроек = "РасшифровкаОстаточнаяСтоимость";
			
		КонецЕсли;
		
	ИначеЕсли ИмяСхемы = "СведенияОбОрганизации" Тогда
		
		Если Характеристика =    "КоличествоОбособленныхПодразделений"
			ИЛИ Характеристика = "КоличествоОбособленныхПодразделенийВДругихРегионах" Тогда
			ИмяНастроек = "РасшифровкаПодразделения";
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ИмяНастроек;
	
КонецФункции

// Функция возвращает признак того, что СКД, соответсвующая значению перечисления,
// принимает список из нескольких организаций в параметре "Организация"
//
// Параметры:
//  ИсточникДанных - Перечисление.ИсточникиДанныхСтатистическихПоказателей - значение источника данных показателя
// 
// Возвращаемое значение:
//   - Булево
//
Функция ИсточникПоддерживаетСписокОрганизаций(ИсточникДанных) Экспорт

	Если ИсточникДанных = СведенияОбОрганизации 
		ИЛИ ИсточникДанных = ОсновнойВидДеятельности 
		ИЛИ ИсточникДанных = ПриобретениеВнеоборотныхМатериальныхАктивов 
		ИЛИ ИсточникДанных = СозданиеВнеоборотныхМатериальныхАктивов Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти

#КонецЕсли