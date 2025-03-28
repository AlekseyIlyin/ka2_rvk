////////////////////////////////////////////////////////////////////////////////
// Локализованные процедуры, связанные с расчетом стоимости ОС и НМА
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура ОбработатьРасчетРасходов(РасчетРасходов, ТаблицаОбъектов) Экспорт

	//++ Локализация
	ОбработатьРасчетРасходовПриЦелевомФинансировании(РасчетРасходов, ТаблицаОбъектов);
	КорректировкаСтоимостиАрендованногоИмущества(РасчетРасходов, ТаблицаОбъектов);
	//-- Локализация
	
КонецПроцедуры

Функция ТекстЗапросаВтРасчетСтоимости() Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ТекущиеРасходы.Ссылка                    КАК Ссылка,
	|	ТекущиеРасходы.Организация               КАК Организация,
	|	ТекущиеРасходы.ИдентификаторСтроки       КАК ИдентификаторСтроки,
	|	ТекущиеРасходы.ИдентификаторСтрокиБУ     КАК ИдентификаторСтрокиБУ,
	|	ТекущиеРасходы.ИдентификаторСтрокиНУ     КАК ИдентификаторСтрокиНУ,
	|	ТекущиеРасходы.ОбъектУчета               КАК ОбъектУчета,
	|	ТекущиеРасходы.СтатьяРасходов            КАК КорСтатьяРасходов,
	|	ТекущиеРасходы.АналитикаРасходов         КАК КорАналитикаРасходов,
	|	ТекущиеРасходы.Подразделение             КАК КорПодразделение,
	|	ТекущиеРасходы.НаправлениеДеятельности   КАК КорНаправлениеДеятельности,
	|
	|	ТекущиеРасходы.СуммаУпр                  КАК Стоимость,
	|	ТекущиеРасходы.Сумма                     КАК Сумма,
	|
	// СтоимостьРегл
	|	ВЫБОР
	|		КОГДА ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования = ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА 0
	|		ИНАЧЕ ТекущиеРасходы.СуммаРегл - ТекущиеРасходы.СуммаЦФ
	|	КОНЕЦ КАК СтоимостьРегл,
	|
	// СтоимостьНУ
	|	ВЫБОР
	|		КОГДА НЕ втУчетнаяПолитика.ПлательщикНалогаНаПрибыль
	|				ИЛИ ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования = ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА 0
	|		ИНАЧЕ ТекущиеРасходы.СуммаРегл
	|				- ТекущиеРасходы.ПостояннаяРазница
	|				- ТекущиеРасходы.ВременнаяРазница
	|				- (ТекущиеРасходы.СуммаЦФ - ТекущиеРасходы.СуммаПРЦФ - ТекущиеРасходы.СуммаВРЦФ) 
	|				- ТекущиеРасходы.НеУчитываемаяСтоимостьНУ
	|	КОНЕЦ КАК СтоимостьНУ,
	|
	// СтоимостьПР
	|	ВЫБОР
	|		КОГДА ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования = ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА 0
	|		ИНАЧЕ ТекущиеРасходы.ПостояннаяРазница - ТекущиеРасходы.СуммаПРЦФ
	|	КОНЕЦ КАК СтоимостьПР,
	|
	// СтоимостьВР
	|	ВЫБОР
	|		КОГДА ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования = ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА 0
	|		ИНАЧЕ ТекущиеРасходы.ВременнаяРазница - ТекущиеРасходы.СуммаВРЦФ + ТекущиеРасходы.НеУчитываемаяСтоимостьНУ
	|	КОНЕЦ КАК СтоимостьВР,
	|
	|	0 КАК СтоимостьЦФ,
	|	0 КАК СтоимостьНУЦФ,
	|	0 КАК СтоимостьПРЦФ,
	|	0 КАК СтоимостьВРЦФ,
	|
	// КорСуммаНУ
	|	ВЫБОР
	|		КОГДА ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования = ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА 0
	|		ИНАЧЕ ТекущиеРасходы.СуммаРегл - ТекущиеРасходы.ПостояннаяРазница - ТекущиеРасходы.ВременнаяРазница
	|				- (ТекущиеРасходы.СуммаЦФ - ТекущиеРасходы.СуммаПРЦФ - ТекущиеРасходы.СуммаВРЦФ)
	|	КОНЕЦ КАК КорСуммаНУ,
	|
	// КорПостояннаяРазница
	|	ВЫБОР  
	|		КОГДА ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования = ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА 0
	|		ИНАЧЕ ТекущиеРасходы.ПостояннаяРазница - ТекущиеРасходы.СуммаПРЦФ
	|	КОНЕЦ КАК КорПостояннаяРазница,
	|
	|	ТекущиеРасходы.НеУчитываемаяСтоимостьНУ КАК НеУчитываемаяСтоимостьНУ,
	|	ТекущиеРасходы.СуммаНДД КАК СуммаНДД
	|
	|ПОМЕСТИТЬ ВтРасчетСтоимости
	|
	|ИЗ
	|	втТекущиеРасходы КАК ТекущиеРасходы
	|
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтТаблицаОбъектов КАК ВтТаблицаОбъектов
	|		ПО ВтТаблицаОбъектов.Ссылка = ТекущиеРасходы.Ссылка
	|			И ВтТаблицаОбъектов.ОбъектУчета = ТекущиеРасходы.ОбъектУчета
	|
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ втУчетнаяПолитика КАК втУчетнаяПолитика
	|		ПО втУчетнаяПолитика.Организация = ТекущиеРасходы.Организация
	|
	|ГДЕ
	|	ТекущиеРасходы.СуммаУпр <> 0
	|		ИЛИ ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования <> ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			И (ТекущиеРасходы.СуммаРегл <> 0
	|				ИЛИ ТекущиеРасходы.ПостояннаяРазница <> 0
	|				ИЛИ ТекущиеРасходы.ВременнаяРазница <> 0)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ТекущиеРасходы.Ссылка                    КАК Ссылка,
	|	ТекущиеРасходы.Организация               КАК Организация,
	|	ТекущиеРасходы.ИдентификаторСтроки       КАК ИдентификаторСтроки,
	|	ТекущиеРасходы.ИдентификаторСтрокиБУ     КАК ИдентификаторСтрокиБУ,
	|	ТекущиеРасходы.ИдентификаторСтрокиНУ     КАК ИдентификаторСтрокиНУ,
	|	ТекущиеРасходы.ОбъектУчета               КАК ОбъектУчета,
	|	ТекущиеРасходы.СтатьяРасходов            КАК КорСтатьяРасходов,
	|	ТекущиеРасходы.АналитикаРасходов         КАК КорАналитикаРасходов,
	|	ТекущиеРасходы.Подразделение             КАК КорПодразделение,
	|	ТекущиеРасходы.НаправлениеДеятельности   КАК КорНаправлениеДеятельности,
	|
	|	0 КАК Стоимость,
	|	0 КАК Сумма,
	|
	|	0 КАК СтоимостьРегл,
	|	0 КАК СтоимостьНУ,
	|	0 КАК СтоимостьПР,
	|	0 КАК СтоимостьВР,
	|
	// СтоимостьЦФ
	|	ВЫБОР ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА ТекущиеРасходы.СуммаРегл
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Частичное)
	|			ТОГДА ТекущиеРасходы.СуммаЦФ
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК СтоимостьЦФ,
	|
	// СтоимостьНУЦФ
	|	0 КАК СтоимостьНУЦФ,
	|
	// СтоимостьПРЦФ
	|	ВЫБОР ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА ТекущиеРасходы.СуммаРегл
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Частичное)
	|			ТОГДА ТекущиеРасходы.СуммаЦФ 
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК СтоимостьПРЦФ,
	|
	// СтоимостьВРЦФ
	|	0 КАК СтоимостьВРЦФ,
	|
	// КорСуммаНУ
	|	ВЫБОР ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА ТекущиеРасходы.СуммаРегл - ТекущиеРасходы.ПостояннаяРазница - ТекущиеРасходы.ВременнаяРазница
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Частичное)
	|			ТОГДА ТекущиеРасходы.СуммаЦФ - ТекущиеРасходы.СуммаПРЦФ - ТекущиеРасходы.СуммаВРЦФ
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК КорСуммаНУ,
	|
	// КорПостояннаяРазница
	|	ВЫБОР ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|			ТОГДА ТекущиеРасходы.ПостояннаяРазница
	|		ИНАЧЕ ТекущиеРасходы.СуммаПРЦФ
	|	КОНЕЦ КАК КорПостояннаяРазница,
	|
	|	0 КАК НеУчитываемаяСтоимостьНУ,
	|	ТекущиеРасходы.СуммаНДД КАК СуммаНДД
	|
	|ИЗ
	|	втТекущиеРасходы КАК ТекущиеРасходы
	|
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтТаблицаОбъектов КАК ВтТаблицаОбъектов
	|		ПО ВтТаблицаОбъектов.Ссылка = ТекущиеРасходы.Ссылка
	|			И ВтТаблицаОбъектов.ОбъектУчета = ТекущиеРасходы.ОбъектУчета
	|
	|ГДЕ
	|	ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования = ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Полное)
	|	ИЛИ ВтТаблицаОбъектов.ВариантПримененияЦелевогоФинансирования = ЗНАЧЕНИЕ(Перечисление.ВариантыПримененияЦелевогоФинансирования.Частичное)
	|		И (ТекущиеРасходы.СуммаЦФ <> 0
	|			ИЛИ ТекущиеРасходы.СуммаПРЦФ <> 0
	|			ИЛИ ТекущиеРасходы.СуммаВРЦФ <> 0)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|";
	
	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаВтУчетнаяПолитика() Экспорт
	
	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	СписокОрганизаций.Организация КАК Организация,
	|	НастройкиУчетаНалогаНаПрибыль.ВключатьВСоставНалоговыхРасходовАрендныеПлатежи КАК ВключатьВСоставНалоговыхРасходовАрендныеПлатежи,
	|	НастройкиСистемыНалогообложения.ПлательщикНалогаНаПрибыль КАК ПлательщикНалогаНаПрибыль
	|	
	|ПОМЕСТИТЬ ВтУчетнаяПолитика
	|
	|ИЗ
	|	(ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		ВтПорцияДанныхКРасчету.Организация КАК Организация,
	|		ВЫРАЗИТЬ(ВтПорцияДанныхКРасчету.Организация КАК Справочник.Организации).ГоловнаяОрганизация КАК ГоловнаяОрганизация
	|	ИЗ
	|		ВтПорцияДанныхКРасчету КАК ВтПорцияДанныхКРасчету
	|		
	|	) КАК СписокОрганизаций
	|	
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.НастройкиУчетаНалогаНаПрибыль.СрезПоследних(&КонецМесяца) КАК НастройкиУчетаНалогаНаПрибыль
	|		ПО НастройкиУчетаНалогаНаПрибыль.Организация = СписокОрганизаций.ГоловнаяОрганизация
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.НастройкиСистемыНалогообложения.СрезПоследних(&КонецМесяца) КАК НастройкиСистемыНалогообложения
	|		ПО НастройкиСистемыНалогообложения.Организация = СписокОрганизаций.ГоловнаяОрганизация
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Организация
	|";
	
	//-- Локализация

	Возврат ТекстЗапроса;
	
КонецФункции

Процедура ДополнитьТипыДокументовДвиженияКоторыхНужноПеренестиНаНачалоМесяца(ТипыОбъектов) Экспорт

	//++ Локализация
	ВнеоборотныеАктивыСлужебный.ДобавитьТипОбъектаМетаданных("РаспределениеНДС", Ложь, ТипыОбъектов);
	//-- Локализация
	
КонецПроцедуры

Процедура УчестьОтражениеВУчетеПриРасчетеСтоимости(ДанныеСтроки, СтрокаДокумента) Экспорт

	//++ Локализация
	
	Если НЕ СтрокаДокумента.ОтражатьВБУ
		И НЕ СтрокаДокумента.ОтражатьВНУ Тогда
								
		ДанныеСтроки.СуммаРегл = 0;
		ДанныеСтроки.ПостояннаяРазница = 0;
		ДанныеСтроки.ВременнаяРазница  = 0;
		
	ИначеЕсли СтрокаДокумента.ОтражатьВБУ
		И НЕ СтрокаДокумента.ОтражатьВНУ Тогда
								
		ДанныеСтроки.ВременнаяРазница = ДанныеСтроки.СуммаРегл - ДанныеСтроки.ПостояннаяРазница;
		
	ИначеЕсли НЕ СтрокаДокумента.ОтражатьВБУ
		И СтрокаДокумента.ОтражатьВНУ Тогда
								
		ДанныеСтроки.ВременнаяРазница = -(ДанныеСтроки.СуммаРегл - ДанныеСтроки.ВременнаяРазница - ДанныеСтроки.ПостояннаяРазница);
		ДанныеСтроки.СуммаРегл = 0;
		ДанныеСтроки.ПостояннаяРазница = 0;
		
	КонецЕсли;
	
	//-- Локализация
	
