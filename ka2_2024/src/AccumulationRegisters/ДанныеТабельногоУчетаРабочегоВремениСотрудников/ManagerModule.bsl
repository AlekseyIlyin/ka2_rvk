#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляРегистраПодчиненногоРегистратору(Настройки);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОписаниеРегистра() Экспорт
	ОписаниеРегистра = УчетРабочегоВремениРасширенный.ОписаниеРегистраДанныхУчетаВремени();
	
	ОписаниеРегистра.МетаданныеРегистра = Метаданные.РегистрыНакопления.ДанныеТабельногоУчетаРабочегоВремениСотрудников;
	ОписаниеРегистра.ИмяПоляСотрудник = "Сотрудник";
	ОписаниеРегистра.ИмяПоляПериод = "Период";
	ОписаниеРегистра.ИмяПоляПериодРегистрации = "ПериодРегистрации";
	ОписаниеРегистра.ИмяПоляВидДанных = Неопределено;
	ОписаниеРегистра.ВидДанных = Перечисления.ВидыДанныхУчетаВремениСотрудников.ДанныеТабельногоУчета;
	
	Возврат ОписаниеРегистра;
КонецФункции

#Область ПервоначальноеЗаполнениеИОбновлениеИнформационнойБазы

Процедура ЗаполнитьОрганизацию(ПараметрыОбновления = Неопределено) Экспорт
	
	ПоследнийОбработанныйРегистратор = Неопределено;
	Пока Истина Цикл
		Запрос = ЗарплатаКадрыРасширенный.ЗапросПолученияРегистраторовДляОбработкиЗаполненияОрганизации("ДанныеТабельногоУчетаРабочегоВремениСотрудников", ПоследнийОбработанныйРегистратор);
		
		Результат = Запрос.Выполнить();
		Если Результат.Пустой() Тогда
			ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.УстановитьПараметрОбновления(ПараметрыОбновления, "ОбработкаЗавершена", Истина);
			Возврат;
		Иначе
			ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.УстановитьПараметрОбновления(ПараметрыОбновления, "ОбработкаЗавершена", Ложь);
		КонецЕсли;
		
		Регистраторы = Результат.Выгрузить().ВыгрузитьКолонку("Регистратор");
		ОрганизацииДокументов = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(Регистраторы, "Организация");
		
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Период КАК Период,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Регистратор КАК Регистратор,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.НомерСтроки КАК НомерСтроки,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Активность КАК Активность,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Сотрудник КАК Сотрудник,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Сотрудник.ГоловнаяОрганизация КАК ГоловнаяОрганизация,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.ПериодРегистрации КАК ПериодРегистрации,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.ВидУчетаВремени КАК ВидУчетаВремени,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Территория КАК Территория,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.УсловияТруда КАК УсловияТруда,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Дни КАК Дни,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Часы КАК Часы,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.УдалитьПлан КАК УдалитьПлан,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.УдалитьВнутрисменное КАК УдалитьВнутрисменное,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.УдалитьВЦеломЗаПериод КАК УдалитьВЦеломЗаПериод,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.УдалитьВидВремениВытесняемый КАК УдалитьВидВремениВытесняемый,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.УдалитьИтоговыеДанные КАК УдалитьИтоговыеДанные,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.ПереходящаяЧастьПредыдущейСмены КАК ПереходящаяЧастьПредыдущейСмены,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.ПереходящаяЧастьТекущейСмены КАК ПереходящаяЧастьТекущейСмены,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Смена КАК Смена,
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Организация КАК Организация
			|ИЗ
			|	РегистрНакопления.ДанныеТабельногоУчетаРабочегоВремениСотрудников КАК ДанныеТабельногоУчетаРабочегоВремениСотрудников
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТРегистраторы КАК ВТРегистраторы
			|		ПО ДанныеТабельногоУчетаРабочегоВремениСотрудников.Регистратор = ВТРегистраторы.Регистратор
			|
			|УПОРЯДОЧИТЬ ПО
			|	ДанныеТабельногоУчетаРабочегоВремениСотрудников.Регистратор";
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.СледующийПоЗначениюПоля("Регистратор") Цикл
			Если Не ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ПодготовитьОбновлениеДанных(ПараметрыОбновления, "РегистрНакопления.ДанныеТабельногоУчетаРабочегоВремениСотрудников.НаборЗаписей", "Регистратор", Выборка.Регистратор) Тогда
				Продолжить;
			КонецЕсли;
			НаборЗаписей = РегистрыНакопления.ДанныеТабельногоУчетаРабочегоВремениСотрудников.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Регистратор.Установить(Выборка.Регистратор);
			Пока Выборка.Следующий() Цикл
				НоваяСтрока = НаборЗаписей.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, Выборка);
				НоваяСтрока.Организация = ОрганизацииДокументов[Выборка.Регистратор];
				Если Не ЗначениеЗаполнено(НоваяСтрока.Организация) Тогда
					НоваяСтрока.Организация = Выборка.ГоловнаяОрганизация;
				КонецЕсли;
			КонецЦикла;
			ОбновлениеИнформационнойБазы.ЗаписатьНаборЗаписей(НаборЗаписей);
			ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ЗавершитьОбновлениеДанных(ПараметрыОбновления);
			ПоследнийОбработанныйРегистратор = Выборка.Регистратор;
		КонецЦикла;
		Если ПараметрыОбновления <> Неопределено Тогда
			Возврат;
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли