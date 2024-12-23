
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьПараметрыПоПолучателю();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОтправители

&НаКлиенте
Процедура ОтправителиВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВыбратьПолучателя();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправителиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВыбратьПолучателя();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбратьПолучателя()
	
	ТекущиеДанные = Элементы.Отправители.ТекущиеДанные;
	Закрыть(Новый Структура("Отправитель, ИдентификаторОтправителя",
		ТекущиеДанные.Отправитель, ТекущиеДанные.ИдентификаторОтправителя));
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПараметрыПоПолучателю()
	
	ПустойДоговор = ОбменСКонтрагентамиИнтеграция.ВсеПустыеЗначенияДоговораСКонтрагентомЭДО();
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Отправители, "ПустойДоговор", ПустойДоговор);
	
	ИспользуетсяПрямойОбменЭлектроннымиДокументами = НастройкиЭДО.ИспользуетсяПрямойОбменЭлектроннымиДокументами();
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Отправители, "ИспользоватьПрямойОбмен", ИспользуетсяПрямойОбменЭлектроннымиДокументами);
	
КонецПроцедуры

#КонецОбласти