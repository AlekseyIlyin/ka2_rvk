
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УведомленияКИК.Параметры.УстановитьЗначениеПараметра("Организация", Параметры.Организация);
	
	Для Каждого Кол Из ДанныеФормыВЗначение(ИностранныеОрганизации, Тип("ТаблицаЗначений")).Колонки Цикл 
		КолонкиРезультата.Добавить(Кол.Имя);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура УведомленияКИКПриАктивизацииСтроки(Элемент)
	ОтключитьОбработчикОжидания("УведомленияКИКПриАктивизацииСтрокиЗавершение");
	ПодключитьОбработчикОжидания("УведомленияКИКПриАктивизацииСтрокиЗавершение", 0.1, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ИностранныеОрганизацииВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Результат = Новый Структура;
	Для Каждого Кол Из КолонкиРезультата Цикл 
		Результат.Вставить(Кол.Значение, ИностранныеОрганизации.НайтиПоИдентификатору(ВыбраннаяСтрока)[Кол.Значение]);
	КонецЦикла;
	Закрыть(Результат);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УведомленияКИКПриАктивизацииСтрокиЗавершение()
	ОтключитьОбработчикОжидания("УведомленияКИКПриАктивизацииСтрокиЗавершение");
	ПерестроитьТаблицуДанныхУведомления(Элементы.УведомленияКИК.ТекущиеДанные.Уведомление);
КонецПроцедуры

&НаСервере
Процедура ПерестроитьТаблицуДанныхУведомления(Ссылка)
	ОТЧ = Новый ОписаниеТипов("Число");
	ИностранныеОрганизации.Очистить();
	Реквизиты = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, "ИмяФормы, ДанныеУведомления");
	ДанныеУведомления = Реквизиты.ДанныеУведомления.Получить();
	
	Для Каждого ЛистА Из ДанныеУведомления.ДанныеМногостраничныхРазделов.ЛистА Цикл 
		Стр = ЛистА.Значение;
		Если Не ЗначениеЗаполнено(Стр.НомерКИКЧисло) Тогда 
			Продолжить;
		КонецЕсли;
		
		НовСтр = ИностранныеОрганизации.Добавить();
		НовСтр.П0009А0000101 = "ИО-" + Формат(Стр.НомерКИКЧисло, "ЧЦ=5; ЧН=00000; ЧВН=; ЧГ=");
		Стр.Свойство("НаимОргЛат", НовСтр.П0009А0000301);
		Стр.Свойство("СтрРег", НовСтр.П0009А0000501);
		Стр.Свойство("СтрРег", НовСтр.П0009А0000601);
		Стр.Свойство("РегНомер", НовСтр.П0009А0000701);
		Стр.Свойство("КодНПРег", НовСтр.П0009А0000801);
		Стр.Свойство("АдрСтрРег", НовСтр.П0009А0000901);
		НовСтр.П0009А0001001 = ОТЧ.ПривестиЗначение(Стр.ДоляПрямУч) + ОТЧ.ПривестиЗначение(Стр.ДоляКосУч);
	КонецЦикла;
	
	Для Каждого ЛистБ Из ДанныеУведомления.ДанныеМногостраничныхРазделов.ЛистБ Цикл 
		Стр = ЛистБ.Значение;
		Если Не ЗначениеЗаполнено(Стр.НомерКИКЧисло) Тогда 
			Продолжить;
		КонецЕсли;
		
		НовСтр = ИностранныеОрганизации.Добавить();
		НовСтр.П0009А0000101 = "ИС-" + Формат(Стр.НомерКИКЧисло, "ЧЦ=5; ЧН=00000; ЧВН=; ЧГ=");
		Стр.Свойство("НаимОргЛат", НовСтр.П0009А0000301);
		Стр.Свойство("НаимДокУчр", НовСтр.П0009А0000401);
		Стр.Свойство("СтрРег", НовСтр.П0009А0000501);
		Стр.Свойство("СтрРег", НовСтр.П0009А0000601);
		Стр.Свойство("РегНомер", НовСтр.П0009А0000701);
		Стр.Свойство("ОргФорм", НовСтр.П0009А0000201);
	КонецЦикла;
	
	Для Каждого ЛистВ Из ДанныеУведомления.ДанныеМногостраничныхРазделов.ЛистВ Цикл 
		Стр = ЛистВ.Значение;
		Для Каждого ТекСтр Из ИностранныеОрганизации.НайтиСтроки(Новый Структура("П0009А0000101", Стр.НомерКИК)) Цикл 
			Для Инд = 1 По 9 Цикл 
				Стр.Свойство("Код100" + Инд, ТекСтр["П0009А000110" + Инд]);
			КонецЦикла;
			
			Если Стр.ПорОпрПрКИК = "1" Тогда 
				ТекСтр.П0009А0000100 = "Х";
			ИначеЕсли Стр.ПорОпрПрКИК = "2" Тогда 
				ТекСтр.П0009А0000200 = "Х";
			КонецЕсли;
			
			Прервать;
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти