#Область ОписаниеПеременных

&НаКлиенте
Перем ВыполняетсяЗакрытие;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Организация = Параметры.Организация;
	Склад = Параметры.Склад;
	Назначение = Параметры.Назначение;
	НалогообложениеНДС = Параметры.НалогообложениеНДС;
	Период = Параметры.Период;
	
	АдресПлатежейВХранилище = Параметры.АдресПлатежейВХранилище;
	
	ЗаполнитьТаблицуТоваров();
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	МассивСтрок = ТаблицаТоваров.НайтиСтроки(Новый Структура("Выбран", Истина));
	
	Если Модифицированность И МассивСтрок.Количество() > 0 Тогда
		
		Если ЗавершениеРаботы Тогда
			Отказ = Истина;
			ВыполняетсяЗакрытие = Истина;
			ТекстПредупреждения = НСтр("ru = 'Есть выбранные товары, не перенесенные в документ. Продолжить закрытие?'");
		КонецЕсли;
		
		Если Не ВыполняетсяЗакрытие Тогда
			
			Отказ = Истина;
			ТекстВопроса = НСтр("ru = 'Выбранные товары не перенесены в документ. Перенести?'");
			ПоказатьВопрос(Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект), ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена, , КодВозвратаДиалога.Да);
			
		КонецЕсли;

	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
    
    Ответ = РезультатВопроса;
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ВыполняетсяЗакрытие = Истина;
        ПеренестиВДокумент();
    ИначеЕсли Ответ = КодВозвратаДиалога.Нет Тогда
        ВыполняетсяЗакрытие = Истина;
		Модифицированность = Ложь;
		Закрыть();
    КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТаблицаТоваровКоличествоПриИзменении(Элемент)
	
	СтрокаТаблицы = Элементы.ТаблицаТоваров.ТекущиеДанные;
	СтрокаТаблицы.Выбран = (СтрокаТаблицы.Количество <> 0);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПеренестиВДокумент()

	Модифицированность = Ложь;
	ПоместитьТоварыВХранилище();
	Закрыть(КодВозвратаДиалога.OK);
	
	СтруктураЗначенияВыбора = Новый Структура("АдресПлатежейВХранилище, НалогообложениеНДС",
		АдресПлатежейВХранилище,
		НалогообложениеНДС);
	ОповеститьОВыборе(СтруктураЗначенияВыбора);
	
КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	
	ЗаполнитьТаблицуТоваров();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьСтроки()

	МассивСтрок = Элементы.ТаблицаТоваров.ВыделенныеСтроки;
	Для Каждого НомерСтроки Из МассивСтрок Цикл
		СтрокаТаблицы = ТаблицаТоваров.НайтиПоИдентификатору(НомерСтроки);
		Если СтрокаТаблицы <> Неопределено Тогда
			СтрокаТаблицы.Выбран = Истина;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ИсключитьСтроки()

	МассивСтрок = Элементы.ТаблицаТоваров.ВыделенныеСтроки;
	Для Каждого НомерСтроки Из МассивСтрок Цикл
		СтрокаТаблицы = ТаблицаТоваров.НайтиПоИдентификатору(НомерСтроки);
		Если СтрокаТаблицы <> Неопределено Тогда
			СтрокаТаблицы.Выбран = Ложь;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТаблицаТоваров.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ТаблицаТоваров.Выбран");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.RosyBrown);

КонецПроцедуры

#Область Прочее


