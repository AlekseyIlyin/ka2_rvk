////////////////////////////////////////////////////////////////////////////////
// УправлениеШтатнымРасписаниемВызовСервера:
//  
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура ОбработкаПолученияДанныхВыбораСправочникаШтатноеРасписание(ДанныеВыбора, Параметры, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	*
		|ИЗ
		|	Справочник.ШтатноеРасписание КАК ШтатноеРасписание
		|ГДЕ
		|	НЕ ШтатноеРасписание.ГруппаПозицийПодразделения
		|	И ШтатноеРасписание.Владелец = &Владелец
		|	И ШтатноеРасписание.Подразделение = &Подразделение
		|	И ШтатноеРасписание.ДатаУтверждения <= &ДатаНачалаПримененияОтбора
		|	И (ШтатноеРасписание.ДатаЗакрытия = ДатаВремя(1, 1, 1)
		|		ИЛИ ШтатноеРасписание.ДатаЗакрытия > &ДатаОкончанияПримененияОтбора)
		|	И &ДополнительноеУсловие";
	
	Если Параметры.Отбор.Свойство("Владелец")
		И ЗначениеЗаполнено(Параметры.Отбор.Владелец) Тогда
		
		Запрос.УстановитьПараметр("Владелец", Параметры.Отбор.Владелец);
		
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ШтатноеРасписание.Владелец = &Владелец", "(ИСТИНА)");
	КонецЕсли;
	Параметры.Отбор.Удалить("Владелец");
	
	Если Параметры.Отбор.Свойство("Подразделение")
		И ЗначениеЗаполнено(Параметры.Отбор.Подразделение) Тогда
		
		Запрос.УстановитьПараметр("Подразделение", Параметры.Отбор.Подразделение);
		
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ШтатноеРасписание.Подразделение = &Подразделение", "(ИСТИНА)");
	КонецЕсли;
	Параметры.Отбор.Удалить("Подразделение");
	
	Если Параметры.Отбор.Свойство("ДатаПримененияОтбора")
		И ЗначениеЗаполнено(Параметры.Отбор.ДатаПримененияОтбора) Тогда
		
		Запрос.УстановитьПараметр("ДатаНачалаПримененияОтбора", Параметры.Отбор.ДатаПримененияОтбора);
		Запрос.УстановитьПараметр("ДатаОкончанияПримененияОтбора", Параметры.Отбор.ДатаПримененияОтбора);
		
	Иначе
		Запрос.УстановитьПараметр("ДатаНачалаПримененияОтбора", ЗарплатаКадрыПериодическиеРегистры.МаксимальнаяДата());
		Запрос.УстановитьПараметр("ДатаОкончанияПримененияОтбора", '00010101');
	КонецЕсли;
	Параметры.Отбор.Удалить("ДатаПримененияОтбора");
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") Тогда
		МодульГосударственнаяСлужба = ОбщегоНазначения.ОбщийМодуль("ГосударственнаяСлужба");
		МодульГосударственнаяСлужба.УточнитьЗапросДанныхВыбораСправочникаШтатноеРасписание(Запрос, Параметры);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ОрганизационнаяСтруктура") Тогда
		МодульОрганизационнаяСтруктура = ОбщегоНазначения.ОбщийМодуль("ОрганизационнаяСтруктура");
		МодульОрганизационнаяСтруктура.УточнитьЗапросДанныхВыбораСправочникаШтатноеРасписание(Запрос, Параметры);
	КонецЕсли;
	
	ЗарплатаКадры.ЗаполнитьДанныеВыбораСправочника(ДанныеВыбора, Метаданные.Справочники.Должности, Параметры, Запрос, "ШтатноеРасписание");
	
КонецПроцедуры

Функция ПолноеИмяМетаданныхДокумента(СсылкаНаДокумент) Экспорт
	
	МетаданныеРегистратора = СсылкаНаДокумент.Метаданные();
	Возврат МетаданныеРегистратора.ПолноеИмя();
	
КонецФункции

Процедура ПодразделенияОрганизацийУстановитьОтборПоУмолчаниюПараметровДанныхВыбора(Параметры) Экспорт
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьШтатноеРасписание") Тогда
		
		Если Не Параметры.Свойство("ТолькоДействующиеПодразделения")
			Или Параметры.ТолькоДействующиеПодразделения Тогда
			
			Если Не Параметры.Отбор.Свойство("Сформировано") Тогда
				Параметры.Отбор.Вставить("Сформировано", Истина);
			КонецЕсли; 
			
			Если Не Параметры.Отбор.Свойство("Расформировано") Тогда
				Параметры.Отбор.Вставить("Расформировано", Ложь);
			КонецЕсли; 
			
		КонецЕсли;
		
		Если Параметры.Свойство("ПоказыватьНовыеПодразделения")
			И Параметры.ПоказыватьНовыеПодразделения Тогда
			
			Если Не Параметры.Отбор.Свойство("Расформировано") Тогда
				Параметры.Отбор.Вставить("Расформировано", Ложь);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
