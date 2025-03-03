
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	НастройкиОсновнойСхемы = КомпоновщикНастроек.ПолучитьНастройки();
	
	УстановитьПараметрыОтчета(НастройкиОсновнойСхемы);
	
	ОбесценениеВНАСервер.УстановитьВидимостьДанныхОбесцененияВОтчете(НастройкиОсновнойСхемы);
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиОсновнойСхемы, ДанныеРасшифровки);	
	
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки, Неопределено, ДанныеРасшифровки, Истина);
	
	ПроцессорВыводаВТабличныйДокумент = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВыводаВТабличныйДокумент.УстановитьДокумент(ДокументРезультат);	
	ПроцессорВыводаВТабличныйДокумент.Вывести(ПроцессорКомпоновкиДанных);
	
	ОформитьШапкуОтчета(ДокументРезультат);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   КлючВарианта - Строка - Имя предопределенного варианта отчета или уникальный идентификатор пользовательского.
//   Настройки - См. ОтчетыКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	
	Настройки.События.ПриСозданииНаСервере = Истина;
	
КонецПроцедуры

// Вызывается в обработчике одноименного события формы отчета после выполнения кода формы.
//
// Параметры:
//   ЭтаФорма - ФормаКлиентскогоПриложения - Форма отчета:
//   	* Параметры - Структура - может содержать свойства:
//				** ПараметрКоманды - СправочникСсылка.НематериальныеАктивы -
//				** ОписаниеКоманды - Структура - может содержать свойства:
//					*** ДополнительныеПараметры - Структура - 
//   Отказ - Булево - Передается из параметров обработчика "как есть".
//   СтандартнаяОбработка - Булево - Передается из параметров обработчика "как есть".
//
// См. также:
//   "ФормаКлиентскогоПриложения.ПриСозданииНаСервере" в синтакс-помощнике.
//
Процедура ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка) Экспорт
	
	Параметры = ЭтаФорма.Параметры;
	
	Если Параметры.Свойство("ПараметрКоманды")
		И Параметры.Свойство("ОписаниеКоманды")
		И Параметры.ОписаниеКоманды.Свойство("ДополнительныеПараметры") Тогда 
		
		ЭтаФорма.ФормаПараметры.КлючНазначенияИспользования = Параметры.ОписаниеКоманды.ДополнительныеПараметры.ИмяКоманды;
		Параметры.КлючНазначенияИспользования = Параметры.ОписаниеКоманды.ДополнительныеПараметры.ИмяКоманды;
		
		Если ТипЗнч(Параметры.ПараметрКоманды) = Тип("СправочникСсылка.НематериальныеАктивы") Тогда
			ЭтаФорма.ФормаПараметры.Отбор.Вставить("НематериальныйАктив", Параметры.ПараметрКоманды);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ФормированиеОтчета
 
Процедура ОформитьШапкуОтчета(ТабДок)
	
	СписокГруппЯчеек = Новый Массив;
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Показатели'"));
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Дата принятия к учету'"));
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Первоначальная стоимость'"));
	
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Стоимость'"));
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Амортизация'"));
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Остаточная стоимость'"));
	
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Увеличение стоимости'"));
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Начисление амортизации'"));
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Уменьшение стоимости'"));
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Списание амортизации'"));
	
	СписокГруппЯчеек.Добавить(НСтр("ru = 'Обесценение'"));
	
	СписокПодчиненныхЯчеек = Новый Массив;
	СписокПодчиненныхЯчеек.Добавить(НСтр("ru = 'БУ'"));
	СписокПодчиненныхЯчеек.Добавить(НСтр("ru = 'УУ'"));
	
	ВнеоборотныеАктивыСлужебный.ОбъединитьПодчиненныеЯчейки(ТабДок, СписокГруппЯчеек, СписокПодчиненныхЯчеек);
	
КонецПроцедуры

Процедура УстановитьПараметрыОтчета(НастройкиОсновнойСхемы)

	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкиОсновнойСхемы, "ПоказательБУ", НСтр("ru = 'БУ'"));
	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкиОсновнойСхемы, "ПоказательУУ", НСтр("ru = 'УУ'"));
	
	// ТипыДокументовСписаниеАмортизации
	ТипыДокументов = Новый СписокЗначений;
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПринятиеКУчетуНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПереоценкаНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.СписаниеНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.КорректировкаРегистров"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПодготовкаКПередачеНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.КорректировкаСтоимостиИАмортизацииНМА"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.РеализацияУслугПрочихАктивов"));
	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкиОсновнойСхемы, "ТипыДокументовСписаниеАмортизации", ТипыДокументов);
	
	// ТипыДокументовНачислениеАмортизации
	ТипыДокументов = Новый СписокЗначений;
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПринятиеКУчетуНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ВводОстатковВнеоборотныхАктивов2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.АмортизацияНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПереоценкаНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.РаспределениеНДС"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.КорректировкаСтоимостиИАмортизацииНМА"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.КорректировкаРегистров"));
	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкиОсновнойСхемы, "ТипыДокументовНачислениеАмортизации", ТипыДокументов);
	
	// ТипыДокументовУвеличениеСтоимости
	ТипыДокументов = Новый СписокЗначений;
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПринятиеКУчетуНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ВводОстатковВнеоборотныхАктивов2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПереоценкаНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.УлучшениеНМА"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.РаспределениеНДС"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.КорректировкаСтоимостиИАмортизацииНМА"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.УлучшениеНМА"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.КорректировкаРегистров"));
	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкиОсновнойСхемы, "ТипыДокументовУвеличениеСтоимости", ТипыДокументов);
	
	// ТипыДокументовУменьшениеСтоимости
	ТипыДокументов = Новый СписокЗначений;
	ТипыДокументов.Добавить(Тип("ДокументСсылка.АмортизацияНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПринятиеКУчетуНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПереоценкаНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.УлучшениеНМА"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.СписаниеНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ПодготовкаКПередачеНМА2_4"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.РеализацияУслугПрочихАктивов"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.РаспределениеНДС"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.КорректировкаСтоимостиИАмортизацииНМА"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.УлучшениеНМА"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.КорректировкаРегистров"));
	КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкиОсновнойСхемы, "ТипыДокументовУменьшениеСтоимости", ТипыДокументов);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли