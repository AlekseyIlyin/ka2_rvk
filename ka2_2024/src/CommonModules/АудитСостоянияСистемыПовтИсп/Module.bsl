// @strict-types

#Область ПрограммныйИнтерфейс

// Заполнить группы проверок для регистрации.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - см. КонтрольВеденияУчетаСлужебныйПовтИсп.НоваяТаблицаГруппПроверок
Функция ЗаполнитьГруппыПроверокДляРегистрации() Экспорт

	ТаблицаГруппПроверок = АудитСостоянияСистемы.ТаблицаГруппПроверокСостоянияСистемы();
	АудитСостоянияСистемыПереопределяемый.ЗаполнитьГруппыПроверокДляРегистрации(ТаблицаГруппПроверок);
	
	ГруппыПроверок = КонтрольВеденияУчетаСлужебныйПовтИсп.НоваяТаблицаГруппПроверок().СкопироватьКолонки();
	
	Для Каждого ТекСтр Из ТаблицаГруппПроверок Цикл
		
		НовСтр = ГруппыПроверок.Добавить();
		ЗаполнитьЗначенияСвойств(НовСтр, ТекСтр);
		
		НовСтр.ИдентификаторГруппы = ТекСтр.ИдентификаторРодителя;
		
	КонецЦикла;
	
	Возврат ГруппыПроверок;
	
КонецФункции

// Заполнить проверки для регистрации.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - см. КонтрольВеденияУчетаСлужебныйПовтИсп.НоваяТаблицаПроверок
Функция ЗаполнитьПроверкиДляРегистрации() Экспорт

	ТаблицаПроверок = АудитСостоянияСистемы.ТаблицаПроверокСостоянияСистемы();
	АудитСостоянияСистемыПереопределяемый.ЗаполнитьПроверкиДляРегистрации(ТаблицаПроверок);
	
	Проверки = КонтрольВеденияУчетаСлужебныйПовтИсп.НоваяТаблицаПроверок().СкопироватьКолонки();
	Проверки.Колонки.Добавить("ВыполняетсяТолькоВКонтексте", Новый ОписаниеТипов("Булево"));
	Проверки.Колонки.Добавить("ВажностьПроблемы",  Новый ОписаниеТипов("ПеречислениеСсылка.ВажностьПроблемыУчета"));
	Проверки.Колонки.Добавить("Использование",  Новый ОписаниеТипов("Булево"));
	Проверки.Колонки.Добавить("СпособВыполнения",  Новый ОписаниеТипов("ПеречислениеСсылка.СпособыВыполненияПроверки"));
	Проверки.Колонки.Добавить("Обработчик",  Новый ОписаниеТипов("Строка"));
	Проверки.Колонки.Добавить("ДетализацияДоОрганизации",  Новый ОписаниеТипов("Булево"));
	Проверки.Колонки.Добавить("ДетализацияДоПериода",  Новый ОписаниеТипов("Булево"));
	Проверки.Колонки.Добавить("ИсходныйОбработчик",  Новый ОписаниеТипов("Строка"));
	
	Если ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		ЛимитПроблем = ЗакрытиеМесяцаСервер.КоличествоРегистрируемыхОднотипныхОшибок();
	Иначе
		ЛимитПроблем = 100; // значение по умолчанию
	КонецЕсли;
	
	УниверсальныйОбработчик = "АудитСостоянияСистемы.УниверсальныйОбработчикПроверокЗакрытияМесяца";
	
	Для Каждого ТекСтр Из ТаблицаПроверок Цикл
		
		НовСтр = Проверки.Добавить();
		ЗаполнитьЗначенияСвойств(НовСтр, ТекСтр);
		
		НовСтр.ИдентификаторГруппы = ТекСтр.ИдентификаторРодителя;
		
		НовСтр.БезОбработчикаПроверки = ПустаяСтрока(ТекСтр.Обработчик);
		НовСтр.ИсходныйОбработчик = ТекСтр.Обработчик;
		НовСтр.ОбработчикПроверки = ?(НовСтр.БезОбработчикаПроверки, "", УниверсальныйОбработчик);
		НовСтр.Обработчик = ?(НовСтр.БезОбработчикаПроверки, "", УниверсальныйОбработчик);
		НовСтр.ЗапрещеноИзменениеВажности = НЕ ТекСтр.ВозможноИзменениеВажности;
		НовСтр.ИдентификаторРодителя = "";
		
		НовСтр.ВажностьПроблемы   = ТекСтр.ВажностьПроблемы;
		НовСтр.ДатаНачалаПроверки = ТекСтр.ДатаНачалаПроверки;
		НовСтр.Использование 	= Истина;
		НовСтр.СпособВыполнения = Перечисления.СпособыВыполненияПроверки.Контекстно;
		НовСтр.ЛимитПроблем 	= ЛимитПроблем;
		
	КонецЦикла;
	
	Возврат Проверки;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти
