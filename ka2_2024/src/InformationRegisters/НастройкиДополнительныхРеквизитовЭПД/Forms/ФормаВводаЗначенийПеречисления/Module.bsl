&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Перечисления") Тогда	
		Перечисления.ЗагрузитьЗначения(СтрРазделить(Параметры.Перечисления, "|", Ложь));
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	Закрыть(СтрСоединить(Перечисления.ВыгрузитьЗначения(), "|"));

КонецПроцедуры

