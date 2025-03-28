#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область Проведение

// Описывает учетные механизмы используемые в документе для регистрации в механизме проведения.
//
// Параметры:
//  МеханизмыДокумента - Массив - список имен учетных механизмов, для которых будет выполнена
//              регистрация в механизме проведения.
//
Процедура ЗарегистрироватьУчетныеМеханизмы(МеханизмыДокумента) Экспорт
	
	МеханизмыДокумента.Добавить("УправлениеАссортиментом");
	
КонецПроцедуры

// Возвращает таблицы для движений, необходимые для проведения документа по регистрам учетных механизмов.
//
// Параметры:
//  Документ - ДокументСсылка, ДокументОбъект - ссылка на документ или объект, по которому необходимо получить данные
//  Регистры - Структура - список имен регистров, для которых необходимо получить таблицы
//  ДопПараметры - Структура - дополнительные параметры для получения данных, определяющие контекст проведения.
//
// Возвращаемое значение:
//  Структура - коллекция элементов:
//     * Таблица - ТаблицаЗначений - таблица данных для отражения в регистр.
//
Функция ДанныеДокументаДляПроведения(Документ, Регистры, ДопПараметры = Неопределено) Экспорт
	
	Если ДопПараметры = Неопределено Тогда
		ДопПараметры = ПроведениеДокументов.ДопПараметрыИнициализироватьДанныеДокументаДляПроведения();
	КонецЕсли;
	
	Если ТипЗнч(Документ) = Тип("ДокументОбъект.УстановкаКвотАссортимента") Тогда
		ДокументСсылка = Документ.Ссылка;
	Иначе
		ДокументСсылка = Документ;
	КонецЕсли;
	
	Запрос			= Новый Запрос;
	ТекстыЗапроса	= Новый СписокЗначений;
	
	Если Не ДопПараметры.ПолучитьТекстыЗапроса Тогда
		////////////////////////////////////////////////////////////////////////////
		// Создадим запрос инициализации движений
		
		Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
		
		////////////////////////////////////////////////////////////////////////////
		// Сформируем текст запроса
		
		ТекстЗапросаТаблицаКвотыАссортимента(Запрос, ТекстыЗапроса, Регистры);
	КонецЕсли;
	
	////////////////////////////////////////////////////////////////////////////
	// Получим таблицы для движений
	
	Возврат ПроведениеДокументов.ИнициализироватьДанныеДокументаДляПроведения(Запрос, ТекстыЗапроса, ДопПараметры);
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет список команд создания на основании.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	БизнесПроцессы.Задание.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
КонецПроцедуры

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.КомандыОтчетов
//   Параметры - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.Параметры
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Интерфейс для работы с подсистемой Загрузка из файла.

// Устанавливает параметры загрузки.
//
Процедура УстановитьПараметрыЗагрузкиИзФайлаВТЧ(Параметры) Экспорт
	
КонецПроцедуры

