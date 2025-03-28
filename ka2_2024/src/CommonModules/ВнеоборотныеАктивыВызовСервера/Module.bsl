////////////////////////////////////////////////////////////////////////////////
// Процедуры подсистемы "Внеоборотные активы".
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает направление деятельности по заданной ссылке
//
// Параметры:
// 		Ссылка - СправочникСсылка.ДоговорыАренды, СправочникСсылка.ОбъектыЭксплуатации - Ссылка на справочник, по которой необходимо получить направление деятельности.
//
// Возвращаемое значение:
// 		СправочникСсылка.НаправленияДеятельности - Ссылка на элемент справочника направлений деятельности.
//
Функция НаправлениеДеятельности(Ссылка) Экспорт
	
	ВозвращаемоеЗначение = Справочники.НаправленияДеятельности.ПустаяСсылка(); 
	
	Если ТипЗнч(Ссылка) = Тип("СправочникСсылка.ДоговорыАренды") Тогда
		
		ВозвращаемоеЗначение = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "НаправлениеДеятельности");
	
	ИначеЕсли ТипЗнч(Ссылка) = Тип("СправочникСсылка.ОбъектыЭксплуатации") Тогда

		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ПорядокУчетаОС.НаправлениеДеятельности КАК НаправлениеДеятельности
		|ИЗ
		|	РегистрСведений.ПорядокУчетаОС.СрезПоследних(, ОсновноеСредство = &ОсновноеСредство) КАК ПорядокУчетаОС";
		
		Запрос = Новый Запрос(ТекстЗапроса);
		Запрос.УстановитьПараметр("ОсновноеСредство", Ссылка);
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		
		Если Выборка.Следующий() Тогда
			ВозвращаемоеЗначение = Выборка.НаправлениеДеятельности;
		КонецЕсли;
		
	КонецЕсли;	
	
	Возврат ?(ЗначениеЗаполнено(ВозвращаемоеЗначение), ВозвращаемоеЗначение, Справочники.НаправленияДеятельности.ПустаяСсылка());
	
КонецФункции

// Формирует данные выбора основных средств.
//
// Параметры:
//  Параметры			 - Структура - Содержит параметры выбора.
//  СтандартнаяОбработка - Булево - Параметр события ОбработкаПолученияДанныхВыбора.
// 
// Возвращаемое значение:
//  СписокЗначений - Значения для выбора.
//
Функция ДанныеВыбораОбъектовЭксплуатации(Параметры, СтандартнаяОбработка) Экспорт

	ДанныеВыбора = Неопределено;
	
	Если ВнеоборотныеАктивыСлужебный.ДоступенВыборОбъектовЭксплуатации2_4(Параметры) Тогда
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = ДанныеВыбораОбъектовЭксплуатации2_4(Параметры);
	Иначе
		ВнеоборотныеАктивыЛокализация.ДанныеВыбораОбъектовЭксплуатации2_2(Параметры);
	КонецЕсли;
	
	Возврат ДанныеВыбора;

КонецФункции

// Формирует данные выбора нематериальных активов.
//
// Параметры:
//  Параметры			 - Структура - Содержит параметры выбора.
//  СтандартнаяОбработка - Булево - Параметр события ОбработкаПолученияДанныхВыбора.
// 
// Возвращаемое значение:
//  СписокЗначений - Значения для выбора.
//
Функция ДанныеВыбораНематериальныхАктивов(Параметры, СтандартнаяОбработка) Экспорт

	ДанныеВыбора = Неопределено;
	
	Если ДоступенВыборНематериальныхАктивов2_4(Параметры) Тогда
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = ДанныеВыбораНематериальныхАктивов2_4(Параметры);
	Иначе
		ВнеоборотныеАктивыЛокализация.ДанныеВыбораНематериальныхАктивов2_2(Параметры);
	КонецЕсли;
	
	Возврат ДанныеВыбора;

КонецФункции

#Область ОтборыПоДаннымУчета

// Возвращает список значений показателями наработок, принадлежащих классу объектов эксплуатации.
//
// Параметры:
// 		ОбъектОтбора - СправочникСсылка.ОбъектыЭксплуатации, СправочникСсылка.УзлыОбъектовЭксплуатации, СправочникСсылка.КлассыОбъектовЭксплуатации - Объект отбора
// 		ПолучатьИсточникиНаработки - Булево - Признак необходимости получать показатели регистрируемые от источника
// 		ПоказательАмортизации - СправочникСсылка.ПоказателиНаработки - Текущее значение.
//
// Возвращаемое значение:
// 		СписокЗначений - Список данных выбора.
//
Функция ДанныеВыбораПоказателейНаработкиПоОтбору(Знач ОбъектОтбора, ПолучатьИсточникиНаработки, ПоказательАмортизации) Экспорт
	
	ДанныеВыбора = Новый СписокЗначений;
	
	СписокЗапросов = Новый Массив;
	
	
	СписокЗапросовОбъединение = Новый Массив;
	
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ПорядокУчетаОС.ПоказательНаработки КАК Значение,
	|	ПорядокУчетаОС.ПоказательНаработки.ПометкаУдаления КАК ПометкаУдаления
	|ИЗ
	|	РегистрСведений.ПорядокУчетаОС.СрезПоследних(
	|			,
	|			ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
	|				И ОсновноеСредство = &ОбъектОтбора
	|	) КАК ПорядокУчетаОС
	|ГДЕ
	|	НЕ &ПоказательАмортизации
	|	И ПорядокУчетаОС.ПоказательНаработки <> ЗНАЧЕНИЕ(Справочник.ПоказателиНаработки.ПустаяСсылка)";
	СписокЗапросовОбъединение.Добавить(ТекстЗапроса);
	
	
	ТекстЗапроса = СтрСоединить(СписокЗапросовОбъединение, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении());
	СписокЗапросов.Добавить(ТекстЗапроса);
	
	ТекстЗапроса = СтрСоединить(СписокЗапросов, ОбщегоНазначения.РазделительПакетаЗапросов());
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("ОбъектОтбора", ОбъектОтбора);
	Запрос.УстановитьПараметр("ПолучатьИсточникиНаработки", ПолучатьИсточникиНаработки);
	Запрос.УстановитьПараметр("ПоказательАмортизации", ПоказательАмортизации);
	Запрос.УстановитьПараметр("ИспользоватьУправлениеРемонтами", ПолучитьФункциональнуюОпцию("ИспользоватьУправлениеРемонтами"));
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат ДанныеВыбора;
	КонецЕсли;
	
	ШаблонПолейСтруктуры = "Значение, ПометкаУдаления";
	
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		СтруктураЭлемента = Новый Структура(ШаблонПолейСтруктуры);
		ЗаполнитьЗначенияСвойств(СтруктураЭлемента, Выборка);
		ДанныеВыбора.Добавить(СтруктураЭлемента);
		
	КонецЦикла;
	
	Возврат ДанныеВыбора;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ДоступенВыборНематериальныхАктивов2_4(Параметры) Экспорт

	Если НЕ ПолучитьФункциональнуюОпцию("ИспользоватьВнеоборотныеАктивы2_4") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если НЕ ПолучитьФункциональнуюОпцию("ИспользоватьВнеоборотныеАктивы2_2") Тогда
		Возврат Истина;
	КонецЕсли;
	
	ДатаНачалаУчета = ВнеоборотныеАктивыЛокализация.ДатаНачалаУчетаВнеоборотныхАктивов2_4();
	
	ДоступенВыбор = 
		Параметры.Свойство("Контекст") 
			И СтрНайти(Параметры.Контекст, "УУ") <> 0 
		ИЛИ НЕ Параметры.Свойство("ДатаСведений")
			И ТекущаяДатаСеанса() >= ДатаНачалаУчета 
		ИЛИ Параметры.Свойство("ДатаСведений")
			И Параметры.ДатаСведений >= ДатаНачалаУчета;
			
	Если НЕ ДоступенВыбор Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если Параметры.Свойство("Отбор") Тогда
		Если Параметры.Отбор.Свойство("БУСостояние") Тогда
			Параметры.Отбор.Вставить("Состояние", Параметры.Отбор.БУСостояние);
		КонецЕсли; 
		Если Параметры.Отбор.Свойство("БУОрганизация") Тогда
			Параметры.Отбор.Вставить("Организация", Параметры.Отбор.БУОрганизация);
		КонецЕсли; 
		Если Параметры.Отбор.Свойство("БУПодразделение") Тогда
			Параметры.Отбор.Вставить("Подразделение", Параметры.Отбор.БУПодразделение);
		КонецЕсли; 
	КонецЕсли; 
	
	Возврат Истина;

КонецФункции
 
Функция ОперацияВводаОстатков(ДокументСсылка) Экспорт

	Если НЕ ЗначениеЗаполнено(ДокументСсылка) Тогда
		Возврат Неопределено;
	КонецЕсли; 
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДокументСсылка, "ХозяйственнаяОперация");
	
КонецФункции

Функция ПредставлениеВводаОстатков(Объект) Экспорт
	
	Если ТипЗнч(Объект) = Тип("Структура") 
		ИЛИ ТипЗнч(Объект) = Тип("ДанныеФормыСтруктура") Тогда
		РеквизитыОбъекта = Объект;
	Иначе	
		РеквизитыОбъекта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Объект, "Ссылка, Номер, Дата, ХозяйственнаяОперация");
	КонецЕсли; 
	
	Если Не ЗначениеЗаполнено(РеквизитыОбъекта.ХозяйственнаяОперация) Тогда
		Возврат "";
	КонецЕсли;
	
	ПредставлениеНомерДата = НСтр("ru='(создание)'");
	Если ЗначениеЗаполнено(РеквизитыОбъекта.Ссылка) Тогда
		ПредставлениеНомерДата = СтрШаблон(НСтр("ru='%1 от %2'"), РеквизитыОбъекта.Номер, РеквизитыОбъекта.Дата);
	КонецЕсли;
	
	Представление = НСтр("ru='Ввод начальных остатков внеоборотных активов %1'");
	
	Если РеквизитыОбъекта.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковОсновныхСредств Тогда
		Представление = НСтр("ru='Ввод начальных остатков основных средств %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковПереданныхВАрендуОС Тогда
		Представление = НСтр("ru='Ввод начальных остатков переданных в аренду основных средств %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковНМАиРасходовНаНИОКР Тогда
		Представление = НСтр("ru='Ввод начальных остатков НМА и расходов на НИОКР %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковВзаиморасчетовПоДоговорамАренды Тогда
		Представление = НСтр("ru='Ввод начальных остатков взаиморасчетов по договорам аренды %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковАрендованныхОСНаБалансе Тогда
		Представление = НСтр("ru='Ввод начальных остатков арендованных ОС (на балансе) %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковАрендованныхОСЗаБалансом Тогда
		Представление = НСтр("ru='Ввод начальных остатков арендованных ОС (за балансом) %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковПредметовЛизингаЗаБалансом Тогда
		Представление = НСтр("ru='Ввод начальных остатков предметов лизинга за балансом %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковПереданныхВАрендуПредметовЛизингаНаБалансе Тогда
		Представление = НСтр("ru='Ввод начальных остатков переданных в аренду предметов лизинга на балансе %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВводОстатковВложенийВоВнеоборотныеАктивы Тогда
		Представление = НСтр("ru='Ввод начальных остатков вложений во внеоборотные активы %1'");
	КонецЕсли;
	
	Возврат СтрШаблон(Представление, ПредставлениеНомерДата);
	
КонецФункции

Функция ПредставлениеВводаОстатков2_2(Объект) Экспорт
	
	Если ТипЗнч(Объект) = Тип("Структура") 
		Или ТипЗнч(Объект) = Тип("ДанныеФормыСтруктура") Тогда
		РеквизитыОбъекта = Объект;
	Иначе	
		РеквизитыОбъекта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Объект, "Ссылка, Номер, Дата, ХозяйственнаяОперация");
	КонецЕсли; 
	
	Если Не ЗначениеЗаполнено(РеквизитыОбъекта.ХозяйственнаяОперация) Тогда
		Возврат "";
	КонецЕсли;
	
	ПредставлениеНомерДата = НСтр("ru='(создание)'");
	Если ЗначениеЗаполнено(РеквизитыОбъекта.Ссылка) Тогда
		ПредставлениеНомерДата = СтрШаблон(НСтр("ru='%1 от %2'"), РеквизитыОбъекта.Номер, РеквизитыОбъекта.Дата);
	КонецЕсли;
	
	Представление = НСтр("ru='Ввод начальных остатков внеоборотных активов %1'");
	Если РеквизитыОбъекта.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВводОстатковОсновныхСредств") Тогда
		Представление = НСтр("ru='Ввод начальных остатков основных средств %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВводОстатковПереданныхВАрендуОС") Тогда
		Представление = НСтр("ru='Ввод начальных остатков переданных в аренду основных средств %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВводОстатковНМАиРасходовНаНИОКР") Тогда
		Представление = НСтр("ru='Ввод начальных остатков нематериальных активов и расходов на НИОКР %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВводОстатковВзаиморасчетовПоДоговорамАренды") Тогда
		Представление = НСтр("ru='Ввод начальных остатков взаиморасчетов по договорам лизинга %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВводОстатковАрендованныхОСНаБалансе") Тогда
		Представление = НСтр("ru='Ввод начальных остатков арендованных ОС (на балансе) %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВводОстатковАрендованныхОСЗаБалансом") Тогда
		Представление = НСтр("ru='Ввод начальных остатков арендованных ОС (за балансом) %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВводОстатковПереданныхВАрендуПредметовЛизингаНаБалансе") Тогда
		Представление = НСтр("ru='Ввод начальных остатков переданных в аренду предметов лизинга на балансе %1'");
	ИначеЕсли РеквизитыОбъекта.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВводОстатковПредметовЛизингаЗаБалансом") Тогда
		Представление = НСтр("ru='Ввод начальных остатков предметов лизинга за балансом %1'");
	КонецЕсли;
	
	Возврат СтрШаблон(Представление, ПредставлениеНомерДата);
	
КонецФункции

Функция ОрганизацииВзаимосвязаныПоОрганизационнойСтруктуре(Знач ОрганизацияПолучатель, Знач Организация) Экспорт

	Возврат Справочники.Организации.ОрганизацииВзаимосвязаныПоОрганизационнойСтруктуре(ОрганизацияПолучатель, Организация);

КонецФункции

Функция ОрганизацияВзаимосвязанаСДругимиОрганизациями(Знач Организация) Экспорт

	Возврат Справочники.Организации.ОрганизацияВзаимосвязанаСДругимиОрганизациями(Организация); 

КонецФункции

Функция ИспользуетсяУправлениеВНА_2_4(Период = '000101010000') Экспорт

	Возврат ВнеоборотныеАктивы.ИспользуетсяУправлениеВНА_2_4(Период);

КонецФункции
 
Функция ОбработкаПолученияФормы_ОбъектыЭксплуатации(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка) Экспорт
	
	Возврат ОбъектыЭксплуатацииЛокализация.ОбработкаПолученияФормы(
				ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Находит узлы объектов эксплуатации по штрихкодам.
//
// Параметры:
//  ДанныеШтрихкодов - Структура, Массив из Строка - Данные штрихкодов.
//  ПараметрыПодбора - см. ОбщегоНазначенияУТКлиентСервер.ПараметрыПодбора
// 
// Возвращаемое значение:
//  см. ВнеоборотныеАктивы.НайтиОбъектыПоШтрихкодам
//
Функция НайтиОбъектыЭксплуатацииПоШтрихкодам(ДанныеШтрихкодов, ПараметрыПодбора = Неопределено) Экспорт

	Возврат ВнеоборотныеАктивы.НайтиОбъектыПоШтрихкодам(ДанныеШтрихкодов, ПараметрыПодбора);
	
КонецФункции

Функция ДанныеВыбораОбъектовЭксплуатации2_4(Параметры)

	ДанныеВыбора = Новый СписокЗначений();

	НастройкиПрав = Новый Структура;
	
	НастройкиПрав.Вставить(
		"ЕстьПравоЧтение_МестонахождениеОС", 
		ПравоДоступа("Чтение", Метаданные.РегистрыСведений.МестонахождениеОС));

	НастройкиПрав.Вставить(
		"ЕстьПравоЧтение_ПорядокУчетаОСУУ", 
		ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПорядокУчетаОСУУ));

	НастройкиПрав.Вставить(
		"ЕстьПравоЧтение_ПорядокУчетаОСБУ", 
		ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПорядокУчетаОСБУ));

	НастройкиПрав.Вставить(
		"ЕстьПравоЧтение_ПорядокУчетаОС", 
		ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПорядокУчетаОС));

	НастройкиПрав.Вставить(
		"ЕстьПравоЧтение_ПараметрыАмортизацииОСУУ", 
		ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПараметрыАмортизацииОСУУ));

	НастройкиПрав.Вставить(
		"ЕстьПравоЧтение_ПараметрыАмортизацииОСБУ", 
		ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПараметрыАмортизацииОСБУ));

	НастройкиПрав.Вставить(
		"ЕстьПравоЧтение_ПервоначальныеСведенияОС", 
		ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПервоначальныеСведенияОС));

	НастройкиПрав.Вставить(
		"ЕстьПравоЧтение_АрендованныеОС", 
		ПравоДоступа("Чтение", Метаданные.РегистрыСведений.АрендованныеОС));

	ПараметрыВыбора = Справочники.ОбъектыЭксплуатации.ПолучитьПараметрыВыбора(Параметры, НастройкиПрав);
	ОписаниеЗапросаДляВыбора = Справочники.ОбъектыЭксплуатации.ОписаниеЗапросаВыбораЭлементов(ПараметрыВыбора, НастройкиПрав, Ложь, Истина);
	
	Если ОписаниеЗапросаДляВыбора.НеобходимыеТаблицы.Количество() <> 0 Тогда
	
		СписокЗапросов = Новый Массив();
		
		ТекстЗапроса =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ДанныеСправочника.Ссылка КАК Ссылка,
		|	ДанныеСправочника.Наименование КАК Наименование,
		|	ДанныеСправочника.ИнвентарныйНомер КАК ИнвентарныйНомер,
		|	ДанныеСправочника.ГруппаОС КАК ГруппаОС,
		|	ДанныеСправочника.ГруппаОСМеждународныйУчет КАК ГруппаОСМеждународныйУчет,
		|	ДанныеСправочника.ТипОС КАК ТипОС,
		|	ДанныеСправочника.ДатаВыпуска КАК ДатаВыпуска,
		|	ДанныеСправочника.ДатаСведений КАК ДатаСведений,
		|	ДанныеСправочника.ЗаводскойНомер КАК ЗаводскойНомер,
		|	ДанныеСправочника.ЗарегистрированоВРеестреСистемыПлатон КАК ЗарегистрированоВРеестреСистемыПлатон,
		|	ДанныеСправочника.Изготовитель КАК Изготовитель,
		|	ДанныеСправочника.Класс КАК Класс,
		|	ДанныеСправочника.Подкласс КАК Подкласс,
		|	ДанныеСправочника.КодПоОКОФ КАК КодПоОКОФ,
		|	ДанныеСправочника.Модель КАК Модель,
		|	ДанныеСправочника.НомерПаспорта КАК НомерПаспорта,
		|	ДанныеСправочника.ОбъектБытовогоНазначения КАК ОбъектБытовогоНазначения,
		|	ДанныеСправочника.ЭксплуатирующееПодразделение КАК ЭксплуатирующееПодразделение,
		|	ДанныеСправочника.РемонтирующееПодразделение КАК РемонтирующееПодразделение,
		|	ДанныеСправочника.СерийныйНомер КАК СерийныйНомер,
		|	ДанныеСправочника.СпособОтраженияЗарплаты КАК СпособОтраженияЗарплаты,
		|	ДанныеСправочника.Статус КАК Статус,
		|	ДанныеСправочника.ШифрПоЕНАОФ КАК ШифрПоЕНАОФ,
		|	ДанныеСправочника.УчитыватьСтоимостьЛиквидационногоОбязательства КАК УчитыватьСтоимостьЛиквидационногоОбязательства
		|
		|ПОМЕСТИТЬ ВтСписокОС
		|
		|ИЗ
		|	Справочник.ОбъектыЭксплуатации КАК ДанныеСправочника
		|
		|ГДЕ
		|	(ДанныеСправочника.Наименование ПОДОБНО &ПодстрокаПоиска
		|			ИЛИ ДанныеСправочника.ИнвентарныйНомер ПОДОБНО &ПодстрокаПоиска)
		|	И НЕ ДанныеСправочника.ЭтоГруппа
		|	И НЕ ДанныеСправочника.ПометкаУдаления
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка
		|";
		СписокЗапросов.Добавить(ТекстЗапроса);
		
		ТекстСоединения = "";
		
		Если ОписаниеЗапросаДляВыбора.НеобходимыеТаблицы.Свойство("МестонахождениеОС") Тогда
			
			ТекстЗапроса =
			"ВЫБРАТЬ
			|	ДанныеРегистра.Организация КАК Организация,
			|	ДанныеРегистра.ОсновноеСредство КАК ОсновноеСредство,
			|	ДанныеРегистра.Местонахождение КАК Местонахождение,
			|	ДанныеРегистра.АдресМестонахождения КАК АдресМестонахождения,
			|	ДанныеРегистра.МОЛ КАК МОЛ,
			|	ДанныеРегистра.Арендатор КАК Арендатор
			|
			|ПОМЕСТИТЬ МестонахождениеОС
			|
			|ИЗ
			|	РегистрСведений.МестонахождениеОС.СрезПоследних(
			|			&ДатаСведений,
			|			&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Условия
			|				И ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
			|				И ОсновноеСредство В (
			|					ВЫБРАТЬ 
			|						ВтСписокОС.Ссылка 
			|					ИЗ 
			|						ВтСписокОС КАК ВтСписокОС)) КАК ДанныеРегистра
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	ОсновноеСредство,
			|	Организация
			|";
			СписокЗапросов.Добавить(ТекстЗапроса);
			
			ТекстСоединения = ТекстСоединения + "
			|		ЛЕВОЕ СОЕДИНЕНИЕ МестонахождениеОС КАК МестонахождениеОС
			|		ПО МестонахождениеОС.ОсновноеСредство = ДанныеСправочникаПереопределяемый.Ссылка
			|"; // @query-part-1
			
		КонецЕсли;
		
		Если ОписаниеЗапросаДляВыбора.НеобходимыеТаблицы.Свойство("ПервоначальныеСведенияОС") Тогда
			
			ТекстЗапроса =
			"ВЫБРАТЬ
			|	ДанныеРегистра.Организация КАК Организация,
			|	ДанныеРегистра.ОсновноеСредство КАК ОсновноеСредство,
			|	ДанныеРегистра.ДатаВводаВЭксплуатациюБУ КАК ДатаВводаВЭксплуатациюБУ,
			|	ДанныеРегистра.ДатаВводаВЭксплуатациюНУ КАК ДатаВводаВЭксплуатациюНУ,
			|	ДанныеРегистра.ДатаВводаВЭксплуатациюУУ КАК ДатаВводаВЭксплуатациюУУ,
			|	ДанныеРегистра.МетодНачисленияАмортизацииБУ КАК МетодНачисленияАмортизацииБУ,
			|	ДанныеРегистра.МетодНачисленияАмортизацииНУ КАК МетодНачисленияАмортизацииНУ,
			|	ДанныеРегистра.Контрагент КАК Контрагент
			|
			|ПОМЕСТИТЬ ПервоначальныеСведенияОС
			|
			|ИЗ
			|	РегистрСведений.ПервоначальныеСведенияОС.СрезПоследних(
			|			&ДатаСведений,
			|			&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Условия
			|				И ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
			|				И (Организация, ОсновноеСредство) В (
			|					ВЫБРАТЬ 
			|						МестонахождениеОС.Организация,  
			|						МестонахождениеОС.ОсновноеСредство  
			|					ИЗ 
			|						МестонахождениеОС КАК МестонахождениеОС)) КАК ДанныеРегистра
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	ОсновноеСредство,
			|	Организация
			|";
			СписокЗапросов.Добавить(ТекстЗапроса);

			ТекстСоединения = ТекстСоединения + "
			|		ЛЕВОЕ СОЕДИНЕНИЕ ПервоначальныеСведенияОС КАК ПервоначальныеСведенияОС
			|		ПО ПервоначальныеСведенияОС.Организация = МестонахождениеОС.Организация
			|			И ПервоначальныеСведенияОС.ОсновноеСредство = МестонахождениеОС.ОсновноеСредство
			|"; // @query-part-1
			
		КонецЕсли;
		
		Если ОписаниеЗапросаДляВыбора.НеобходимыеТаблицы.Свойство("ПорядокУчетаОСУУ") Тогда
			
			ТекстЗапроса =
			"ВЫБРАТЬ
			|	ДанныеРегистра.Организация КАК Организация,
			|	ДанныеРегистра.ОсновноеСредство КАК ОсновноеСредство,
			|	ДанныеРегистра.Состояние КАК Состояние
			|
			|ПОМЕСТИТЬ ПорядокУчетаОСУУ
			|
			|ИЗ
			|	РегистрСведений.ПорядокУчетаОСУУ.СрезПоследних(
			|			&ДатаСведений,
			|			&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Условия
			|				И ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
			|				И (Организация, ОсновноеСредство) В (
			|					ВЫБРАТЬ 
			|						МестонахождениеОС.Организация,  
			|						МестонахождениеОС.ОсновноеСредство  
			|					ИЗ 
			|						МестонахождениеОС КАК МестонахождениеОС)) КАК ДанныеРегистра
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	ОсновноеСредство,
			|	Организация
			|";
			СписокЗапросов.Добавить(ТекстЗапроса);

			ТекстСоединения = ТекстСоединения + "
			|		ЛЕВОЕ СОЕДИНЕНИЕ ПорядокУчетаОСУУ КАК ПорядокУчетаОСУУ
			|		ПО ПорядокУчетаОСУУ.Организация = МестонахождениеОС.Организация
			|			И ПорядокУчетаОСУУ.ОсновноеСредство = МестонахождениеОС.ОсновноеСредство
			|"; // @query-part-1
			
		КонецЕсли;
		
		Если ОписаниеЗапросаДляВыбора.НеобходимыеТаблицы.Свойство("ПорядокУчетаОСБУ") Тогда
			
			ТекстЗапроса =
			"ВЫБРАТЬ
			|	ДанныеРегистра.Организация КАК Организация,
			|	ДанныеРегистра.ОсновноеСредство КАК ОсновноеСредство,
			|	ДанныеРегистра.СостояниеБУ КАК СостояниеБУ,
			|	ДанныеРегистра.СостояниеНУ КАК СостояниеНУ,
			|	ДанныеРегистра.АмортизационнаяГруппа КАК АмортизационнаяГруппа,
			|	ДанныеРегистра.НедвижимоеИмущество КАК НедвижимоеИмущество,
			|	ДанныеРегистра.НалогообложениеНДС КАК НалогообложениеНДС
			|
			|ПОМЕСТИТЬ ПорядокУчетаОСБУ
			|
			|ИЗ
			|	РегистрСведений.ПорядокУчетаОСБУ.СрезПоследних(
			|			&ДатаСведений,
			|			&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Условия
			|				И ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
			|				И (Организация, ОсновноеСредство) В (
			|					ВЫБРАТЬ 
			|						МестонахождениеОС.Организация,  
			|						МестонахождениеОС.ОсновноеСредство  
			|					ИЗ 
			|						МестонахождениеОС КАК МестонахождениеОС)) КАК ДанныеРегистра
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	ОсновноеСредство,
			|	Организация
			|";
			СписокЗапросов.Добавить(ТекстЗапроса);

			ТекстСоединения = ТекстСоединения + "
			|		ЛЕВОЕ СОЕДИНЕНИЕ ПорядокУчетаОСБУ КАК ПорядокУчетаОСБУ
			|		ПО ПорядокУчетаОСБУ.Организация = МестонахождениеОС.Организация
			|			И ПорядокУчетаОСБУ.ОсновноеСредство = МестонахождениеОС.ОсновноеСредство
			|"; // @query-part-1
			
		КонецЕсли;
	
		Если ОписаниеЗапросаДляВыбора.НеобходимыеТаблицы.Свойство("ПараметрыАмортизацииОСУУ") Тогда
			
			ТекстЗапроса =
			"ВЫБРАТЬ
			|	ДанныеРегистра.Организация КАК Организация,
			|	ДанныеРегистра.ОсновноеСредство КАК ОсновноеСредство,
			|	ДанныеРегистра.СрокИспользования КАК СрокИспользования,
			|	ДанныеРегистра.МетодНачисленияАмортизации КАК МетодНачисленияАмортизации
			|
			|ПОМЕСТИТЬ ПараметрыАмортизацииОСУУ
			|
			|ИЗ
			|	РегистрСведений.ПараметрыАмортизацииОСУУ.СрезПоследних(
			|			&ДатаСведений,
			|			&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Условия
			|				И ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
			|				И (Организация, ОсновноеСредство) В (
			|					ВЫБРАТЬ 
			|						МестонахождениеОС.Организация,  
			|						МестонахождениеОС.ОсновноеСредство  
			|					ИЗ 
			|						МестонахождениеОС КАК МестонахождениеОС)) КАК ДанныеРегистра
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	ОсновноеСредство,
			|	Организация
			|";
			СписокЗапросов.Добавить(ТекстЗапроса);

			ТекстСоединения = ТекстСоединения + "
			|		ЛЕВОЕ СОЕДИНЕНИЕ ПараметрыАмортизацииОСУУ КАК ПараметрыАмортизацииОСУУ
			|		ПО ПараметрыАмортизацииОСУУ.Организация = МестонахождениеОС.Организация
			|			И ПараметрыАмортизацииОСУУ.ОсновноеСредство = МестонахождениеОС.ОсновноеСредство
			|"; // @query-part-1
			
		КонецЕсли;
		
		Если ОписаниеЗапросаДляВыбора.НеобходимыеТаблицы.Свойство("ПараметрыАмортизацииОСБУ") Тогда
			
			ТекстЗапроса =
			"ВЫБРАТЬ
			|	ДанныеРегистра.Организация КАК Организация,
			|	ДанныеРегистра.ОсновноеСредство КАК ОсновноеСредство,
			|	ДанныеРегистра.СрокПолезногоИспользованияБУ КАК СрокПолезногоИспользованияБУ,
			|	ДанныеРегистра.СрокПолезногоИспользованияНУ КАК СрокПолезногоИспользованияНУ
			|
			|ПОМЕСТИТЬ ПараметрыАмортизацииОСБУ
			|
			|ИЗ
			|	РегистрСведений.ПараметрыАмортизацииОСБУ.СрезПоследних(
			|			&ДатаСведений,
			|			&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Условия
			|				И ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
			|				И (Организация, ОсновноеСредство) В (
			|					ВЫБРАТЬ 
			|						МестонахождениеОС.Организация,  
			|						МестонахождениеОС.ОсновноеСредство  
			|					ИЗ 
			|						МестонахождениеОС КАК МестонахождениеОС)) КАК ДанныеРегистра
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	ОсновноеСредство,
			|	Организация
			|";
			СписокЗапросов.Добавить(ТекстЗапроса);

			ТекстСоединения = ТекстСоединения + "
			|		ЛЕВОЕ СОЕДИНЕНИЕ ПараметрыАмортизацииОСБУ КАК ПараметрыАмортизацииОСБУ
			|		ПО ПараметрыАмортизацииОСБУ.Организация = МестонахождениеОС.Организация
			|			И ПараметрыАмортизацииОСБУ.ОсновноеСредство = МестонахождениеОС.ОсновноеСредство
			|"; // @query-part-1
			
		КонецЕсли;
		
		Если ОписаниеЗапросаДляВыбора.НеобходимыеТаблицы.Свойство("ПорядокУчетаОС") Тогда
			
			ТекстЗапроса =
			"ВЫБРАТЬ
			|	ДанныеРегистра.ОсновноеСредство КАК ОсновноеСредство,
			|	ДанныеРегистра.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчета,
			|	ДанныеРегистра.НаправлениеДеятельности КАК НаправлениеДеятельности
			|
			|ПОМЕСТИТЬ ПорядокУчетаОС
			|
			|ИЗ
			|	РегистрСведений.ПорядокУчетаОС.СрезПоследних(
			|			&ДатаСведений,
			|			&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Условия
			|				И ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
			|				И ОсновноеСредство В (
			|					ВЫБРАТЬ 
			|						ВтСписокОС.Ссылка  
			|					ИЗ 
			|						ВтСписокОС КАК ВтСписокОС)) КАК ДанныеРегистра
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	ОсновноеСредство
			|";
			СписокЗапросов.Добавить(ТекстЗапроса);

			ТекстСоединения = ТекстСоединения + "
			|		ЛЕВОЕ СОЕДИНЕНИЕ ПорядокУчетаОС КАК ПорядокУчетаОС
			|		ПО ПорядокУчетаОС.ОсновноеСредство = ДанныеСправочникаПереопределяемый.Ссылка
			|"; // @query-part-1
			
		КонецЕсли;
		
		Если ОписаниеЗапросаДляВыбора.НеобходимыеТаблицы.Свойство("АрендованныеОС") Тогда
			
			ТекстЗапроса =
			"ВЫБРАТЬ
			|	ДанныеРегистра.ОсновноеСредство КАК ОсновноеСредство,
			|	ДанныеРегистра.Партнер КАК Партнер,
			|	ДанныеРегистра.Контрагент КАК Контрагент,
			|	ДанныеРегистра.Договор КАК Договор
			|
			|ПОМЕСТИТЬ АрендованныеОС
			|
			|ИЗ
			|	РегистрСведений.АрендованныеОС.СрезПоследних(
			|			&ДатаСведений,
			|			ОсновноеСредство В (
			|					ВЫБРАТЬ 
			|						ВтСписокОС.Ссылка  
			|					ИЗ 
			|						ВтСписокОС КАК ВтСписокОС)) КАК ДанныеРегистра
			|
			|ИНДЕКСИРОВАТЬ ПО
			|	ОсновноеСредство
			|";
			СписокЗапросов.Добавить(ТекстЗапроса);

			ТекстСоединения = ТекстСоединения + "
			|		ЛЕВОЕ СОЕДИНЕНИЕ АрендованныеОС КАК АрендованныеОС
			|		ПО АрендованныеОС.ОсновноеСредство = ДанныеСправочникаПереопределяемый.Ссылка
			|"; // @query-part-1
			
		КонецЕсли;
	
		ТекстЗапроса =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 10
		|	ДанныеСправочникаПереопределяемый.Ссылка КАК Ссылка,
		|	ДанныеСправочникаПереопределяемый.Наименование КАК Наименование,
		|	ДанныеСправочникаПереопределяемый.ИнвентарныйНомер КАК ИнвентарныйНомер
		|
		|ИЗ
		|	ВтСписокОС КАК ДанныеСправочникаПереопределяемый
		|";
		
		Если ЗначениеЗаполнено(ТекстСоединения) Тогда
			ТекстЗапроса = ТекстЗапроса + Символы.ПС + ТекстСоединения;
		КонецЕсли;

		СписокЗапросов.Добавить(ТекстЗапроса);
		
		ТекстЗапроса = СтрСоединить(СписокЗапросов, ОбщегоНазначения.РазделительПакетаЗапросов());
		
		ТекстОтборы = "";

	Иначе
		
		ТекстЗапроса =		
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 10
		|	ДанныеСправочникаПереопределяемый.Ссылка КАК Ссылка,
		|	ДанныеСправочникаПереопределяемый.Наименование КАК Наименование,
		|	ДанныеСправочникаПереопределяемый.ИнвентарныйНомер КАК ИнвентарныйНомер
		|
		|ИЗ	
		|	Справочник.ОбъектыЭксплуатации КАК ДанныеСправочникаПереопределяемый
		|";
		
		ТекстОтборы = 
		"ГДЕ
		|	(ДанныеСправочникаПереопределяемый.Наименование ПОДОБНО &ПодстрокаПоиска
		|			ИЛИ ДанныеСправочникаПереопределяемый.ИнвентарныйНомер ПОДОБНО &ПодстрокаПоиска)
		|	И НЕ ДанныеСправочникаПереопределяемый.ЭтоГруппа
		|	И НЕ ДанныеСправочникаПереопределяемый.ПометкаУдаления
		|";
		
	КонецЕсли;

	Если НЕ ПустаяСтрока(ОписаниеЗапросаДляВыбора.ТекстОтборы) Тогда
		ТекстИ = "И"; // @query-part-1
		ТекстГДЕ = "ГДЕ"; // @query-part-1
		ТекстОтборы = ТекстОтборы
			+ ?(ТекстОтборы <> "", Символы.ПС + ТекстИ, ТекстГДЕ) + Символы.ПС + ОписаниеЗапросаДляВыбора.ТекстОтборы; 
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(ТекстОтборы) Тогда
		ТекстЗапроса = ТекстЗапроса + Символы.ПС + ТекстОтборы;
	КонецЕсли;
	
	ТекстЗапроса = ТекстЗапроса + 
	"
	|УПОРЯДОЧИТЬ ПО
	|	Наименование
	|";
	
	ПараметрыСрезаПоследних_Период = "";
	ПараметрыСрезаПоследних_ДатаИсправления = "ИСТИНА";
	ПараметрыСрезаПоследних_Условия = "ИСТИНА";
	ПараметрыСрезаПоследних_Регистрация = "ИСТИНА";
	
	Если ПараметрыВыбора.Свойство("ДатаСведений") Тогда
		ПараметрыСрезаПоследних_Период = "&ДатаСведений";
		ПараметрыСрезаПоследних_ДатаИсправления = "ДатаИсправления = ДАТАВРЕМЯ(1,1,1)";
	КонецЕсли; 
	
	Если ПараметрыВыбора.Свойство("ТекущийРегистратор") Тогда
		ПараметрыСрезаПоследних_Условия = "Регистратор <> &ТекущийРегистратор";
	КонецЕсли; 

	Если ПараметрыВыбора.Свойство("ЕстьПараметрыНачисленияТранспортногоНалога")
			И ПараметрыВыбора.ЕстьПараметрыНачисленияТранспортногоНалога
		ИЛИ ПараметрыВыбора.Свойство("ЕстьПараметрыНачисленияЗемельногоНалога")
			И ПараметрыВыбора.ЕстьПараметрыНачисленияЗемельногоНалога Тогда
		
		ПараметрыСрезаПоследних_Регистрация = ПараметрыСрезаПоследних_Условия;
		
		Если ПараметрыВыбора.Отбор.Свойство("Организация")
			И ЗначениеЗаполнено(ПараметрыВыбора.Отбор.Организация) Тогда
			
			ПараметрыСрезаПоследних_Регистрация = 
				ПараметрыСрезаПоследних_Регистрация 
				+ ?(ПараметрыСрезаПоследних_Регистрация <> "", " И ", "")
				+ "Организация = &Организация";
				
		КонецЕсли; 
		
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Период", ПараметрыСрезаПоследних_Период);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДатаИсправления", ПараметрыСрезаПоследних_ДатаИсправления);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Условия", ПараметрыСрезаПоследних_Условия);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Регистрация", ПараметрыСрезаПоследних_Регистрация);
		
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц();
	Запрос.УстановитьПараметр("ПодстрокаПоиска", "%" + Параметры.СтрокаПоиска + "%");
	Запрос.УстановитьПараметр("ДатаСведений", ?(ПараметрыВыбора.Свойство("ДатаСведений"), КонецДня(ПараметрыВыбора.ДатаСведений), '00010101'));
	
	Для каждого ОписаниеПараметра Из ОписаниеЗапросаДляВыбора.ПараметрыЗапроса Цикл
		Запрос.УстановитьПараметр(ОписаниеПараметра.Ключ, ОписаниеПараметра.Значение);
	КонецЦикла;

	Если ПараметрыВыбора.Свойство("ТекущийРегистратор") Тогда
		Запрос.УстановитьПараметр("ТекущийРегистратор", ПараметрыВыбора.ТекущийРегистратор);
	КонецЕсли; 
	
	Если ПараметрыВыбора.Отбор.Свойство("Состояние") Тогда
		
		ЗначениеОтбора = ВнеоборотныеАктивыСлужебный.ЗначениеВМассив(ПараметрыВыбора.Отбор.Состояние);
		
		Запрос.УстановитьПараметр("Состояние", ЗначениеОтбора);
		Запрос.УстановитьПараметр("НеИспользоватьОтборСостояние", НЕ ЗначениеЗаполнено(ЗначениеОтбора));
		
	Иначе			
		
		ЗначениеОтбора = Новый Массив;
		ЗначениеОтбора.Добавить(Перечисления.СостоянияОС.ПустаяСсылка());
		
		Запрос.УстановитьПараметр("Состояние", ЗначениеОтбора);
		Запрос.УстановитьПараметр("НеИспользоватьОтборСостояние", Истина);
		
	КонецЕсли;

	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		Если ЗначениеЗаполнено(Выборка.ИнвентарныйНомер) Тогда
			Представление = СтрШаблон(НСтр("ru = '%1 (инв.№ %2)'"), СокрЛП(Выборка.Наименование), СокрЛП(Выборка.ИнвентарныйНомер));
		Иначе
			Представление = СокрЛП(Выборка.Наименование);
		КонецЕсли;
		
		Представление = ОбщегоНазначенияУТ.ПредставлениеРезультатаПоискаПоСтроке(Представление, Параметры.СтрокаПоиска);
		ДанныеВыбора.Добавить(Выборка.Ссылка, Представление);
		
	КонецЦикла;
	
	Возврат ДанныеВыбора;
	
