// @strict-types


#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Данные, полученные по отбору номенклатуры.
// 
// Параметры:
//  НастройкиСКД Настройки СКД - содержит настройки, полученные при закрытии формы "Условия отбора номенклатуры"
// 
// Возвращаемое значение:
//  ТаблицаЗначений - Данные по отбору номенклатуры
Функция ДанныеПоОтборуНоменклатуры(НастройкиСКД) Экспорт
	
	Запрос = Обработки.УправлениеВыгрузкамиВБидзаар.ЗапросОтборНоменклатуры(НастройкиСКД, Ложь);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса.Выгрузить();
	
КонецФункции

#КонецОбласти

#Область ОбработчикиСобытий

// Код процедур и функций

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Формирует запрос отбора номенклатуры по переданной настройке компоновки данных.
// За основу берется ТекстЗапросаОтборНоменклатуры().
//
// Параметры:
//  Настройки - НастройкиКомпоновкиДанных - настройки отбора номенклатуры.
//  ПоместитьВоВременнуюТаблицу - Булево - если ИСТИНА, запрос создает временную таблицу.
//
// Возвращаемое значение:
//  Запрос - Запрос - запрос для отбора номенклатуры.
//
Функция ЗапросОтборНоменклатуры(Настройки, ПоместитьВоВременнуюТаблицу = Истина) Экспорт
	
	СКД = Обработки.УправлениеВыгрузкамиВБидзаар.ПолучитьМакет("УсловияОтбораНоменклатуры");

	ТекстЗапросаОтбораНоменклатуры = "";
	ИнтеграцияСЭлектроннымиТорговымиПлощадкамиПереопределяемый.ТекстЗапросаОтбораНоменклатуры(ТекстЗапросаОтбораНоменклатуры);
	Если ТекстЗапросаОтбораНоменклатуры <> "" тогда
		СКД.НаборыДанных[0].Запрос = ТекстЗапросаОтбораНоменклатуры;
	КонецЕсли;
	
	ИменаКолонокРезультатаОтбора = "";
	ИнтеграцияСЭлектроннымиТорговымиПлощадкамиПереопределяемый.ИменаКолонокРезультатаОтбора(ИменаКолонокРезультатаОтбора);
	Если ИменаКолонокРезультатаОтбора <> "" Тогда
		ИменаДоступныхПолей = СтрРазделить(ИменаКолонокРезультатаОтбора, ",", Ложь);
	Иначе
		ИменаДоступныхПолей = Новый Массив;
	КонецЕсли;
	
	ТипыНоменклатуры = Метаданные.ОпределяемыеТипы.НоменклатураИнтеграцияСЭлектроннымиТорговымиПлощадками.Тип.Типы();
	Если ТипыНоменклатуры.Количество() > 0 Тогда
		МетаТип = Метаданные.НайтиПоТипу(ТипыНоменклатуры[0]);
		Если МетаТип <> Неопределено Тогда
			МетаИмяСправочникаНоменклатура = МетаТип.Имя;
			СКД.НаборыДанных[0].Запрос = СтрЗаменить(СКД.НаборыДанных[0].Запрос, "ОпределяемыйТипНоменклатура", "Справочник." + МетаИмяСправочникаНоменклатура);
			ИменаДоступныхПолей.Добавить("Номенклатура");
		КонецЕсли;
	КонецЕсли;
	
	ЗначимыеКолонки = Новый Структура(СтрСоединить(ИменаДоступныхПолей,","));
	
	Если ТипЗнч(Настройки) <> Тип("НастройкиКомпоновкиДанных") Тогда
		Настройки = СКД.НастройкиПоУмолчанию;
	КонецЕсли;
	
	Настройки.Структура.Очистить();
	
	ДетальныеЗаписи = Настройки.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	Для каждого КолонкаЗапроса Из ЗначимыеКолонки Цикл
		ДетальныеЗаписи.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных")).Поле = Новый ПолеКомпоновкиДанных(КолонкаЗапроса.Ключ);
	КонецЦикла;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновкиДанных = КомпоновщикМакета.Выполнить(СКД, Настройки);
	
	СхемаЗапроса = Новый СхемаЗапроса();
	СхемаЗапроса.УстановитьТекстЗапроса(МакетКомпоновкиДанных.НаборыДанных[0].Запрос);
	
	ОсновнойЗапрос = СхемаЗапроса.ПакетЗапросов[СхемаЗапроса.ПакетЗапросов.Количество() - 1];
	Если ПоместитьВоВременнуюТаблицу = Истина Тогда
		ОсновнойЗапрос.ТаблицаДляПомещения = "ОтборНоменклатуры";
	КонецЕсли;
	
	КоличествоКолонок = ОсновнойЗапрос.Колонки.Количество();
	Для ОбратныйИндекс = 1 По КоличествоКолонок Цикл
		ПроверяемоеПоле = ОсновнойЗапрос.Колонки[КоличествоКолонок - ОбратныйИндекс];
		Если НЕ ЗначимыеКолонки.Свойство(ПроверяемоеПоле.Псевдоним) Тогда 
			ОсновнойЗапрос.Колонки.Удалить(КоличествоКолонок - ОбратныйИндекс);
		КонецЕсли;
	КонецЦикла;
	
	Запрос = Новый Запрос(СхемаЗапроса.ПолучитьТекстЗапроса());
	
	Для каждого ЗначениеПараметра Из МакетКомпоновкиДанных.ЗначенияПараметров Цикл
		Запрос.УстановитьПараметр(ЗначениеПараметра.Имя, ЗначениеПараметра.Значение);
	КонецЦикла;
	
	Возврат Запрос;
	
КонецФункции

// Функция формирует табличный документ.
//
// Параметры:
//	Данные - ТаблицаЗначений - содержит данные, на основании которых формируется выходная форма
//	
// Возвращаемое значение:
//  ТабличныйДокумент - данные для выгрузки в виде табличного документа
//
Функция СформироватьПечатнуюФормуДляВыгрузки(Данные) Экспорт
	
	ТабДокумент = Новый ТабличныйДокумент;
	ТабДокумент.ИмяПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_ВыгрузкаДанныхВБидзаар";
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Обработка.УправлениеВыгрузкамиВБидзаар.МакетВыгрузкиВExcel");
	
	ОбластьСтрока = Макет.ПолучитьОбласть("Строка");
	Для Каждого Строка Из Данные Цикл
		ОбластьСтрока.Параметры.Заполнить(Строка);
		ТабДокумент.Вывести(ОбластьСтрока);
	КонецЦикла;
		
	Возврат ТабДокумент;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти

#КонецЕсли
