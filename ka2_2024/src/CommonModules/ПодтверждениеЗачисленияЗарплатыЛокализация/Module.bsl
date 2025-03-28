#Область ПрограммныйИнтерфейс

#Область Проведение

// Описывает учетные механизмы используемые в документе для регистрации в механизме проведения.
//
// Параметры:
//  МеханизмыДокумента - Массив - список имен учетных механизмов, для которых будет выполнена
//              регистрация в механизме проведения.
//
Процедура ЗарегистрироватьУчетныеМеханизмы(МеханизмыДокумента) Экспорт
	
	//++ Локализация

	//++ НЕ УТ
	МеханизмыДокумента.Добавить("РегламентированныйУчет");
	//-- НЕ УТ

	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

//++ НЕ УТ
#Область ПроводкиРегУчета

// Функция возвращает текст запроса для отражения документа в регламентированном учете.
//
// Возвращаемое значение:
//	Строка - Текст запроса
//
Функция ТекстОтраженияВРеглУчете() Экспорт
	
	ТекстыОтражения = Новый Массив;
	
	//++ Локализация
	
#Область ТекстВыдачаПодотчетнику // Дт 71.21 :: Кт 57.21, Дт 71.01 :: Кт 57.01
	ТекстЗапроса = "
	|ВЫБРАТЬ // Выдача подотчетнику  (Дт 71.21 :: Кт 57.21, Дт 71.01 :: Кт 57.01 )
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	Строки.СуммаРегл КАК Сумма,
	|	Строки.СуммаУпр КАК СуммаУУ,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК ГруппаФинансовогоУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	Операция.Валюта КАК ВалютаДт,
	|	СписаниеБезналичныхДенежныхСредств.Подразделение КАК ПодразделениеДт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиДт,
	|
	|	ВЫБОР КОГДА Операция.Валюта = &ВалютаРеглУчета ТОГДА
	|		ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицами)
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПодотчетнымиЛицамиВал)
	|	КОНЕЦ КАК СчетДт,
	|	Строки.ПодотчетноеЛицо КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	Строки.Сумма КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	СписаниеБезналичныхДенежныхСредств.Валюта КАК ВалютаКт,
	|	СписаниеБезналичныхДенежныхСредств.Подразделение КАК ПодразделениеКт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиКт,
	|
	|	ВЫБОР КОГДА Операция.Валюта = &ВалютаРеглУчета ТОГДА
	|		ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПереводыВПути)
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПереводыВПутиВал)
	|	КОНЕЦ КАК СчетКт,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт1,
	|	Строки.СтатьяДвиженияДенежныхСредств КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	Строки.Сумма КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""Выдача подотчетнику"" КАК Содержание
	|
	|ИЗ 
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.ПодтверждениеЗачисленияЗарплаты КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеБезналичныхДенежныхСредств КАК СписаниеБезналичныхДенежныхСредств
	|	ПО
	|		Операция.ПервичныйДокумент = СписаниеБезналичныхДенежныхСредств.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РегистрНакопления.ДенежныеСредстваУПодотчетныхЛиц КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Регистратор
	|
	|ГДЕ 
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВыдачаДенежныхСредствПодотчетнику)
	|";
	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти
	
#Область ТекстВыплатаЗарплатыПоЗарплатномуПроекту // (Дт 70 :: Кт 57.01)
	ТекстЗапроса = "
	|ВЫБРАТЬ // Выплата зарплаты по зарплатному проекту  (Дт 70 :: Кт 57.01 )
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(ВыплатыСотрудникам.КВыплате, Операция.Сумма) * ЕСТЬNULL(КурсВалютыДокумента.Курс, 1) КАК Сумма,
	|	ЕСТЬNULL(ВыплатыСотрудникам.КВыплате, Операция.Сумма) * ЕСТЬNULL(КурсВалютыДокумента.Курс, 1) / ЕСТЬNULL(КурсВалютыУпрУчета.Курс, 1) КАК СуммаУУ,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК ГруппаФинансовогоУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	Операция.Валюта КАК ВалютаДт,
	|	НЕОПРЕДЕЛЕНО КАК ПодразделениеДт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиДт,
	|
	|	ЕСТЬNULL(ВыплатыСотрудникам.СчетУчета, ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПерсоналомПоОплатеТруда)) КАК СчетДт,
	|	ВЫБОР КОГДА Операция.ПроводкиПоРаботникам
	|		ТОГДА Операция.ФизическоеЛицо
	|	ИНАЧЕ
	|		ЗНАЧЕНИЕ(Справочник.ФизическиеЛица.ПустаяСсылка)
	|	КОНЕЦ КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	ЕСТЬNULL(ВыплатыСотрудникам.КВыплате, Операция.Сумма) КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Операция.Валюта КАК ВалютаКт,
	|	СписаниеБезналичныхДенежныхСредств.БанковскийСчет.Подразделение КАК ПодразделениеКт,
	|	СписаниеБезналичныхДенежныхСредств.БанковскийСчет.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПереводыВПути) КАК СчетКт,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт1,
	|	Операция.СтатьяДвиженияДенежныхСредств КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	ЕСТЬNULL(ВыплатыСотрудникам.КВыплате, Операция.Сумма) КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""Выплата зарплаты по зарплатному проекту"" КАК Содержание
	|
	|ИЗ
	|	РезультатыЗачисления КАК Операция
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеБезналичныхДенежныхСредств КАК СписаниеБезналичныхДенежныхСредств
	|	ПО
	|		Операция.ПервичныйДокумент = СписаниеБезналичныхДенежныхСредств.Ссылка
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВыплатыСотрудникам КАК ВыплатыСотрудникам
	|	ПО
	|		Операция.Ссылка = ВыплатыСотрудникам.Ссылка
	|		И Операция.ФизическоеЛицо = ВыплатыСотрудникам.ФизическоеЛицо
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		КурсыВалют КАК КурсВалютыУпрУчета
	|	ПО
	|		КурсВалютыУпрУчета.Валюта = &ВалютаУпрУчета
	|		И КурсВалютыУпрУчета.Дата = Операция.Дата
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		КурсыВалют КАК КурсВалютыДокумента
	|	ПО
	|		КурсВалютыДокумента.Валюта = Операция.Валюта
	|		И КурсВалютыДокумента.Дата = Операция.Дата
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Константа.ДатаНачалаПеречисленияЗарплатыЧерезПереводыВПути КАК ДатаНачалаПеречисленияЗарплатыЧерезПереводыВПути
	|	ПО (ИСТИНА)
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Константа.ИспользоватьНачислениеЗарплаты КАК ИспользоватьНачислениеЗарплаты
	|	ПО (ИСТИНА)
	|
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВыплатаЗарплатыПоЗарплатномуПроекту)
	|	И Операция.РезультатЗачисленияЗарплаты = ЗНАЧЕНИЕ(Перечисление.РезультатыЗачисленияЗарплаты.Зачислено)
	|	И Операция.Дата >= ДатаНачалаПеречисленияЗарплатыЧерезПереводыВПути.Значение
	|	И ДатаНачалаПеречисленияЗарплатыЧерезПереводыВПути.Значение <> ДАТАВРЕМЯ(1,1,1)
	|	И ИспользоватьНачислениеЗарплаты.Значение
	|";
	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти
	//-- Локализация
	Возврат СтрСоединить(ТекстыОтражения, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении());

КонецФункции

// Функция возвращает текст запроса дополнительных временных таблиц, необходимых для отражения в регламентированном учете.
//
// Возвращаемое значение:
//   Строка - сформированный текст запроса.
//
Функция ТекстЗапросаВТОтраженияВРеглУчете() Экспорт
	
	//++ Локализация
	
	ТекстыЗапроса = Новый Массив;
	
	#Область ВыплатыСотрудникам
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Ссылка КАК СтатьяРасходов,
	|	ВЫБОР СпособРасчетовСФизическимиЛицами
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.СпособыРасчетовСФизическимиЛицами.ПрочиеРасчетыСПерсоналом)
	|			ТОГДА ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыПоПрочимОперациям)
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.СпособыРасчетовСФизическимиЛицами.РасчетыСКонтрагентами)
	|			ТОГДА ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПрочиеРасчетыСРазнымиДебиторамиИКредиторами)
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.СпособыРасчетовСФизическимиЛицами.Дивиденды)
	|			ТОГДА ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыПоВыплатеДоходов)
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.СпособыРасчетовСФизическимиЛицами.ДивидендыСотрудникам)
	|			ТОГДА ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыПоВыплатеДоходов)
	|		ИНАЧЕ ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПерсоналомПоОплатеТруда)
	|	КОНЕЦ КАК Счет
	|ПОМЕСТИТЬ СчетаУчетаСтатейРасходовЗарплаты
	|ИЗ
	|	Справочник.СтатьиРасходовЗарплата КАК СтатьиРасходовЗарплата
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	Операция.Дата КАК Дата,
	|	Операция.Организация КАК Организация,
	|	Операция.Валюта КАК Валюта,
	|	Операция.ПроводкиПоРаботникам КАК ПроводкиПоРаботникам,
	|	Операция.ПервичныйДокумент КАК ПервичныйДокумент,
	|	Строки.ФизическоеЛицо КАК ФизическоеЛицо,
	|	СУММА(Строки.Сумма) КАК Сумма,
	|	Строки.СтатьяДвиженияДенежныхСредств КАК СтатьяДвиженияДенежныхСредств,
	|	Строки.РезультатЗачисленияЗарплаты КАК РезультатЗачисленияЗарплаты
	|ПОМЕСТИТЬ РезультатыЗачисления
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПодтверждениеЗачисленияЗарплаты КАК Операция
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПодтверждениеЗачисленияЗарплаты.Сотрудники КАК Строки
	|			ПО Операция.Ссылка = Строки.Ссылка
	|		ПО ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	Операция.Ссылка,
	|	Строки.ФизическоеЛицо,
	|	Строки.СтатьяДвиженияДенежныхСредств,
	|	Операция.Дата,
	|	Операция.Организация,
	|	Операция.Валюта,
	|	Операция.ПроводкиПоРаботникам,
	|	Операция.ПервичныйДокумент,
	|	Строки.РезультатЗачисленияЗарплаты,
	|	Операция.ХозяйственнаяОперация";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	РезультатыЗачисления.Ссылка КАК Ссылка,
	|	ДанныеПервичногоДокумента.Ведомость КАК Ведомость,
	|	РезультатыЗачисления.ФизическоеЛицо КАК ФизическоеЛицо
	|ПОМЕСТИТЬ ВедомостиСотрудников
	|ИЗ
	|	РезультатыЗачисления КАК РезультатыЗачисления
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.СписаниеБезналичныхДенежныхСредств.РасшифровкаПлатежа КАК ДанныеПервичногоДокумента
	|		ПО РезультатыЗачисления.ПервичныйДокумент = ДанныеПервичногоДокумента.Ссылка";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ВедомостиСотрудников.Ссылка КАК Ссылка,
	|	ВедомостиСотрудников.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ЕСТЬNULL(СчетаУчета.Счет,
	|		ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПерсоналомПоОплатеТруда)) КАК СчетУчета,
	|	СУММА(РасшифровкаВедомости.КВыплате) КАК КВыплате
	|ПОМЕСТИТЬ ВыплатыСотрудникам
	|ИЗ
	|	ВедомостиСотрудников КАК ВедомостиСотрудников
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ВедомостьНаВыплатуЗарплатыВБанк.Зарплата КАК РасшифровкаВедомости
	|		ПО ВедомостиСотрудников.Ведомость = РасшифровкаВедомости.Ссылка
	|			И ВедомостиСотрудников.ФизическоеЛицо = РасшифровкаВедомости.ФизическоеЛицо
	|		ЛЕВОЕ СОЕДИНЕНИЕ СчетаУчетаСтатейРасходовЗарплаты КАК СчетаУчета
	|		ПО РасшифровкаВедомости.СтатьяРасходов = СчетаУчета.СтатьяРасходов
	|
	|СГРУППИРОВАТЬ ПО
	|	ВедомостиСотрудников.Ссылка,
	|	ВедомостиСотрудников.ФизическоеЛицо,
	|	ЕСТЬNULL(СчетаУчета.Счет,
	|		ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПерсоналомПоОплатеТруда))
	|		
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВедомостиСотрудников.Ссылка КАК Ссылка,
	|	ВедомостиСотрудников.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ЕСТЬNULL(СчетаУчета.Счет,
	|		ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПерсоналомПоОплатеТруда)) КАК СчетУчета,
	|	СУММА(РасшифровкаВедомости.КВыплате) КАК КВыплате
	|ИЗ
	|	ВедомостиСотрудников КАК ВедомостиСотрудников
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ВедомостьПрочихДоходовВБанк.Выплаты КАК РасшифровкаВедомости
	|		ПО ВедомостиСотрудников.Ведомость = РасшифровкаВедомости.Ссылка
	|			И ВедомостиСотрудников.ФизическоеЛицо = РасшифровкаВедомости.ФизическоеЛицо
	|		ЛЕВОЕ СОЕДИНЕНИЕ СчетаУчетаСтатейРасходовЗарплаты КАК СчетаУчета
	|		ПО РасшифровкаВедомости.СтатьяРасходов = СчетаУчета.СтатьяРасходов
	|
	|СГРУППИРОВАТЬ ПО
	|	ВедомостиСотрудников.Ссылка,
	|	ВедомостиСотрудников.ФизическоеЛицо,
	|	ЕСТЬNULL(СчетаУчета.Счет,
	|		ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.РасчетыСПерсоналомПоОплатеТруда))
	|";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	
	#КонецОбласти
	
	ТекстЗапроса = СтрСоединить(ТекстыЗапроса, ОбщегоНазначения.РазделительПакетаЗапросов());
	ТекстЗапроса = ТекстЗапроса + ОбщегоНазначения.РазделительПакетаЗапросов();
	
	Возврат ТекстЗапроса;
	
	//-- Локализация

	Возврат "";
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  Запрос - Запрос - Общий запрос проведения документа.
//  ТекстыЗапроса - СписокЗначений - Список текстов запроса проведения.
//  Регистры - Строка, Структура - Список регистров проведения документа через запятую или в ключах структуры.
//
Процедура ДополнитьТекстыЗапросовПроведения(Запрос, ТекстыЗапроса, Регистры) Экспорт
	
	//++ Локализация

	//++ НЕ УТ
	ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры);
	//-- НЕ УТ

	//-- Локализация
	
КонецПроцедуры

//++ Локализация

//++ НЕ УТ

Функция ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ОтражениеДокументовВРеглУчете";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	&Период                      КАК Период,
	|	&Организация                 КАК Организация,
	|	НАЧАЛОПЕРИОДА(&Период, ДЕНЬ) КАК ДатаОтражения";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции
//-- НЕ УТ

//-- Локализация

#КонецОбласти

#КонецОбласти