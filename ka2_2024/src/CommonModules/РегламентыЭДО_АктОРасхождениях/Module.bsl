//@strict-types

#Область СлужебныеПроцедурыИФункции

#Область ДляВызоваИзМодуляРегламентыЭДО

// Возвращает состояние входящего электронного документа.
// 
// Параметры:
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостояния
//  СостоянияЭлементовРегламента - См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
// 
// Возвращаемое значение:
//  ПеречислениеСсылка.СостоянияДокументовЭДО
//
Функция СостояниеВходящегоДокумента(ПараметрыДокумента, СостоянияЭлементовРегламента) Экспорт

	Возврат СостояниеДокумента(ПараметрыДокумента, СостоянияЭлементовРегламента);

КонецФункции

// Возвращает состояние исходящего электронного документа.
// 
// Параметры:
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостояния
//  СостоянияЭлементовРегламента - См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
// 
// Возвращаемое значение:
//  ПеречислениеСсылка.СостоянияДокументовЭДО
//
Функция СостояниеИсходящегоДокумента(ПараметрыДокумента, СостоянияЭлементовРегламента) Экспорт
	
	Возврат СостояниеДокумента(ПараметрыДокумента, СостоянияЭлементовРегламента);
	
КонецФункции

// Возвращает состояние сообщения.
//
// Параметры:
//  ПараметрыСообщения - См. РегламентыЭДО.НовыеПараметрыСообщенияДляОпределенияСостояния
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостоянияСообщения
//  ИспользоватьУтверждение  - Булево
//
// Возвращаемое значение:
//  ПеречислениеСсылка.СостоянияСообщенийЭДО
//
Функция СостояниеСообщения(ПараметрыСообщения, ПараметрыДокумента, ИспользоватьУтверждение) Экспорт
	
	Если ПараметрыСообщения.ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ПОА Тогда
		Состояние = РегламентыЭДО.СостояниеСообщенияАннулирования(ПараметрыСообщения, ПараметрыДокумента);
	ИначеЕсли РегламентыЭДО.ЭтоСлужебноеСообщение(ПараметрыСообщения.ТипЭлементаРегламента) Тогда
		Состояние = РегламентыЭДО.СостояниеСлужебногоСообщения(ПараметрыСообщения, ПараметрыДокумента);
	Иначе
		ИспользоватьУтверждениеСообщенияФНС = ИспользоватьУтверждениеСообщенияФНС(ПараметрыСообщения,
			ИспользоватьУтверждение);
		Состояние = РегламентыЭДО.СостояниеСообщенияФНС(ПараметрыСообщения, ПараметрыДокумента,
			ИспользоватьУтверждениеСообщенияФНС);
	КонецЕсли;
	
	Возврат Состояние;
	
КонецФункции

// Возвращает коллекцию добавленных элементов схемы регламента.
// 
// Параметры:
//  СхемаРегламента - См. РегламентыЭДО.НоваяСхемаРегламента
//  НастройкиСхемыРегламента - См. РегламентыЭДО.НовыеНастройкиСхемыРегламента
//
// Возвращаемое значение:
//  См. РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента
Функция ДобавитьЭлементыСхемыРегламента(СхемаРегламента, НастройкиСхемыРегламента) Экспорт
	
	ЭлементыСхемы = РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента();
	
	Если НастройкиСхемыРегламента.ЭтоВходящийЭДО Тогда
		ДобавитьЭлементыРегламентаПолучателя(СхемаРегламента, НастройкиСхемыРегламента, ЭлементыСхемы);
	Иначе
		ДобавитьЭлементыРегламентаОтправителя(СхемаРегламента, НастройкиСхемыРегламента, ЭлементыСхемы);
	КонецЕсли;
	
	Возврат ЭлементыСхемы;
	
КонецФункции

