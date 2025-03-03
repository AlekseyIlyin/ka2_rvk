
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	// Обработчик подсистемы запрета редактирования реквизитов объектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
	
	ОписаниеТиповМаркетинговоеМероприятие = Новый ОписаниеТипов("СправочникСсылка.МаркетинговыеМероприятия");
	ИспользоватьМаркетинговыеМероприятия = ПолучитьФункциональнуюОпцию("ИспользоватьМаркетинговыеМероприятия");
	ТипМаркетинговоеМероприятие = Тип("СправочникСсылка.МаркетинговыеМероприятия");
	
	ИспользоватьПартнеровКакКонтрагентов = ПолучитьФункциональнуюОпцию("ИспользоватьПартнеровКакКонтрагентов");
	
	Для каждого ДоступныйТип Из Метаданные.ПланыВидовХарактеристик.КаналыРекламныхВоздействий.Тип.Типы() Цикл
		
		Если (НЕ (ДоступныйТип = ТипМаркетинговоеМероприятие
			И НЕ ИспользоватьМаркетинговыеМероприятия))
			ИЛИ (Объект.ТипЗначения = ОписаниеТиповМаркетинговоеМероприятие
			И ДоступныйТип = ТипМаркетинговоеМероприятие) Тогда
			
			МассивТипов = Новый Массив;
			МассивТипов.Добавить(ДоступныйТип);
			Если ДоступныйТип = Тип("СправочникСсылка.Партнеры") И ИспользоватьПартнеровКакКонтрагентов Тогда
				Элементы.ТипЗначения.СписокВыбора.Добавить(Новый ОписаниеТипов(МассивТипов), НСтр("ru = 'Контрагент'"));
			Иначе
				Элементы.ТипЗначения.СписокВыбора.Добавить(Новый ОписаниеТипов(МассивТипов));
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если Объект.Ссылка.Пустая()
		И НЕ Объект.ТипЗначения.Типы().Количество() = 1 Тогда
		Объект.ТипЗначения = Элементы.ТипЗначения.СписокВыбора[0].Значение;
	КонецЕсли;
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборотБазоваяФункциональность.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец ИнтеграцияС1СДокументооборотом
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если НЕ ЗначениеЗаполнено(Объект.ТипЗначения) Тогда
	
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не указан тип воздействия.'"),"ТипЗначения","Объект.ТипЗначения");
		Отказ = Истина;
	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборотБазоваяФункциональность.ПередЗаписьюНаСервере(
		ЭтотОбъект,
		ТекущийОбъект,
		ПараметрыЗаписи);
	// Конец ИнтеграцияС1СДокументооборотом
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// Обработчик подсистемы запрета редактирования реквизитов объектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	ОбщегоНазначенияУТКлиент.РазрешитьРедактированиеРеквизитовОбъекта(ЭтаФорма);
	
КонецПроцедуры

// ИнтеграцияС1СДокументооборотом
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	ИнтеграцияС1СДокументооборотБазоваяФункциональностьКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(
		Команда,
		ЭтотОбъект,
		Объект);
	
КонецПроцедуры
// Конец ИнтеграцияС1СДокументооборотом

#КонецОбласти
