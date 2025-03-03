
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ИмяПоляГруппаЗатрат = Параметры.ИмяПоляГруппаЗатрат;
	
	ЗаполнитьТаблицуТоваров();
	
	Если
		//++ Устарело_Производство21 
		Параметры.ГруппировкаЗатрат = Перечисления.ГруппировкиЗатратВЗаказеПереработчику.ПоЗаказамНаПроизводство
		Или
		//-- Устарело_Производство21 
		Параметры.ГруппировкаЗатрат = Перечисления.ГруппировкиЗатратВЗаказеПереработчику.ПоЭтапамПроизводства Тогда
		
		Элементы.ТаблицаТоваровГруппаЗатрат.Заголовок = ПереработкаНаСторонеКлиентСервер.ЗаголовокПоляГруппыЗатрат(
			Параметры.ГруппировкаЗатрат, Параметры.ОбосабливатьПоНазначениюПродукции);
		
	Иначе
		Элементы.ТаблицаТоваровГруппаЗатрат.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПеренестиВДокументВыполнить()
	
	СтруктураПоиска = Новый Структура("Пометка", Истина);
 	СписокСтрок = ТаблицаТоваров.НайтиСтроки(СтруктураПоиска);
	
	Если СписокСтрок.Количество() = 0 Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Необходимо выбрать продукцию.'"));
		Возврат;
	КонецЕсли;
	
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

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	#Область СтандартноеОформление
	
	НоменклатураСервер.УстановитьУсловноеОформлениеХарактеристикНоменклатуры(
		ЭтаФорма, 
		"ТаблицаТоваровХарактеристика",
		"ТаблицаТоваров.ХарактеристикиИспользуются");
																			 
	ПараметрыУсловногоОформления = НоменклатураСервер.НовыеПараметрыУсловногоОформленияЕдиницИзмерения();
	ПараметрыУсловногоОформления.ИмяПоляЕдиницаИзмерения = "ТаблицаТоваровНоменклатураЕдиницаИзмерения";
	ПараметрыУсловногоОформления.ПутьКПолюУпаковка = "ТаблицаТоваров.Упаковка";
	НоменклатураСервер.УстановитьУсловноеОформлениеЕдиницИзмерения(ЭтаФорма, ПараметрыУсловногоОформления);
		
	#КонецОбласти

	#Область Подразделение

	//ТолькоПросмотр, Текст, ЦветТекста
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТаблицаТоваровПодразделение.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ТаблицаТоваров.ТипНоменклатуры");
	ОтборЭлемента.ВидСравнения   = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ТипыНоменклатуры.Работа;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст"      , НСтр("ru = '<для работ>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста" , ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);

	#КонецОбласти
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьВсеТоварыНаСервере(ЗначениеВыбора)
	
	Для Каждого СтрокаТаблицы Из ТаблицаТоваров.НайтиСтроки(Новый Структура("Пометка", Не ЗначениеВыбора)) Цикл
		
		СтрокаТаблицы.Пометка = ЗначениеВыбора;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьВыбраннуюПродукцию()
	
	ДанныеЗаполнения = Новый Массив;
	
	Для каждого ТекущиеДанные Из ТаблицаТоваров Цикл
		
		Если НЕ ТекущиеДанные.Пометка Тогда
			Продолжить;
		КонецЕсли;
		
		ДанныеПродукции = Новый Структура(
			"Номенклатура,
			|Характеристика,
			|Назначение,
			|Получатель,
			|КодСтроки,
			|Упаковка,
			|ТипСтоимости,
			|НомерГруппыЗатрат,
			|ЭтапПроизводства,
			|Цена,
			|Сумма,
			|СтатьяКалькуляции,
			|Спецификация,
			|ДоляСтоимости,
			|ДоляСтоимостиНаЕдиницу,
			|ВидЦены");
		
		ЗаполнитьЗначенияСвойств(ДанныеПродукции, ТекущиеДанные);
		Если ТекущиеДанные.Поступило <> 0 Тогда
			Количество = ТекущиеДанные.Поступило;
		Иначе
			Количество = ТекущиеДанные.Заказано;
		КонецЕсли;
		ДанныеПродукции.Вставить("Количество", Количество);
		
		ДанныеЗаполнения.Добавить(ДанныеПродукции);
		
	КонецЦикла; 
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьТаблицуТоваров()
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ЗаказыПоставщикам.Распоряжение           КАК Распоряжение,
	|	ЗаказыПоставщикам.КодСтроки              КАК КодСтроки,
	|	ЗаказыПоставщикам.Номенклатура           КАК Номенклатура,
	|	ЗаказыПоставщикам.Характеристика         КАК Характеристика,
	|	СУММА(ЗаказыПоставщикам.Поступило)       КАК Поступило,
	|	СУММА(ЗаказыПоставщикам.Заказано)
	|		+ СУММА(ЗаказыПоставщикам.Поступило) КАК Заказано
	|ПОМЕСТИТЬ ТаблицаКОформлению
	|ИЗ 
	|	(ВЫБРАТЬ
	|		ЗаказыПоставщикам.ЗаказПоставщику КАК Распоряжение,
	|		ЗаказыПоставщикам.КодСтроки КАК КодСтроки,
	|		ЗаказыПоставщикам.Номенклатура КАК Номенклатура,
	|		ЗаказыПоставщикам.Характеристика КАК Характеристика,
	|		0 КАК Поступило,
	|		ЗаказыПоставщикам.КОформлениюОстаток КАК Заказано
	|	ИЗ
	|		РегистрНакопления.ЗаказыПоставщикам.Остатки(, ЗаказПоставщику = &Заказ) КАК ЗаказыПоставщикам
	|
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		ТоварыПолученныеОтПереработчикаОстатки.Распоряжение,
	|		ТоварыПолученныеОтПереработчикаОстатки.КодСтроки,
	|		ТоварыПолученныеОтПереработчикаОстатки.АналитикаУчетаНоменклатуры.Номенклатура,
	|		ТоварыПолученныеОтПереработчикаОстатки.АналитикаУчетаНоменклатуры.Характеристика,
	|		ТоварыПолученныеОтПереработчикаОстатки.КоличествоОстаток,
	|		0
	|	ИЗ
	|		РегистрНакопления.ТоварыПолученныеОтПереработчика.Остатки(, Распоряжение = &Заказ) КАК ТоварыПолученныеОтПереработчикаОстатки
	|
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		ТоварыПолученныеОтПереработчикаОстатки.Распоряжение,
	|		ТоварыПолученныеОтПереработчикаОстатки.КодСтроки,
	|		ТоварыПолученныеОтПереработчикаОстатки.АналитикаУчетаНоменклатуры.Номенклатура,
	|		ТоварыПолученныеОтПереработчикаОстатки.АналитикаУчетаНоменклатуры.Характеристика,
	|		ВЫБОР КОГДА ТоварыПолученныеОтПереработчикаОстатки.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|				ТоварыПолученныеОтПереработчикаОстатки.Количество
	|			ИНАЧЕ
	|				-ТоварыПолученныеОтПереработчикаОстатки.Количество
	|			КОНЕЦ,
	|		0
	|	ИЗ
	|		РегистрНакопления.ТоварыПолученныеОтПереработчика КАК ТоварыПолученныеОтПереработчикаОстатки
	|	ГДЕ
	|		ТоварыПолученныеОтПереработчикаОстатки.Регистратор = &Регистратор
	|		И ТоварыПолученныеОтПереработчикаОстатки.Активность) КАК ЗаказыПоставщикам
	|
	|	СГРУППИРОВАТЬ ПО
	|		ЗаказыПоставщикам.Распоряжение,
	|		ЗаказыПоставщикам.КодСтроки,
	|		ЗаказыПоставщикам.Номенклатура,
	|		ЗаказыПоставщикам.Характеристика
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Распоряжение,
	|	КодСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ЕСТЬNULL(ТаблицаПродукция.НомерСтроки, ТаблицаОтходы.НомерСтроки)  КАК Порядок,
	|	ЕСТЬNULL(ТаблицаУслуги.Распоряжение, НЕОПРЕДЕЛЕНО)           КАК Распоряжение,
	|	ТаблицаКОформлению.КодСтроки                                 КАК КодСтроки,
	|	ТаблицаКОформлению.Номенклатура                              КАК Номенклатура,
	|	ТаблицаКОформлению.Характеристика                            КАК Характеристика,
	|	ДанныеНоменклатуры.ТипНоменклатуры                           КАК ТипНоменклатуры,
	|	ЕСТЬNULL(ТаблицаПродукция.Назначение, ТаблицаОтходы.Назначение)                               КАК Назначение,
	|	ЕСТЬNULL(ТаблицаПродукция.Получатель, ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)) КАК Получатель,
	|	ТаблицаПродукция.Спецификация                                КАК Спецификация,
	|	ТаблицаОтходы.ВидЦены                                        КАК ВидЦены,
	|	ЕСТЬNULL(ТаблицаПродукция.Упаковка, ТаблицаОтходы.Упаковка)  КАК Упаковка,
	|	ВЫБОР
	|		КОГДА НЕ ТаблицаПродукция.Количество ЕСТЬ NULL И ТаблицаПродукция.Количество > 0 И ВЫРАЗИТЬ(ТаблицаКОформлению.Распоряжение КАК Документ.ЗаказПереработчику).СпособРаспределенияЗатратНаВыходныеИзделия
	|			= ЗНАЧЕНИЕ(Перечисление.СпособыРаспределенияЗатратНаВыходныеИзделия.ПоДолямСтоимости) 
	|			ТОГДА ТаблицаКОформлению.Заказано * ТаблицаПродукция.ДоляСтоимости / ТаблицаПродукция.Количество
	|		ИНАЧЕ
	|			ТаблицаКОформлению.Заказано * ЕСТЬNULL(ТаблицаПродукция.ДоляСтоимостиНаЕдиницу, 0)
	|	КОНЕЦ                                                        КАК ДоляСтоимости,
	|	ЕСТЬNULL(ТаблицаПродукция.ДоляСтоимостиНаЕдиницу, 0)         КАК ДоляСтоимостиНаЕдиницу,
	|	ТаблицаУслуги.НомерГруппыЗатрат                              КАК НомерГруппыЗатрат,
	|	ТаблицаОтходы.СтатьяКалькуляции                              КАК СтатьяКалькуляции,
	|	ТаблицаУслуги.Распоряжение                                   КАК ЭтапПроизводства,
	|	ВЫБОР
	|		КОГДА НЕ ТаблицаПродукция.Ссылка ЕСТЬ NULL 
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСтоимостиВыходныхИзделий.Рассчитывается)
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ТипыСтоимостиВыходныхИзделий.Фиксированная)
	|	КОНЕЦ                                                        КАК ТипСтоимости,
	|	ЕСТЬNULL(ТаблицаОтходы.Цена, 0)                              КАК Цена,
	|	ЕСТЬNULL(ТаблицаОтходы.Сумма, 0)                             КАК Сумма,
	|	ТаблицаКОформлению.Поступило                                 КАК Поступило,
	|	ТаблицаКОформлению.Заказано                                  КАК Заказано,
	|	
	|	ТаблицаКОформлению.Поступило /
	|					ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки1, ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки2, 1))
	|		КАК ПоступилоУпаковок,
	
	|	ТаблицаКОформлению.Заказано /
	|					ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки1, ЕСТЬNULL(&ТекстЗапросаКоэффициентУпаковки2, 1))
	|		КАК ЗаказаноУпаковок,
	|
	|	ВЫБОР
	|		КОГДА ТаблицаКОформлению.Номенклатура.ИспользованиеХарактеристик В (
	|							ЗНАЧЕНИЕ(Перечисление.ВариантыИспользованияХарактеристикНоменклатуры.ОбщиеДляВидаНоменклатуры), 
	|							ЗНАЧЕНИЕ(Перечисление.ВариантыИспользованияХарактеристикНоменклатуры.ОбщиеСДругимВидомНоменклатуры), 
	|							ЗНАЧЕНИЕ(Перечисление.ВариантыИспользованияХарактеристикНоменклатуры.ИндивидуальныеДляНоменклатуры))
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ХарактеристикиИспользуются,
	|	ВЫРАЗИТЬ(ТаблицаКОформлению.Распоряжение КАК Документ.ЗаказПереработчику).Номер   КАК НомерРаспоряжения,
	|	ВЫРАЗИТЬ(ТаблицаКОформлению.Распоряжение КАК Документ.ЗаказПереработчику).Дата    КАК ДатаРаспоряжения
	|ИЗ
	|	ТаблицаКОформлению КАК ТаблицаКОформлению
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЗаказПереработчику.Продукция КАК ТаблицаПродукция
	|		ПО (ТаблицаПродукция.Ссылка = ТаблицаКОформлению.Распоряжение)
	|			И (ТаблицаПродукция.КодСтроки = ТаблицаКОформлению.КодСтроки)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЗаказПереработчику.ВозвратныеОтходы КАК ТаблицаОтходы
	|		ПО (ТаблицаОтходы.Ссылка = ТаблицаКОформлению.Распоряжение)
	|			И (ТаблицаОтходы.КодСтроки = ТаблицаКОформлению.КодСтроки)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЗаказПереработчику.Услуги КАК ТаблицаУслуги
	|		ПО ТаблицаКОформлению.Распоряжение = ТаблицаУслуги.Ссылка
	|			И(ТаблицаПродукция.НомерГруппыЗатрат = ТаблицаУслуги.НомерГруппыЗатрат
	|				ИЛИ ТаблицаОтходы.НомерГруппыЗатрат = ТаблицаУслуги.НомерГруппыЗатрат)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК ДанныеНоменклатуры
	|		ПО ТаблицаКОформлению.Номенклатура = ДанныеНоменклатуры.Ссылка
	|ГДЕ
	|	(НЕ ТаблицаПродукция.Ссылка ЕСТЬ NULL
	|		ИЛИ НЕ ТаблицаОтходы.Ссылка ЕСТЬ NULL)
	|
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДатаРаспоряжения,
	|	НомерРаспоряжения,
	|	Распоряжение,
	|	Порядок";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
		"&ТекстЗапросаКоэффициентУпаковки1",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
		"ТаблицаПродукция.Упаковка",
		"ТаблицаПродукция.Номенклатура"));
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,
		"&ТекстЗапросаКоэффициентУпаковки2",
		Справочники.УпаковкиЕдиницыИзмерения.ТекстЗапросаКоэффициентаУпаковки(
		"ТаблицаОтходы.Упаковка",
		"ТаблицаОтходы.Номенклатура"));
		
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("Заказ", Параметры.Заказ);
	Запрос.УстановитьПараметр("Регистратор", Параметры.ОтчетПереработчика);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
	
		ДанныеСтроки = ТаблицаТоваров.Добавить();
		ЗаполнитьЗначенияСвойств(ДанныеСтроки, Выборка);
		
		Если
			//++ Устарело_Производство21 
			Параметры.ГруппировкаЗатрат = Перечисления.ГруппировкиЗатратВЗаказеПереработчику.ПоЗаказамНаПроизводство
			ИЛИ
			//-- Устарело_Производство21 
			Параметры.ГруппировкаЗатрат = Перечисления.ГруппировкиЗатратВЗаказеПереработчику.ПоЭтапамПроизводства Тогда
			
			ДанныеСтроки.ГруппаЗатрат = ПереработкаНаСтороне.ПредставлениеГруппыЗатрат(
										Выборка, 
										Параметры.ГруппировкаЗатрат, 
										Неопределено,
										ИмяПоляГруппаЗатрат);
		КонецЕсли; 
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПеренестиТоварыВДокумент()
	
	ДанныеЗаполнения = ПолучитьВыбраннуюПродукцию();
	
	Закрыть(ДанныеЗаполнения);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
