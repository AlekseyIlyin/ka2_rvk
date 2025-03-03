
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Параметры.Свойство("Отбор") И Параметры.Отбор.Свойство("Организация") Тогда
		Организация = Параметры.Отбор.Организация;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "Организация", Организация);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ЗавершитьВыбор();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьПакет(Команда)
	
	ЗавершитьВыбор();
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьНомераПакетов(Команда)
	
	РассчитатьНомераПакетовНаСервере();
	Элементы.Список.Обновить();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗавершитьВыбор()

	МассивСтрок = ОбщегоНазначенияУТКлиент.ПроверитьПолучитьВыделенныеВСпискеСсылки(Элементы.Список);
	Если МассивСтрок.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеСтроки = Элементы.Список.ДанныеСтроки(МассивСтрок[0]);
	ОповеститьОВыборе(ДанныеСтроки.НомерПакета);

КонецПроцедуры

&НаСервере
Процедура РассчитатьНомераПакетовНаСервере()

	Если ЗначениеЗаполнено(Организация) Тогда
		СписокОрганизаций = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Организация);
	Иначе
		СписокОрганизаций = Неопределено;
	КонецЕсли; 
	
	РегистрыСведений.ПакетыАмортизацииОС.СоздатьПакетыАмортизации(СписокОрганизаций);

КонецПроцедуры

#КонецОбласти
