#Область СлужебныйПрограммныйИнтерфейс

Процедура ФИООбработкаВыбора(УправляемаяФорма, Элемент, ВыбранноеЗначение, СтандартнаяОбработка) Экспорт
	
	#Если ВебКлиент Тогда
	 	Возврат;
	#КонецЕсли
	
	СоставляющиеФИО = СтрРазделить(ВыбранноеЗначение, " ", Истина);
	Если СоставляющиеФИО.Количество() < 3 Тогда
		Элемент.ОбновитьТекстРедактирования();
		Элемент.ВыделенныйТекст = ВыбранноеЗначение;
		УправляемаяФорма.ФИОПриИзменении(Элемент);
		СтандартнаяОбработка = Ложь;
	КонецЕсли;

КонецПроцедуры

Процедура ФИОАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка) Экспорт
	
	#Если ВебКлиент Тогда
	 	Возврат;
	#КонецЕсли
	
	Если ДанныеВыбора = Неопределено
		И СтрЗаканчиваетсяНа(Текст, " ") Тогда
		
		Текст = СокрП(Текст);
	Иначе
		АвтоПодборПоДаннымФИО("ФИО", Текст, ДанныеВыбора, СтандартнаяОбработка)
	КонецЕсли;
КонецПроцедуры

Процедура ФамилияАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка) Экспорт
	
	#Если ВебКлиент Тогда
	 	Возврат;
	#КонецЕсли
	
	Если ДанныеВыбора = Неопределено
		И СтрЗаканчиваетсяНа(Текст, " ") Тогда
		
		Текст = СокрП(Текст);
	Иначе
		АвтоПодборПоДаннымФИО("Фамилия", Текст, ДанныеВыбора, СтандартнаяОбработка)
	КонецЕсли;
КонецПроцедуры

Процедура ИмяАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка) Экспорт
	
	#Если ВебКлиент Тогда
	 	Возврат;
	#КонецЕсли
	
	Если ДанныеВыбора = Неопределено
		И СтрЗаканчиваетсяНа(Текст, " ") Тогда
		
		Текст = СокрП(Текст);
	Иначе
		АвтоПодборПоДаннымФИО("Имя", Текст, ДанныеВыбора, СтандартнаяОбработка)
	КонецЕсли;
КонецПроцедуры

Процедура ОтчествоАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка) Экспорт
	
	#Если ВебКлиент Тогда
	 	Возврат;
	#КонецЕсли
	
	Если ДанныеВыбора = Неопределено
		И СтрЗаканчиваетсяНа(Текст, " ") Тогда
		
		Текст = СокрП(Текст);
	Иначе
		АвтоПодборПоДаннымФИО("Отчество", Текст, ДанныеВыбора, СтандартнаяОбработка)
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура АвтоПодборПоДаннымФИО(РежимПоиска, Текст, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не ПустаяСтрока(Текст)
		И СтрДлина(Текст) >= 2
		И ОбщегоНазначенияКлиент.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПодборФИО") Тогда
		
		Если РежимПоиска = "ФИО" Тогда
			ДанныеФИО = Новый Структура("Представление", Текст);
		Иначе
			ДанныеФИО = Новый Структура(РежимПоиска, Текст);
		КонецЕсли;
		ОбщийМодульПодборФИОКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодборФИОКлиент");
		ДанныеКлассификатора = ОбщийМодульПодборФИОКлиент.Подобрать(РежимПоиска, ДанныеФИО);
		Если ЗначениеЗаполнено(ДанныеКлассификатора) Тогда
			Если ДанныеВыбора = Неопределено Тогда
				ДанныеВыбора = Новый СписокЗначений;
			КонецЕсли;
			Для Каждого ЗначениеКлассификатора Из ДанныеКлассификатора Цикл
				ДанныеВыбора.Добавить(ЗначениеКлассификатора, ЗначениеКлассификатора);
			КонецЦикла;
			СтандартнаяОбработка = Ложь;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