// Параметры:
//  СхемаРегламента - см. РегламентыЭДО.НоваяСхемаРегламента
//  НастройкиСхемыРегламента - см. РегламентыЭДО.НовыеНастройкиСхемыРегламента
//  ТипЭлементаРегламента - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
// 
// Возвращаемое значение:
//  См. РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента
Функция ДобавитьЭлементыСхемыВложенногоРегламента(СхемаРегламента, НастройкиСхемыРегламента, ТипЭлементаРегламента) Экспорт
	
	Если ЭтоЭлементРегламентаАннулирования(ТипЭлементаРегламента) Тогда
		
		НовыеЭлементыСхемы = ДобавитьЭлементыРегламентаАннулирования(СхемаРегламента);
		
	ИначеЕсли ЭтоЭлементРегламентаОтклонения(ТипЭлементаРегламента) Тогда
		
		НовыеЭлементыСхемы = ДобавитьЭлементыРегламентаОтклонения(СхемаРегламента, НастройкиСхемыРегламента);
		
	Иначе
		
		НовыеЭлементыСхемы = ДобавитьПроизвольныйЭлементРегламента(СхемаРегламента, ТипЭлементаРегламента);
		
	КонецЕсли;
	
	Возврат НовыеЭлементыСхемы;
	
КонецФункции

// Возвращает тип извещения для элемента входящего документа.
// 
// Параметры:
//  ТипЭлементаРегламента - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
//
// Возвращаемое значение:
//  ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
//
Функция ТипИзвещенияДляЭлементаВходящегоДокумента(ТипЭлементаРегламента) Экспорт
	Результат = Перечисления.ТипыЭлементовРегламентаЭДО.ПустаяСсылка();
	Если ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияОтправителя Тогда
		Результат = Перечисления.ТипыЭлементовРегламентаЭДО.ИОП;
	ИначеЕсли ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки Тогда
		Результат = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ИОП;
	КонецЕсли;
	Возврат Результат;
КонецФункции

// Возвращает тип извещения для элемента исходящего документа.
// 
// Параметры:
//  ТипЭлементаРегламента - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
//
// Возвращаемое значение:
//  ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
//
Функция ТипИзвещенияДляЭлементаИсходящегоДокумента(ТипЭлементаРегламента) Экспорт
	Результат = Перечисления.ТипыЭлементовРегламентаЭДО.ПустаяСсылка();
	Если ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки Тогда
		Результат = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ИОП;
	КонецЕсли;
	Возврат Результат;
КонецФункции

// Возвращает признак наличия информации получателя в регламенте.
// 
// Возвращаемое значение:
//  Булево
//
Функция ЕстьИнформацияПолучателя() Экспорт
	Возврат Истина;
КонецФункции

// Корректирует описание сообщения согласно регламенту.
// Выполняется после распаковки контейнера, но до создания объекта сообщения ЭДО.
// 
// Параметры:
//  ОписаниеСообщения - См. ЭлектронныеДокументыЭДО.НовоеОписаниеСообщения
Процедура СкорректироватьОписаниеСообщения(ОписаниеСообщения) Экспорт

	Если ОписаниеСообщения.ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияПолучателя_ИОП Тогда
		ОписаниеСообщения.ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ИОП;
	ИначеЕсли ОписаниеСообщения.ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияПолучателя_ПДП Тогда
		ОписаниеСообщения.ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДП;
	ИначеЕсли ОписаниеСообщения.ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияПолучателя_ПДО Тогда
		ОписаниеСообщения.ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДО
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СостояниеДокумента

// Вычисляет состояние документа по титулу формата и подрегламентов извещения и подтверждения оператора.
// 
// Параметры:
//  ТипЭлементаТитула - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостояния
//  СостоянияЭлементовРегламента - См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
//  Состояние - ПеречислениеСсылка.СостоянияДокументовЭДО - Состояние
// 
// Возвращаемое значение:
//  Булево - Вычисление статуса завершено
Функция ЗаполнитьСостояниеПоТитулу(ТипЭлементаТитула, ПараметрыДокумента, СостоянияЭлементовРегламента, Состояние)
	
	ОписаниеТиповЭлементов = Новый Структура;
	ОписаниеТиповЭлементов.Вставить("ОсновнойЭлемент", ТипЭлементаТитула);
	Если ТипЭлементаТитула = Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияОтправителя Тогда
		ОписаниеТиповЭлементов.Вставить("Извещение", Перечисления.ТипыЭлементовРегламентаЭДО.ИОП);
		ОписаниеТиповЭлементов.Вставить("ПодтверждениеДатыОтправки", Перечисления.ТипыЭлементовРегламентаЭДО.ПДО);
		ОписаниеТиповЭлементов.Вставить("ПодтверждениеДатыПолучения", Перечисления.ТипыЭлементовРегламентаЭДО.ПДП);
	Иначе
		ОписаниеТиповЭлементов.Вставить("Извещение",
			Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ИОП);
		ОписаниеТиповЭлементов.Вставить("ПодтверждениеДатыОтправки",
			Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДО);
		ОписаниеТиповЭлементов.Вставить("ПодтверждениеДатыПолучения",
			Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДП);
	КонецЕсли;
	
	Возврат ЗаполнитьСостояниеПоОсновномуЭлементу(ТипЭлементаТитула, ПараметрыДокумента, СостоянияЭлементовРегламента,
				Состояние)
		Или ЗаполнитьСостояниеПоПодтверждениюОператора(ОписаниеТиповЭлементов, ПараметрыДокумента,
				СостоянияЭлементовРегламента, Состояние)
		Или ЗаполнитьСостояниеПоИзвещению(ОписаниеТиповЭлементов, ПараметрыДокумента, СостоянияЭлементовРегламента,
				Состояние);
КонецФункции

// Вычисляет состояние документа по регламента отзыва и аннулирования документа,
// а также по титулам формата и подрегламентам извещения и подтверждения оператора.
// 
// Параметры:
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостояния
//  СостоянияЭлементовРегламента - См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
// 
// Возвращаемое значение:
//  ПеречислениеСсылка.СостоянияДокументовЭДО
Функция СостояниеДокумента(ПараметрыДокумента, СостоянияЭлементовРегламента)
	
	Состояние = Перечисления.СостоянияДокументовЭДО.ПустаяСсылка();
	
	ТипОсновногоТитула = Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияОтправителя;
	ТипДополнительногоТитула = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки;
	
	Если ЗаполнитьСостояниеПоОтклонению(ПараметрыДокумента, СостоянияЭлементовРегламента, Состояние)
		Или ЗаполнитьСостояниеПоПредложениюОбАннулировании(ПараметрыДокумента, СостоянияЭлементовРегламента, Состояние)
		Или ЗаполнитьСостояниеПоТитулу(ТипОсновногоТитула, ПараметрыДокумента, СостоянияЭлементовРегламента, Состояние)
		Или ЗаполнитьСостояниеПоТитулу(ТипДополнительногоТитула, ПараметрыДокумента, СостоянияЭлементовРегламента, Состояние)
		Или ЗначениеЗаполнено(Состояние) Тогда
		
		Возврат Состояние;
		
	ИначеЕсли ПараметрыДокумента.Исправлен Тогда
		
		Возврат Перечисления.СостоянияДокументовЭДО.ОбменЗавершенСИсправлением;
		
	КонецЕсли;
	
	Возврат Перечисления.СостоянияДокументовЭДО.ОбменЗавершен;
	
КонецФункции

