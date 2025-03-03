#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс	

// Проводит документ по учетам. Если в параметре ВидыУчетов передано Неопределено, то документ проводится по всем учетам.
// Процедура вызывается из обработки проведения и может вызываться из вне.
// 
// Параметры:
//  ДокументСсылка	- ДокументСсылка.ОтпускБезСохраненияОплаты - Ссылка на документ
//  РежимПроведения - РежимПроведенияДокумента - Режим проведения документа (оперативный, неоперативный)
//  Отказ 			- Булево - Признак отказа от выполнения проведения
//  ВидыУчетов 		- Строка - Список видов учета, по которым необходимо провести документ. Если параметр пустой или Неопределено, то документ проведется по всем учетам
//  Движения 		- Коллекция движений документа - Передается только при вызове из обработки проведения документа
//  Объект			- ДокументОбъект.ОтпускБезСохраненияОплаты - Передается только при вызове из обработки проведения документа
//  ДополнительныеПараметры - Структура - Дополнительные параметры, необходимые для проведения документа.
//
Процедура ПровестиПоУчетам(ДокументСсылка, РежимПроведения, Отказ, ВидыУчетов = Неопределено, Движения = Неопределено, Объект = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт
	
	СтруктураВидовУчета = ПроведениеРасширенныйСервер.СтруктураВидовУчета();
	ПроведениеРасширенныйСервер.ПодготовитьНаборыЗаписейКРегистрацииДвиженийПоВидамУчета(РежимПроведения, ДокументСсылка, СтруктураВидовУчета, ВидыУчетов, Движения, Объект, Отказ);
	
	Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда
		
		РеквизитыДляПроведения = РеквизитыДляПроведения(ДокументСсылка);
		
		Если РеквизитыДляПроведения.ДанныеНачислений <> Неопределено Тогда
			// Движения по начислениям сотрудника.
			ДанныеДляПроведенияНачислений = ДанныеДляПроведенияНачислений(РеквизитыДляПроведения, СтруктураВидовУчета);
			РасчетЗарплатыРасширенный.СформироватьДвиженияНачислений(
				Движения,
				Отказ,
				РеквизитыДляПроведения.Организация,
				КонецМесяца(РеквизитыДляПроведения.ПериодРегистрации),
				ДанныеДляПроведенияНачислений.Начисления,
				ДанныеДляПроведенияНачислений.ПоказателиНачислений,
				Истина);
			ПерерасчетЗарплаты.СформироватьДвиженияИсходныеДанныхПерерасчетов(Движения, РеквизитыДляПроведения.Организация, РеквизитыДляПроведения.ПериодРегистрации, ДанныеДляПроведенияНачислений.Начисления);
		КонецЕсли;
			
		Если РеквизитыДляПроведения.ДанныеСостояний <> Неопределено Тогда
			// Движения по состояниям сотрудника.
			СостоянияСотрудников.ЗарегистрироватьСостоянияСотрудников(
				Движения,
				РеквизитыДляПроведения.Ссылка,
				РеквизитыДляПроведения.ДанныеСостояний);
				
		КонецЕсли;
			
		УчетСтажаПФР.ЗарегистрироватьПериодыВУчетеСтажаПФР(Движения, ДанныеДляРегистрацииВУчетаСтажаПФР(ДокументСсылка));
		
	КонецЕсли;

	ПроведениеРасширенныйСервер.ЗаписьДвиженийПоУчетам(Движения, СтруктураВидовУчета);
	
КонецПроцедуры

// Сторнирует документ по учетам. Используется подсистемой исправления документов.
//
// Параметры:
//  Движения				 - КоллекцияДвижений, Структура	 - Коллекция движений исправляющего документа в которую будут добавлены сторно стоки.
//  Регистратор				 - ДокументСсылка				 - Документ регистратор исправления (документ исправление).
//  ИсправленныйДокумент	 - ДокументСсылка				 - Исправленный документ движения которого будут сторнированы.
//  СтруктураВидовУчета		 - Структура					 - Виды учета, по которым будет выполнено сторнирование исправленного документа.
//  					Состав полей см. в ПроведениеРасширенныйСервер.СтруктураВидовУчета().
//  ДополнительныеПараметры	 - Структура					 - Структура со свойствами:
//  					* ИсправлениеВТекущемПериоде - Булево - Истина когда исправление выполняется в периоде регистрации исправленного документа.
//						* ОтменаДокумента - Булево - Истина когда исправление вызвано документом СторнированиеНачислений.
//  					* ПериодРегистрации	- Дата - Период регистрации документа регистратора исправления.
// 
// Возвращаемое значение:
//  Булево - "Истина" если сторнирование выполнено этой функцией, "Ложь" если специальной процедуры не предусмотрено.
//
Функция СторнироватьПоУчетам(Движения, Регистратор, ИсправленныйДокумент, СтруктураВидовУчета, ДополнительныеПараметры) Экспорт
	
КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ДляВсехСтрок( ЗначениеРазрешено(ФизическиеЛица.ФизическоеЛицо, NULL КАК ИСТИНА)
	|	) И ЗначениеРазрешено(Организация)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляОтбораПоОрганизации(Настройки);
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляОбъектаСПрисоединеннымиФайлами(Настройки);
КонецПроцедуры

#КонецОбласти

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаОбъекта.
Функция ОписаниеСоставаОбъекта() Экспорт
	
	МетаданныеДокумента = Метаданные.Документы.ПериодыОплаченныеДоНачалаЭксплуатации;
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъектаПоМетаданнымФизическиеЛицаВТабличныхЧастях(МетаданныеДокумента);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры

#КонецОбласти

Функция ДанныеДляПроведенияНачислений(РеквизитыДляПроведения, СтруктураВидовУчета) 

	Если НЕ СтруктураВидовУчета.ОстальныеВидыУчета Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ДанныеНачислений = РеквизитыДляПроведения.ДанныеНачислений;
	
	РазбитьСтрокиПоПериодамДействия(ДанныеНачислений);
	ЗарплатаКадрыРасширенный.ОбъединитьСтрокиОбразующиеНепрерывныеИнтервалы(ДанныеНачислений, "ДатаНачала", "ДатаОкончания", "Сотрудник, Начисление");
	
	ДанныеДляПроведенияНачислений = РасчетЗарплаты.СоздатьДанныеДляПроведенияНачисленияЗарплаты();
	ДанныеДляПроведенияНачислений.Начисления = ДанныеНачислений;

	Возврат ДанныеДляПроведенияНачислений;

КонецФункции

Процедура РазбитьСтрокиПоПериодамДействия(ДанныеНачислений)

	Для каждого СтрокаНачислений Из ДанныеНачислений Цикл
		
	    Если НачалоМесяца(СтрокаНачислений.ДатаНачала) = НачалоМесяца(СтрокаНачислений.ДатаОкончания) Тогда
			Продолжить;
		КонецЕсли;
		
		ДатаОкончания = КонецМесяца(СтрокаНачислений.ДатаНачала);
		
		Пока КонецМесяца(СтрокаНачислений.ДатаОкончания) > КонецМесяца(ДатаОкончания) Цикл
			
			ДатаНачала = КонецМесяца(ДатаОкончания) + 1;
			ДатаОкончания = Мин(КонецМесяца(ДатаНачала), СтрокаНачислений.ДатаОкончания);
			
			НоваяСтрока = ДанныеНачислений.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаНачислений);
			НоваяСтрока.ДатаНачала = ДатаНачала;
			НоваяСтрока.ДатаОкончания = ДатаОкончания;
			НоваяСтрока.ПериодДействия = НачалоМесяца(ДатаНачала);
			
		КонецЦикла;
		СтрокаНачислений.ДатаОкончания = КонецМесяца(СтрокаНачислений.ДатаНачала);
		
	КонецЦикла;

	ДанныеНачислений.Сортировать("Сотрудник, ДатаНачала", Новый СравнениеЗначений);
	
