#Область ОписаниеПеременных

&НаКлиенте
Перем ВыполняетсяЗакрытие;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();

	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ВалютаДокумента    = Параметры.ВалютаДокумента;
	НалогообложениеНДС = Параметры.НалогообложениеНДС;
	ЦенаВключаетНДС    = Параметры.ЦенаВключаетНДС;
	
	ЗаполнитьТаблицуТоваров();
	ПодборТоваровКлиентСервер.СформироватьЗаголовокФормыПодбора(Заголовок, Параметры.Документ);

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)

	Если НЕ ВыполняетсяЗакрытие И Модифицированность И НЕ ЗавершениеРаботы Тогда
		Отказ = Истина;
		ПоказатьВопрос(Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект), 
			НСтр("ru = 'Данные были изменены. Перенести изменения в документ?'"), РежимДиалогаВопрос.ДаНетОтмена);

	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Ответ = РезультатВопроса;
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ВыполняетсяЗакрытие = Истина;
		Модифицированность = Ложь;
		ПеренестиТоварыВДокумент();
		
	ИначеЕсли Ответ = КодВозвратаДиалога.Нет Тогда
		ВыполняетсяЗакрытие = Истина;
		Модифицированность = Ложь;
		Закрыть();
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТаблицаТоваровВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Элементы.ТаблицаТоваров.ТекущиеДанные <> Неопределено Тогда
		Если Поле.Имя = "ТаблицаТоваровЗаказПоставщику" Тогда
			ПоказатьЗначение(Неопределено, Элементы.ТаблицаТоваров.ТекущиеДанные.ЗаказПоставщику);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПеренестиВДокументВыполнить()

	ПеренестиТоварыВДокумент();

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьТоварыВыполнить()
	
	ВыбратьВсеТоварыНаСервере(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ИсключитьТоварыВыполнить()
	
	ВыбратьВсеТоварыНаСервере(Ложь);
	
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
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ТаблицаТоваров.ПрисутствуетВДокументе");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.Gray);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТаблицаТоваровЗаказПоставщику.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ТаблицаТоваров.ЗаказКлиента");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ГиперссылкаЦвет);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТаблицаТоваровСуммаСНДС.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ЦенаВключаетНДС");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТаблицаТоваровСуммаНДС.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТаблицаТоваровСуммаСНДС.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТаблицаТоваровСтавкаНДС.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("НалогообложениеНДС");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ТипыНалогообложенияНДС.ПродажаНеОблагаетсяНДС;

	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);

КонецПроцедуры

&НаСервере
Процедура ВыбратьВсеТоварыНаСервере(ЗначениеВыбора = Истина)
	
	Для Каждого СтрокаТаблицы Из ТаблицаТоваров.НайтиСтроки(Новый Структура("СтрокаВыбрана", Не ЗначениеВыбора)) Цикл
		
		СтрокаТаблицы.СтрокаВыбрана = ЗначениеВыбора;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ПоместитьТоварыВХранилище()

	// Формирование таблицы для возврата в документ.
	ТаблицаВыбранныхТоваров = ТаблицаТоваров.Выгрузить(Новый Структура("СтрокаВыбрана", Истина));

	АдресТоваровВХранилище = ПоместитьВоВременноеХранилище(ТаблицаВыбранныхТоваров);

	Возврат АдресТоваровВХранилище;

КонецФункции

&НаСервере
Процедура ЗаполнитьТаблицуТоваров()
	
	ДанныеОтбора = Новый Структура();
	ДанныеОтбора.Вставить("Партнер",               Параметры.Партнер);
	ДанныеОтбора.Вставить("Контрагент",            Параметры.Контрагент);
	ДанныеОтбора.Вставить("Договор",               Параметры.Договор);
	ДанныеОтбора.Вставить("Организация",           Параметры.Организация);
	ДанныеОтбора.Вставить("Соглашение",            Параметры.Соглашение);
	ДанныеОтбора.Вставить("Валюта",                Параметры.ВалютаДокумента);
	ДанныеОтбора.Вставить("ВалютаВзаиморасчетов",  Параметры.ВалютаВзаиморасчетов);
	ДанныеОтбора.Вставить("НалогообложениеНДС",    Параметры.НалогообложениеНДС);
	ДанныеОтбора.Вставить("ЦенаВключаетНДС",       Параметры.ЦенаВключаетНДС);
	ДанныеОтбора.Вставить("Склад",                 Параметры.Склад);
	ДанныеОтбора.Вставить("ДокументОснование",     Параметры.ДокументОснование);
	ДанныеОтбора.Вставить("Сделка",                Параметры.Сделка);
	ДанныеОтбора.Вставить("Дата",                  Параметры.Дата);
	
	Если Не ЗначениеЗаполнено(Параметры.ЗаказПоставщику) Или ПолучитьФункциональнуюОпцию("ИспользоватьПоступлениеПоНесколькимЗаказам") Тогда
		МассивЗаказов = Неопределено;
	Иначе
		МассивЗаказов = Новый Массив();
		МассивЗаказов.Добавить(Параметры.ЗаказПоставщику);
	КонецЕсли;
	
	ЗаполнитьПоОстаткамЗаказов(
		ДанныеОтбора,
		ТаблицаТоваров,
		Параметры.Склад,
		МассивЗаказов);
	
	ЗаказыСервер.УстановитьПризнакиПрисутствияСтрокиВДокументе(ТаблицаТоваров, "ЗаказПоставщику", Параметры.МассивКодовСтрок);
	
КонецПроцедуры

