
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Элементы.ИспользоватьПроверкуРНПТ.ТолькоПросмотр = НЕ Пользователи.ЭтоПолноправныйПользователь();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьПроверкуРНПТПриИзменении(Элемент)
	СохранитьЗначениеКонстанты();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СохранитьЗначениеКонстанты()
	
	// Сохранения значения константы.
	КонстантаМенеджер = Константы.ИспользоватьПроверкуРНПТ;
	КонстантаЗначение = НаборКонстант.ИспользоватьПроверкуРНПТ;
	
	Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
		КонстантаМенеджер.Установить(КонстантаЗначение);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