КонецФункции

Функция ДанныеВыбораНематериальныхАктивов2_4(Параметры)

	ОписаниеЗапроса = Справочники.НематериальныеАктивы.ОписаниеЗапросаДляВыбора(Параметры, Истина);
	
	Запрос = Новый Запрос(ОписаниеЗапроса.ТекстЗапроса);
	Для каждого ОписаниеПараметра Из ОписаниеЗапроса.ПараметрыЗапроса Цикл
		Запрос.УстановитьПараметр(ОписаниеПараметра.Ключ, ОписаниеПараметра.Значение);
	КонецЦикла; 
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	ДанныеВыбора = Новый СписокЗначений;
	Пока Выборка.Следующий() Цикл
		Представление = ОбщегоНазначенияУТ.ПредставлениеРезультатаПоискаПоСтроке(Выборка.Наименование, Параметры.СтрокаПоиска);
		ДанныеВыбора.Добавить(Выборка.Ссылка, Представление);
	КонецЦикла;
	
	Возврат ДанныеВыбора;
	
КонецФункции

Функция НеВедетсяУчетВнеоборотныхАктивов2_4(Период) Экспорт
	
	Возврат ПолучитьФункциональнуюОпцию("ИспользоватьВнеоборотныеАктивы2_4")
		И Период < ВнеоборотныеАктивыЛокализация.ДатаНачалаУчетаВнеоборотныхАктивов2_4();
		