// Производит сопоставление данных, загружаемых в табличную часть ПолноеИмяТабличнойЧасти,
// с данными в ИБ, и заполняет параметры АдресТаблицыСопоставления и СписокНеоднозначностей.
//
// Параметры:
//   АдресЗагружаемыхДанных    - Строка - адрес временного хранилища с таблицей значений, в которой
//                                        находятся загруженные данные из файла. Состав колонок:
//     * Идентификатор - Число - порядковый номер строки;
//      остальные колонки сооответствуют колонкам макета ЗагрузкаИзФайла.
//   АдресТаблицыСопоставления - Строка - адрес временного хранилища с пустой таблицей значений,
//                                        являющейся копией табличной части документа,
//                                        которую необходимо заполнить из таблицы АдресЗагружаемыхДанных.
//   СписокНеоднозначностей - ТаблицаЗначений - список неоднозначных значений, для которых в ИБ имеется несколько подходящих вариантов:
//     * Колонка       - Строка - имя колонки, в которой была обнаружена неоднозначность;
//     * Идентификатор - Число  - идентификатор строки, в которой была обнаружена неоднозначность.
//   ПолноеИмяТабличнойЧасти   - Строка - полное имя табличной части, в которую загружаются данные.
//   ДополнительныеПараметры   - Структура - доп. параметры
//
Процедура СопоставитьЗагружаемыеДанные(АдресЗагружаемыхДанных, АдресТаблицыСопоставления, СписокНеоднозначностей, ПолноеИмяТабличнойЧасти, ДополнительныеПараметры) Экспорт
	
	ТоварныеКатегории =  ПолучитьИзВременногоХранилища(АдресТаблицыСопоставления); // см. СопоставитьЗагружаемыеДанные.СписокНеоднозначностей
	ЗагружаемыеДанные = ПолучитьИзВременногоХранилища(АдресЗагружаемыхДанных); // см. СопоставитьЗагружаемыеДанные.СписокНеоднозначностей
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.ТоварнаяКатегория КАК СТРОКА(&ДлинаТоварнаяКатегория)) КАК ТоварнаяКатегория,
	|	ВЫРАЗИТЬ(ДанныеДляСопоставления.Марка КАК СТРОКА(&ДлинаМарка)) КАК Марка,
	|	ДанныеДляСопоставления.Идентификатор
	|ПОМЕСТИТЬ ДанныеДляСопоставления
	|ИЗ
	|	&ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(ТоварныеКатегории.Ссылка) КАК ТоварнаяКатегорияСсылка,
	|	ДанныеДляСопоставления.Идентификатор,
	|	КОЛИЧЕСТВО(ДанныеДляСопоставления.Идентификатор) КАК Количество
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ТоварныеКатегории КАК ТоварныеКатегории
	|		ПО (ТоварныеКатегории.Наименование = ДанныеДляСопоставления.ТоварнаяКатегория)
	|			И НЕ ТоварныеКатегории.ЭтоГруппа
	|ГДЕ
	|	НЕ ТоварныеКатегории.Ссылка ЕСТЬ NULL 
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеДляСопоставления.Идентификатор
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(Марки.Ссылка) КАК МаркаСсылка,
	|	ДанныеДляСопоставления.Идентификатор,
	|	КОЛИЧЕСТВО(ДанныеДляСопоставления.Идентификатор) КАК Количество
	|ИЗ
	|	ДанныеДляСопоставления КАК ДанныеДляСопоставления
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Марки КАК Марки
	|		ПО (Марки.Наименование = ДанныеДляСопоставления.Марка)
	|			И НЕ Марки.ЭтоГруппа
	|ГДЕ
	|	НЕ Марки.Ссылка ЕСТЬ NULL 
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеДляСопоставления.Идентификатор";
	
	Запрос.УстановитьПараметр("ДанныеДляСопоставления", ЗагружаемыеДанные);
	
	ДлинаТоварнаяКатегория = Метаданные.Справочники.ТоварныеКатегории.ДлинаНаименования;
	ДлинаМарка = Метаданные.Справочники.Марки.ДлинаНаименования;
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ДлинаТоварнаяКатегория", ДлинаТоварнаяКатегория);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ДлинаМарка", ДлинаМарка);
	
	РезультатыЗапросов = Запрос.ВыполнитьПакет();
	
	ТаблицаТоварныеКатегории = РезультатыЗапросов[1].Выгрузить();
	ТаблицаМарки = РезультатыЗапросов[2].Выгрузить();
	
	Для каждого СтрокаТаблицы Из ЗагружаемыеДанные Цикл 
		
		НоваяСтрока = ТоварныеКатегории.Добавить();
		НоваяСтрока.Идентификатор = СтрокаТаблицы.Идентификатор;
		НоваяСтрока.Квота = СтрокаТаблицы.Квота;
		НоваяСтрока.ПроцентОтклонения = СтрокаТаблицы.ПроцентОтклонения;
		
		СтрокаТоварнаяКатегория = ТаблицаТоварныеКатегории.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
		Если СтрокаТоварнаяКатегория <> Неопределено Тогда 
			Если СтрокаТоварнаяКатегория.Количество = 1 Тогда 
				НоваяСтрока.ТоварнаяКатегория  = СтрокаТоварнаяКатегория.ТоварнаяКатегорияСсылка;
			ИначеЕсли СтрокаТоварнаяКатегория.Количество > 1 Тогда 
				ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
				ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
				ЗаписьОНеоднозначности.Колонка = "ТоварнаяКатегория";
			КонецЕсли;
		КонецЕсли;
		
		СтрокаМарка = ТаблицаМарки.Найти(СтрокаТаблицы.Идентификатор, "Идентификатор");
		Если СтрокаМарка <> Неопределено Тогда 
			Если СтрокаМарка.Количество = 1 Тогда 
				НоваяСтрока.Марка  = СтрокаМарка.МаркаСсылка;
			ИначеЕсли СтрокаМарка.Количество > 1 Тогда 
				ЗаписьОНеоднозначности = СписокНеоднозначностей.Добавить();
				ЗаписьОНеоднозначности.Идентификатор = СтрокаТаблицы.Идентификатор; 
				ЗаписьОНеоднозначности.Колонка = "Марка";
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	ПоместитьВоВременноеХранилище(ТоварныеКатегории, АдресТаблицыСопоставления);
	
КонецПроцедуры

// Возвращает список подходящих объектов ИБ для неоднозначного значения ячейки.
//
// Параметры:
//  ПолноеИмяТабличнойЧасти  - Строка - полное имя табличной части, в которую загружаются данные.
//  СписокНеоднозначностей    - Массив - список с неоднозначными данными
//  ИмяКолонки                - Строка - имя колонки, в который возника неоднозначность
//  ЗагружаемыеЗначенияСтрока - Строка - Загружаемые данные на основании которых возникла неоднозначность
//  ДополнительныеПараметры - Структура.
//
Процедура ЗаполнитьСписокНеоднозначностей(ПолноеИмяТабличнойЧасти, СписокНеоднозначностей, ИмяКолонки, ЗагружаемыеЗначенияСтрока, ДополнительныеПараметры) Экспорт
	
	Если ИмяКолонки = "ТоварнаяКатегория" Тогда

		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТоварныеКатегории.Ссылка
		|ИЗ
		|	Справочник.ТоварныеКатегории КАК ТоварныеКатегории
		|ГДЕ
		|	ТоварныеКатегории.Наименование = &Наименование
		|	И НЕ ТоварныеКатегории.ЭтоГруппа";
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.ТоварнаяКатегория);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);  
		КонецЦикла;
	КонецЕсли;
	
	Если ИмяКолонки = "Марка" Тогда

		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	Марки.Ссылка
		|ИЗ
		|	Справочник.Марки КАК Марки
		|ГДЕ
		|	Марки.Наименование = &Наименование
		|	И НЕ Марки.ЭтоГруппа";
		Запрос.УстановитьПараметр("Наименование", ЗагружаемыеЗначенияСтрока.Марка);
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СписокНеоднозначностей.Добавить(ВыборкаДетальныеЗаписи.Ссылка);  
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#Область Проведение

Функция ДополнительныеИсточникиДанныхДляДвижений(ИмяРегистра) Экспорт

	ИсточникиДанных = Новый Соответствие;

	Возврат ИсточникиДанных; 

КонецФункции

Функция ТекстЗапросаТаблицаКвотыАссортимента(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "КвотыАссортимента";
	
	Если НЕ ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ТоварныеКатегории.НомерСтроки КАК НСтр,
	|	ТоварныеКатегории.Ссылка.ДатаНачалаДействия КАК Период,
	|	ТоварныеКатегории.ТоварнаяКатегория КАК ТоварнаяКатегория,
	|	ТоварныеКатегории.Ссылка.ОбъектПланирования КАК ОбъектПланирования,
	|	ТоварныеКатегории.Марка КАК Марка,
	|	ТоварныеКатегории.Ссылка.КоллекцияНоменклатуры КАК КоллекцияНоменклатуры,
	|	ТоварныеКатегории.Квота КАК Квота,
	|	ТоварныеКатегории.ПроцентОтклонения КАК ПроцентОтклонения
	|ИЗ
	|	Документ.УстановкаКвотАссортимента.ТоварныеКатегории КАК ТоварныеКатегории
	|ГДЕ
	|	ТоварныеКатегории.Ссылка = &Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	НСтр";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

#Область Печать

// Заполняет список команд печати.
//
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область Прочие

// Возвращаемое значение:
//  Булево - Существует план
Функция СуществуетПлан(ПроверяемыйОбъектПланирования, НаДату, ВызывающийДокумент) Экспорт
	ЕстьПлан = Ложь;
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	|	Регистратор КАК Регистратор
	|ИЗ
	|	РегистрСведений.КвотыАссортимента КАК КвотыАссортимента
	|ГДЕ
	|	КвотыАссортимента.Период = &Период
	|	И КвотыАссортимента.ОбъектПланирования = &ОбъектПланирования");
	Запрос.УстановитьПараметр("Период", НачалоМесяца(НаДату));
	Запрос.УстановитьПараметр("ОбъектПланирования", ПроверяемыйОбъектПланирования);
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Если Выборка.Регистратор <> ВызывающийДокумент Тогда
			ЕстьПлан = Истина;
		КонецЕсли;
	КонецЦикла;
	Возврат ЕстьПлан;
КонецФункции

#КонецОбласти

// Добавляет команду создания документа "Установка квот ассортимента".
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
// Возвращаемое значение:
//  СтрокаТаблицыЗначений, Неопределено - См. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	Если ПравоДоступа("Добавление", Метаданные.Документы.УстановкаКвотАссортимента) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.УстановкаКвотАссортимента.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = ОбщегоНазначенияУТ.ПредставлениеОбъекта(Метаданные.Документы.УстановкаКвотАссортимента);
		КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		КомандаСоздатьНаОсновании.ФункциональныеОпции = "ИспользоватьТоварныеКатегории";
	

		Возврат КомандаСоздатьНаОсновании;
	КонецЕсли;

	Возврат Неопределено;
КонецФункции

#КонецОбласти

#КонецЕсли
