
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Параметры.ФорматОтвета) Тогда
		ФорматОтвета = XMLСтрока(Параметры.ФорматОтвета);
	Иначе
		ФорматОтвета = Перечисления.ФорматОтветаНаЗапросИОН.PDF;
	КонецЕсли;
	
	РазрешенXLSв5_07 = Документы.ЗапросНаИнформационноеОбслуживаниеНалогоплательщика.РазрешенXLSв5_07(Параметры.ВидУслуги);
		
	Если Параметры.ЭтоФормат5_05 ИЛИ Параметры.ЭтоФормат5_07 И НЕ РазрешенXLSв5_07 Тогда
		Элемент = Элементы.ФорматОтвета.СписокВыбора.НайтиПоЗначению("XLS");
		Элементы.ФорматОтвета.СписокВыбора.Удалить(Элемент);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	Результат = ПредопределенноеЗначение("Перечисление.ФорматОтветаНаЗапросИОН." + ФорматОтвета);
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