&НаСервере
Процедура ЗаполнитьТаблицуТоваров()
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст= 
	"ВЫБРАТЬ
	|	Товары.Выбран КАК Выбран,
	|	Товары.Номенклатура КАК Номенклатура,
	|	Товары.Характеристика КАК Характеристика,
	|	Товары.Серия КАК Серия,
	|	Товары.Назначение КАК Назначение,
	|	Товары.Количество КАК Количество
	|ПОМЕСТИТЬ Товары
	|ИЗ
	|	&Товары КАК Товары
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВидыЗапасов.Ссылка КАК ВидЗапасов,
	|	ВидыЗапасов.Ссылка КАК ВидЗапасовПродавца
	|ПОМЕСТИТЬ ДоступныеВидыЗапасов
	|ИЗ
	|	Справочник.ВидыЗапасов КАК ВидыЗапасов
	|ГДЕ
	|	НЕ ВидыЗапасов.РеализацияЗапасовДругойОрганизации
	|	И ВидыЗапасов.Организация = &Организация
	|	И ВидыЗапасов.ТипЗапасов = ЗНАЧЕНИЕ(Перечисление.ТипыЗапасов.Товар)
	|	И (ВидыЗапасов.НалогообложениеНДС = &НалогообложениеНДС
	|			ИЛИ ВидыЗапасов.НалогообложениеНДС = ЗНАЧЕНИЕ(Перечисление.ТипыНалогообложенияНДС.ПустаяСсылка)
	|				И &НалогообложениеНДС = &НалогообложениеОрганизации)
	|	И НЕ ВидыЗапасов.ПометкаУдаления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Номенклатура КАК Номенклатура,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Характеристика КАК Характеристика,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Серия КАК Серия,
	|	ТоварыОрганизаций.АналитикаУчетаНоменклатуры.Назначение КАК Назначение,
	|	ТоварыОрганизаций.КоличествоОстаток КАК КоличествоОстаток
	|ПОМЕСТИТЬ Остатки
	|ИЗ
	|	РегистрНакопления.ТоварыОрганизаций.Остатки(
	|			,
	|			НЕ &ПартионныйУчетВерсии22
	|				И Организация = &Организация
	|				И ВидЗапасов В
	|					(ВЫБРАТЬ
	|						ДоступныеВидыЗапасов.ВидЗапасов
	|					ИЗ
	|						ДоступныеВидыЗапасов КАК ДоступныеВидыЗапасов)
	|				И АналитикаУчетаНоменклатуры.МестоХранения = &Склад
	|				И АналитикаУчетаНоменклатуры.Назначение = &Назначение) КАК ТоварыОрганизаций
	|ГДЕ
	|	ТоварыОрганизаций.КоличествоОстаток > 0
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	Себестоимость.АналитикаУчетаНоменклатуры.Номенклатура,
	|	Себестоимость.АналитикаУчетаНоменклатуры.Характеристика,
	|	Себестоимость.АналитикаУчетаНоменклатуры.Серия,
	|	Себестоимость.АналитикаУчетаНоменклатуры.Назначение,
	|	Себестоимость.КоличествоОстаток
	|ИЗ
	|	РегистрНакопления.СебестоимостьТоваров.Остатки(
	|			,
	|			&ПартионныйУчетВерсии22
	|				И Организация = &Организация
	|				И РазделУчета = ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаСкладах)
	|				И ВидДеятельностиНДС = &НалогообложениеНДС
	|				И АналитикаУчетаНоменклатуры.МестоХранения = &Склад
	|				И АналитикаУчетаНоменклатуры.Назначение = &Назначение) КАК Себестоимость
	|ГДЕ
	|	Себестоимость.КоличествоОстаток > 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(Товары.Выбран) КАК Выбран,
	|	Товары.Номенклатура КАК Номенклатура,
	|	Товары.Характеристика КАК Характеристика,
	|	Товары.Серия КАК Серия,
	|	Товары.Назначение КАК Назначение,
	|	СУММА(Товары.Количество) КАК Количество,
	|	СУММА(Товары.КоличествоОстаток) КАК КоличествоОстаток
	|ИЗ
	|	(ВЫБРАТЬ
	|		Товары.Выбран КАК Выбран,
	|		Товары.Номенклатура КАК Номенклатура,
	|		Товары.Характеристика КАК Характеристика,
	|		Товары.Серия КАК Серия,
	|		Товары.Назначение КАК Назначение,
	|		Товары.Количество КАК Количество,
	|		0 КАК КоличествоОстаток
	|	ИЗ
	|		Товары КАК Товары
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ЛОЖЬ,
	|		ТоварыОрганизаций.Номенклатура,
	|		ТоварыОрганизаций.Характеристика,
	|		ТоварыОрганизаций.Серия,
	|		ТоварыОрганизаций.Назначение,
	|		0,
	|		ТоварыОрганизаций.КоличествоОстаток
	|	ИЗ
	|		Остатки КАК ТоварыОрганизаций) КАК Товары
	|
	|СГРУППИРОВАТЬ ПО
	|	Товары.Номенклатура,
	|	Товары.Характеристика,
	|	Товары.Серия,
	|	Товары.Назначение
	|
	|УПОРЯДОЧИТЬ ПО
	|	Номенклатура,
	|	Характеристика,
	|	Серия,
	|	Назначение";
	
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Склад", Склад);
	Запрос.УстановитьПараметр("Назначение", Назначение);
	Запрос.УстановитьПараметр("НалогообложениеНДС", НалогообложениеНДС);
	Запрос.УстановитьПараметр("ПартионныйУчетВерсии22",
		РасчетСебестоимостиПовтИсп.ПартионныйУчетВерсии22(НачалоМесяца(Период)));

	ПараметрыУчетаПоОрганизации = УчетНДСУП.ПараметрыУчетаПоОрганизации(Организация, Неопределено);
	Запрос.УстановитьПараметр("НалогообложениеОрганизации", ПараметрыУчетаПоОрганизации.ОсновноеНалогообложениеНДСПродажи);
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Если ТаблицаТоваров.Количество() > 0 Тогда
		Товары = ТаблицаТоваров.Выгрузить(, "Выбран, Номенклатура, Характеристика, Серия, Назначение, Количество");
	Иначе
		Товары = ПолучитьИзВременногоХранилища(АдресПлатежейВХранилище);
		Товары.Свернуть("Номенклатура, Характеристика, Серия, Назначение", "Количество");
		Товары.Колонки.Добавить("Выбран", Новый ОписаниеТипов("Булево"));
		Товары. ЗаполнитьЗначения(Истина, "Выбран");
	КонецЕсли;
	Запрос.УстановитьПараметр("Товары", Товары);
	
	ТаблицаТоваров.Загрузить(Запрос.Выполнить().Выгрузить());
	
	МассивСтрок = ТаблицаТоваров.НайтиСтроки(Новый Структура("Количество", 0));
	Для Каждого СтрокаТаблицы Из МассивСтрок Цикл
		СтрокаТаблицы.Количество = СтрокаТаблицы.КоличествоОстаток;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПоместитьТоварыВХранилище() 
	
	Товары = ТаблицаТоваров.Выгрузить(Новый Структура("Выбран", Истина), "Выбран, Номенклатура, Характеристика, Серия, Назначение, КоличествоУпаковок, Количество");
	
	Для Каждого СтрокаТаблицы Из Товары Цикл
		
		СтрокаТаблицы.КоличествоУпаковок = СтрокаТаблицы.Количество;
		
	КонецЦикла;
	
	ПоместитьВоВременноеХранилище(Товары, АдресПлатежейВХранилище);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область Инициализация

ВыполняетсяЗакрытие = Ложь;

#КонецОбласти