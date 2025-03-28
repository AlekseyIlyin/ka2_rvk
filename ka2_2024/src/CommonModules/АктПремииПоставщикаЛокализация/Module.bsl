//@strict-types

#Область ПрограммныйИнтерфейс

#Область Проведение

// Описывает учетные механизмы используемые в документе для регистрации в механизме проведения.
//
// Параметры:
//  МеханизмыДокумента - Массив из Строка - список имен учетных механизмов, для которых будет выполнена
//              регистрация в механизме проведения.
//
Процедура ЗарегистрироватьУчетныеМеханизмы(МеханизмыДокумента) Экспорт
	
	//++ Локализация
	
	//++ НЕ УТ
	МеханизмыДокумента.Добавить("РегламентированныйУчет");
	МеханизмыДокумента.Добавить("УчетУСНПСН");
	//-- НЕ УТ
	
	//-- Локализация
	
КонецПроцедуры

// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  Запрос - Запрос - Общий запрос проведения документа.
//  ТекстыЗапроса - СписокЗначений из Строка - Список текстов запроса проведения.
//  Регистры - Строка, Структура - Список регистров проведения документа через запятую или в ключах структуры.
//  ДокументОбъект - Неопределено, ДокументОбъект.АктПремииПоставщика- 
//
Процедура ДополнитьТекстыЗапросовПроведения(Запрос, ТекстыЗапроса, Регистры, ДокументОбъект = Неопределено) Экспорт
	
	//++ Локализация
	
	//++ НЕ УТ
	
	ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры, ДокументОбъект);
	ТекстЗапросаТаблицаКУДиР(Запрос, ТекстыЗапроса, Регистры);
	
	//-- НЕ УТ
	
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый документ.
//  Отказ - Булево - Признак проведения документа.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то проведение документа выполнено не будет.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ОбработкаПроведения(Объект, Отказ, РежимПроведения) Экспорт
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то будет выполнен отказ от продолжения работы после выполнения проверки заполнения.
//  ПроверяемыеРеквизиты - Массив из Строка  - Массив путей к реквизитам, для которых будет выполнена проверка заполнения.
//
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты) Экспорт
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект.
//  ДанныеЗаполнения - Произвольный - Значение, которое используется как основание для заполнения.
//  СтандартнаяОбработка - Булево - В данный параметр передается признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//
Процедура ОбработкаУдаленияПроведения(Объект, Отказ) Экспорт
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//  РежимЗаписи - РежимЗаписиДокумента - В параметр передается текущий режим записи документа. Позволяет определить в теле процедуры режим записи.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ПередЗаписью(Объект, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина, то запись выполнена не будет и будет вызвано исключение.
//
Процедура ПриЗаписи(Объект, Отказ) Экспорт
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  ОбъектКопирования - ДокументОбъект - Исходный документ, который является источником копирования.
//
Процедура ПриКопировании(Объект, ОбъектКопирования) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// Определяет список команд создания на основании.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
КонецПроцедуры

// Добавляет команду создания документа "Авансовый отчет".
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
Процедура ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт

КонецПроцедуры

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.КомандыОтчетов
//   Параметры - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.Параметры
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
КонецПроцедуры

// Заполняет список команд печати.
//
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область Печать

// Формирует печатные формы.
//
// Параметры:
//  МассивОбъектов  - Массив из ДокументСсылка.АктПремииПоставщика- ссылки на объекты, которые нужно распечатать;
//  ПараметрыПечати - Структура - дополнительные настройки печати;
//  КоллекцияПечатныхФорм - ТаблицаЗначений - сформированные табличные документы (выходной параметр)
//  ОбъектыПечати - СписокЗначений  - значение - ссылка на объект; представление - имя области в которой был выведен объект (выходной параметр).
//  ПараметрыВывода - Структура - дополнительные параметры сформированных табличных документов (выходной параметр).
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
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
	
	ТекстыОтражения = Новый Массив; // Массив из Строка
	
	//++ Локализация
	
