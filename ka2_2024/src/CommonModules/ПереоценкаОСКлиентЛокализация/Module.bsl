////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Переоценка ОС".
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Параметры:
// 	Элемент - ПолеФормы - 
// 	Форма - ФормаКлиентскогоПриложения -
Процедура ПриИзмененииРеквизита(Элемент, Форма) Экспорт

	ДополнительныеПараметры = Неопределено;
	ТребуетсяВызовСервера = Ложь;
	ПродолжитьИзменениеРеквизита = Истина;
	
	//++ Локализация
	
	Элементы = Форма.Элементы;
	
	Если Элемент.Имя = Элементы.ДокументНаОсновании.Имя Тогда
		
		ДокументНаОснованииПриИзменении(Форма, ПродолжитьИзменениеРеквизита);
		
	КонецЕсли; 
	
	//-- Локализация
	
	Если ПродолжитьИзменениеРеквизита Тогда
		
		ОбщегоНазначенияУТКлиент.ПродолжитьИзменениеРеквизита(
			Форма, 
			Элемент.Имя, 
			ТребуетсяВызовСервера,
			ДополнительныеПараметры);
	
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеЗаписи(Форма, ПараметрыЗаписи) Экспорт

	//++ Локализация
	Объект = Форма.Объект;
	
	Если ЗначениеЗаполнено(Объект.ДокументОснование)
		И ТипЗнч(Объект.ДокументОснование) = Тип("ДокументСсылка.ИнвентаризацияОС") Тогда
		Оповестить("ЗаписьДокументаНаОснованииИнвентаризации",, Объект.Ссылка);
	КонецЕсли;
	//-- Локализация
	
КонецПроцедуры
 
//++ Локализация

Процедура ДокументНаОснованииПриИзменении(Форма, ПродолжитьИзменениеРеквизита)
	
	ПродолжитьИзменениеРеквизита = Ложь;
	
	Объект = Форма.Объект;
	
	Если Объект.ДокументНаОсновании Тогда
		
		ОтборСписка = Новый Структура;
		ОтборСписка.Вставить("Проведен", Истина);
		Если ЗначениеЗаполнено(Объект.Организация) Тогда
			ОтборСписка.Вставить("Организация", Объект.Организация);
		КонецЕсли;
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Отбор", ОтборСписка);
		
		ПараметрыОповещения = Новый Структура;
		ПараметрыОповещения.Вставить("Форма", Форма);
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ДокументНаОснованииПриИзмененииЗавершение", ЭтотОбъект, ПараметрыОповещения);
		ОткрытьФорму("Документ.ИнвентаризацияОС.ФормаВыбора", ПараметрыФормы,,,,, ОписаниеОповещения);
		
	Иначе
		Объект.ДокументОснование = Неопределено;
	КонецЕсли; 
	
КонецПроцедуры

Процедура ДокументНаОснованииПриИзмененииЗавершение(РезультатЗакрытия, ДополнительныеПараметры) Экспорт

	Форма = ДополнительныеПараметры.Форма;
	Объект = Форма.Объект;
	
	Если ЗначениеЗаполнено(РезультатЗакрытия) Тогда
		Объект.ДокументОснование = РезультатЗакрытия;
	Иначе
		Объект.ДокументНаОсновании = Ложь;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект.ДокументОснование) Тогда
		ТекстВопроса = НСтр("ru = 'Заполнить документ по инвентаризации?'");
		ПараметрыОповещения = Новый Структура;
		ПараметрыОповещения.Вставить("Форма", Форма);
		ОписаниеОповещения = Новый ОписаниеОповещения("ЗаполнитьПоДаннымОснованияЗавершение", ЭтотОбъект, ПараметрыОповещения);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет); 
	КонецЕсли; 
	
КонецПроцедуры

Процедура ЗаполнитьПоДаннымОснованияЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		
		ОбщегоНазначенияУТКлиент.ПродолжитьИзменениеРеквизита(
			ДополнительныеПараметры.Форма, 
			"ДокументНаОсновании", 
			Истина);
			
	КонецЕсли;
	
КонецПроцедуры

//-- Локализация

#КонецОбласти