КонецФункции

// Параметры способа отражения расходов.
// 
// Параметры:
//  СпособОтраженияРасходов - СправочникСсылка.СпособыОтраженияРасходов - Способ отражения расходов
// 
// Возвращаемое значение:
//  Структура - Параметры способа отражения расходов:
// 		* СтатьяРасходов - ПланВидовХарактеристикСсылка.СтатьиРасходов - Статья
// 		* АналитикаРасходов - ЛюбаяСсылка, Неопределено -
// 		* Подразделение - СправочникСсылка.СтруктураПредприятия -
// 		* НаправлениеДеятельности - СправочникСсылка.НаправленияДеятельности -
// 		* ПодразделениеИНаправлениеДеятельностиСовпадаютСДаннымиУчета - Булево
// 
Функция ПараметрыСпособаОтраженияРасходов(СпособОтраженияРасходов) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("СтатьяРасходов", ПланыВидовХарактеристик.СтатьиРасходов.ПустаяСсылка());
	Результат.Вставить("АналитикаРасходов", Неопределено);
	Результат.Вставить("Подразделение", Справочники.СтруктураПредприятия.ПустаяСсылка());
	Результат.Вставить("НаправлениеДеятельности", Справочники.НаправленияДеятельности.ПустаяСсылка());
	Результат.Вставить("ПодразделениеИНаправлениеДеятельностиСовпадаютСДаннымиУчета", Истина);
	
	ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(СпособОтраженияРасходов, "СтатьяРасходов,АналитикаРасходов,Подразделение,НаправлениеДеятельности,ПодразделениеИНаправлениеДеятельностиСовпадаютСДаннымиУчета");
	
	ЗаполнитьЗначенияСвойств(Результат, ЗначенияРеквизитов);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