КонецПроцедуры

Функция РеквизитыДляПроведения(ДокументСсылка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Сотрудник,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ДатаНачала КАК Начало,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ДатаОкончания КАК Окончание,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ВидПериода КАК Состояние,
	|	НЕОПРЕДЕЛЕНО КАК ВидВремени
	|ИЗ
	|	Документ.ПериодыОплаченныеДоНачалаЭксплуатации.Начисления КАК ПериодыОплаченныеДоНачалаЭксплуатацииНачисления
	|ГДЕ
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Ссылка = &Ссылка
	|	И ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ВидПериода <> &ПустойПериод
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Ссылка,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.НомерСтроки,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Сотрудник,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.ВидРасчета КАК Начисление,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ДатаНачала,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ДатаОкончания,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ВидПериода,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Подразделение,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Результат,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ОтработаноДней,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ОтработаноЧасов,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.НормаДней,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.НормаЧасов,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ФиксРасчет,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ИдентификаторСтрокиВидаРасчета,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ОплаченоДней,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ОплаченоЧасов,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ФиксСтрока,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ФиксЗаполнение,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ФиксРасчетВремени,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ВремяВЧасах,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ПериодРегистрацииВремени,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ПериодРегистрацииНормыВремени,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ГрафикРаботыНорма,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ВремяВЦеломЗаПериод,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ОбщийГрафик,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ВидУчетаВремени,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ГрафикРаботы,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.СуммаВычета,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.КодВычета,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.РасчетнаяБазаЗаЕдиницуНормыВремени,
	|	Сотрудники.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Ссылка КАК ДокументОснование,
	|	0 КАК Сумма,
	|	ЛОЖЬ КАК Сторно,
	|	НАЧАЛОПЕРИОДА(ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.ДатаНачала, МЕСЯЦ) КАК ПериодДействия
	|ИЗ
	|	Документ.ПериодыОплаченныеДоНачалаЭксплуатации.Начисления КАК ПериодыОплаченныеДоНачалаЭксплуатацииНачисления
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПериодыОплаченныеДоНачалаЭксплуатации КАК ПериодыОплаченныеДоНачалаЭксплуатации
	|		ПО ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Ссылка = ПериодыОплаченныеДоНачалаЭксплуатации.Ссылка
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
	|		ПО ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Сотрудник = Сотрудники.Ссылка
	|ГДЕ
	|	ПериодыОплаченныеДоНачалаЭксплуатацииНачисления.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПериодыОплаченныеДоНачалаЭксплуатации.Ссылка,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.Организация,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.ПериодРегистрации,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.Дата,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.Номер
	|ИЗ
	|	Документ.ПериодыОплаченныеДоНачалаЭксплуатации КАК ПериодыОплаченныеДоНачалаЭксплуатации
	|ГДЕ
	|	ПериодыОплаченныеДоНачалаЭксплуатации.Ссылка = &Ссылка";
	Запрос.УстановитьПараметр("ПустойПериод", ПредопределенноеЗначение("Перечисление.СостоянияСотрудника.ПустаяСсылка"));
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	ДанныеСостояний = РезультатыЗапроса[РезультатыЗапроса.Количество()-3];
	ДанныеНачислений = РезультатыЗапроса[РезультатыЗапроса.Количество()-2];
	РеквизитыДокумента = РезультатыЗапроса[РезультатыЗапроса.Количество()-1];
	
	РеквизитыДляПроведения = РеквизитыДляПроведенияПустаяСтруктура();
	
	Если НЕ РеквизитыДокумента.Пустой() Тогда
	    ВыборкаРеквизитов = РеквизитыДокумента.Выбрать();
		ВыборкаРеквизитов.Следующий();
		ЗаполнитьЗначенияСвойств(РеквизитыДляПроведения, ВыборкаРеквизитов);
	КонецЕсли;
	
	Если НЕ ДанныеСостояний.Пустой() Тогда
		РеквизитыДляПроведения.ДанныеСостояний = ДанныеСостояний.Выгрузить();
	КонецЕсли;
	
	Если НЕ ДанныеНачислений.Пустой() Тогда
		РеквизитыДляПроведения.ДанныеНачислений = ДанныеНачислений.Выгрузить();
	КонецЕсли;
	
	Возврат РеквизитыДляПроведения;
	
КонецФункции

Функция ДанныеДляРегистрацииВУчетаСтажаПФР(ДокументСсылка)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ДокументСсылка", ДокументСсылка);
	Запрос.УстановитьПараметр("ПустойПериод", Перечисления.СостоянияСотрудника.ПустаяСсылка());
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПериодыОплаченныеДоНачалаЭксплуатации.Сотрудник КАК Сотрудник,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.Ссылка.ПериодРегистрации КАК ПериодРегистрации,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.Ссылка КАК Ссылка,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.ДатаНачала КАК ДатаНачала,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.ДатаОкончания КАК ДатаОкончания,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.ВидПериода КАК ВидПериода,
	|	ПериодыОплаченныеДоНачалаЭксплуатации.ВидСтажаПФР КАК ВидСтажаПФР
	|ИЗ
	|	Документ.ПериодыОплаченныеДоНачалаЭксплуатации.Начисления КАК ПериодыОплаченныеДоНачалаЭксплуатации
	|ГДЕ
	|	ПериодыОплаченныеДоНачалаЭксплуатации.Ссылка В(&ДокументСсылка)
	|	И ПериодыОплаченныеДоНачалаЭксплуатации.Ссылка.ПериодРегистрации <= ПериодыОплаченныеДоНачалаЭксплуатации.ДатаОкончания
	|	И ПериодыОплаченныеДоНачалаЭксплуатации.Сотрудник = ПериодыОплаченныеДоНачалаЭксплуатации.Сотрудник.ГоловнойСотрудник
	|	И ПериодыОплаченныеДоНачалаЭксплуатации.ВидПериода <> &ПустойПериод
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка";
	
	Результат = Запрос.Выполнить();
	
	Если Не Результат.Пустой() Тогда
		ДанныеДляРегистрации = УчетСтажаПФР.ДанныеДляРегистрацииВУчетеСтажаПФР();
		Выборка = Результат.Выбрать();
		
		Пока Выборка.Следующий() Цикл
			ОписаниеПериода = УчетСтажаПФР.ОписаниеРегистрируемогоПериода();
			ОписаниеПериода.Сотрудник = Выборка.Сотрудник;	
			ОписаниеПериода.ДатаНачалаПериода = Макс(Выборка.ПериодРегистрации, Выборка.ДатаНачала);
			ОписаниеПериода.ДатаОкончанияПериода = Выборка.ДатаОкончания;
			ОписаниеПериода.ДатаНачалаСобытия = Выборка.ДатаНачала;
			ОписаниеПериода.Состояние = Выборка.ВидПериода;

			РегистрируемыйПериод = УчетСтажаПФР.ДобавитьЗаписьВДанныеДляРегистрацииВУчета(ДанныеДляРегистрации, ОписаниеПериода);
			УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "ВидСтажаПФР", Выборка.ВидСтажаПФР);
		КонецЦикла;	
	КонецЕсли;;	
	
	Возврат ДанныеДляРегистрации;
	
КонецФункции

Функция РеквизитыДляПроведенияПустаяСтруктура()
	
	РеквизитыДляПроведенияПустаяСтруктура = Новый Структура("Ссылка, Организация, ПериодРегистрации, Дата, Номер");
	РеквизитыДляПроведенияПустаяСтруктура.Вставить("ДанныеСостояний", Неопределено);
	РеквизитыДляПроведенияПустаяСтруктура.Вставить("ДанныеНачислений", Неопределено);
	
	Возврат РеквизитыДляПроведенияПустаяСтруктура;
	
КонецФункции

#КонецОбласти

#КонецЕсли