// Возвращает признак успешности заполнения состояния по предложению об аннулировании.
// 
// Параметры:
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостояния
//  СостоянияЭлементовРегламента - См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
//  Состояние - ПеречислениеСсылка.СостоянияДокументовЭДО
//
// Возвращаемое значение:
//  Булево
//
Функция ЗаполнитьСостояниеПоПредложениюОбАннулировании(ПараметрыДокумента, СостоянияЭлементовРегламента, Состояние)
	
	ЭлементРегламента = Неопределено; // Неопределено,СтрокаТаблицыЗначений: См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
	
	Если Не РегламентыЭДО.ЕстьАктуальноеАннулирование(СостоянияЭлементовРегламента, ЭлементРегламента) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Результат = Истина;
	
	ОтклонениеПОА = Неопределено; // Неопределено,СтрокаТаблицыЗначений: См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
	Если РегламентыЭДО.ЕстьАктуальноеОтклонениеАннулирования(СостоянияЭлементовРегламента,
		ЭлементРегламента, ОтклонениеПОА) Тогда
		
		Если ОтклонениеПОА.Состояние = Перечисления.СостоянияСообщенийЭДО.Подписание Тогда 
			
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодписаниеОтклонения;
			
		ИначеЕсли ОтклонениеПОА.Состояние = Перечисления.СостоянияСообщенийЭДО.ПодготовкаКОтправке Тогда 
			
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодготовкаКОтправкеОтклонения;
			
		ИначеЕсли ОтклонениеПОА.Состояние = Перечисления.СостоянияСообщенийЭДО.Отправка Тогда 
			
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяОтправкаОтклонения;
			
		Иначе
			
			Результат = Ложь;
			
		КонецЕсли;
		
	ИначеЕсли РегламентыЭДО.ЕстьЭлементРегламента(СостоянияЭлементовРегламента,
		Перечисления.ТипыЭлементовРегламентаЭДО.УОУ, ОтклонениеПОА) Тогда
		
		// Отправитель запросил аннулирование документа, получатель - отклонил документ. 
		// Проверка состояния будет в ЗаполнитьСостояниеПоВходящемуОтклонению.
		Результат = Ложь;
	
	ИначеЕсли ЭлементРегламента.Состояние = Перечисления.СостоянияСообщенийЭДО.Подтверждение Тогда
		
		Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодтверждениеАннулирования;
		
	ИначеЕсли ЭлементРегламента.Состояние = Перечисления.СостоянияСообщенийЭДО.Подписание Тогда
		
		Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодписаниеАннулирования;
		
	ИначеЕсли ЭлементРегламента.Состояние = Перечисления.СостоянияСообщенийЭДО.ПодготовкаКОтправке Тогда 
		
		Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодготовкаКОтправкеАннулирования;
		
	ИначеЕсли ЭлементРегламента.Состояние = Перечисления.СостоянияСообщенийЭДО.Отправка Тогда 
		
		Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяОтправкаАннулирования;
		
	ИначеЕсли ЭлементРегламента.Состояние = Перечисления.СостоянияСообщенийЭДО.ОжидаетсяПодпись Тогда 
		
		Состояние = Перечисления.СостоянияДокументовЭДО.ОжидаетсяПодтверждениеАннулирования;

	ИначеЕсли ЭлементРегламента.Состояние = Перечисления.СостоянияСообщенийЭДО.Хранение Тогда
		
		Состояние = Перечисления.СостоянияДокументовЭДО.Аннулирован;
		
	Иначе
		
		Результат = Ложь;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Вычисляет состояние документа по регламенту отклоения документа
// 
// Параметры:
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостояния
//  СостоянияЭлементовРегламента - См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
//  Состояние - ПеречислениеСсылка.СостоянияДокументовЭДО
// 
// Возвращаемое значение:
//  Булево - Вычисление статуса завершено
Функция ЗаполнитьСостояниеПоОтклонению(ПараметрыДокумента, СостоянияЭлементовРегламента, Состояние)
	ЭлементОтклонения = СостоянияЭлементовРегламента.Найти(Перечисления.ТипыЭлементовРегламентаЭДО.УОУ,
		"ТипЭлементаРегламента");
	Если ЭлементОтклонения = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если ЭлементОтклонения.Направление = Перечисления.НаправленияЭДО.Исходящий Тогда
		Если ЭлементОтклонения.Состояние = Перечисления.СостоянияСообщенийЭДО.Подписание Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодписаниеОтклонения;
		ИначеЕсли ЭлементОтклонения.Состояние = Перечисления.СостоянияСообщенийЭДО.ПодготовкаКОтправке Тогда 
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодготовкаКОтправкеОтклонения;
		ИначеЕсли ЭлементОтклонения.Состояние = Перечисления.СостоянияСообщенийЭДО.Отправка Тогда 
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяОтправкаОтклонения;
		ИначеЕсли Не ПараметрыДокумента.Исправлен Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ОжидаетсяИсправление;
		Иначе
			Состояние = Перечисления.СостоянияДокументовЭДО.ЗакрытСОтклонением;
		КонецЕсли;
	Иначе
		Если ПараметрыДокумента.Исправлен Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ЗакрытСОтклонением;
		Иначе
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяУточнение;
		КонецЕсли;
	КонецЕсли;
	Возврат Истина;
	
КонецФункции

// Вычисляет состояние документа по титулу формата
// 
// Параметры:
//  ТипОсновногоЭлемента - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостояния
//  СостоянияЭлементовРегламента - См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
//  Состояние - ПеречислениеСсылка.СостоянияДокументовЭДО
// 
// Возвращаемое значение:
//  Булево - Вычисление статуса завершено
Функция ЗаполнитьСостояниеПоОсновномуЭлементу(ТипОсновногоЭлемента, ПараметрыДокумента, СостоянияЭлементовРегламента, Состояние)
	
	ЭлементТитула = СостоянияЭлементовРегламента.Найти(ТипОсновногоЭлемента, "ТипЭлементаРегламента");
	Если ЭлементТитула = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если ЭлементТитула.Направление = Перечисления.НаправленияЭДО.Исходящий Тогда
		Если ЭлементТитула.Состояние = Перечисления.СостоянияСообщенийЭДО.Подписание Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодписание;
		ИначеЕсли ЭлементТитула.Состояние = Перечисления.СостоянияСообщенийЭДО.ПодготовкаКОтправке Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодготовкаКОтправке;
		ИначеЕсли ЭлементТитула.Состояние = Перечисления.СостоянияСообщенийЭДО.Отправка Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяОтправка;
		ИначеЕсли (ЭлементТитула.Состояние =  Перечисления.СостоянияСообщенийЭДО.ПустаяСсылка()
			Или ЭлементТитула.Состояние = Перечисления.СостоянияСообщенийЭДО.Формирование)
			И ТипОсновногоЭлемента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодписание;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	Иначе
		Если ЭлементТитула.Состояние = Перечисления.СостоянияСообщенийЭДО.Утверждение Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяУтверждение;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;
	Возврат Истина;
	
КонецФункции

// Вычисляет состояние документа по подрегламенту извещения получателя
// 
// Параметры:
//  ОписаниеТиповЭлемента - Структура:
// * ОсновнойЭлемент - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО - элемент, на который отправляется/получается извещения
// * Извещение - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
// * ПодтверждениеДатыОтправки - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
// * ПодтверждениеДатыПолучения - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостояния
//  СостоянияЭлементовРегламента - См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
//  Состояние - ПеречислениеСсылка.СостоянияДокументовЭДО
// 
// Возвращаемое значение:
//  Булево - Вычисление статуса завершено
Функция ЗаполнитьСостояниеПоИзвещению(ОписаниеТиповЭлемента, ПараметрыДокумента, СостоянияЭлементовРегламента, Состояние)
	
	Если Не ПараметрыДокумента.ТребуетсяИзвещение Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ЭлементВладелец = СостоянияЭлементовРегламента.Найти(ОписаниеТиповЭлемента.ОсновнойЭлемент, "ТипЭлементаРегламента");
	Если ЭлементВладелец = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ЭлементИзвещения = СостоянияЭлементовРегламента.Найти(ОписаниеТиповЭлемента.Извещение, "ТипЭлементаРегламента");
	Если ЭлементВладелец.Направление = Перечисления.НаправленияЭДО.Входящий Тогда
		Если ЭлементИзвещения = Неопределено Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяИзвещениеОПолучении;
		ИначеЕсли ЭлементИзвещения.Состояние = Перечисления.СостоянияСообщенийЭДО.Подписание Тогда 
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодписаниеИзвещения;
		ИначеЕсли ЭлементИзвещения.Состояние = Перечисления.СостоянияСообщенийЭДО.ПодготовкаКОтправке Тогда 
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяПодготовкаКОтправкеИзвещения;
		ИначеЕсли ЭлементИзвещения.Состояние = Перечисления.СостоянияСообщенийЭДО.Отправка Тогда 
			Состояние = Перечисления.СостоянияДокументовЭДО.ТребуетсяОтправкаИзвещения;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	Иначе
		Если ЭлементИзвещения = Неопределено Тогда
			Состояние = Перечисления.СостоянияДокументовЭДО.ОжидаетсяИзвещениеОПолучении;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;
	Возврат Истина;
	
КонецФункции

// Вычисляет состояние документа по подрегламенту подтверждения оператором
// 
// Параметры:
//  ОписаниеТиповЭлемента - Структура:
// * ОсновнойЭлемент - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО - элемент, на который получается подтверждение
// * Извещение - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
// * ПодтверждениеДатыОтправки - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
// * ПодтверждениеДатыПолучения - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
//  ПараметрыДокумента - См. РегламентыЭДО.НовыеПараметрыДокументаДляОпределенияСостояния
//  СостоянияЭлементовРегламента - См. РегламентыЭДО.НовыеСостоянияЭлементовРегламента
//  Состояние - ПеречислениеСсылка.СостоянияДокументовЭДО
// 
// Возвращаемое значение:
//  Булево - Вычисление статуса завершено
Функция ЗаполнитьСостояниеПоПодтверждениюОператора(ОписаниеТиповЭлемента, ПараметрыДокумента,
	СостоянияЭлементовРегламента, Состояние)

	Если Не РегламентыЭДО.ЭтоОбменЧерезОператора(ПараметрыДокумента.СпособОбмена) Тогда
		Возврат Ложь;
	КонецЕсли;

	ЭлементВладелец = СостоянияЭлементовРегламента.Найти(ОписаниеТиповЭлемента.ОсновнойЭлемент, "ТипЭлементаРегламента");
	Если ЭлементВладелец = Неопределено
		Или Не ЗначениеЗаполнено(ЭлементВладелец.Состояние)
		Или ЭлементВладелец.Состояние = Перечисления.СостоянияСообщенийЭДО.Формирование Тогда
		Возврат Ложь;
	КонецЕсли;

	Если ЭлементВладелец.Направление = Перечисления.НаправленияЭДО.Исходящий Тогда
		ЭлементПодтверждения = СостоянияЭлементовРегламента.Найти(ОписаниеТиповЭлемента.ПодтверждениеДатыПолучения,
			"ТипЭлементаРегламента");
	Иначе
		ЭлементПодтверждения = СостоянияЭлементовРегламента.Найти(ОписаниеТиповЭлемента.ПодтверждениеДатыОтправки,
			"ТипЭлементаРегламента");
	КонецЕсли;
	Если ЭлементПодтверждения = Неопределено Тогда
		Состояние = Перечисления.СостоянияДокументовЭДО.ОжидаетсяПодтверждениеОператора;
		Возврат Истина;
	КонецЕсли;
	Возврат Ложь;

КонецФункции

// Вычисляет необходимость использования утверждения для сообщения ФНС.
// 
// Параметры:
//  ПараметрыСообщения - См. РегламентыЭДО.НовыеПараметрыСообщенияДляОпределенияСостояния
//  ИспользоватьУтверждение  - Булево
// 
// Возвращаемое значение:
//  Булево - использовать утверждение
//
Функция ИспользоватьУтверждениеСообщенияФНС(ПараметрыСообщения, ИспользоватьУтверждение)
	
	Результат = ИспользоватьУтверждение;
	
	Если ПараметрыСообщения.ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки
		И ПараметрыСообщения.Направление = Перечисления.НаправленияЭДО.Входящий Тогда
		Результат = Ложь;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область ДобавитьЭлементыСхемыРегламента

// Добавляет элементы по регламенту отправителя.
// 
// Параметры:
//  СхемаРегламента - См. РегламентыЭДО.НоваяСхемаРегламента
//  НастройкиСхемыРегламента - См. РегламентыЭДО.НовыеНастройкиСхемыРегламента
//  ЭлементыСхемы - См. РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента
//
Процедура ДобавитьЭлементыРегламентаОтправителя(СхемаРегламента, НастройкиСхемыРегламента, ЭлементыСхемы)
	
	ЭтоОбменЧерезОператора = РегламентыЭДО.ЭтоОбменЧерезОператора(НастройкиСхемыРегламента.СпособОбмена);
	
	ИнформацияОтправителя = РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, СхемаРегламента,
		Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияОтправителя);
	
	Если ЭтоОбменЧерезОператора Тогда
		
		РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ИнформацияОтправителя,
			Перечисления.ТипыЭлементовРегламентаЭДО.ПДП); 
			
	КонецЕсли;
	
	РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ИнформацияОтправителя,
		Перечисления.ТипыЭлементовРегламентаЭДО.ИОП,
		Не НастройкиСхемыРегламента.ТребуетсяИзвещение); 
		
	СвойстваДокументовПоФорматам = НастройкиСхемыРегламента.СвойстваДокументовПоФорматам.АктОРасхождениях;
	
	Если СвойстваДокументовПоФорматам.ФормируютсяИтогиПриемки Тогда
		
		ВариантыФормирования = ФорматыЭДО.ВариантыФормированияИтоговПриемки();
		
		ВариантыФормированияПокупателя = Новый Массив;
		ВариантыФормированияПокупателя.Добавить(
			ВариантыФормирования.ПокупателемФормируютсяДопСведенияОбОприходованииИмЦенностей);
		ВариантыФормированияПокупателя.Добавить(
			ВариантыФормирования.ПокупателемФормируютсяДопСведенияОУтвержденииДокумента);
		ВариантыФормированияПокупателя.Добавить(
			ВариантыФормирования.ПокупателемФормируютсяДопСведенияИные);
		
		НайденныйВариантФормирования = ВариантыФормированияПокупателя.Найти(
			СвойстваДокументовПоФорматам.ВариантФормированияИтоговПриемки);
		ЭтоДополнительныйЭлемент = НайденныйВариантФормирования = Неопределено;
		
		ДополнительныеСведения = РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ИнформацияОтправителя,
			Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки, ЭтоДополнительныйЭлемент);
		
		Если ЭтоОбменЧерезОператора Тогда
			
			Если НайденныйВариантФормирования <> Неопределено Тогда
				РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ДополнительныеСведения,
					Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДП,
					ЭтоДополнительныйЭлемент);
			Иначе
				РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ДополнительныеСведения,
					Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДО,
					ЭтоДополнительныйЭлемент);
			КонецЕсли;
		
		КонецЕсли;
			
		РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ДополнительныеСведения,
			Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ИОП, ЭтоДополнительныйЭлемент);
			
	КонецЕсли;
	
КонецПроцедуры

// Добавляет элементы по регламенту получателя.
// 
// Параметры:
//  СхемаРегламента - См. РегламентыЭДО.НоваяСхемаРегламента
//  НастройкиСхемыРегламента - См. РегламентыЭДО.НовыеНастройкиСхемыРегламента
//  ЭлементыСхемы - См. РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента
//
Процедура ДобавитьЭлементыРегламентаПолучателя(СхемаРегламента, НастройкиСхемыРегламента, ЭлементыСхемы)
	
	ЭтоОбменЧерезОператора = РегламентыЭДО.ЭтоОбменЧерезОператора(НастройкиСхемыРегламента.СпособОбмена);
	
	ИнформацияОтправителя = РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, СхемаРегламента,
		Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияОтправителя);
		
	Если ЭтоОбменЧерезОператора Тогда
		
		РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ИнформацияОтправителя,
			Перечисления.ТипыЭлементовРегламентаЭДО.ПДО);
		
	КонецЕсли;
		
	РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ИнформацияОтправителя,
		Перечисления.ТипыЭлементовРегламентаЭДО.ИОП,
		Не НастройкиСхемыРегламента.ТребуетсяИзвещение); 
		
	СвойстваДокументовПоФорматам = НастройкиСхемыРегламента.СвойстваДокументовПоФорматам.АктОРасхождениях;
		
	Если СвойстваДокументовПоФорматам.ФормируютсяИтогиПриемки Тогда
		
		ВариантыФормирования = ФорматыЭДО.ВариантыФормированияИтоговПриемки();
			
		ВариантыФормированияПродавца = Новый Массив;
		ВариантыФормированияПродавца.Добавить(
			ВариантыФормирования.ПродавцомФормируютсяДопСведенияОСогласииНесогласииСРезультатамиПриемки);
		ВариантыФормированияПродавца.Добавить(
			ВариантыФормирования.ПродавцомФормируютсяДопСведенияИные);
		
		НайденныйВариантФормирования = ВариантыФормированияПродавца.Найти(
			СвойстваДокументовПоФорматам.ВариантФормированияИтоговПриемки);
		ЭтоДополнительныйЭлемент = НайденныйВариантФормирования = Неопределено;
		
		ДополнительныеСведения = РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ИнформацияОтправителя,
			Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки, ЭтоДополнительныйЭлемент);
			
		Если ЭтоОбменЧерезОператора Тогда
			
			Если НайденныйВариантФормирования <> Неопределено Тогда
				РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ДополнительныеСведения,
					Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДО,
					ЭтоДополнительныйЭлемент);
			Иначе
				РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ДополнительныеСведения,
					Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДП,
					ЭтоДополнительныйЭлемент);
			КонецЕсли;
				
		КонецЕсли;
		
		РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ДополнительныеСведения,
			Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ИОП, ЭтоДополнительныйЭлемент);
			
	КонецЕсли;
	
КонецПроцедуры

// Параметры:
//  ТипЭлементаРегламента - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
// 
// Возвращаемое значение:
//  Булево
Функция ЭтоЭлементРегламентаАннулирования(ТипЭлементаРегламента)
	Возврат ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ПОА
		ИЛИ ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ПОА_УОУ;
КонецФункции

// Параметры:
//  СхемаРегламента - См. РегламентыЭДО.НоваяСхемаРегламента
//
// Возвращаемое значение:
//  См. РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента
Функция ДобавитьЭлементыРегламентаАннулирования(СхемаРегламента)
	
	ЭлементыСхемы = РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента();
	
	ИнформацияОтправителя = РегламентыЭДО.НайтиЭлементСхемыРегламента(СхемаРегламента,
		Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияОтправителя);
	Если ИнформацияОтправителя = Неопределено Тогда
		Возврат ЭлементыСхемы;
	КонецЕсли;
	
	ПОА = РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ИнформацияОтправителя,
		Перечисления.ТипыЭлементовРегламентаЭДО.ПОА, Истина);
	
	РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ПОА,
		Перечисления.ТипыЭлементовРегламентаЭДО.ПОА_УОУ, Истина);
	
	Возврат ЭлементыСхемы;
	
КонецФункции

// Параметры:
//  ТипЭлементаРегламента - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
// 
// Возвращаемое значение:
//  Булево
Функция ЭтоЭлементРегламентаОтклонения(ТипЭлементаРегламента)
	Возврат ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.УОУ
		ИЛИ ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.УОУ_ПДП
		ИЛИ ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.УОУ_ПДО;
КонецФункции

// Параметры:
//  СхемаРегламента - См. РегламентыЭДО.НоваяСхемаРегламента
//  НастройкиСхемыРегламента - См. РегламентыЭДО.НовыеНастройкиСхемыРегламента
// 
// Возвращаемое значение:
//  См. РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента
Функция ДобавитьЭлементыРегламентаОтклонения(СхемаРегламента, НастройкиСхемыРегламента)
	
	ЭлементыСхемы = РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента();
	
	ИнформацияОтправителя = РегламентыЭДО.НайтиЭлементСхемыРегламента(СхемаРегламента,
		Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияОтправителя);
	Если ИнформацияОтправителя = Неопределено Тогда
		Возврат ЭлементыСхемы;
	КонецЕсли;
	
	УОУ = РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ИнформацияОтправителя,
		Перечисления.ТипыЭлементовРегламентаЭДО.УОУ, Истина);
	
	Если НастройкиСхемыРегламента.ЭтоВходящийЭДО Тогда
		РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, УОУ,
			Перечисления.ТипыЭлементовРегламентаЭДО.УОУ_ПДП);
	Иначе
		РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, УОУ,
			Перечисления.ТипыЭлементовРегламентаЭДО.УОУ_ПДО);
	КонецЕсли;
	
	Возврат ЭлементыСхемы;
	
КонецФункции

// Параметры:
//  СхемаРегламента - См. РегламентыЭДО.НоваяСхемаРегламента
//  ТипЭлементаРегламента - ПеречислениеСсылка.ТипыЭлементовРегламентаЭДО
//
// Возвращаемое значение:
//  См. РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента
Функция ДобавитьПроизвольныйЭлементРегламента(СхемаРегламента, ТипЭлементаРегламента)
	
	ЭлементыСхемы = РегламентыЭДО.НоваяКоллекцияЭлементовСхемыРегламента();
	
	Если ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ИОП
		Или ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДП
		Или ТипЭлементаРегламента = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки_ПДО Тогда
		ТипЭлементаРодителя = Перечисления.ТипыЭлементовРегламентаЭДО.ДопСведенияПоРезультатамПриемки;
	Иначе
		ТипЭлементаРодителя = Перечисления.ТипыЭлементовРегламентаЭДО.ИнформацияОтправителя;
	КонецЕсли;
	
	ЭлементРодитель = РегламентыЭДО.НайтиЭлементСхемыРегламента(СхемаРегламента, ТипЭлементаРодителя, Истина);
	
	Если ЭлементРодитель <> Неопределено Тогда
		РегламентыЭДО.ВставитьЭлементСхемыРегламента(ЭлементыСхемы, ЭлементРодитель, ТипЭлементаРегламента, Истина);
	КонецЕсли;
	
	Возврат ЭлементыСхемы;
	
КонецФункции

#КонецОбласти

#КонецОбласти
