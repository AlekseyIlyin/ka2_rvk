//@strict-types

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

// При компоновке результата.
// 
// Параметры:
//  ДокументРезультат - ТабличныйДокумент - Документ результат
//  ДанныеРасшифровки - ДанныеРасшифровкиКомпоновкиДанных - Данные расшифровки
//  СтандартнаяОбработка - Булево - Стандартная обработка
//
Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	
	ПараметрДоговор = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(НастройкиОтчета, "Договор");
	Договор = ПараметрДоговор.Значение;  // СправочникСсылка.ДоговорыКонтрагентов
	
	Если Договор = Неопределено Тогда
		
		ТекстОшибки = НСтр("ru = 'Не выбран договор'");
		ВызватьИсключение ТекстОшибки;
		
	КонецЕсли;
	
	Реквизиты = "Контрагент, Партнер";
	РеквизитыДоговора = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Договор, Реквизиты);
	
	Контрагент = РеквизитыДоговора.Контрагент;
	Партнер = РеквизитыДоговора.Партнер;
	
	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкиОтчета, "Контрагент", Контрагент);
	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкиОтчета, "Партнер", Партнер);
	
	УстановитьЗаголовокОтчета(НастройкиОтчета, Договор);
	
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОтчета, ДанныеРасшифровки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки,, ДанныеРасшифровки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	ОтчетПустой = ОтчетыСервер.ОтчетПустой(ЭтотОбъект, ПроцессорКомпоновки);
	КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ОтчетПустой", ОтчетПустой);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения, Неопределено - Форма отчета или форма настроек отчета.
//       Неопределено когда вызов без контекста.
//   КлючВарианта - Строка, Неопределено - Имя предопределенного
//       или уникальный идентификатор пользовательского варианта отчета.
//       Неопределено когда вызов без контекста.
//   Настройки - См. ОтчетыКлиентСервер.НастройкиОтчетаПоУмолчанию
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт 
	
	Если КлючВарианта = "ДействующиеРетроБонусыПоДоговоруКонтекст" Тогда
		
		Настройки.ФормироватьСразу = Истина;
		Настройки.РазрешеноИзменятьВарианты = Ложь;
		Настройки.РазрешеноИзменятьСтруктуру = Ложь;
		
	КонецЕсли;
	
	Настройки.События.ПриСозданииНаСервере = Истина; 
	Настройки.События.ПередЗагрузкойНастроекВКомпоновщик = Истина;
	
КонецПроцедуры

// См. ОтчетыПереопределяемый.ПриСозданииНаСервере
Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	Параметры = Форма.Параметры;
	
	Если Параметры.Свойство("ПараметрКоманды") Тогда
		
		Форма.НастройкиОтчета.РазрешеноВыбиратьВарианты = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

// Вызывается перед загрузкой новых настроек. Используется для изменения схемы компоновки.
//   Например, если схема отчета зависит от ключа варианта или параметров отчета.
//   Чтобы изменения схемы вступили в силу следует вызывать метод ОтчетыСервер.ПодключитьСхему().
//
// Параметры:
//   Контекст - См. ОбщаяФорма.ФормаОтчета
//   КлючСхемы - Строка -
//       Идентификатор текущей схемы компоновщика настроек.
//       По умолчанию не заполнен (это означает что компоновщик инициализирован на основании основной схемы).
//       Используется для оптимизации, чтобы переинициализировать компоновщик как можно реже).
//       Может не использоваться, если переинициализация выполняется безусловно.
//   КлючВарианта - Строка, Неопределено -
//       Имя предопределенного или уникальный идентификатор пользовательского варианта отчета.
//       Неопределено, когда вызов для варианта расшифровки или без контекста.
//   НовыеНастройкиКД - НастройкиКомпоновкиДанных, Неопределено -
//       Настройки варианта отчета, которые будут загружены в компоновщик настроек после его инициализации.
//       Неопределено, когда настройки варианта не надо загружать (уже загружены ранее).
//   НовыеПользовательскиеНастройкиКД - ПользовательскиеНастройкиКомпоновкиДанных, Неопределено -
//       Пользовательские настройки, которые будут загружены в компоновщик настроек после его инициализации.
//       Неопределено, когда пользовательские настройки не надо загружать (уже загружены ранее).
//
Процедура ПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
	
	Если КлючСхемы = КлючВарианта Тогда
		Возврат;
	КонецЕсли;
	
	Если НовыеНастройкиКД = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда
		
		Параметры = Контекст.Параметры;
		Если Параметры.Свойство("ПараметрКоманды") Тогда
			
			ПараметрКоманды = Параметры.ПараметрКоманды; // СправочникСсылка.Партнеры, СправочникСсылка.Контрагенты
			ЗаполнитьПараметрыПоКонтексту(ПараметрКоманды, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД);
			
		КонецЕсли;
		
	КонецЕсли;
	
	КлючСхемы = КлючВарианта;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Заполняет параметры из переданного контекста.
// 
// Параметры:
//  ПараметрКоманды - ЛюбаяСсылка
//   НовыеНастройкиКД - НастройкиКомпоновкиДанных, Неопределено -
//       Настройки варианта отчета, которые будут загружены в компоновщик настроек после его инициализации.
//       Неопределено, когда настройки варианта не надо загружать (уже загружены ранее).
//   НовыеПользовательскиеНастройкиКД - ПользовательскиеНастройкиКомпоновкиДанных, Неопределено -
//       Пользовательские настройки, которые будут загружены в компоновщик настроек после его инициализации.
//       Неопределено, когда пользовательские настройки не надо загружать (уже загружены ранее).
//
Процедура ЗаполнитьПараметрыПоКонтексту(ПараметрКоманды, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД)
	
	ТипПараметраКоманды = ТипЗнч(ПараметрКоманды);
	
	Если ТипПараметраКоманды = Тип("СправочникСсылка.ДоговорыКонтрагентов") Тогда
		
		КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НовыеНастройкиКД, "Договор", ПараметрКоманды);
		Если НовыеПользовательскиеНастройкиКД <> Неопределено Тогда
			
			КомпоновкаДанныхКлиентСервер.УстановитьПараметр(
				НовыеПользовательскиеНастройкиКД,
				"Договор", 
				ПараметрКоманды);
			
		КонецЕсли;
		
		ПустаяДата = Дата(1, 1, 1);
		
		Период = Новый СтандартныйПериод;
		Период.Вариант = ВариантСтандартногоПериода.ПроизвольныйПериод;
		Период.ДатаНачала = ПустаяДата;
		Период.ДатаОкончания = ПустаяДата;
		
		КомпоновкаДанныхКлиентСервер.УстановитьПараметр(
			НовыеНастройкиКД,
			"Период",
			Период,
			Ложь);
		
		Если НовыеПользовательскиеНастройкиКД <> Неопределено Тогда
			
			КомпоновкаДанныхКлиентСервер.УстановитьПараметр(
				НовыеПользовательскиеНастройкиКД,
				"Период",
				Период,
				Ложь);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Параметры:
//  НастройкиОтчета - НастройкиКомпоновкиДанных - Настройки отчета
//  Договор - СправочникСсылка.ДоговорыКонтрагентов
//
Процедура УстановитьЗаголовокОтчета(НастройкиОтчета, Договор)

	Шаблон = НСтр("ru = 'Действующие ретро-бонусы по договору ""%1""'");
	ДоговорСтрокой = Строка(Договор);
	ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		Шаблон,
		ДоговорСтрокой);
		
	КомпоновкаДанныхКлиентСервер.УстановитьПараметрВывода(НастройкиОтчета, "Заголовок", ЗаголовокОтчета);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли