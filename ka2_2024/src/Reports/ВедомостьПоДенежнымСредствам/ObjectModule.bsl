#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   КлючВарианта - Строка - Имя предопределенного варианта отчета или уникальный идентификатор пользовательского.
//   Настройки - См. ОтчетыКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	
	Настройки.События.ПередЗагрузкойНастроекВКомпоновщик = Истина;
	
КонецПроцедуры

Процедура ПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
	
	Если ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда
		
		Для каждого НаборДанных Из НаборыДанныхКУдалению() Цикл
			Набор = СхемаКомпоновкиДанных.НаборыДанных.НаборДанных1; // НаборДанныхОбъединениеСхемыКомпоновкиДанных
			Набор.Элементы.Удалить(НаборДанных);
		КонецЦикла;
		
		ОтчетыСервер.ПодключитьСхему(ЭтотОбъект, Контекст, СхемаКомпоновкиДанных, КлючСхемы);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПользовательскиеНастройкиМодифицированы = Ложь;
	
	НастройкиОсновнойСхемы = КомпоновщикНастроек.ПолучитьНастройки();
	
	// Сформируем отчет
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОсновнойСхемы, ДанныеРасшифровки);
	
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки,, ДанныеРасшифровки, Истина);
	
	ПроцессорВыводаВТабличныйДокумент = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВыводаВТабличныйДокумент.УстановитьДокумент(ДокументРезультат);
	ПроцессорВыводаВТабличныйДокумент.Вывести(ПроцессорКомпоновкиДанных);
	
	// Сообщим форме отчета, что настройки модифицированы
	Если ПользовательскиеНастройкиМодифицированы Тогда
		КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ПользовательскиеНастройкиМодифицированы", Истина);
	КонецЕсли;
	
	ОтчетПустой = ОтчетыСервер.ОтчетПустой(ЭтотОбъект, ПроцессорКомпоновкиДанных);
	КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ОтчетПустой", ОтчетПустой);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция НаборыДанныхКУдалению()
	
	Набор = СхемаКомпоновкиДанных.НаборыДанных.НаборДанных1; // НаборДанныхОбъединениеСхемыКомпоновкиДанных
	
	НаборыДанныхКУдалению = Новый Массив;
	
	Если Не ПравоДоступа("Чтение", Метаданные.РегистрыНакопления.ДенежныеСредстваБезналичные) Тогда
		НаборыДанныхКУдалению.Добавить(Набор.Элементы.Найти("Безналичные"));
	КонецЕсли;
	
	Если Не ПравоДоступа("Чтение", Метаданные.РегистрыНакопления.ДенежныеСредстваНаличные) Тогда
		НаборыДанныхКУдалению.Добавить(Набор.Элементы.Найти("Наличные"));
	КонецЕсли;
	
	Если Не ПравоДоступа("Чтение", Метаданные.РегистрыНакопления.ДенежныеСредстваВКассахККМ) Тогда
		НаборыДанныхКУдалению.Добавить(Набор.Элементы.Найти("ВКассахККМ"));
	КонецЕсли;
	
	Если Не ПравоДоступа("Чтение", Метаданные.РегистрыНакопления.ДенежныеСредстваВПути) Тогда
		НаборыДанныхКУдалению.Добавить(Набор.Элементы.Найти("ВПути"));
	КонецЕсли;
	
	Возврат НаборыДанныхКУдалению;
	
КонецФункции

#КонецОбласти

#КонецЕсли