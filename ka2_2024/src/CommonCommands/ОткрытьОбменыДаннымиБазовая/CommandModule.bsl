#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ИнформацияОНастроенныхОбменах = ИнформацияОНастроенныхСинхронизациях();
	
	Если ИнформацияОНастроенныхОбменах.КоличествоНастроенныхОбменов > 0 Тогда
		
		ПараметрыФормы = Новый Структура("ИмяПланаОбмена",     "СинхронизацияДанныхЧерезУниверсальныйФормат");
		ПараметрыФормы.Вставить("ИдентификаторНастройки",      ИдентификаторНастройкиОбменаБП30());
		ПараметрыФормы.Вставить("НастройкаНовойСинхронизации", Ложь);
		ПараметрыФормы.Вставить("УзелПланаОбмена",             ИнформацияОНастроенныхОбменах.НастроенныйУзелПланаОбмена);
		
		ОткрытьФорму("ОбщаяФорма.СинхронизацияДанныхБазовая", ПараметрыФормы, , ,ПараметрыВыполненияКоманды.Окно);

	Иначе
		
		ПараметрыФормы = Новый Структура("ИмяПланаОбмена",     "СинхронизацияДанныхЧерезУниверсальныйФормат");
		ПараметрыФормы.Вставить("ИдентификаторНастройки",      ИдентификаторНастройкиОбменаБП30());
		ПараметрыФормы.Вставить("НастройкаНовойСинхронизации", Истина);
		
		ОбработкаОповещенияПослеЗакрытияПомощника = Новый ОписаниеОповещения("ПослеЗакрытияФормыПомощника", ЭтотОбъект);
		
		ОткрытьФорму("Обработка.ПомощникСозданияОбменаДанными.Форма.НастройкаСинхронизации", ПараметрыФормы, , ,
			ПараметрыВыполненияКоманды.Окно, , ОбработкаОповещенияПослеЗакрытияПомощника, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПослеЗакрытияФормыПомощника(Результат, ДополнительныеПараметры) Экспорт
	
	ИнформацияОНастроенныхОбменах = ИнформацияОНастроенныхСинхронизациях();	
	
	Если ИнформацияОНастроенныхОбменах.КоличествоНастроенныхОбменов > 0 Тогда
		
		ПараметрыФормы = Новый Структура("ИмяПланаОбмена",     "СинхронизацияДанныхЧерезУниверсальныйФормат");
		ПараметрыФормы.Вставить("ИдентификаторНастройки",      ИдентификаторНастройкиОбменаБП30());
		ПараметрыФормы.Вставить("НастройкаНовойСинхронизации", Ложь);
		ПараметрыФормы.Вставить("УзелПланаОбмена",             ИнформацияОНастроенныхОбменах.НастроенныйУзелПланаОбмена);
		
		ОткрытьФорму("ОбщаяФорма.СинхронизацияДанныхБазовая", ПараметрыФормы);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ИдентификаторНастройкиОбменаБП30()
	
	Возврат ОбменДаннымиЛокализация.ИдентификаторНастройкиОбменаБазовойУТБП30();
	
КонецФункции

&НаСервере
Функция ИнформацияОНастроенныхСинхронизациях()
	
	ИнформацияОНастроенныхОбменах = Новый Структура();
	ИнформацияОНастроенныхОбменах.Вставить("КоличествоНастроенныхОбменов", 0);
	ИнформацияОНастроенныхОбменах.Вставить("НастроенныйУзелПланаОбмена",   ПланыОбмена.СинхронизацияДанныхЧерезУниверсальныйФормат.ПустаяСсылка());
	ИнформацияОНастроенныхОбменах.Вставить("НастройкаЗавершена",           Ложь);

	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
		|	СинхронизацияДанныхЧерезУниверсальныйФормат.Ссылка КАК НастроенныйУзелПланаОбмена,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ СинхронизацияДанныхЧерезУниверсальныйФормат.Ссылка) КАК КоличествоНастроенныхОбменов,
		|	ЕСТЬNULL(ОбщиеНастройкиУзловИнформационныхБаз.НастройкаЗавершена, ЛОЖЬ) КАК НастройкаЗавершена
		|ИЗ
		|	ПланОбмена.СинхронизацияДанныхЧерезУниверсальныйФормат КАК СинхронизацияДанныхЧерезУниверсальныйФормат
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОбщиеНастройкиУзловИнформационныхБаз КАК ОбщиеНастройкиУзловИнформационныхБаз
		|		ПО СинхронизацияДанныхЧерезУниверсальныйФормат.Ссылка = ОбщиеНастройкиУзловИнформационныхБаз.УзелИнформационнойБазы
		|ГДЕ
		|	НЕ СинхронизацияДанныхЧерезУниверсальныйФормат.ЭтотУзел
		|
		|СГРУППИРОВАТЬ ПО
		|	СинхронизацияДанныхЧерезУниверсальныйФормат.Ссылка,
		|	ОбщиеНастройкиУзловИнформационныхБаз.НастройкаЗавершена");
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ИнформацияОНастроенныхОбменах, Выборка);
	КонецЕсли;
	
	Возврат ИнформацияОНастроенныхОбменах;
	
КонецФункции

#КонецОбласти