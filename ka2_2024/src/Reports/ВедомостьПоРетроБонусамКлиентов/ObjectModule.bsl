//@strict-types

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

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
	
	Если КлючВарианта = "ВедомостьПоРетроБонусамКлиентовКонтекст" Тогда
		
		Настройки.ФормироватьСразу = Истина;
		Настройки.РазрешеноИзменятьВарианты = Ложь;
		
	КонецЕсли;
	
	Настройки.События.ПриСозданииНаСервере = Истина; 
	
КонецПроцедуры

// См. ОтчетыПереопределяемый.ПриСозданииНаСервере
Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	Параметры = Форма.Параметры;
	Если Параметры.Свойство("ПараметрКоманды")
	   И ТипЗнч(Параметры.ПараметрКоманды) = Тип("ДокументСсылка.УсловияРетроБонусовКлиентов") Тогда
		
		УсловияРетроБонусовКлиентов = Параметры.ПараметрКоманды; // ДокументСсылка.УсловияРетроБонусовКлиентов
		
		Реквизиты = "Исправление, ИсправляемыйДокумент";
		ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(УсловияРетроБонусовКлиентов, Реквизиты);
		
		Если ЗначенияРеквизитов.Исправление = Истина Тогда
			ИсходныйДокумент = ЗначенияРеквизитов.ИсправляемыйДокумент;
		Иначе
			ИсходныйДокумент = УсловияРетроБонусовКлиентов;
		КонецЕсли;
		
		Форма.ФормаПараметры.Отбор = Новый Структура("ДокументУсловий", ИсходныйДокумент);
		Форма.НастройкиОтчета.РазрешеноВыбиратьВарианты = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПользовательскиеНастройкиМодифицированы = Ложь;
	
	НастройкиОсновнойСхемы = КомпоновщикНастроек.ПолучитьНастройки();
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОсновнойСхемы, ДанныеРасшифровки);
	
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки,, ДанныеРасшифровки, Истина);
	
	ПроцессорВыводаВТабличныйДокумент = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВыводаВТабличныйДокумент.УстановитьДокумент(ДокументРезультат);
	ПроцессорВыводаВТабличныйДокумент.Вывести(ПроцессорКомпоновкиДанных);
	
	// Сообщим форме отчета, что настройки модифицированы
	Если ПользовательскиеНастройкиМодифицированы Тогда
		КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить(
			"ПользовательскиеНастройкиМодифицированы", Истина);
	КонецЕсли;
	
	ОтчетПустой = ОтчетыСервер.ОтчетПустой(ЭтотОбъект, ПроцессорКомпоновкиДанных);
	КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ОтчетПустой", ОтчетПустой);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли