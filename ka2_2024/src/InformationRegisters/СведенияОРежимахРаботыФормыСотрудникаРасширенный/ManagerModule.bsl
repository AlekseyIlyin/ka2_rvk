#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляРегламентированныхДанных(Настройки);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьНастройкиРежимов(Знач МассивРежимовРаботы) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ЗначенияФункциональныхОпций = Новый Структура;
	ЗначенияФункциональныхОпций.Вставить("ИспользоватьВоинскийУчет", Ложь);
	ЗначенияФункциональныхОпций.Вставить("ИспользоватьНачисленияПоДоговорам", Ложь);
	ЗначенияФункциональныхОпций.Вставить("ИспользоватьНачислениеЗарплаты", Ложь);
	ЗначенияФункциональныхОпций.Вставить("ИспользоватьВыплатыПоДоговорамОпеки", Ложь);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	НастройкиВоинскогоУчета.ИспользоватьВоинскийУчет КАК ИспользоватьВоинскийУчет
		|ПОМЕСТИТЬ ВТНастройкиВоинскогоУчета
		|ИЗ
		|	РегистрСведений.НастройкиВоинскогоУчета КАК НастройкиВоинскогоУчета
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	НастройкиВыплатПоДоговорамОпеки.ИспользоватьВыплатыПоДоговорамОпеки КАК ИспользоватьВыплатыПоДоговорамОпеки
		|ПОМЕСТИТЬ ВТНастройкиВыплатПоДоговорамОпеки
		|ИЗ
		|	РегистрСведений.НастройкиВыплатПоДоговорамОпеки КАК НастройкиВыплатПоДоговорамОпеки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	ИспользоватьНачислениеЗарплаты.Значение
		|		И НастройкиРасчетаЗарплаты.ИспользоватьНачисленияПоДоговорам КАК ИспользоватьНачисленияПоДоговорам
		|ПОМЕСТИТЬ ВТНастройкиРасчетаЗарплаты
		|ИЗ
		|	РегистрСведений.НастройкиРасчетаЗарплаты КАК НастройкиРасчетаЗарплаты
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Константа.ИспользоватьНачислениеЗарплаты КАК ИспользоватьНачислениеЗарплаты
		|		ПО (ИСТИНА)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МАКСИМУМ(ЕСТЬNULL(НастройкиВоинскогоУчета.ИспользоватьВоинскийУчет, ЛОЖЬ)) КАК ИспользоватьВоинскийУчет,
		|	МАКСИМУМ(ЕСТЬNULL(НастройкиВыплатПоДоговорамОпеки.ИспользоватьВыплатыПоДоговорамОпеки, ЛОЖЬ)) КАК ИспользоватьВыплатыПоДоговорамОпеки,
		|	МАКСИМУМ(ЕСТЬNULL(НастройкиРасчетаЗарплаты.ИспользоватьНачисленияПоДоговорам, ЛОЖЬ)) КАК ИспользоватьНачисленияПоДоговорам,
		|	ИспользоватьНачислениеЗарплаты.Значение КАК ИспользоватьНачислениеЗарплаты
		|ИЗ
		|	ВТНастройкиВоинскогоУчета КАК НастройкиВоинскогоУчета
		|		ПОЛНОЕ СОЕДИНЕНИЕ ВТНастройкиРасчетаЗарплаты КАК НастройкиРасчетаЗарплаты
		|		ПО (ИСТИНА)
		|		ПОЛНОЕ СОЕДИНЕНИЕ ВТНастройкиВыплатПоДоговорамОпеки КАК НастройкиВыплатПоДоговорамОпеки
		|		ПО (ИСТИНА)
		|		ПОЛНОЕ СОЕДИНЕНИЕ Константа.ИспользоватьНачислениеЗарплаты КАК ИспользоватьНачислениеЗарплаты
		|		ПО (ИСТИНА)
		|
		|СГРУППИРОВАТЬ ПО
		|	ИспользоватьНачислениеЗарплаты.Значение";
		
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		ЗаполнитьЗначенияСвойств(ЗначенияФункциональныхОпций, Выборка);
		
	КонецЕсли; 
	
	Набор = РегистрыСведений.СведенияОРежимахРаботыФормыСотрудникаРасширенный.СоздатьНаборЗаписей();
	Набор.Прочитать();
	
	УдаляемыеЗаписи = Новый Массив;
	
	Для каждого Запись Из Набор Цикл
		
		Если НЕ ЗначениеЗаполнено(Запись.РежимРаботы) Тогда
			УдаляемыеЗаписи.Добавить(Запись);
		КонецЕсли; 
		
		ИндексРежима = МассивРежимовРаботы.Найти(Запись.РежимРаботы);
		Если ИндексРежима <> Неопределено Тогда
			МассивРежимовРаботы.Удалить(ИндексРежима);
		КонецЕсли; 
		
		ЗаполнитьЗаписьРежимаРаботыФормы(Запись, ЗначенияФункциональныхОпций);
		
	КонецЦикла;
	
	Для каждого УдаляемаяЗапись Из УдаляемыеЗаписи Цикл
		Набор.Удалить(УдаляемаяЗапись);
	КонецЦикла;
	
	Если МассивРежимовРаботы.Количество() > 0 Тогда
		
		Для каждого РежимРаботы Из МассивРежимовРаботы Цикл
			
			Запись = Набор.Добавить();
			Запись.РежимРаботы = РежимРаботы;
			
			ЗаполнитьЗаписьРежимаРаботыФормы(Запись, ЗначенияФункциональныхОпций);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Набор.Записать();
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

Процедура ЗаполнитьЗаписьРежимаРаботыФормы(Запись, ЗначенияФункциональныхОпций)
	
	Если Запись.РежимРаботы = Перечисления.РежимыРаботыФормыСотрудника.Сотрудник Тогда
		
		Запись.ИспользоватьНачисленияПоДоговорамВФормеСотрудника = Ложь;
		Запись.ИспользоватьВоинскийУчетВФормеСотрудника = ЗначенияФункциональныхОпций.ИспользоватьВоинскийУчет;
		Запись.ИспользоватьЛичныеДанныеВФормеСотрудника = Истина;
		
	ИначеЕсли Запись.РежимРаботы = Перечисления.РежимыРаботыФормыСотрудника.ФизическоеЛицо Тогда
		
		Запись.ИспользоватьНачисленияПоДоговорамВФормеСотрудника = Ложь;
		Запись.ИспользоватьВоинскийУчетВФормеСотрудника = Ложь;
		Запись.ИспользоватьЛичныеДанныеВФормеСотрудника = Ложь;
		
	ИначеЕсли Запись.РежимРаботы = Перечисления.РежимыРаботыФормыСотрудника.СотрудникОформленныйПоТрудовомуДоговору Тогда
		
		Запись.ИспользоватьНачисленияПоДоговорамВФормеСотрудника = Ложь;
		Запись.ИспользоватьВоинскийУчетВФормеСотрудника = ЗначенияФункциональныхОпций.ИспользоватьВоинскийУчет;
		Запись.ИспользоватьЛичныеДанныеВФормеСотрудника = Истина;
		
	ИначеЕсли Запись.РежимРаботы = Перечисления.РежимыРаботыФормыСотрудника.СотрудникОформленныйПоДоговоруГПХ Тогда
		
		Запись.ИспользоватьНачисленияПоДоговорамВФормеСотрудника = ЗначенияФункциональныхОпций.ИспользоватьНачисленияПоДоговорам;
		Запись.ИспользоватьВоинскийУчетВФормеСотрудника = Ложь;
		Запись.ИспользоватьЛичныеДанныеВФормеСотрудника = ЗначенияФункциональныхОпций.ИспользоватьВыплатыПоДоговорамОпеки;
		
	ИначеЕсли Запись.РежимРаботы = Перечисления.РежимыРаботыФормыСотрудника.СотрудникОформленныйПоТрудовомуДоговоруИДоговоруГПХ Тогда
		
		Запись.ИспользоватьНачисленияПоДоговорамВФормеСотрудника = ЗначенияФункциональныхОпций.ИспользоватьНачисленияПоДоговорам;
		Запись.ИспользоватьВоинскийУчетВФормеСотрудника = ЗначенияФункциональныхОпций.ИспользоватьВоинскийУчет;
		Запись.ИспользоватьЛичныеДанныеВФормеСотрудника = Истина;
		
	КонецЕсли; 
		
КонецПроцедуры

#КонецОбласти

#КонецЕсли