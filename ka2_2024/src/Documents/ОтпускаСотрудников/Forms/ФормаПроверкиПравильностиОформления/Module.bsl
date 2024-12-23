#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не ЗначениеЗаполнено(Параметры.ДанныеОРасхождениях) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли; 
	
	Для Каждого ОписаниеРасхождения Из Параметры.ДанныеОРасхождениях Цикл
		ЗаполнитьЗначенияСвойств(РезультатыПроверки.Добавить(), ОписаниеРасхождения);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРезультатыПроверки

&НаКлиенте
Процедура РезультатыПроверкиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "РезультатыПроверкиПредставлениеОшибки" Тогда
		
		ПараметрыПечати = Новый Структура;
		ПараметрыПечати.Вставить("ДатаОстатков", Элемент.ТекущиеДанные.ДатаНачала);
		
		МассивОбъектов = Новый Массив;
		МассивОбъектов.Добавить(Элемент.ТекущиеДанные.Сотрудник);
		
		УправлениеПечатьюКлиент.ВыполнитьКомандуПечати("Справочник.Сотрудники", "СправкаПоОтпускамСотрудника", 
				МассивОбъектов, ЭтаФорма, ПараметрыПечати);
				
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