#Область ТекстЗадолженностьРасчетыСПоставщиковДоходы
	ТекстЗапроса =
	"ВЫБРАТЬ // Начисление задолженности поставщика за счет доходов по ретро-бонусам (Дт <60.01, 76> :: Кт <91.01>)
	|	Расчеты.Ссылка КАК Ссылка,
	|	Расчеты.Период КАК Период,
	|	Расчеты.ОрганизацияАналитики КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	Расчеты.СуммаРегл КАК Сумма,
	|	Расчеты.СуммаУпр КАК СуммаУУ,
	|	Расчеты.ВидСчета КАК ВидСчетаДт,
	|	Расчеты.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|	Расчеты.Валюта КАК ВалютаДт,
	|	Расчеты.Подразделение КАК ПодразделениеДт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК СчетДт,
	|	Расчеты.Контрагент КАК СубконтоДт1,
	|	Расчеты.Договор КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	Расчеты.Сумма КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Доходы) КАК ВидСчетаКт,
	|	РегистрПрочиеДоходы.СтатьяДоходов КАК АналитикаУчетаКт,
	|	РегистрПрочиеДоходы.Подразделение КАК МестоУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	РегистрПрочиеДоходы.Подразделение КАК ПодразделениеКт,
	|	РегистрПрочиеДоходы.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|	РегистрПрочиеДоходы.СтатьяДоходов  КАК СубконтоКт1,
	|	РегистрПрочиеДоходы.АналитикаДоходов КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	Расчеты.Сумма КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	&Содержание КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РасчетыСПоставщикамиНоваяАрхитектура КАК Расчеты
	|		ПО ДокументыКОтражению.Ссылка = Расчеты.Ссылка
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РасчетыСПоставщикамиПоДокументам КАК НовыеРасчеты
	|		ПО (Расчеты.Ссылка = НовыеРасчеты.Ссылка)
	|			И (Расчеты.ОбъектРасчетов = НовыеРасчеты.ОбъектРасчетов)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТДанныеПрочиеДоходы КАК РегистрПрочиеДоходы
	|		ПО (Расчеты.Ссылка = РегистрПрочиеДоходы.Регистратор)
	|			И (РегистрПрочиеДоходы.ИдентификаторФинЗаписи = Расчеты.ИдентификаторФинЗаписи)";
	
	Содержание = НСтр("ru = '""Ретро-бонусы поставщика за счет доходов""'");
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&Содержание", Содержание);
	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти

#Область ТекстЗадолженностьРасчетыСКлиентомПрочиеАктивыПассивы
	ТекстЗапроса =
	"ВЫБРАТЬ // Начисление задолженности поставщика на активы/пассивы по ретро-бонусам (Дт <60.01, 76> :: Кт <Прочие счета>)
	|	Расчеты.Ссылка КАК Ссылка,
	|	Расчеты.Период КАК Период,
	|	Расчеты.ОрганизацияАналитики КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	Расчеты.СуммаРегл КАК Сумма,
	|	Расчеты.СуммаУпр КАК СуммаУУ,
	|	Расчеты.ВидСчета КАК ВидСчетаДт,
	|	Расчеты.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|	Расчеты.Валюта КАК ВалютаДт,
	|	Расчеты.Подразделение КАК ПодразделениеДт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК СчетДт,
	|	Расчеты.Контрагент КАК СубконтоДт1,
	|	Расчеты.Договор КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	Расчеты.Сумма КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеАктивыПассивы) КАК ВидСчетаКт,
	|	Расчеты.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	ПрочиеАктивыПассивы.Статья КАК МестоУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	ПрочиеАктивыПассивы.Подразделение КАК ПодразделениеКт,
	|	ПрочиеАктивыПассивы.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	ПрочиеАктивыПассивы.СчетУчета КАК СчетКт,
	|	ПрочиеАктивыПассивы.Субконто1 КАК СубконтоКт1,
	|	ПрочиеАктивыПассивы.Субконто2 КАК СубконтоКт2,
	|	ПрочиеАктивыПассивы.Субконто3 КАК СубконтоКт3,
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	&Содержание КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РасчетыСПоставщикамиНоваяАрхитектура КАК Расчеты
	|		ПО ДокументыКОтражению.Ссылка = Расчеты.Ссылка
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РасчетыСПоставщикамиПоДокументам КАК НовыеРасчеты
	|		ПО (Расчеты.Ссылка = НовыеРасчеты.Ссылка)
	|			И (Расчеты.ОбъектРасчетов = НовыеРасчеты.ОбъектРасчетов)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТДанныеПрочиеАктивыПассивы КАК ПрочиеАктивыПассивы
	|		ПО (Расчеты.Ссылка = ПрочиеАктивыПассивы.Регистратор)
	|			И (ПрочиеАктивыПассивы.ИдентификаторФинЗаписи = Расчеты.ИдентификаторФинЗаписи)";
	
	Содержание = НСтр("ru = '""Ретро-бонусы поставщика за счет прочих активов""'");
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&Содержание", Содержание);
	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти
	
	//-- Локализация
	
	Возврат СтрСоединить(ТекстыОтражения, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении());
	
КонецФункции