КонецПроцедуры

Процедура ЗаписатьТаблицыДвижений(ТаблицыДвижений, ПараметрыВыполнения) Экспорт
	
	//++ Локализация
	
	Если ПараметрыВыполнения.СформироватьЗадания Тогда
		СформироватьЗаданияКДоначислениюНалогаНаИмущество(ПараметрыВыполнения.МенеджерВременныхТаблиц);
	КонецЕсли;
	
	//-- Локализация
	
КонецПроцедуры

//++ Локализация

Процедура ОбработатьРасчетРасходовПриЦелевомФинансировании(РасчетРасходов, ТаблицаОбъектов)

	Для Каждого ДанныеОбъекта Из ТаблицаОбъектов Цикл
		
		Если ДанныеОбъекта.ВариантПримененияЦелевогоФинансирования <> Перечисления.ВариантыПримененияЦелевогоФинансирования.Частичное Тогда
			Продолжить;
		КонецЕсли; 
			
		// Сумму целевых средств нужно распределить пропорционально по строкам расходов.
		СтоимостьРеглКоэффициенты = Новый Массив;
		
		СтруктураПоиска = Новый Структура("АналитикаРасходов", ДанныеОбъекта.АналитикаКапитализацииРасходов);
		СписокСтрок = РасчетРасходов.НайтиСтроки(СтруктураПоиска);
		Для каждого СтрокаРасход Из СписокСтрок Цикл
			СтоимостьРеглКоэффициенты.Добавить(СтрокаРасход.СуммаРегл);
		КонецЦикла; 
		
		СуммаЦФ = ОбщегоНазначения.РаспределитьСуммуПропорциональноКоэффициентам(ДанныеОбъекта.СуммаЦелевыхСредств, СтоимостьРеглКоэффициенты);
		
		Для Сч = 0 По СписокСтрок.ВГраница() Цикл
			
			СтрокаРасход = СписокСтрок[Сч];
			
			СтрокаРасход.СуммаЦФ = ?(СуммаЦФ <> Неопределено, СуммаЦФ[Сч], 0);
			СтрокаРасход.СуммаПРЦФ = Мин(СтрокаРасход.СуммаЦФ, СтрокаРасход.ПостояннаяРазница);
			СтрокаРасход.СуммаВРЦФ = СтрокаРасход.СуммаЦФ - СтрокаРасход.СуммаПРЦФ;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура КорректировкаСтоимостиАрендованногоИмущества(РасчетРасходов, ТаблицаОбъектов)

	Для Каждого ДанныеОбъекта Из ТаблицаОбъектов Цикл
		
		Если ДанныеОбъекта.ХозяйственнаяОперация <> Перечисления.ХозяйственныеОперации.ПринятиеКУчетуПредметовАренды
			ИЛИ НЕ ДанныеОбъекта.ВключатьВСоставНалоговыхРасходовАрендныеПлатежи Тогда
			Продолжить;
		КонецЕсли; 
			
		// Стоимость в НУ распределить пропорционально по строкам расходов.
		СтоимостьНУКоэффициенты = Новый Массив;
		
		СтруктураПоиска = Новый Структура("АналитикаРасходов", ДанныеОбъекта.АналитикаКапитализацииРасходов);
		СписокСтрок = РасчетРасходов.НайтиСтроки(СтруктураПоиска);
		Для каждого СтрокаРасход Из СписокСтрок Цикл
			СтоимостьНУКоэффициенты.Добавить(СтрокаРасход.СуммаРегл - СтрокаРасход.ПостояннаяРазница - СтрокаРасход.ВременнаяРазница);
		КонецЦикла; 
		
		СуммаНУ = ОбщегоНазначения.РаспределитьСуммуПропорциональноКоэффициентам(ДанныеОбъекта.СтоимостьНУ, СтоимостьНУКоэффициенты);

		Если СуммаНУ = Неопределено Тогда
			Продолжить
		КонецЕсли;
		
		Для Сч = 0 По СписокСтрок.ВГраница() Цикл
			
			СтрокаРасход = СписокСтрок[Сч];
			СтрокаРасход.НеУчитываемаяСтоимостьНУ = СтоимостьНУКоэффициенты[Сч] - СуммаНУ[Сч];
			
		КонецЦикла;
		
	КонецЦикла;

