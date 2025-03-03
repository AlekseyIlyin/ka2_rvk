&НаКлиенте
Перем КонтекстЭДОКлиент;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Ответы.Параметры.УстановитьЗначениеПараметра("ОтветыСсылки", Параметры.Ответы);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриОткрытииЗавершение", ЭтотОбъект);
	ДокументооборотСКОКлиент.ПолучитьКонтекстЭДО(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	ИмяСобытияПолучения = ЭлектронныйДокументооборотСФССКлиент.ИмяСобытияОповещенияЗавершенияПолученияСообщенийИзСЭДО();
	ИмяСобытияОтправки = ЭлектронныйДокументооборотСФССКлиент.ИмяСобытияОповещенияЗавершенияОтправкиСообщенийВСЭДО();
	
	Если ИмяСобытия = ИмяСобытияПолучения
		ИЛИ ИмяСобытия = ИмяСобытияОтправки Тогда
		
		Элементы.Ответы.Обновить();
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтветыПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
	ПоказатьЗначение(, Элемент.ТекущиеДанные.Ссылка);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОтветы

&НаКлиенте
Процедура ОтветыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтветыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Поле.Имя = "ОтветыСтатусОтправки" Тогда
		КонтекстЭДОКлиент.ПоказатьФормуСтатусовОтправкиИзСписка(Элемент);
	Иначе
		ПоказатьЗначение(, Элемент.ТекущиеДанные.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтветыПередУдалением(Элемент, Отказ)
	
	Отказ = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	КонтекстЭДОКлиент = Результат.КонтекстЭДО;
	
КонецПроцедуры

#КонецОбласти