// Функция возвращает текст запроса дополнительных временных таблиц, необходимых для отражения в регламентированном учете
//
// Возвращаемое значение:
//   Строка - сформированный текст запроса.
//
Функция ТекстЗапросаВТОтраженияВРеглУчете() Экспорт
	
	ТекстыЗапроса = Новый Массив; // Массив из Строка
	
	//++ Локализация
	
	#Область РасчетыСПоставщикамиПоДокументам
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Расчеты.Ссылка КАК Ссылка,
	|	Расчеты.Контрагент КАК Контрагент,
	|	Расчеты.Договор КАК Договор,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	Расчеты.ОбъектРасчетов КАК ОбъектРасчетов,
	|	Расчеты.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчета,
	|	Расчеты.Подразделение КАК Подразделение,
	|	Расчеты.Валюта КАК Валюта,
	|	ВЫБОР КОГДА СУММА(Расчеты.Предоплата) < 0 ТОГДА -СУММА(Расчеты.Предоплата) ИНАЧЕ СУММА(Расчеты.Предоплата) КОНЕЦ КАК Предоплата,
	|	ВЫБОР КОГДА СУММА(Расчеты.ПредоплатаУпр) < 0 ТОГДА -СУММА(Расчеты.ПредоплатаУпр) ИНАЧЕ СУММА(Расчеты.ПредоплатаУпр) КОНЕЦ КАК ПредоплатаУпр,
	|	ВЫБОР КОГДА СУММА(Расчеты.ПредоплатаРегл) < 0 ТОГДА -СУММА(Расчеты.ПредоплатаРегл) ИНАЧЕ СУММА(Расчеты.ПредоплатаРегл) КОНЕЦ КАК ПредоплатаРегл,
	|	ВЫБОР КОГДА СУММА(Расчеты.Долг) < 0 ТОГДА -СУММА(Расчеты.Долг) ИНАЧЕ СУММА(Расчеты.Долг) КОНЕЦ КАК Долг,
	|	ВЫБОР КОГДА СУММА(Расчеты.ДолгУпр) < 0 ТОГДА -СУММА(Расчеты.ДолгУпр) ИНАЧЕ СУММА(Расчеты.ДолгУпр) КОНЕЦ КАК ДолгУпр,
	|	ВЫБОР КОГДА СУММА(Расчеты.ДолгРегл) < 0 ТОГДА -СУММА(Расчеты.ДолгРегл) ИНАЧЕ СУММА(Расчеты.ДолгРегл) КОНЕЦ КАК ДолгРегл
	|
	|ПОМЕСТИТЬ РасчетыСПоставщикамиПоДокументам
	|ИЗ
	|	РасчетыСПоставщикамиНоваяАрхитектура КАК Расчеты
	|	
	|СГРУППИРОВАТЬ ПО
	|	Расчеты.Ссылка,
	|	Расчеты.Контрагент,
	|	Расчеты.Договор,
	|	Расчеты.НаправлениеДеятельности,
	|	Расчеты.ОбъектРасчетов,
	|	Расчеты.ГруппаФинансовогоУчета,
	|	Расчеты.Подразделение,
	|	Расчеты.Валюта,
	|	Расчеты.ИдентификаторФинЗаписи = """",
	|	ВЫБОР КОГДА Расчеты.ИдентификаторФинЗаписи = """" ТОГДА Расчеты.Долг <> 0 ИНАЧЕ ЛОЖЬ КОНЕЦ
	|	
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	
	#КонецОбласти
	
	#Область ВТДанныеПрочиеДоходы
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ДанныеРегистра.Регистратор КАК Регистратор,
	|	ДанныеРегистра.Период КАК Период,
	|	ДанныеРегистра.Организация КАК Организация,
	|	ДанныеРегистра.СтатьяДоходов КАК СтатьяДоходов,
	|	ДанныеРегистра.Подразделение КАК Подразделение,
	|	ДанныеРегистра.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	ДанныеРегистра.АналитикаДоходов,
	|	ЕСТЬNULL(ДанныеРегистра.СтатьяДоходов.ПринятиеКНалоговомуУчету, ЛОЖЬ) КАК ПринятиеКНалоговомуУчету,
	|	ДанныеРегистра.ИдентификаторФинЗаписи КАК ИдентификаторФинЗаписи,
	|	ДанныеРегистра.НастройкаХозяйственнойОперации КАК НастройкаХозяйственнойОперации,
	|	СУММА(ДанныеРегистра.СуммаРегл) КАК СуммаРегл,
	|	СУММА(ДанныеРегистра.СуммаУпр) КАК СуммаУпр,
	|	СУММА(ДанныеРегистра.Сумма) КАК Сумма
	|ПОМЕСТИТЬ ВТДанныеПрочиеДоходы
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ПрочиеДоходы КАК ДанныеРегистра
	|		ПО ДокументыКОтражению.Ссылка = ДанныеРегистра.Регистратор
	|		И НЕ ДанныеРегистра.Сторно
	|		И ДанныеРегистра.Активность
	|СГРУППИРОВАТЬ ПО
	|	ДанныеРегистра.Регистратор,
	|	ДанныеРегистра.Период,
	|	ДанныеРегистра.Организация,
	|	ДанныеРегистра.СтатьяДоходов,
	|	ДанныеРегистра.Подразделение,
	|	ДанныеРегистра.НаправлениеДеятельности,
	|	ДанныеРегистра.АналитикаДоходов,
	|	ЕСТЬNULL(ДанныеРегистра.СтатьяДоходов.ПринятиеКНалоговомуУчету, ЛОЖЬ),
	|	ДанныеРегистра.ИдентификаторФинЗаписи,
	|	ДанныеРегистра.НастройкаХозяйственнойОперации
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Регистратор";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	
	#КонецОбласти
	
	#Область ВТДанныеПрочиеАктивыПассивы
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ДанныеРегистра.Регистратор КАК Регистратор,
	|	ДанныеРегистра.Период КАК Период,
	|	ДанныеРегистра.Организация КАК Организация,
	|	ДанныеРегистра.Статья КАК Статья,
	|	ДанныеРегистра.Подразделение КАК Подразделение,
	|	ДанныеРегистра.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	ЕСТЬNULL(НастройкиСчетовУчета.СчетУчета, НЕОПРЕДЕЛЕНО) КАК СчетУчета,
	|	ЕСТЬNULL(НастройкиСчетовУчета.Субконто1, НЕОПРЕДЕЛЕНО) КАК Субконто1,
	|	ЕСТЬNULL(НастройкиСчетовУчета.Субконто2, НЕОПРЕДЕЛЕНО) КАК Субконто2,
	|	ЕСТЬNULL(НастройкиСчетовУчета.Субконто3, НЕОПРЕДЕЛЕНО) КАК Субконто3,
	|	ДанныеРегистра.ИдентификаторФинЗаписи КАК ИдентификаторФинЗаписи,
	|	ДанныеРегистра.НастройкаХозяйственнойОперации КАК НастройкаХозяйственнойОперации,
	|	СУММА(ДанныеРегистра.СуммаРегл) КАК СуммаРегл,
	|	СУММА(ДанныеРегистра.СуммаУпр) КАК СуммаУпр,
	|	СУММА(ДанныеРегистра.СуммаСНДС) КАК СуммаСНДС,
	|	МИНИМУМ(ДанныеПоПрочимДоходамРасходам.Регистратор ЕСТЬ NULL) КАК ТолькоАктивыПассивы
	|ПОМЕСТИТЬ ВТДанныеПрочиеАктивыПассивы
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ДвиженияПоПрочимАктивамПассивам КАК ДанныеРегистра
	|	ПО ДокументыКОтражению.Ссылка = ДанныеРегистра.Регистратор
	|		И НЕ ДанныеРегистра.Сторно
	|		И ДанныеРегистра.Активность
	|	ЛЕВОЕ СОЕДИНЕНИЕ (
	|		ВЫБРАТЬ ПЕРВЫЕ 1 Т.Регистратор ИЗ ВТДанныеПрочиеДоходы КАК Т) КАК ДанныеПоПрочимДоходамРасходам
	|	ПО ДокументыКОтражению.Ссылка = ДанныеПоПрочимДоходамРасходам.Регистратор
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ Справочник.НастройкиСчетовУчетаПрочихОпераций КАК НастройкиСчетовУчета
	|	ПО ДанныеРегистра.НастройкаСчетовУчета = НастройкиСчетовУчета.Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеРегистра.Регистратор,
	|	ДанныеРегистра.Период,
	|	ДанныеРегистра.Организация,
	|	ДанныеРегистра.Статья,
	|	ДанныеРегистра.Подразделение,
	|	ДанныеРегистра.НаправлениеДеятельности,
	|	ЕСТЬNULL(НастройкиСчетовУчета.СчетУчета, НЕОПРЕДЕЛЕНО),
	|	ЕСТЬNULL(НастройкиСчетовУчета.Субконто1, НЕОПРЕДЕЛЕНО),
	|	ЕСТЬNULL(НастройкиСчетовУчета.Субконто2, НЕОПРЕДЕЛЕНО),
	|	ЕСТЬNULL(НастройкиСчетовУчета.Субконто3, НЕОПРЕДЕЛЕНО),
	|	ДанныеРегистра.ИдентификаторФинЗаписи,
	|	ДанныеРегистра.НастройкаХозяйственнойОперации
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Регистратор";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	
	#КонецОбласти
	
	//-- Локализация
	
	ТекстЗапроса = СтрСоединить(ТекстыЗапроса, ОбщегоНазначения.РазделительПакетаЗапросов());
	ТекстЗапроса = ТекстЗапроса + ОбщегоНазначения.РазделительПакетаЗапросов();
	
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

//-- НЕ УТ

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

//++ Локализация
//
//++ НЕ УТ

Функция ТекстЗапросаТаблицаКУДиР(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "КнигаУчетаДоходовИРасходов";
	
	Если НЕ ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	Если НЕ ПроведениеДокументов.ЕстьТаблицаЗапроса("ВтКурсыВалют", ТекстыЗапроса) Тогда
		Документы.АктПремииПоставщика.ТекстЗапросаТаблицаВтКурсыВалют(
			Запрос, ТекстыЗапроса, Неопределено, Неопределено);
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Шапка.Дата КАК Период,
	|	Шапка.Ссылка КАК Регистратор,
	|	Шапка.Организация КАК Организация,
	|	Шапка.Ссылка КАК ДокументВозникновенияДоходовРасходов,
	|	ВЫБОР
	|		КОГДА Шапка.ВалютаВзаиморасчетов = &ВалютаРегламентированногоУчета
	|			ТОГДА Шапка.СуммаВзаиморасчетов
	|		ИНАЧЕ ВЫРАЗИТЬ(Шапка.СуммаВзаиморасчетов * ЕСТЬNULL(КурсВалюты.КурсЧислительВалютыВзаиморасчетов, 1) / ЕСТЬNULL(КурсВалюты.КурсЗнаменательВалютыВзаиморасчетов, 1) КАК ЧИСЛО(31, 2))
	|	КОНЕЦ КАК Графа4,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(СтатьиДоходов.ВидДеятельностиДляНалоговогоУчетаЗатрат, НЕОПРЕДЕЛЕНО) = ЗНАЧЕНИЕ(Перечисление.ВидыДеятельностиДляНалоговогоУчетаЗатрат.ОсновнаяСистемаНалогообложения)
	|			ТОГДА ВЫБОР
	|				КОГДА Шапка.ВалютаВзаиморасчетов = &ВалютаРегламентированногоУчета
	|					ТОГДА Шапка.СуммаВзаиморасчетов
	|				ИНАЧЕ ВЫРАЗИТЬ(Шапка.СуммаВзаиморасчетов * ЕСТЬNULL(КурсВалюты.КурсЧислительВалютыВзаиморасчетов, 1) / ЕСТЬNULL(КурсВалюты.КурсЗнаменательВалютыВзаиморасчетов, 1) КАК ЧИСЛО(31, 2))
	|			КОНЕЦ
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК Графа5,
	|	0 КАК Графа6,
	|	0 КАК Графа7,
	|	0 КАК НДС,
	|	0 КАК ДоходЕНВД,
	|	0 КАК ДоходПатент,
	|	ЗНАЧЕНИЕ(Справочник.Патенты.ПустаяСсылка) КАК Патент,
	|	Шапка.Номер КАК Номер,
	|	Шапка.Дата КАК Дата,
	|	Шапка.ХозяйственнаяОперация КАК ХозяйственнаяОперация,
	|	Шапка.Контрагент КАК Контрагент,
	|	Шапка.СтатьяДоходовПассивов КАК Статья
	|ИЗ
	|	ДанныеДокументаШапка КАК Шапка
	|		ЛЕВОЕ СОЕДИНЕНИЕ ПланВидовХарактеристик.СтатьиДоходов КАК СтатьиДоходов
	|		ПО Шапка.СтатьяДоходовПассивов = СтатьиДоходов.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВтКурсыВалют КАК КурсВалюты
	|		ПО Шапка.ВалютаВзаиморасчетов = КурсВалюты.ВалютаВзаиморасчетов
	|		И Шапка.ОбъектРасчетов = КурсВалюты.ОбъектРасчетов
	|ГДЕ
	|	Шапка.Ссылка В (&Ссылка)";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

#Область ПроводкиРегУчета

Функция ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры, ДокументОбъект)
	
	ИмяРегистра = "ОтражениеДокументовВРеглУчете";
	
	Если НЕ ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	&Период КАК Период,
	|	&Организация КАК Организация,
	|	НАЧАЛОПЕРИОДА(&Период, ДЕНЬ) КАК ДатаОтражения";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

//-- НЕ УТ

//-- Локализация

#КонецОбласти

#КонецОбласти