&НаКлиенте
Процедура ПеренестиТоварыВДокумент()

	// Снятие модифицированности, т.к. перед закрытием признак проверяется.
	Модифицированность = Ложь;

	АдресТоваровВХранилище = ПоместитьТоварыВХранилище();

	Закрыть();

	ОповеститьОВыборе(Новый Структура("АдресТоваровВХранилище", АдресТоваровВХранилище));

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПоОстаткамЗаказов(ДанныеОтбора,
	                                 Товары,
	                                 СкладПоступления,
	                                 МассивЗаказов=Неопределено)
	
	// Данные по остаткам товаров заказа.
	ВыборкаТовары = ПолучитьРезультатЗапросаПоОстаткамЗаказов(
		ДанныеОтбора,
		СкладПоступления,
		МассивЗаказов
	).Выбрать();
	
	МассивЗаказовПоставщику = Новый Массив();
	
	Пока ВыборкаТовары.Следующий() Цикл
		Если МассивЗаказовПоставщику.Найти(ВыборкаТовары.ЗаказПоставщику) = Неопределено Тогда
			МассивЗаказовПоставщику.Добавить(ВыборкаТовары.ЗаказПоставщику);
		КонецЕсли;
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("МассивЗаказовПоставщику", МассивЗаказовПоставщику);
	Запрос.УстановитьПараметр("ВалютаДокумента", ДанныеОтбора.Валюта);
		
	Запрос.Текст =
	"
	|ВЫБРАТЬ
	|	НАЧАЛОПЕРИОДА(ТаблицаЗаказов.Дата, ДЕНЬ) КАК Дата,
	|	ТаблицаЗаказов.Ссылка                    КАК ЗаказПоставщику,
	|	ТаблицаЗаказов.Валюта                    КАК Валюта,
	|	ТаблицаЗаказов.ЦенаВключаетНДС           КАК ЦенаВключаетНДС,
	|	ВЫБОР
	|		КОГДА
	|			ТаблицаЗаказов.Валюта <> &ВалютаДокумента
	|		ТОГДА
	|			ИСТИНА
	|		ИНАЧЕ
	|			ЛОЖЬ
	|	КОНЕЦ КАК ПересчитатьВВалютуДокумента
	|ИЗ
	|	Документ.ЗаказПоставщику КАК ТаблицаЗаказов
	|ГДЕ
	|	ТаблицаЗаказов.Ссылка В (&МассивЗаказовПоставщику)
	|;
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	НАЧАЛОПЕРИОДА(ТаблицаЗаказов.Дата, ДЕНЬ) КАК Дата,
	|	ТаблицаЗаказов.Валюта                    КАК Валюта,
	|	ТаблицаЗаказов.Организация.ВалютаРегламентированногоУчета КАК ВалютаРегламентированногоУчета
	|ИЗ
	|	Документ.ЗаказПоставщику КАК ТаблицаЗаказов
	|ГДЕ
	|	ТаблицаЗаказов.Ссылка В (&МассивЗаказовПоставщику)
	|	И ТаблицаЗаказов.Валюта <> &ВалютаДокумента
	|
	|";
	
	МассивРезультатовЗапроса = Запрос.ВыполнитьПакет();
	
	РезультатРеквизитыЗаказов = МассивРезультатовЗапроса[0]; // РезультатЗапроса
	РезультатВыборка = МассивРезультатовЗапроса[1]; // РезультатЗапроса
	
	РеквизитыЗаказов = РезультатРеквизитыЗаказов.Выбрать();
	
	ТаблицаКурсовВалют = Новый ТаблицаЗначений;
	ТаблицаКурсовВалют.Колонки.Добавить("Валюта",    Новый ОписаниеТипов("СправочникСсылка.Валюты"));
	ТаблицаКурсовВалют.Колонки.Добавить("Дата",      Новый ОписаниеТипов("Дата"));
	ТаблицаКурсовВалют.Колонки.Добавить("КурсЧислитель",      Новый ОписаниеТипов("Число"));
	ТаблицаКурсовВалют.Колонки.Добавить("КурсЗнаменатель", Новый ОписаниеТипов("Число"));
	
	Выборка = РезультатВыборка.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрока = ТаблицаКурсовВалют.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Выборка);
		
		КурсыВалюты = РаботаСКурсамиВалютУТ.ПолучитьКурсВалюты(Выборка.Валюта, Выборка.Дата, Выборка.ВалютаРегламентированногоУчета);
		НоваяСтрока.КурсЧислитель = КурсыВалюты.КурсЧислитель;
		НоваяСтрока.КурсЗнаменатель = КурсыВалюты.КурсЗнаменатель;
		
	КонецЦикла;
	
	Если ТаблицаКурсовВалют.Количество() > 0 Тогда
		СтруктураКурсовНовойВалюты = РаботаСКурсамиВалютУТ.ПолучитьКурсВалюты(ДанныеОтбора.Валюта, ТекущаяДатаСеанса(),
					ЗначениеНастроекПовтИсп.ВалютаРегламентированногоУчетаОрганизации(ДанныеОтбора.Организация));
	КонецЕсли;
	
	ВыборкаТовары.Сбросить();
	Пока ВыборкаТовары.Следующий() Цикл
		
		НеобходимПересчетСумм = (ВыборкаТовары.Количество<>ВыборкаТовары.КоличествоПоЗаказу);
		
		СтрокаТаб = Товары.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТаб, ВыборкаТовары);
		
		СтрокаТаб.Количество = ВыборкаТовары.Количество;
		СтрокаТаб.КоличествоУпаковок = ВыборкаТовары.Количество / ВыборкаТовары.Коэффициент;
		
		РеквизитыЗаказов.Сбросить();
		ЗаказНайден = РеквизитыЗаказов.НайтиСледующий(СтрокаТаб.ЗаказПоставщику, "ЗаказПоставщику");
		
		Если ЗаказНайден Тогда
			
			Если РеквизитыЗаказов.ПересчитатьВВалютуДокумента Тогда
				
				ПараметрыОтбора = Новый Структура("Валюта,Дата", РеквизитыЗаказов.Валюта, РеквизитыЗаказов.Дата);
				КурсВалюты = ТаблицаКурсовВалют.НайтиСтроки(ПараметрыОтбора);
				
				Если КурсВалюты.Количество() = 1 Тогда
					
					СтрокаТаб.Цена = РаботаСКурсамиВалютУТКлиентСервер.ПересчитатьПоКурсу(
							СтрокаТаб.Цена,
							КурсВалюты[0],
							СтруктураКурсовНовойВалюты);
					НеобходимПересчетСумм = Истина;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если НеобходимПересчетСумм Тогда
			
			Ценообразование.ПересчитатьСуммыВСтроке(СтрокаТаб, Ложь, Ложь, Истина, РеквизитыЗаказов.ЦенаВключаетНДС);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьРезультатЗапросаПоОстаткамЗаказов(ДанныеОтбора,
	                                              СкладПоступления = Неопределено,
	                                              МассивЗаказов = Неопределено)

	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ТаблицаЗаказы.ЗаказПоставщику        КАК ЗаказПоставщику,
	|	ТаблицаЗаказы.Номенклатура           КАК Номенклатура,
	|	ТаблицаЗаказы.Характеристика         КАК Характеристика,
	|	ТаблицаЗаказы.КодСтроки              КАК КодСтроки,
	|	ТаблицаЗаказы.Склад                  КАК Склад,
	|	СУММА(ТаблицаЗаказы.КОформлению)     КАК Количество
	|
	|ПОМЕСТИТЬ ТаблицаОстатки
	|
	|ИЗ
	|	(ВЫБРАТЬ
	|		ЗаказыОстатки.ЗаказПоставщику        КАК ЗаказПоставщику,
	|		ЗаказыОстатки.Номенклатура           КАК Номенклатура,
	|		ЗаказыОстатки.Характеристика         КАК Характеристика,
	|		ЗаказыОстатки.КодСтроки              КАК КодСтроки,
	|		ЗаказыОстатки.Склад                  КАК Склад,
	|		ЗаказыОстатки.КОформлениюОстаток     КАК КОформлению
	|	ИЗ
	|		РегистрНакопления.ЗаказыПоставщикам.Остатки(,
	|				ВЫБОР КОГДА &ОтобратьПоЗаказу ТОГДА
	|					ЗаказПоставщику В (&МассивЗаказов)
	|				ИНАЧЕ
	|					ЗаказПоставщику.Партнер = &Партнер
	|					И ЗаказПоставщику.Контрагент = &Контрагент
	|					И ЗаказПоставщику.Договор = &Договор
	|					И ЗаказПоставщику.Организация = &Организация
	|					И ЗаказПоставщику.ХозяйственнаяОперация = &ХозяйственнаяОперация
	|					И ЗаказПоставщику.Соглашение = &Соглашение
	|					И ЗаказПоставщику.Валюта = &ВалютаВзаиморасчетов
	|					И ЗаказПоставщику.НалогообложениеНДС = &НалогообложениеНДС
	|					И ЗаказПоставщику.ЦенаВключаетНДС = &ЦенаВключаетНДС
	|				КОНЕЦ
	|				И
	|				ВЫБОР
	|					КОГДА
	|						ВЫРАЗИТЬ(&СкладПоступления КАК Справочник.Склады).ЭтоГруппа
	|					ТОГДА
	|						Склад В ИЕРАРХИИ (&СкладПоступления) ИЛИ Склад = ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка)
	|					ИНАЧЕ
	|						Склад В (ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка), &СкладПоступления)
	|				КОНЕЦ
	|			) КАК ЗаказыОстатки
	|
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		ЗаказыДвижения.ЗаказПоставщику,
	|		ЗаказыДвижения.Номенклатура,
	|		ЗаказыДвижения.Характеристика,
	|		ЗаказыДвижения.КодСтроки,
	|		ЗаказыДвижения.Склад,
	|		ВЫБОР КОГДА ЗаказыДвижения.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|				-ЗаказыДвижения.КОформлению
	|			ИНАЧЕ
	|				ЗаказыДвижения.КОформлению
	|		КОНЕЦ
	|	ИЗ
	|		РегистрНакопления.ЗаказыПоставщикам КАК ЗаказыДвижения
	|	ГДЕ
	|		(ЗаказыДвижения.Регистратор = &ДокументОснование
	|		ИЛИ ЗаказыДвижения.Регистратор В (ВЫБРАТЬ
	|							Корректировки.Ссылка
	|						ИЗ
	|							Документ.КорректировкаПриобретения КАК Корректировки
	|						ГДЕ
	|							Корректировки.ДокументОснование = &ДокументОснование
	|							И Корректировки.Проведен))
	|		И ВЫБОР КОГДА &ОтобратьПоЗаказу ТОГДА
	|			ЗаказыДвижения.ЗаказПоставщику В (&МассивЗаказов)
	|		ИНАЧЕ
	|			ЗаказыДвижения.ЗаказПоставщику.Партнер = &Партнер
	|			И ЗаказыДвижения.ЗаказПоставщику.Контрагент = &Контрагент
	|			И ЗаказыДвижения.ЗаказПоставщику.Договор = &Договор
	|			И ЗаказыДвижения.ЗаказПоставщику.Организация = &Организация
	|			И ЗаказыДвижения.ЗаказПоставщику.ХозяйственнаяОперация = &ХозяйственнаяОперация
	|			И ЗаказыДвижения.ЗаказПоставщику.Соглашение = &Соглашение
	|			И ЗаказыДвижения.ЗаказПоставщику.Валюта = &ВалютаВзаиморасчетов
	|			И ЗаказыДвижения.ЗаказПоставщику.НалогообложениеНДС = &НалогообложениеНДС
	|			И ЗаказыДвижения.ЗаказПоставщику.ЦенаВключаетНДС = &ЦенаВключаетНДС
	|		КОНЕЦ
	|		И ЗаказыДвижения.Активность
	|				И ВЫБОР
	|					КОГДА
	|						ВЫРАЗИТЬ(&СкладПоступления КАК Справочник.Склады).ЭтоГруппа
	|					ТОГДА
	|						ЗаказыДвижения.Склад В ИЕРАРХИИ (&СкладПоступления) ИЛИ Склад = ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка)
	|					ИНАЧЕ
	|						ЗаказыДвижения.Склад В (ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка), &СкладПоступления)
	|				КОНЕЦ
	|
	|	) КАК ТаблицаЗаказы
	|	
	|	СГРУППИРОВАТЬ ПО
	|		ТаблицаЗаказы.ЗаказПоставщику,
	|		ТаблицаЗаказы.Номенклатура,
	|		ТаблицаЗаказы.Характеристика,
	|		ТаблицаЗаказы.КодСтроки,
	|		ТаблицаЗаказы.Склад
	|	
	|	ИМЕЮЩИЕ
	|		СУММА(ТаблицаЗаказы.КОформлению) > 0
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаОстатки.ЗаказПоставщику           КАК ЗаказПоставщику,
	|	ТаблицаОстатки.Номенклатура              КАК Номенклатура,
	|	ТаблицаОстатки.Характеристика            КАК Характеристика,
	|	ТаблицаОстатки.КодСтроки                 КАК КодСтроки,
	|	ТаблицаОстатки.Количество                КАК Количество,
	|	ТаблицаОстатки.Склад                     КАК Склад,
	|	ЗаказТовары.Ссылка.Сделка                КАК Сделка,
	|	ЗаказТовары.СтатьяРасходов               КАК СтатьяРасходов,
	|	ЗаказТовары.АналитикаРасходов            КАК АналитикаРасходов,
	|	ЗаказТовары.ДатаПоступления              КАК ДатаПоступления,
	|	ЗаказТовары.Упаковка                     КАК Упаковка,
	|	ЗаказТовары.ВидЦеныПоставщика            КАК ВидЦеныПоставщика,
	|	ЗаказТовары.Количество                   КАК КоличествоПоЗаказу,
	|	ЗаказТовары.Цена                         КАК Цена,
	|	ЗаказТовары.СтавкаНДС                    КАК СтавкаНДС,
	|	ЗаказТовары.Сумма                        КАК Сумма,
	|	ЗаказТовары.СуммаНДС                     КАК СуммаНДС,
	|	ЗаказТовары.СуммаСНДС                    КАК СуммаСНДС,
	|	ЗаказТовары.ПроцентРучнойСкидки          КАК ПроцентРучнойСкидки,
	|	ЗаказТовары.СуммаРучнойСкидки            КАК СуммаРучнойСкидки,
	|	ЗаказТовары.Номенклатура.ТипНоменклатуры КАК ТипНоменклатуры,
	|	ЗаказТовары.НоменклатураПартнера       КАК НоменклатураПартнера,
	|	ВЫБОР КОГДА ЗаказТовары.Упаковка = ЗНАЧЕНИЕ(Справочник.УпаковкиЕдиницыИзмерения.ПустаяСсылка)
	|			ТОГДА 1
	|		ИНАЧЕ &ТекстЗапросаКоэффициентУпаковки
	|	КОНЕЦ                                    КАК Коэффициент
	|ИЗ
	|	ТаблицаОстатки КАК ТаблицаОстатки
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказПоставщику.Товары КАК ЗаказТовары
	|		ПО  ТаблицаОстатки.Номенклатура     = ЗаказТовары.Номенклатура
	|			И ТаблицаОстатки.Характеристика = ЗаказТовары.Характеристика
	|			И ТаблицаОстатки.КодСтроки      = ЗаказТовары.КодСтроки
	|			И ТаблицаОстатки.ЗаказПоставщику = ЗаказТовары.Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	ТаблицаОстатки.ЗаказПоставщику,
	|	ЗаказТовары.НомерСтроки,
	|	ТаблицаОстатки.Номенклатура,
	|	ТаблицаОстатки.Характеристика,
	|	ТаблицаОстатки.Склад,
	|	ЗаказТовары.ДатаПоступления";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
		"&ТекстЗапросаКоэффициентУпаковки",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
		"ЗаказТовары.Упаковка",
		"ЗаказТовары.Номенклатура"));

	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	
	Запрос.УстановитьПараметр("МассивЗаказов",         МассивЗаказов);
	Запрос.УстановитьПараметр("Партнер",               ДанныеОтбора.Партнер);
	Запрос.УстановитьПараметр("Контрагент",            ДанныеОтбора.Контрагент);
	Запрос.УстановитьПараметр("Договор",               ДанныеОтбора.Договор);
	Запрос.УстановитьПараметр("Организация",           ДанныеОтбора.Организация);
	Запрос.УстановитьПараметр("ХозяйственнаяОперация", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДанныеОтбора.ДокументОснование, "ХозяйственнаяОперация"));
	Запрос.УстановитьПараметр("Соглашение",            ДанныеОтбора.Соглашение);
	Запрос.УстановитьПараметр("ВалютаВзаиморасчетов",  ДанныеОтбора.ВалютаВзаиморасчетов);
	Запрос.УстановитьПараметр("НалогообложениеНДС",    ДанныеОтбора.НалогообложениеНДС);
	Запрос.УстановитьПараметр("ЦенаВключаетНДС",       ДанныеОтбора.ЦенаВключаетНДС);
	Запрос.УстановитьПараметр("ДокументОснование",     ДанныеОтбора.ДокументОснование);
	Запрос.УстановитьПараметр("СкладПоступления",      СкладПоступления);
	Запрос.УстановитьПараметр("ОтобратьПоЗаказу",      МассивЗаказов <> Неопределено);
	
	УстановитьПривилегированныйРежим(Истина);
	Возврат Запрос.Выполнить();

КонецФункции

ВыполняетсяЗакрытие = Ложь;

#КонецОбласти
