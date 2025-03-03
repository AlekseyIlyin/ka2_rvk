#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);

КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Количество() = 1 Тогда
		
		ПерваяЗапись = Получить(0);
		
		ОбменДанными.Получатели.АвтоЗаполнение = Ложь;
		ОбменДанными.Получатели.Очистить();
		
		Запрос = Новый Запрос;
		
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ПодключаемоеОборудование.УзелИнформационнойБазы КАК УзелОбмена
		|ИЗ
		|	Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
		|ГДЕ
		|	ПодключаемоеОборудование.ПравилоОбмена = &ПравилоОбмена
		|	И ПодключаемоеОборудование.УзелИнформационнойБазы <> ЗНАЧЕНИЕ(ПланОбмена.ОбменСПодключаемымОборудованиемOffline.ПустаяСсылка)";
		
		//++ Локализация
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ПодключаемоеОборудование.УзелИнформационнойБазы КАК УзелОбмена
		|ИЗ
		|	Справочник.ОфлайнОборудование КАК ПодключаемоеОборудование
		|ГДЕ
		|	ПодключаемоеОборудование.ПравилоОбмена = &ПравилоОбмена
		|	И ПодключаемоеОборудование.УзелИнформационнойБазы <> ЗНАЧЕНИЕ(ПланОбмена.ОбменСПодключаемымОборудованиемOffline.ПустаяСсылка)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПодключаемоеОборудование.УзелИнформационнойБазы КАК УзелОбмена
		|ИЗ
		|	Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
		|ГДЕ
		|	ПодключаемоеОборудование.ПравилоОбмена = &ПравилоОбмена
		|	И ПодключаемоеОборудование.УзелИнформационнойБазы <> ЗНАЧЕНИЕ(ПланОбмена.ОбменСПодключаемымОборудованиемOffline.ПустаяСсылка)";
		//-- Локализация
		
		Запрос.Текст = ТекстЗапроса;
		Запрос.УстановитьПараметр("ПравилоОбмена", ПерваяЗапись.ПравилоОбмена);
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		
		Набор = РегистрыСведений.КодыТоваровПодключаемогоОборудованияOffline.СоздатьНаборЗаписей();
		Пока Выборка.Следующий() Цикл
		
			Набор.Отбор.ПравилоОбмена.Значение = ПерваяЗапись.ПравилоОбмена;
			Набор.Отбор.ПравилоОбмена.Использование = Истина;
			
			Набор.Отбор.Код.Значение = ПерваяЗапись.Код;
			Набор.Отбор.Код.Использование = Истина;
			
			ПланыОбмена.ЗарегистрироватьИзменения(Выборка.УзелОбмена, Набор);
		
		КонецЦикла;
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецЕсли