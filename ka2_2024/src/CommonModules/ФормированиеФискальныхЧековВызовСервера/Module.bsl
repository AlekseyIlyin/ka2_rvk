#Область ПрограммныйИнтерфейс

// Возвращает поддерживаемую максимальную версию ФФД
// 
// Возвращаемое значение:
// 	Строка - Описание - Версия ФФД
Функция МаксимальнаяВерсияФФД() Экспорт
	
	Возврат ФормированиеФискальныхЧековСервер.МаксимальнаяВерсияФФД();
	
КонецФункции

// Инициализирует параметры фискального чека
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ, по которому требуется распечатать чек 
// 	Организация - СправочникСсылка.Организации - Организация по документу
// Возвращаемое значение:
// 	Структура - Описание: Параметры фискального чека
//
Функция ПараметрыОперацииФискализацииЧека(ДокументСсылка, Организация) Экспорт
	
	Возврат ФормированиеПараметровФискальногоЧекаСервер.ПараметрыОперацииФискализацииЧека(ДокументСсылка, Организация);
	
КонецФункции

// Возвращает параметры операции для фискализации чека по документу
// 
// Параметры:
// 	ДокументСсылка - см. ФормированиеПараметровФискальногоЧекаСервер.ПараметрыОперацииФискализацииЧекаПакетныйРежим.ДокументСсылка
// 	ОборудованиеККТ - см. ФормированиеПараметровФискальногоЧекаСервер.ПараметрыОперацииФискализацииЧекаПакетныйРежим.ОборудованиеККТ
// 	
// Возвращаемое значение:
// 	см. ФормированиеПараметровФискальногоЧекаСервер.ПараметрыОперацииФискализацииЧекаПакетныйРежим 
//
Функция ПараметрыОперацииФискализацииЧекаПакетныйРежим(ДокументСсылка, ОборудованиеККТ) Экспорт
	
	Возврат ФормированиеПараметровФискальногоЧекаСервер.ПараметрыОперацииФискализацииЧекаПакетныйРежим(ДокументСсылка, ОборудованиеККТ);
	
КонецФункции

// Проверяет, возможна ли фискализация по конкретному документу
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Проверяемый документ
// 	
// Возвращаемое значение:
// 	Булево
//
Функция РазрешеноПробитиеФискальныхЧековПоДокументу(ДокументСсылка) Экспорт

	СтруктураФормы = Новый Структура;
	СтруктураФормы.Вставить("Объект", ДокументСсылка);
	
	МодульЛокализации = ОбщегоНазначенияУТ.ПолучитьМодульЛокализации(ДокументСсылка.Метаданные().Имя);

	Если НЕ МодульЛокализации.РазрешеноПробитиеФискальныхЧековПоДокументу(СтруктураФормы) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

// Возвращает параметры пробитого фискального чека по документу, иначе, если не пробит, неопределено
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ, по которому возможно пробит чек
// 	ТипРасчета - ПеречислениеСсылка.ТипыРасчетаДенежнымиСредствами - Тип расчета
// Возвращаемое значение:
// 	Структура, Неопределено - Описание: Параметры пробитого фискального чека по документу, иначе, если не пробит, неопределено
Функция ДанныеПробитогоФискальногоЧекаПоДокументу(ДокументСсылка, ТипРасчета = Неопределено) Экспорт
	
	Возврат ФормированиеФискальныхЧековСервер.ДанныеПробитогоФискальногоЧекаПоДокументу(ДокументСсылка, ТипРасчета);
	
КонецФункции

// Флаг пробития чека - пробит = Истина, не пробит = Ложь
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ, по которому возможно пробит чек
//  ТипРасчета - ПеречислениеСсылка.ТипыРасчетаДенежнымиСредствами - Тип расчета
// Возвращаемое значение:
// 	Булево - Флаг пробития чека - пробит = Истина, не пробит = Ложь
Функция ПробитФискальныйЧекПоДокументу(ДокументСсылка, ТипРасчета = Неопределено) Экспорт
	
	Возврат ФормированиеФискальныхЧековСервер.ПробитФискальныйЧекПоДокументу(ДокументСсылка, ТипРасчета);	
	
КонецФункции

// Возвращает флаг корректности ввода объектов расчетов в документе: 
//  - если в документе содержатся объекты расчетов авансовые и предоплатные, флаг = Ложь
//  - иначе, флаг = Истина.
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - ссылка на документ оплаты
// 	ТекстСообщения - Строка - Информационное сообщение пользователю об ошибке, иначе пустая строка
// 	ИмяКомандыПробитияЧека - Строка - Имя команды пробития чека
// Возвращаемое значение:
// 	Булево - Описание - возвращает статус корректности заполнения объектов расчетов
Функция ОбъектыРасчетовВДокументеОплатыВведеныКорректно(ДокументСсылка, ТекстСообщения, ИмяКомандыПробитияЧека) Экспорт
	
	Возврат ФормированиеФискальныхЧековСервер.ОбъектыРасчетовВДокументеОплатыВведеныКорректно(ДокументСсылка, ТекстСообщения, ИмяКомандыПробитияЧека);
	
КонецФункции

// Вызывает метод механизма Взаиморасчеты для распределения расчетов с клиентами
// 
// Параметры:
// 	ПараметрыОперации - см. ФормированиеПараметровФискальногоЧекаСервер.ПараметрыОперацииФискализацииЧека
//
Процедура РаспределитьРасчетыСКлиентами(ПараметрыОперации) Экспорт
	
	ФормированиеФискальныхЧековСервер.РаспределитьРасчетыСКлиентами(ПараметрыОперации);
	
КонецПроцедуры

// Проверяет, заполнены ли в документах штрихкоды упаковок для маркированных товаров
// 
// Параметры:
//  ДокументыРеализации - Массив ИЗ ДокументСсылка.РеализацияТоваровУслуг, ДокументСсылка.ВозвратТоваровОтКлиента - Проверяемые документы
// 
// Возвращаемое значение:
//  Булево - ИСТИНА, если в документах заполныены штрихкоды упаковок для маркированных товаров
Функция ШтрихкодыУпаковокПоДокументамЗаполнены(ДокументыРеализации) Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ШтрихкодыУпаковокПоДокументамЗаполнены(ДокументыРеализации);
	
КонецФункции

#КонецОбласти