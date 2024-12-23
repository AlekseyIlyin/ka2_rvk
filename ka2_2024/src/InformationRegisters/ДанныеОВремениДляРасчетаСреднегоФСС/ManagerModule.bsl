#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляОбъектаСГоловнойОрганизациейИФизическимЛицом(Настройки);
КонецПроцедуры

#КонецОбласти

#Область РегистрацияФизическихЛиц

Функция РеквизитГоловнаяОрганизация() Экспорт
	Возврат Метаданные.РегистрыСведений.ДанныеОВремениДляРасчетаСреднегоФСС.Измерения.ГоловнаяОрганизация.Имя;
КонецФункции

Функция РеквизитФизическоеЛицо() Экспорт
	Возврат Метаданные.РегистрыСведений.ДанныеОВремениДляРасчетаСреднегоФСС.Измерения.ФизическоеЛицо.Имя;
КонецФункции

#КонецОбласти

#Область ДоговорРаботыУслуги

Процедура УстановитьОтработанныеДни(Движения, Данные, ДатаНачала, ДатаОкончания) Экспорт
	Если Не ЗначениеЗаполнено(Данные.Регистратор)
		Или Не ЗначениеЗаполнено(Данные.ФизическоеЛицо)
		Или Не ЗначениеЗаполнено(Данные.ГоловнаяОрганизация)
		Или Не ЗначениеЗаполнено(Данные.ДокументОснование)
		Или Не ЗначениеЗаполнено(ДатаНачала)
		Или Не ЗначениеЗаполнено(ДатаОкончания)
		Или ДатаНачала > ДатаОкончания
		Или Год(ДатаНачала) + 100 < Год(ДатаОкончания)
		Тогда
		Возврат;
	КонецЕсли;
	ТаблицаДвижений = Движения.ДанныеОВремениДляРасчетаСреднегоФСС.Выгрузить();
	ЕстьИзменения = Ложь;
	ОтработанныеДни = ОбщегоНазначенияБЗК.МассивДатИзПериода(ДатаНачала, ДатаОкончания);
	СтруктураПоиска = Новый Структура(Новый ФиксированнаяСтруктура(Данные));
	Для Каждого ОтработанныйДень Из ОтработанныеДни Цикл
		СтруктураПоиска.Вставить("Месяц", НачалоМесяца(ОтработанныйДень));
		Найденные = ТаблицаДвижений.НайтиСтроки(СтруктураПоиска);
		Если Найденные.Количество() > 0 Тогда
			СтрокаТаблицы = Найденные[0];
		Иначе
			СтрокаТаблицы = ТаблицаДвижений.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТаблицы, СтруктураПоиска);
		КонецЕсли;
		НомерДня = День(ОтработанныйДень);
		ИмяРесурса = "ОтработанДень" + НомерДня;
		Если СтрокаТаблицы.Активность <> Истина Тогда
			СтрокаТаблицы.Активность = Истина;
			ЕстьИзменения = Истина;
		КонецЕсли;
		Если СтрокаТаблицы[ИмяРесурса] <> Истина Тогда
			СтрокаТаблицы[ИмяРесурса] = Истина;
			ЕстьИзменения = Истина;
		КонецЕсли;
	КонецЦикла;
	Если ЕстьИзменения Тогда
		Движения.ДанныеОВремениДляРасчетаСреднегоФСС.Загрузить(ТаблицаДвижений);
		Движения.ДанныеОВремениДляРасчетаСреднегоФСС.Записывать = Истина;
	КонецЕсли;
КонецПроцедуры

Функция ДанныеДляУстановитьОтработанныеДни(Регистратор, ФизическоеЛицо, ГоловнаяОрганизация, ДокументОснование, ВидБолезниУходаЗаДетьми) Экспорт
	Возврат Новый Структура(
		"Регистратор, ФизическоеЛицо, ГоловнаяОрганизация, ДокументОснование, ВидБолезниУходаЗаДетьми",
		Регистратор, ФизическоеЛицо, ГоловнаяОрганизация, ДокументОснование, ВидБолезниУходаЗаДетьми);
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли
