
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Параметры.АдресТаблицыШаблонов) Или
		Не ЗначениеЗаполнено(Параметры.КоличествоДокументов)Тогда
		
		ТекстСообщения = НСтр("ru='Непосредственное открытие этой формы не предусмотрено. 
			|Для открытия формы можно воспользоваться командой ""Заполнить этапы по предыдущим заказам"" в форме документа ""Заказ поставщику""'");
		ВызватьИсключение ТекстСообщения;
		
	КонецЕсли;
	
	КоличествоДокументов = Параметры.КоличествоДокументов;
	
	ТаблицаШаблонов = ПолучитьИзВременногоХранилища(Параметры.АдресТаблицыШаблонов);
	
	Для Каждого Шаблон Из ТаблицаШаблонов Цикл
		ЗаполнитьЗначенияСвойств(ШаблоныГрафиков.Добавить(), Шаблон);
	КонецЦикла;

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТаблицаГрафиковВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.ТаблицаГрафиков.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	КодГрафика = ТекущиеДанные.КодГрафика;
	
	Закрыть(КодГрафика);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТаблицаГрафиковПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.ТаблицаГрафиков.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаИнформации = НСтр("ru='Используется в %1 из %2, дата последнего использования %3'");
	СтрокаИнформации = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		СтрокаИнформации, 
		ТекущиеДанные.ЧастотаИспользования,
		КоличествоДокументов,
		Формат(ТекущиеДанные.ДатаПоследнегоИспользования, "ДЛФ=DD"));
	
	Информация = СтрокаИнформации;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	ТекущиеДанные = Элементы.ТаблицаГрафиков.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	КодГрафика = ТекущиеДанные.КодГрафика;
	
	Закрыть(КодГрафика);
	
КонецПроцедуры

&НаКлиенте
Процедура УпорядочитьПоЧастоте(Команда)
	
	ШаблоныГрафиков.Сортировать("ЧастотаИспользования Убыв, ДатаПоследнегоИспользования Убыв");
	
	Элементы.УпорядочитьПоЧастоте.Пометка = Истина;
	Элементы.УпорядочитьПоДате.Пометка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура УпорядочитьПоДате(Команда)
	
	ШаблоныГрафиков.Сортировать("ДатаПоследнегоИспользования Убыв,ЧастотаИспользования Убыв");
	
	Элементы.УпорядочитьПоЧастоте.Пометка = Ложь;
	Элементы.УпорядочитьПоДате.Пометка = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти
