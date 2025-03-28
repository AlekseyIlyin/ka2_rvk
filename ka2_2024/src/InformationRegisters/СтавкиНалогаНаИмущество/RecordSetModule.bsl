#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	СтруктураВременныеТаблицы = Новый Структура("МенеджерВременныхТаблиц", Новый МенеджерВременныхТаблиц);
	ДополнительныеСвойства.Вставить("СтруктураВременныеТаблицы", СтруктураВременныеТаблицы);
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ТаблицаПередЗаписью.Период,
	|	ТаблицаПередЗаписью.Организация,
	|	ТаблицаПередЗаписью.НалоговаяСтавка,
	|	ТаблицаПередЗаписью.НалоговаяСтавкаДвижимоеИмущество,
	|	ТаблицаПередЗаписью.ОсвобождениеОтНалогообложения,
	|	ТаблицаПередЗаписью.СнижениеНалоговойСтавки,
	|	ТаблицаПередЗаписью.СнижениеНалоговойСтавкиДвижимоеИмущество,
	|	ТаблицаПередЗаписью.ОсвобождениеОтНалогообложенияДвижимогоИмущества,
	|	ТаблицаПередЗаписью.УменьшениеСуммыНалогаВПроцентах,
	|	ТаблицаПередЗаписью.ПроцентУменьшения
	|ПОМЕСТИТЬ СтавкиНалогаНаИмуществоПередЗаписью
	|ИЗ
	|	РегистрСведений.СтавкиНалогаНаИмущество КАК ТаблицаПередЗаписью
	|ГДЕ
	|	//ОтборОрганизация//
	|	И //ОтборПериод//";
	
	Если Отбор.Организация.Использование Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, 
									"//ОтборОрганизация//",
									"ТаблицаПередЗаписью.Организация = &Организация");
	Иначе
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, 
									"//ОтборОрганизация//", "ИСТИНА");
	КонецЕсли;
	
	Если Отбор.Период.Использование Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, 
									"//ОтборПериод//", 
									"ТаблицаПередЗаписью.Период = &Период");
	Иначе
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, 
									"//ОтборПериод//", "ИСТИНА");
	КонецЕсли;
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Организация", Отбор.Организация.Значение);
	Запрос.УстановитьПараметр("Период", Отбор.Период.Значение);
	
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураВременныеТаблицы = ДополнительныеСвойства.СтруктураВременныеТаблицы;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	Таблица.Период           КАК Период,
	|	Таблица.Организация      КАК Организация,
	|	ИСТИНА                   КАК ОтражатьВРеглУчете,
	|	ЛОЖЬ                     КАК ОтражатьВУпрУчете,
	|	НЕОПРЕДЕЛЕНО             КАК Документ
	|ПОМЕСТИТЬ СтавкиНалогаНаИмуществоИзменение
	|ИЗ
	|	(ВЫБРАТЬ
	|		НАЧАЛОПЕРИОДА(ТаблицаПередЗаписью.Период, МЕСЯЦ) КАК Период,
	|		ТаблицаПередЗаписью.Организация КАК Организация
	|	ИЗ
	|		СтавкиНалогаНаИмуществоПередЗаписью КАК ТаблицаПередЗаписью
	|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СтавкиНалогаНаИмущество КАК ТаблицаПриЗаписи
	|			ПО ТаблицаПриЗаписи.Организация = ТаблицаПередЗаписью.Организация
	|		ГДЕ
	|			(ТаблицаПриЗаписи.НалоговаяСтавка <> ТаблицаПередЗаписью.НалоговаяСтавка
	|				ИЛИ ТаблицаПриЗаписи.НалоговаяСтавкаДвижимоеИмущество <> ТаблицаПередЗаписью.НалоговаяСтавкаДвижимоеИмущество
	|				ИЛИ ТаблицаПриЗаписи.ОсвобождениеОтНалогообложения <> ТаблицаПередЗаписью.ОсвобождениеОтНалогообложения
	|				ИЛИ ТаблицаПриЗаписи.ОсвобождениеОтНалогообложенияДвижимогоИмущества <> ТаблицаПередЗаписью.ОсвобождениеОтНалогообложенияДвижимогоИмущества
	|				ИЛИ ТаблицаПриЗаписи.СнижениеНалоговойСтавки <> ТаблицаПередЗаписью.СнижениеНалоговойСтавки
	|				ИЛИ ТаблицаПриЗаписи.СнижениеНалоговойСтавкиДвижимоеИмущество <> ТаблицаПередЗаписью.СнижениеНалоговойСтавкиДвижимоеИмущество
	|				ИЛИ ТаблицаПриЗаписи.УменьшениеСуммыНалогаВПроцентах <> ТаблицаПередЗаписью.УменьшениеСуммыНалогаВПроцентах
	|				ИЛИ ТаблицаПриЗаписи.ПроцентУменьшения <> ТаблицаПередЗаписью.ПроцентУменьшения
	|				ИЛИ ТаблицаПриЗаписи.Период <> ТаблицаПередЗаписью.Период
	|				ИЛИ ТаблицаПриЗаписи.Организация ЕСТЬ NULL)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		НАЧАЛОПЕРИОДА(ТаблицаПриЗаписи.Период, МЕСЯЦ),
	|		ТаблицаПриЗаписи.Организация
	|	ИЗ
	|		РегистрСведений.СтавкиНалогаНаИмущество КАК ТаблицаПриЗаписи
	|			ЛЕВОЕ СОЕДИНЕНИЕ СтавкиНалогаНаИмуществоПередЗаписью КАК ТаблицаПередЗаписью
	|			ПО ТаблицаПриЗаписи.Организация = ТаблицаПередЗаписью.Организация
	|		ГДЕ
	|			(ТаблицаПриЗаписи.НалоговаяСтавка <> ТаблицаПередЗаписью.НалоговаяСтавка
	|				ИЛИ ТаблицаПриЗаписи.НалоговаяСтавкаДвижимоеИмущество <> ТаблицаПередЗаписью.НалоговаяСтавкаДвижимоеИмущество
	|				ИЛИ ТаблицаПриЗаписи.ОсвобождениеОтНалогообложения <> ТаблицаПередЗаписью.ОсвобождениеОтНалогообложения
	|				ИЛИ ТаблицаПриЗаписи.ОсвобождениеОтНалогообложенияДвижимогоИмущества <> ТаблицаПередЗаписью.ОсвобождениеОтНалогообложенияДвижимогоИмущества
	|				ИЛИ ТаблицаПриЗаписи.СнижениеНалоговойСтавки <> ТаблицаПередЗаписью.СнижениеНалоговойСтавки
	|				ИЛИ ТаблицаПриЗаписи.СнижениеНалоговойСтавкиДвижимоеИмущество <> ТаблицаПередЗаписью.СнижениеНалоговойСтавкиДвижимоеИмущество
	|				ИЛИ ТаблицаПриЗаписи.УменьшениеСуммыНалогаВПроцентах <> ТаблицаПередЗаписью.УменьшениеСуммыНалогаВПроцентах
	|				ИЛИ ТаблицаПриЗаписи.ПроцентУменьшения <> ТаблицаПередЗаписью.ПроцентУменьшения
	|				ИЛИ ТаблицаПриЗаписи.Период <> ТаблицаПередЗаписью.Период
	|				ИЛИ ТаблицаПередЗаписью.Организация ЕСТЬ NULL)
	|			//ОтборОрганизация//
	|			//ОтборПериод//
	|
	|	) КАК Таблица
	|
	|
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ СтавкиНалогаНаИмуществоПередЗаписью";
	
	Если Отбор.Организация.Использование Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, 
							"//ОтборОрганизация//", 
							"И ТаблицаПриЗаписи.Организация = &Организация");
	КонецЕсли;
	
	Если Отбор.Период.Использование Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, 
									"//ОтборПериод//", 
									"И ТаблицаПриЗаписи.Период = &Период");
	КонецЕсли;
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Организация", Отбор.Организация.Значение);
	Запрос.УстановитьПараметр("Период", Отбор.Период.Значение);
	Выборка = Запрос.ВыполнитьПакет()[0].Выбрать();
	Выборка.Следующий();
	
	СтруктураВременныеТаблицы.Вставить("СтавкиНалогаНаИмуществоИзменение", Выборка.Количество > 0);
	
	РасчетИмущественныхНалоговУП.СформироватьЗаданиеКРасчетуНалогаНаИмущество(Неопределено, СтруктураВременныеТаблицы);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
