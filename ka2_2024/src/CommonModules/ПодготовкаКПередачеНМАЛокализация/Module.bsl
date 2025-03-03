////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Подготовка к передаче НМА".
// 
////////////////////////////////////////////////////////////////////////////////

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
	МеханизмыДокумента.Добавить("РегламентированныйУчет");
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиСобытий

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект.ПодготовкаКПередачеНМА2_4 - Обрабатываемый документ.
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
//  Объект - ДокументОбъект.ПодготовкаКПередачеНМА2_4 - Обрабатываемый объект
//  Отказ - Булево - Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то будет выполнен отказ от продолжения работы после выполнения проверки заполнения.
//  ПроверяемыеРеквизиты - Массив - Массив путей к реквизитам, для которых будет выполнена проверка заполнения.
//
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект.ПодготовкаКПередачеНМА2_4 - Обрабатываемый объект.
//  ДанныеЗаполнения - Произвольный - Значение, которое используется как основание для заполнения.
//  СтандартнаяОбработка - Булево - В данный параметр передается признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, СтандартнаяОбработка) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект.ПодготовкаКПередачеНМА2_4 - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//
Процедура ОбработкаУдаленияПроведения(Объект, Отказ) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект.ПодготовкаКПередачеНМА2_4 - Обрабатываемый объект
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
//  Объект - ДокументОбъект.ПодготовкаКПередачеНМА2_4 - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина, то запись выполнена не будет и будет вызвано исключение.
//
Процедура ПриЗаписи(Объект, Отказ) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект.ПодготовкаКПередачеНМА2_4 - Обрабатываемый объект
//  ОбъектКопирования - ДокументОбъект.ПодготовкаКПередачеНМА2_4 - Исходный документ, который является источником копирования.
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

// Добавляет команды печати.
// 
// Параметры:
// 	КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область Печать

// Формирует печатные формы.
//
// Параметры:
//  МассивОбъектов  - Массив    - ссылки на объекты, которые нужно распечатать;
//  ПараметрыПечати - Структура - дополнительные настройки печати;
//  КоллекцияПечатныхФорм - ТаблицаЗначений - сформированные табличные документы (выходной параметр)
//  ОбъектыПечати         - СписокЗначений  - значение - ссылка на объект;
//                                            представление - имя области в которой был выведен объект (выходной параметр);
//  ПараметрыВывода       - Структура       - дополнительные параметры сформированных табличных документов (выходной параметр).
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область ПроводкиРегУчета

// Функция возвращает текст запроса для отражения документа в регламентированном учете.
//
// Возвращаемое значение:
//	Строка - Текст запроса
//
Функция ТекстОтраженияВРеглУчете() Экспорт
	
	ТекстЗапроса = "";
	
	//++ Локализация
	
	ТекстыЗапроса = Новый Массив;
	
	#Область ПереносНачисленнойАмортизацииНМА_Дт_СчетНакопленияАмортизации__Кт_СчетУчета
	ТекстЗапроса =
	"////////////////////////////////////////////////////////////////////////////////////////////////////
	|// Перенос начисленной амортизации НМА (Дт СчетНакопленияАмортизации :: Кт СчетУчета)
	|ВЫБРАТЬ
	|	
	|	Строки.Регистратор КАК Ссылка,
	|	Строки.Период КАК Период,
	|	Строки.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	
	|	Строки.АмортизацияРегл КАК Сумма,
	|	Строки.Амортизация КАК СуммаУУ,
	|	
	|	// Дт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.АмортизацияВНА) КАК ВидСчетаДт,
	|	Строки.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	Строки.НематериальныйАктив КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	Строки.АмортизацияНУ КАК СуммаНУДт,
	|	Строки.АмортизацияПР КАК СуммаПРДт,
	|	Строки.АмортизацияВР КАК СуммаВРДт,
	|	
	|	// Кт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.СтоимостьВНА) КАК ВидСчетаКт,
	|	Строки.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Строки.Подразделение КАК ПодразделениеКт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	Строки.НематериальныйАктив КАК СубконтоКт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	Строки.АмортизацияНУ КАК СуммаНУКт,
	|	Строки.АмортизацияПР КАК СуммаПРКт,
	|	Строки.АмортизацияВР КАК СуммаВРКт,
	|	
	|	""Перенос начисленной амортизации НМА"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.АмортизацияНМА КАК Строки
	|		ПО ДокументыКОтражению.Ссылка = Строки.Регистратор
	|	
	|ГДЕ
	|	Строки.НематериальныйАктив.ВидОбъектаУчета = ЗНАЧЕНИЕ(Перечисление.ВидыОбъектовУчетаНМА.НематериальныйАктив)
	|	И (Строки.Амортизация <> 0
	|		ИЛИ Строки.АмортизацияРегл <> 0
	|		ИЛИ Строки.АмортизацияНУ <> 0
	|		ИЛИ Строки.АмортизацияПР <> 0
	|		ИЛИ Строки.АмортизацияВР <> 0)";
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	#КонецОбласти
	
	#Область ПереносНачисленнойАмортизацииНМАЦФ_Дт_СчетНакопленияАмортизации__Кт_СчетУчета
	ТекстЗапроса =
	"////////////////////////////////////////////////////////////////////////////////////////////////////
	|// Перенос начисленной амортизации НМА (Дт СчетНакопленияАмортизации :: Кт СчетУчетаЦФ)
	|ВЫБРАТЬ
	|	
	|	Строки.Регистратор КАК Ссылка,
	|	Строки.Период КАК Период,
	|	Строки.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	
	|	Строки.АмортизацияЦФ КАК Сумма,
	|	0 КАК СуммаУУ,
	|	
	|	// Дт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.АмортизацияВНА_ЦФ) КАК ВидСчетаДт,
	|	Строки.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	Строки.НематериальныйАктив КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	Строки.АмортизацияНУЦФ КАК СуммаНУДт,
	|	Строки.АмортизацияПРЦФ КАК СуммаПРДт,
	|	Строки.АмортизацияВРЦФ КАК СуммаВРДт,
	|	
	|	// Кт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.СтоимостьВНА_ЦФ) КАК ВидСчетаКт,
	|	Строки.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Строки.Подразделение КАК ПодразделениеКт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	Строки.НематериальныйАктив КАК СубконтоКт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	Строки.АмортизацияНУЦФ КАК СуммаНУКт,
	|	Строки.АмортизацияПРЦФ КАК СуммаПРКт,
	|	Строки.АмортизацияВРЦФ КАК СуммаВРКт,
	|	
	|	""Перенос начисленной амортизации НМА"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.АмортизацияНМА КАК Строки
	|		ПО ДокументыКОтражению.Ссылка = Строки.Регистратор
	|	
	|ГДЕ
	|	Строки.НематериальныйАктив.ВидОбъектаУчета = ЗНАЧЕНИЕ(Перечисление.ВидыОбъектовУчетаНМА.НематериальныйАктив)
	|	И (Строки.АмортизацияЦФ <> 0
	|		ИЛИ Строки.АмортизацияНУЦФ <> 0
	|		ИЛИ Строки.АмортизацияПРЦФ <> 0
	|		ИЛИ Строки.АмортизацияВРЦФ <> 0)";
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	#КонецОбласти
	
	#Область ПереносОбесцененияНМА_Дт_СчетОбесценения__Кт_СчетУчета
	ТекстЗапроса =
	"////////////////////////////////////////////////////////////////////////////////////////////////////
	|// Перенос обесценения НМА (Дт СчетОбесценения :: Кт СчетУчета)
	|ВЫБРАТЬ
	|	
	|	Строки.Регистратор КАК Ссылка,
	|	Строки.Период КАК Период,
	|	Строки.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	
	|	Строки.ОбесценениеРегл КАК Сумма,
	|	Строки.ОбесценениеУпр КАК СуммаУУ,
	|	
	|	// Дт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ОбесценениеВНА) КАК ВидСчетаДт,
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	Строки.ВнеоборотныйАктив КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	Строки.ОбесценениеРегл КАК СуммаВРДт,
	|	
	|	// Кт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.СтоимостьВНА) КАК ВидСчетаКт,
	|	Строки.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Строки.Подразделение КАК ПодразделениеКт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	Строки.ВнеоборотныйАктив КАК СубконтоКт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	Строки.ОбесценениеРегл КАК СуммаВРКт,
	|	
	|	""Перенос обесценения НМА"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ОбесценениеВНА КАК Строки
	|		ПО ДокументыКОтражению.Ссылка = Строки.Регистратор
	|	
	|ГДЕ
	|	Строки.ВнеоборотныйАктив.ВидОбъектаУчета = ЗНАЧЕНИЕ(Перечисление.ВидыОбъектовУчетаНМА.НематериальныйАктив)
	|	И (Строки.ОбесценениеРегл <> 0
	|		ИЛИ Строки.ОбесценениеУпр <> 0)";
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	#КонецОбласти
	
	#Область СписаниеДоходыОтЦелевогоФинансирования_Дт_98__Кт_91
	ТекстЗапроса =
	"////////////////////////////////////////////////////////////////////////////////////////////////////
	|// Признание доходов от целевого финансирования (Дт 98 :: Кт 91)
	|ВЫБРАТЬ
	|	
	|	Строки.Регистратор КАК Ссылка,
	|	Строки.Период КАК Период,
	|	Строки.Организация КАК Организация,
	|	"""" КАК ИдентификаторСтроки,
	|	
	|	Строки.СтоимостьЦФ КАК Сумма,
	|	0 КАК СуммаУУ,
	|	
	|	// Дт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ДоходыБудущихПериодовОтЦелевогоФинансированияНМА) КАК СчетДт,
	|	Строки.НематериальныйАктив КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	Строки.СтоимостьНУЦФ + Строки.СтоимостьПРЦФ + Строки.СтоимостьВРЦФ КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	// Кт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Доходы) КАК ВидСчетаКт,
	|	ПараметрыЦФ.СтатьяДоходов КАК АналитикаУчетаКт,
	|	Строки.Подразделение КАК МестоУчетаКт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаКт,
	|	Строки.Подразделение КАК ПодразделениеКт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|	ПараметрыЦФ.СтатьяДоходов КАК СубконтоКт1,
	|	ПараметрыЦФ.АналитикаДоходов КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	Строки.СтоимостьНУЦФ + Строки.СтоимостьПРЦФ + Строки.СтоимостьВРЦФ КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	
	|	/////////////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	""Признание доходов от целевого финансирования при списании"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.СтоимостьНМА КАК Строки
	|		ПО ДокументыКОтражению.Ссылка = Строки.Регистратор
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПараметрыЦелевогоФинансированияНМА КАК ПараметрыЦФ
	|		ПО Строки.НематериальныйАктив = ПараметрыЦФ.НематериальныйАктив
	|	
	|ГДЕ
	|	(Строки.СтоимостьЦФ <> 0
	|		ИЛИ Строки.СтоимостьНУЦФ <> 0
	|		ИЛИ Строки.СтоимостьПРЦФ <> 0
	|		ИЛИ Строки.СтоимостьВРЦФ <> 0)";
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	#КонецОбласти
	
	#Область СписаниеРезерваДооценки_Дт_РезервДоОценкиВНА__Кт_84_01
	ТекстЗапроса =
	"////////////////////////////////////////////////////////////////////////////////////////////////////
	|// Списание резерва дооценки (Дт 83.01 :: Кт 84.01)
	|ВЫБРАТЬ
	|	
	|	Строки.Регистратор КАК Ссылка,
	|	Строки.Период КАК Период,
	|	Строки.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	
	|	Строки.РезервПереоценкиСтоимостиРегл КАК Сумма,
	|	Строки.РезервПереоценкиСтоимости КАК СуммаУУ,
	|	
	|	// Дт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РезервДоОценкиВНА) КАК ВидСчетаДт,
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаДт,
	|	Строки.Подразделение КАК МестоУчетаДт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Строки.Подразделение КАК ПодразделениеДт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	Строки.НематериальныйАктив КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	Строки.РезервПереоценкиСтоимостиРегл КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	// Кт ///////////////////////////////////////////////////////////////////////////////////////////
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК ГруппаФинансовогоУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Строки.Подразделение КАК ПодразделениеКт,
	|	Строки.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПрибыльПодлежащаяРаспределению) КАК СчетКт,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	Строки.РезервПереоценкиСтоимостиРегл КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	
	|	""Списание резерва дооценки"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТОстаткиРезерваПереоценки КАК Строки
	|		ПО ДокументыКОтражению.Ссылка = Строки.Регистратор
	|	
	|ГДЕ
	|	(Строки.РезервПереоценкиСтоимости <> 0
	|		ИЛИ Строки.РезервПереоценкиСтоимостиРегл <> 0)";
	ТекстыЗапроса.Добавить(ТекстЗапроса);
	#КонецОбласти
	
	ТекстЗапроса = СтрСоединить(ТекстыЗапроса, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении());
	
	//-- Локализация
	Возврат ТекстЗапроса;
	
КонецФункции

// Функция возвращает текст запроса дополнительных временных таблиц,
// необходимых для отражения в регламентированном учете
//
// Возвращаемое значение:
//   Строка - сформированный текст запроса.
//
Функция ТекстЗапросаВТОтраженияВРеглУчете() Экспорт
	
	ТекстЗапроса = "";
	
	//++ Локализация
	
	ТекстыОтражения = Новый Массив;
	ТекстыОтражения.Добавить(ТекстЗапросаВТОстаткиРезерваПереоценки());
	ТекстыОтражения.Добавить(Символы.ПС);
	
	ТекстЗапроса = СтрСоединить(ТекстыОтражения, ОбщегоНазначения.РазделительПакетаЗапросов());
	
	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

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
	
	ВнеоборотныеАктивыЛокализация.ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(ТекстыЗапроса, Регистры);
	
	//-- Локализация
	
КонецПроцедуры

// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  ТекстыЗапроса - СписокЗначений - Список текстов запроса проведения.
//
Процедура ТаблицыОтложенногоФормированияДвижений(ТекстыЗапроса) Экспорт
	
	//++ Локализация
	
	ВнеоборотныеАктивыЛокализация.ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(ТекстыЗапроса, Неопределено);
	
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

// 
// Возвращаемое значение:
//  Строка - Текст запроса
Функция ТекстЗапросаТаблицаПорядокУчетаНМАБУ() Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ДанныеДокумента.Ссылка           КАК Регистратор,
	|	ДанныеДокумента.Период           КАК Период,
	|	ДанныеДокумента.Организация      КАК Организация,
	|	ТаблицаНМА.НематериальныйАктив   КАК НематериальныйАктив,
	|	ЛОЖЬ                             КАК НачислятьАмортизациюБУ,
	|	ЛОЖЬ                             КАК НачислятьАмортизациюНУ,
	|	ЗНАЧЕНИЕ(Перечисление.СостоянияНМА.Списан) КАК СостояниеБУ,
	|	ЗНАЧЕНИЕ(Перечисление.СостоянияНМА.Списан) КАК СостояниеНУ
	|ИЗ
	|	ДанныеДокументаРеквизиты КАК ДанныеДокумента
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ ДанныеДокументаТаблицаНМА КАК ТаблицаНМА
	|		ПО ДанныеДокумента.Ссылка = ТаблицаНМА.Ссылка
	|ГДЕ
	|	ДанныеДокумента.ОтражатьВРеглУчете";
	
	//-- Локализация

	Возврат ТекстЗапроса;
		
КонецФункции

// 
// Возвращаемое значение:
//  Строка - Текст запроса
Функция ТекстЗапросаТаблицаПервоначальныеСведенияНМА() Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ДанныеДокумента.Ссылка                                      КАК Регистратор,
	|	ДанныеДокумента.Период                                      КАК Период,
	|	ДанныеДокумента.Организация                                 КАК Организация,
	|	ТаблицаНМА.НематериальныйАктив                              КАК НематериальныйАктив,
	|	ПервоначальныеСведения.СпособПоступления                    КАК СпособПоступления,
	|	ПервоначальныеСведения.ПервоначальнаяСтоимостьБУ            КАК ПервоначальнаяСтоимостьБУ,
	|	ПервоначальныеСведения.ПервоначальнаяСтоимостьНУ            КАК ПервоначальнаяСтоимостьНУ,
	|	ПервоначальныеСведения.ПервоначальнаяСтоимостьПР            КАК ПервоначальнаяСтоимостьПР,
	|	ПервоначальныеСведения.ПервоначальнаяСтоимостьВР            КАК ПервоначальнаяСтоимостьВР,
	|	ПервоначальныеСведения.ПервоначальнаяСтоимостьУУ            КАК ПервоначальнаяСтоимостьУУ,
	|	ПервоначальныеСведения.МетодНачисленияАмортизацииБУ         КАК МетодНачисленияАмортизацииБУ,
	|	ПервоначальныеСведения.МетодНачисленияАмортизацииНУ         КАК МетодНачисленияАмортизацииНУ,
	|	ПервоначальныеСведения.АмортизацияДо2002                    КАК АмортизацияДо2002,
	|	ПервоначальныеСведения.АмортизацияДо2009                    КАК АмортизацияДо2009,
	|	ПервоначальныеСведения.СтоимостьДо2002                      КАК СтоимостьДо2002,
	|	ПервоначальныеСведения.ФактическийСрокИспользованияДо2009   КАК ФактическийСрокИспользованияДо2009,
	|	ПервоначальныеСведения.ДатаПриобретения                     КАК ДатаПриобретения,
	|	ПервоначальныеСведения.ДатаПринятияКУчетуУУ                 КАК ДатаПринятияКУчетуУУ,
	|	ПервоначальныеСведения.ДатаПринятияКУчетуБУ                 КАК ДатаПринятияКУчетуБУ,
	|	ПервоначальныеСведения.ДатаПринятияКУчетуНУ                 КАК ДатаПринятияКУчетуНУ,
	|	ПервоначальныеСведения.ДокументПринятияКУчетуУУ             КАК ДокументПринятияКУчетуУУ,
	|	ПервоначальныеСведения.ДокументПринятияКУчетуБУ             КАК ДокументПринятияКУчетуБУ,
	|	ПервоначальныеСведения.ДокументПринятияКУчетуНУ             КАК ДокументПринятияКУчетуНУ,
	|	ПервоначальныеСведения.ПорядокУчетаНУ             			КАК ПорядокУчетаНУ,
	|	ДанныеДокумента.Ссылка                                      КАК ДокументСписания
	|ИЗ
	|	ДанныеДокументаРеквизиты КАК ДанныеДокумента
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ ДанныеДокументаТаблицаНМА КАК ТаблицаНМА
	|		ПО ДанныеДокумента.Ссылка = ТаблицаНМА.Ссылка
	|
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВтПервоначальныеСведенияНМА КАК ПервоначальныеСведения
	|		ПО ТаблицаНМА.НематериальныйАктив = ПервоначальныеСведения.НематериальныйАктив
	|			И ПервоначальныеСведения.Организация = ТаблицаНМА.Организация
	|
	|ГДЕ
	|	ДанныеДокумента.ОтражатьВРеглУчете";
	
	//-- Локализация

	Возврат ТекстЗапроса;
		
КонецФункции

#КонецОбласти

//++ Локализация

#Область ПроводкиРегУчета

Функция ТекстЗапросаВТОстаткиРезерваПереоценки()

	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ОстаткиРезерваПереоценки.Регистратор КАК Регистратор,
	|	ОстаткиРезерваПереоценки.Период КАК Период,
	|	ОстаткиРезерваПереоценки.Организация КАК Организация,
	|	ОстаткиРезерваПереоценки.Подразделение КАК Подразделение,
	|	ОстаткиРезерваПереоценки.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	ОстаткиРезерваПереоценки.ГруппаФинансовогоУчета КАК ГруппаФинансовогоУчета,
	|	ОстаткиРезерваПереоценки.НематериальныйАктив КАК НематериальныйАктив,
	|	СУММА(ОстаткиРезерваПереоценки.РезервПереоценкиСтоимостиРегл) КАК РезервПереоценкиСтоимостиРегл,
	|	СУММА(ОстаткиРезерваПереоценки.РезервПереоценкиСтоимости) КАК РезервПереоценкиСтоимости
	|ПОМЕСТИТЬ ВТОстаткиРезерваПереоценки
	|ИЗ
	|	(ВЫБРАТЬ
	|		СтоимостьНМА.Регистратор КАК Регистратор,
	|		СтоимостьНМА.Период КАК Период,
	|		СтоимостьНМА.Организация КАК Организация,
	|		СтоимостьНМА.Подразделение КАК Подразделение,
	|		СтоимостьНМА.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|		СтоимостьНМА.ГруппаФинансовогоУчета,
	|		СтоимостьНМА.НематериальныйАктив КАК НематериальныйАктив,
	|		СтоимостьНМА.РезервПереоценкиСтоимостиРегл КАК РезервПереоценкиСтоимостиРегл,
	|		СтоимостьНМА.РезервПереоценкиСтоимости КАК РезервПереоценкиСтоимости
	|	ИЗ
	|		РегистрНакопления.СтоимостьНМА КАК СтоимостьНМА
	|	ГДЕ
	|		СтоимостьНМА.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|		И СтоимостьНМА.Регистратор В
	|				(ВЫБРАТЬ
	|					ДокументыКОтражению.Ссылка
	|				ИЗ
	|					ДокументыКОтражению)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		АмортизацияНМА.Регистратор,
	|		АмортизацияНМА.Период,
	|		АмортизацияНМА.Организация,
	|		АмортизацияНМА.Подразделение,
	|		АмортизацияНМА.НаправлениеДеятельности,
	|		АмортизацияНМА.ГруппаФинансовогоУчета,
	|		АмортизацияНМА.НематериальныйАктив,
	|		-АмортизацияНМА.РезервПереоценкиАмортизацииРегл,
	|		-АмортизацияНМА.РезервПереоценкиАмортизации
	|	ИЗ
	|		РегистрНакопления.АмортизацияНМА КАК АмортизацияНМА
	|	ГДЕ
	|		АмортизацияНМА.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|		И АмортизацияНМА.Регистратор В
	|				(ВЫБРАТЬ
	|					ДокументыКОтражению.Ссылка
	|				ИЗ
	|					ДокументыКОтражению)) КАК ОстаткиРезерваПереоценки
	|
	|СГРУППИРОВАТЬ ПО
	|	ОстаткиРезерваПереоценки.Регистратор,
	|	ОстаткиРезерваПереоценки.Период,
	|	ОстаткиРезерваПереоценки.Организация,
	|	ОстаткиРезерваПереоценки.Подразделение,
	|	ОстаткиРезерваПереоценки.НаправлениеДеятельности,
	|	ОстаткиРезерваПереоценки.ГруппаФинансовогоУчета,
	|	ОстаткиРезерваПереоценки.НематериальныйАктив
	|
	|ИМЕЮЩИЕ
	|	(СУММА(ОстаткиРезерваПереоценки.РезервПереоценкиСтоимостиРегл) <> 0
	|		ИЛИ СУММА(ОстаткиРезерваПереоценки.РезервПереоценкиСтоимости) <> 0)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Регистратор";
	
	Возврат ТекстЗапроса;

КонецФункции

#КонецОбласти

//-- Локализация

#КонецОбласти