КонецПроцедуры

Процедура СформироватьЗаданияКДоначислениюНалогаНаИмущество(МенеджерВременныхТаблиц) Экспорт
	
	ИспользуемыеВТ = ОбщегоНазначенияУТ.СписокВременныхТаблиц(МенеджерВременныхТаблиц);
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ПорядокУчетаОСБУ.Организация КАК Организация,
	|	ПорядокУчетаОСБУ.ОсновноеСредство КАК ОсновноеСредство,
	|	МАКСИМУМ(ПорядокУчетаОСБУ.Период) КАК Период
	|ПОМЕСТИТЬ ДатыДляСрезаПоследних
	|ИЗ
	|	РегистрСведений.ПорядокУчетаОСБУ КАК ПорядокУчетаОСБУ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтТаблицаОбъектов КАК ВтТаблицаОбъектов
	|		ПО ПорядокУчетаОСБУ.Организация = ВтТаблицаОбъектов.Организация
	|			И ПорядокУчетаОСБУ.ОсновноеСредство = ВтТаблицаОбъектов.ОбъектУчета
	|ГДЕ
	|	ПорядокУчетаОСБУ.Период <= КОНЕЦПЕРИОДА(ВтТаблицаОбъектов.Дата, МЕСЯЦ)
	|
	|СГРУППИРОВАТЬ ПО
	|	ПорядокУчетаОСБУ.Организация,
	|	ПорядокУчетаОСБУ.ОсновноеСредство
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Организация,
	|	ОсновноеСредство
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПорядокУчетаОСБУ.Организация КАК Организация,
	|	ПорядокУчетаОСБУ.ОсновноеСредство КАК ОсновноеСредство,
	|	ПорядокУчетаОСБУ.НедвижимоеИмущество КАК НедвижимоеИмущество
	|ПОМЕСТИТЬ ПризнакНедвижимогоИмущества
	|ИЗ
	|	ДатыДляСрезаПоследних КАК ДатыДляСрезаПоследних
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПорядокУчетаОСБУ КАК ПорядокУчетаОСБУ
	|		ПО ДатыДляСрезаПоследних.Организация = ПорядокУчетаОСБУ.Организация
	|			И ДатыДляСрезаПоследних.ОсновноеСредство = ПорядокУчетаОСБУ.ОсновноеСредство
	|			И ДатыДляСрезаПоследних.Период = ПорядокУчетаОСБУ.Период
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Организация,
	|	ОсновноеСредство
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВтТаблицаОбъектов.Ссылка КАК Ссылка,
	|	ВтТаблицаОбъектов.Организация КАК Организация,
	|	ВтТаблицаОбъектов.ОбъектУчета КАК ОбъектУчета,
	|	ВтТаблицаОбъектов.Дата КАК Месяц,
	|	ЕСТЬNULL(ПризнакНедвижимогоИмущества.НедвижимоеИмущество, ЛОЖЬ) КАК НедвижимоеИмущество
	|ПОМЕСТИТЬ ВтСписокОбъектов
	|ИЗ
	|	ВтТаблицаОбъектов КАК ВтТаблицаОбъектов
	|		ЛЕВОЕ СОЕДИНЕНИЕ ПризнакНедвижимогоИмущества КАК ПризнакНедвижимогоИмущества
	|		ПО ВтТаблицаОбъектов.Организация = ПризнакНедвижимогоИмущества.Организация
	|			И ВтТаблицаОбъектов.ОбъектУчета = ПризнакНедвижимогоИмущества.ОсновноеСредство
	|ГДЕ
	|	КОНЕЦПЕРИОДА(ВтТаблицаОбъектов.Дата, МЕСЯЦ) = КОНЕЦПЕРИОДА(ВтТаблицаОбъектов.Дата, КВАРТАЛ)
	|	И ЕСТЬNULL(ПризнакНедвижимогоИмущества.НедвижимоеИмущество, ЛОЖЬ) = ИСТИНА
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаСтоимости.Ссылка КАК Ссылка,
	|	ТаблицаСтоимости.Организация КАК Организация,
	|	ТаблицаСтоимости.ОбъектУчета КАК ОбъектУчета
	|
	|ПОМЕСТИТЬ ВТ_РазницаВСтоимостиОС
	|
	|ИЗ
	|	(ВЫБРАТЬ
	|		ТаблицаСтоимости.Регистратор КАК Ссылка,
	|		ТаблицаСтоимости.Организация КАК Организация,
	|		ТаблицаСтоимости.ОсновноеСредство КАК ОбъектУчета,
	|
	|		ТаблицаСтоимости.Стоимость КАК ФактическаяСтоимостьУУ,
	|		ТаблицаСтоимости.СтоимостьРегл + ТаблицаСтоимости.СтоимостьЦФ КАК ФактическаяСтоимостьБУ,
	|
	|		0 КАК ПредварительнаяСтоимостьУУ,
	|		0 КАК ПредварительнаяСтоимостьБУ
	|	ИЗ
	|		РегистрНакопления.СтоимостьОС КАК ТаблицаСтоимости
	|
	|	ГДЕ
	|		ТаблицаСтоимости.РасчетСтоимости
	|		И ТаблицаСтоимости.Регистратор В
	|				(ВЫБРАТЬ
	|					ВтСписокОбъектов.Ссылка
	|				ИЗ
	|					ВтСписокОбъектов КАК ВтСписокОбъектов)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ТаблицаСтоимости.Ссылка КАК Ссылка,
	|		ТаблицаСтоимости.Ссылка.Организация КАК Организация,
	|		ТаблицаСтоимости.ОсновноеСредство КАК ОбъектУчета,
	|
	|		0 КАК ФактическаяСтоимостьУУ,
	|		0 КАК ФактическаяСтоимостьБУ,
	|
	|		ТаблицаСтоимости.СтоимостьУУ КАК ПредварительнаяСтоимостьУУ,
	|		ТаблицаСтоимости.СтоимостьБУ КАК ПредварительнаяСтоимостьБУ
	|	ИЗ
	|		Документ.ПринятиеКУчетуОС2_4.ОС КАК ТаблицаСтоимости
	|
	|	ГДЕ
	|		ТаблицаСтоимости.Ссылка В
	|				(ВЫБРАТЬ
	|					ВтСписокОбъектов.Ссылка
	|				ИЗ
	|					ВтСписокОбъектов КАК ВтСписокОбъектов)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ТаблицаСтоимости.Ссылка КАК Ссылка,
	|		ТаблицаСтоимости.Ссылка.Организация КАК Организация,
	|		ТаблицаСтоимости.ОсновноеСредство КАК ОбъектУчета,
	|
	|		0 КАК ФактическаяСтоимостьУУ,
	|		0 КАК ФактическаяСтоимостьБУ,
	|
	|		ТаблицаСтоимости.СтоимостьУУ КАК ПредварительнаяСтоимостьУУ,
	|		ТаблицаСтоимости.СтоимостьБУ КАК ПредварительнаяСтоимостьБУ
	|
	|	ИЗ
	|		Документ.МодернизацияОС2_4.ОС КАК ТаблицаСтоимости
	|
	|	ГДЕ
	|		ТаблицаСтоимости.Ссылка В
	|				(ВЫБРАТЬ
	|					ВтСписокОбъектов.Ссылка
	|				ИЗ
	|					ВтСписокОбъектов КАК ВтСписокОбъектов)
	|
	|	) КАК ТаблицаСтоимости
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаСтоимости.Ссылка,
	|	ТаблицаСтоимости.Организация,
	|	ТаблицаСтоимости.ОбъектУчета
	|
	|ИМЕЮЩИЕ
	|	(СУММА(ТаблицаСтоимости.ФактическаяСтоимостьУУ) > СУММА(ТаблицаСтоимости.ПредварительнаяСтоимостьУУ)
	|		ИЛИ СУММА(ТаблицаСтоимости.ФактическаяСтоимостьБУ) > СУММА(ТаблицаСтоимости.ПредварительнаяСтоимостьБУ))
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка,
	|	ОбъектУчета
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВтСписокОбъектов.Ссылка КАК Документ,
	|	ВтСписокОбъектов.Организация КАК Организация,
	|	ВтСписокОбъектов.ОбъектУчета КАК ОбъектУчета,
	|	ВтСписокОбъектов.Месяц КАК Месяц
	|
	|ИЗ
	|	ВтСписокОбъектов КАК ВтСписокОбъектов
	|
	|ГДЕ
	|	(ВтСписокОбъектов.Ссылка, ВтСписокОбъектов.ОбъектУчета) В (
	|		ВЫБРАТЬ
	|			ВТ_РазницаВСтоимостиОС.Ссылка,
	|			ВТ_РазницаВСтоимостиОС.ОбъектУчета
	|		ИЗ
	|			ВТ_РазницаВСтоимостиОС КАК ВТ_РазницаВСтоимостиОС)
	|";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	УстановитьПривилегированныйРежим(Истина);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	РегистрыСведений.ЗаданияКДоначислениюНалогаНаИмущество.СоздатьЗаписиРегистраПоДаннымВыборки(РезультатЗапроса.Выбрать());
	
	ОбщегоНазначенияУТ.УничтожитьВременныеТаблицы(МенеджерВременныхТаблиц,, ИспользуемыеВТ);
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

//-- Локализация

#КонецОбласти
