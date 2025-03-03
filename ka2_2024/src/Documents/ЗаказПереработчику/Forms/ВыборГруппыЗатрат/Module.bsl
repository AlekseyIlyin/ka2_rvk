#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ЗаголовокГруппы = Параметры.ЗаголовокГруппы;
	ИмяПоляГруппаЗатрат = Параметры.ИмяПоляГруппаЗатрат;
	
	Если Параметры.ГруппировкаЗатрат = Перечисления.ГруппировкиЗатратВЗаказеПереработчику.ПоПродукции Тогда
		Заголовок = НСтр("ru = 'Выбор продукции'");
	ИначеЕсли Параметры.ГруппировкаЗатрат = Перечисления.ГруппировкиЗатратВЗаказеПереработчику.ПоСпецификациям Тогда
		Заголовок = НСтр("ru = 'Выбор спецификации продукции'");
	//++ Устарело_Производство21	
	ИначеЕсли Параметры.ГруппировкаЗатрат = Перечисления.ГруппировкиЗатратВЗаказеПереработчику.ПоЗаказамНаПроизводство Тогда
		Заголовок = НСтр("ru = 'Выбор заказа'");
	//-- Устарело_Производство21	
	ИначеЕсли Параметры.ГруппировкаЗатрат = Перечисления.ГруппировкиЗатратВЗаказеПереработчику.ПоЭтапамПроизводства Тогда
		Заголовок = НСтр("ru = 'Выбор этапа'");
	КонецЕсли; 
	
	Элементы.СписокГруппГруппаЗатрат.Заголовок = ЗаголовокГруппы;
	
	ТекущаяСтрока = Неопределено;
	Для каждого СтрокаУслуга Из Параметры.Услуги Цикл
		СтрокаГруппа = СписокГрупп.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаГруппа, СтрокаУслуга);
		Если Параметры.НомерГруппыЗатрат = СтрокаУслуга[ИмяПоляГруппаЗатрат] Тогда
			ТекущаяСтрока = СтрокаГруппа.ПолучитьИдентификатор();
		КонецЕсли; 
	КонецЦикла;
	
	Если ТекущаяСтрока <> Неопределено Тогда
		Элементы.СписокГрупп.ТекущаяСтрока = ТекущаяСтрока;
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура СписокГруппВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОбработатьВыборГруппы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьГруппу(Команда)
	
	ОбработатьВыборГруппы();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработатьВыборГруппы()

	ТекущиеДанные = Элементы.СписокГрупп.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыВыбора = Новый Структура("ГруппаЗатрат,Спецификация,Распоряжение,НомерГруппыЗатрат");
	ЗаполнитьЗначенияСвойств(ПараметрыВыбора, ТекущиеДанные);

	Закрыть(ПараметрыВыбора);

КонецПроцедуры

#КонецОбласти
