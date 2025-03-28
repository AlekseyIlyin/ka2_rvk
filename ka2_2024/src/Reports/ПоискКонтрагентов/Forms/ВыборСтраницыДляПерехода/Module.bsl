///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Параметры.МаксимальноеЗначение) Тогда
		Элементы.НомерСтраницы.МаксимальноеЗначение = Параметры.МаксимальноеЗначение;
	КонецЕсли;
	
	НомерСтраницы = Параметры.ТекущееЗначение;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Ок(Команда)
	
	Если НомерСтраницы > Параметры.ДоступноСтраниц Тогда
		
		ТекстПредупреждения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Переход на страницу с номером больше %1 не поддерживается.'"),
			Параметры.ДоступноСтраниц);
		ПоказатьПредупреждение(, ТекстПредупреждения);
		
		Возврат;
		
	КонецЕсли;
	
	Закрыть(НомерСтраницы);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти
