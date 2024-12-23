#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);

	ПодготовитьДанныеДляФормированияЗаданийПередЗаписью();

КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПодготовитьДанныеДляФормированияЗаданийПриЗаписи();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПодготовитьДанныеДляФормированияЗаданийПередЗаписью()
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ТаблицаПередЗаписью.Период            КАК Период,
	|	ТаблицаПередЗаписью.Организация       КАК Организация,
	|	ТаблицаПередЗаписью.ВнеоборотныйАктив КАК ВнеоборотныйАктив,
	|	ТаблицаПередЗаписью.ЕГДС              КАК ЕГДС
	|ПОМЕСТИТЬ СоставЕГДСПередЗаписью
	|ИЗ
	|	РегистрСведений.СоставЕГДС КАК ТаблицаПередЗаписью
	|ГДЕ
	|	ТаблицаПередЗаписью.Регистратор = &Регистратор";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ПодготовитьДанныеДляФормированияЗаданийПриЗаписи()
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Таблица.Период            КАК Период,
	|	Таблица.Организация       КАК Организация,
	|	Таблица.ВнеоборотныйАктив КАК ВнеоборотныйАктив,
	|	Таблица.ЕГДС              КАК ЕГДС,
	|	&Регистратор              КАК Документ
	|ПОМЕСТИТЬ СоставЕГДСИзменение
	|ИЗ
	|	(ВЫБРАТЬ
	|		ТаблицаПередЗаписью.Период            КАК Период,
	|		ТаблицаПередЗаписью.Организация       КАК Организация,
	|		ТаблицаПередЗаписью.ВнеоборотныйАктив КАК ВнеоборотныйАктив,
	|		ТаблицаПередЗаписью.ЕГДС              КАК ЕГДС
	|	ИЗ
	|		СоставЕГДСПередЗаписью КАК ТаблицаПередЗаписью
	|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СоставЕГДС КАК ТаблицаПриЗаписи
	|			ПО ТаблицаПриЗаписи.ВнеоборотныйАктив = ТаблицаПередЗаписью.ВнеоборотныйАктив
	|				И ТаблицаПриЗаписи.Организация = ТаблицаПередЗаписью.Организация
	|				И ТаблицаПриЗаписи.Регистратор = &Регистратор
	|	ГДЕ
	|		(ТаблицаПриЗаписи.Период ЕСТЬ NULL
	|				ИЛИ ТаблицаПриЗаписи.ЕГДС <> ТаблицаПередЗаписью.ЕГДС
	|				ИЛИ НАЧАЛОПЕРИОДА(ТаблицаПриЗаписи.Период, ДЕНЬ) <> НАЧАЛОПЕРИОДА(ТаблицаПередЗаписью.Период, ДЕНЬ))
	|
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		ТаблицаПриЗаписи.Период,
	|		ТаблицаПриЗаписи.Организация,
	|		ТаблицаПриЗаписи.ВнеоборотныйАктив,
	|		ТаблицаПриЗаписи.ЕГДС
	|	ИЗ
	|		РегистрСведений.СоставЕГДС КАК ТаблицаПриЗаписи
	|			ЛЕВОЕ СОЕДИНЕНИЕ СоставЕГДСПередЗаписью КАК ТаблицаПередЗаписью
	|			ПО ТаблицаПриЗаписи.ВнеоборотныйАктив = ТаблицаПередЗаписью.ВнеоборотныйАктив
	|			И ТаблицаПриЗаписи.Организация = ТаблицаПередЗаписью.Организация
	|	ГДЕ
	|		(ТаблицаПередЗаписью.Период ЕСТЬ NULL
	|				ИЛИ ТаблицаПриЗаписи.ЕГДС <> ТаблицаПередЗаписью.ЕГДС
	|				ИЛИ НАЧАЛОПЕРИОДА(ТаблицаПриЗаписи.Период, ДЕНЬ) <> НАЧАЛОПЕРИОДА(ТаблицаПередЗаписью.Период, ДЕНЬ))
	|			И ТаблицаПриЗаписи.Регистратор = &Регистратор) КАК Таблица
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ СоставЕГДСПередЗаписью";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	
	Выборка = Запрос.ВыполнитьПакет()[0].Выбрать();
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"СоставЕГДСИзменение", Выборка.Следующий() И Выборка.Количество > 0);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли