////////////////////////////////////////////////////////////////////////////////
// Обновление информационной базы библиотеки КомплекснаяАвтоматизация.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область СведенияОБиблиотекеИлиКонфигурации

// Заполняет основные сведения о библиотеке или основной конфигурации.
// Библиотека, имя которой имя совпадает с именем конфигурации в метаданных, определяется как основная конфигурация.
// 
// Параметры:
//  Описание - Структура - сведения о библиотеке:
//
//   * Имя                 - Строка - имя библиотеки, например, "СтандартныеПодсистемы".
//   * Версия              - Строка - версия в формате из 4-х цифр, например, "2.1.3.1".
//
//   * ТребуемыеПодсистемы - Массив - имена других библиотек (Строка), от которых зависит данная библиотека.
//                                    Обработчики обновления таких библиотек должны быть вызваны ранее
//                                    обработчиков обновления данной библиотеки.
//                                    При циклических зависимостях или, напротив, отсутствии каких-либо зависимостей,
//                                    порядок вызова обработчиков обновления определяется порядком добавления модулей
//                                    в процедуре ПриДобавленииПодсистем общего модуля
//                                    ПодсистемыКонфигурацииПереопределяемый.
//   * РежимВыполненияОтложенныхОбработчиков - Строка - "Последовательно" - отложенные обработчики обновления выполняются
//                                    последовательно в интервале от номера версии информационной базы до номера
//                                    версии конфигурации включительно или "Параллельно" - отложенный обработчик после
//                                    обработки первой порции данных передает управление следующему обработчику, а после
//                                    выполнения последнего обработчика цикл повторяется заново.
//
Процедура ПриДобавленииПодсистемы(Описание) Экспорт
	
	Описание.Имя    = "КомплекснаяАвтоматизация";
	Описание.Версия = "2.5.21.99";
	Описание.РежимВыполненияОтложенныхОбработчиков = "Параллельно";
	Описание.ИдентификаторИнтернетПоддержки = "ARAutomation";
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиОбновленияИнформационнойБазы

// См. ОбновлениеИнформационнойБазыБСП.ПриДобавленииОбработчиковОбновления
//
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт

	ОбновлениеИнформационнойБазыКА.ПриДобавленииОбработчиковОбновленияКА(Обработчики);
	Документы.ПроизводствоБезЗаказа.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.ВыработкаСотрудников.ПриДобавленииОбработчиковОбновления(Обработчики);
	Справочники.ЭтапыПроизводства.ПриДобавленииОбработчиковОбновления(Обработчики);
	ВнеоборотныеАктивы.ПриДобавленииОбработчиковОбновления(Обработчики);
	ПланыВидовХарактеристик.АналитикиСтатейБюджетов.ПриДобавленииОбработчиковОбновления(Обработчики);
	РегистрыСведений.НастройкиИсключенийПроверкиДокументов.ПриДобавленииОбработчиковОбновления(Обработчики);
	РегистрыСведений.СпецификацииИзделий.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.УстановкаЗначенийНефинансовыхПоказателей.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.ЭкземплярБюджета.ПриДобавленииОбработчиковОбновления(Обработчики);
	РегистрыНакопления.ЛимитыПоДаннымБюджетирования.ПриДобавленииОбработчиковОбновления(Обработчики);
	РегистрыНакопления.ОборотыБюджетов.ПриДобавленииОбработчиковОбновления(Обработчики);
	РегистрыНакопления.ФактическиеДанныеБюджетирования.ПриДобавленииОбработчиковОбновления(Обработчики);
	РегистрыСведений.ЗначенияНефинансовыхПоказателей.ПриДобавленииОбработчиковОбновления(Обработчики);
	РегистрыСведений.СвязиПоказателейБюджетов.ПриДобавленииОбработчиковОбновления(Обработчики);
	РегистрыНакопления.ВыпускПродукции.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.ЗаказПереработчику2_5.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.ЗаключениеДоговораАренды.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.ИзменениеУсловийДоговораАренды.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.ОтражениеЗарплатыВФинансовомУчете2_5.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.ОтчетПереработчика2_5.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.ПоступлениеУслугПоАренде.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.РаспределениеВозвратныхОтходов.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.РаспределениеПроизводственныхЗатрат.ПриДобавленииОбработчиковОбновления(Обработчики);
	Справочники.НефинансовыеПоказателиБюджетов.ПриДобавленииОбработчиковОбновления(Обработчики);
	Справочники.ПравилаПолученияФактаПоСтатьямБюджетов.ПриДобавленииОбработчиковОбновления(Обработчики);
	Справочники.ПравилаПолученияФактаПоПоказателямБюджетов.ПриДобавленииОбработчиковОбновления(Обработчики);
	Справочники.ЭлементыФинансовыхОтчетов.ПриДобавленииОбработчиковОбновления(Обработчики);
	Справочники.ПравилаРаспределенияРасходов.ПриДобавленииОбработчиковОбновления(Обработчики);
	Документы.РаспределениеПрочихЗатрат.ПриДобавленииОбработчиковОбновления(Обработчики);
	
КонецПроцедуры

// Вызывается перед процедурами-обработчиками обновления данных ИБ.
//
Процедура ПередОбновлениемИнформационнойБазы() Экспорт
	
КонецПроцедуры

// Вызывается после завершения обновления данных ИБ.
// 
// Параметры:
//   ПредыдущаяВерсия       - Строка - версия до обновления. "0.0.0.0" для "пустой" ИБ.
//   ТекущаяВерсия          - Строка - версия после обновления.
//   ВыполненныеОбработчики - ДеревоЗначений - список выполненных процедур-обработчиков обновления,
//                                             сгруппированных по номеру версии.
//   ВыводитьОписаниеОбновлений - Булево - (возвращаемое значение) если установить Истина,
//                                то будет выведена форма с описанием обновлений. По умолчанию, Истина.
//   МонопольныйРежим           - Булево - Истина, если обновление выполнялось в монопольном режиме.
//
// Пример обхода выполненных обработчиков обновления:
//
//	Для Каждого Версия Из ВыполненныеОбработчики.Строки Цикл
//		
//		Если Версия.Версия = "*" Тогда
//			// Обработчик, который может выполнятся при каждой смене версии.
//		Иначе
//			// Обработчик, который выполняется для определенной версии.
//		КонецЕсли;
//		
//		Для Каждого Обработчик Из Версия.Строки Цикл
//			...
//		КонецЦикла;
//		
//	КонецЦикла;
//
Процедура ПослеОбновленияИнформационнойБазы(Знач ПредыдущаяВерсия, Знач ТекущаяВерсия,
		Знач ВыполненныеОбработчики, ВыводитьОписаниеОбновлений, МонопольныйРежим) Экспорт
	
	ОбновлениеИнформационнойБазыУТ.ПослеОбновленияИнформационнойБазы(ПредыдущаяВерсия, ТекущаяВерсия,
		ВыполненныеОбработчики, ВыводитьОписаниеОбновлений, МонопольныйРежим);
	
КонецПроцедуры

// Вызывается при подготовке табличного документа с описанием изменений в программе.
//
// Параметры:
//   Макет - ТабличныйДокумент - описание обновления всех библиотек и конфигурации.
//           Макет можно дополнить или заменить.
//           См. общий макет ОписаниеИзмененийСистемы.
//
Процедура ПриПодготовкеМакетаОписанияОбновлений(Знач Макет) Экспорт
	
КонецПроцедуры

// Добавляет в список процедуры-обработчики перехода с другой программы (с другим именем конфигурации).
// Например, для перехода между разными, но родственными конфигурациями: базовая -> проф -> корп.
// Вызывается перед началом обновления данных ИБ.
//
// Параметры:
//  Обработчики - ТаблицаЗначений - с колонками:
//    * ПредыдущееИмяКонфигурации - Строка - имя конфигурации, с которой выполняется переход;
//    * Процедура                 - Строка - полное имя процедуры-обработчика перехода с программы ПредыдущееИмяКонфигурации. 
//                                  Например, "ОбновлениеИнформационнойБазыУПП.ЗаполнитьУчетнуюПолитику"
//                                  Обязательно должна быть экспортной.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.ПредыдущееИмяКонфигурации  = "КомплекснаяАвтоматизация";
//  Обработчик.Процедура                  = "ОбновлениеИнформационнойБазыУПП.ЗаполнитьУчетнуюПолитику";
//
Процедура ПриДобавленииОбработчиковПереходаСДругойПрограммы(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.ПредыдущееИмяКонфигурации = "УправлениеТорговлей";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыКА.ОбновлениеУТДоКА";
	
	Обработчик = Обработчики.Добавить();
	Обработчик.ПредыдущееИмяКонфигурации = "УправлениеТорговлей";
	Обработчик.Процедура = "Справочники.НастройкиХозяйственныхОпераций.ЗаполнитьПредопределенныеНастройкиХозяйственныхОпераций";
	
	ОбновлениеИнформационнойБазыЛокализация.ПриДобавленииОбработчиковПереходаНаКА(Обработчики);
	
КонецПроцедуры

// Позволяет переопределить режим обновления данных информационной базы.
// Для использования в редких (нештатных) случаях перехода, не предусмотренных в
// стандартной процедуре определения режима обновления.
//
// Параметры:
//   РежимОбновленияДанных - Строка - в обработчике можно присвоить одно из значений:
//              "НачальноеЗаполнение"     - если это первый запуск пустой базы (области данных);
//              "ОбновлениеВерсии"        - если выполняется первый запуск после обновление конфигурации базы данных;
//              "ПереходСДругойПрограммы" - если выполняется первый запуск после обновление конфигурации базы данных, 
//                                          в которой изменилось имя основной конфигурации.
//
//   СтандартнаяОбработка  - Булево - если присвоить Ложь, то стандартная процедура
//                                    определения режима обновления не выполняется, 
//                                    а используется значение РежимОбновленияДанных.
//
Процедура ПриОпределенииРежимаОбновленияДанных(РежимОбновленияДанных, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Вызывается после выполнения всех процедур-обработчиков перехода с другой программы (с другим именем конфигурации),
// и до начала выполнения обновления данных ИБ.
//
// Параметры:
//  ПредыдущееИмяКонфигурации    - Строка - имя конфигурации до перехода.
//  ПредыдущаяВерсияКонфигурации - Строка - имя предыдущей конфигурации (до перехода).
//  Параметры                    - Структура: 
//    * ВыполнитьОбновлениеСВерсии   - Булево - по умолчанию Истина. Если установить Ложь, 
//        то будут выполнена только обязательные обработчики обновления (с версией "*").
//    * ВерсияКонфигурации           - Строка - номер версии после перехода. 
//        По умолчанию, равен значению версии конфигурации в свойствах метаданных.
//        Для того чтобы выполнить, например, все обработчики обновления с версии ПредыдущаяВерсияКонфигурации, 
//        следует установить значение параметра в ПредыдущаяВерсияКонфигурации.
//        Для того чтобы выполнить вообще все обработчики обновления, установить значение "0.0.0.1".
//    * ОчиститьСведенияОПредыдущейКонфигурации - Булево - по умолчанию Истина. 
//        Для случаев когда предыдущая конфигурация совпадает по имени с подсистемой текущей конфигурации, следует
//        указать Ложь.
//
Процедура ПриЗавершенииПереходаСДругойПрограммы(Знач ПредыдущееИмяКонфигурации, 
	Знач ПредыдущаяВерсияКонфигурации, Параметры) Экспорт
	
	Если ПредыдущееИмяКонфигурации = "УправлениеТорговлей" Тогда
		Параметры.ОчиститьСведенияОПредыдущейКонфигурации = Ложь;
		ОбновлениеИнформационнойБазы.УстановитьВерсиюИБ(ПредыдущееИмяКонфигурации, ПредыдущаяВерсияКонфигурации, Ложь);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПереименованныеОбъектыМетаданных

// Заполняет переименования объектов метаданных (подсистемы и роли).
// Подробнее см. ОбщегоНазначенияПереопределяемый.ПриДобавленииПереименованийОбъектовМетаданных.
// 
// Параметры:
//   Итог	- Структура - передается в процедуру подсистемой БазоваяФункциональность.
//
Процедура ПриДобавленииПереименованийОбъектовМетаданных(Итог) Экспорт
	
	ОписаниеПодсистемы = Новый Структура("Имя, Версия, РежимВыполненияОтложенныхОбработчиков, ИдентификаторИнтернетПоддержки");
	ПриДобавленииПодсистемы(ОписаниеПодсистемы);
	
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.1.1.19",
		"Роль.РазделПроизводство",
		"Роль.ПодсистемаПроизводство",
		ОписаниеПодсистемы.Имя);
	
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.1.1.59",
		"Подсистема.Производство.Подсистема.МежцеховоеУправление",
		"Подсистема.Производство.Подсистема.МежцеховоеУправление2_1",
		ОписаниеПодсистемы.Имя);
		
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.1.1.59",
		"Подсистема.Производство.Подсистема.ВнутрицеховоеУправление",
		"Подсистема.Производство.Подсистема.ВнутрицеховоеУправление2_1",
		ОписаниеПодсистемы.Имя);
		
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.1.1.59",
		"Подсистема.Производство.Подсистема.МатериальныйУчет",
		"Подсистема.Производство.Подсистема.МатериальныйУчет2_1",
		ОписаниеПодсистемы.Имя);
		
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.1.1.72",
		"Подсистема.Производство.Подсистема.ПроизводственныеЗатраты",
		"Подсистема.Производство.Подсистема.ПроизводственныеЗатраты2_1",
		ОписаниеПодсистемы.Имя);
		
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.1.1.72",
		"Подсистема.Производство.Подсистема.АнализСебестоимости",
		"Подсистема.Производство.Подсистема.АнализСебестоимости2_1",
		ОписаниеПодсистемы.Имя);
		
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.5.2.10",
		"Роль.ДобавлениеИзменениеРегистрацийНаработок",
		"Роль.ДобавлениеИзменениеНаработкиОбъектовЭксплуатации",
		ОписаниеПодсистемы.Имя);	
	
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.5.6.1",
		"Подсистема.ВнеоборотныеАктивы.Подсистема.Лизинг",
		"Подсистема.ВнеоборотныеАктивы.Подсистема.Аренда",
		ОписаниеПодсистемы.Имя);
	
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.5.6.1",
		"Роль.ЧтениеДоговоровЛизинга",
		"Роль.ЧтениеДоговоровАренды",
		ОписаниеПодсистемы.Имя);
	
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.5.6.1",
		"Роль.ДобавлениеИзменениеПриобретенийУслугПоЛизингу",
		"Роль.ДобавлениеИзменениеПоступленийУслугПоАренде",
		ОписаниеПодсистемы.Имя);
	
	ОбщегоНазначения.ДобавитьПереименование(Итог,
		"2.5.6.1",
		"Роль.ЧтениеПриобретенийУслугПоЛизингу",
		"Роль.ЧтениеПоступленийУслугПоАренде",
		ОписаниеПодсистемы.Имя);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ЗаполненияПустойИБ

// Обработчик первого запуска КА.
//
Процедура ПервыйЗапуск() Экспорт
	
	УстановитьВалютуПлановыхЦен();
	УстановитьВалютуРасценокВидовРабот();
	
	ЗаполнитьКонстантуИспользоватьБюджетирование();
	ПланыВидовХарактеристик.АналитикиСтатейБюджетов.ЗаполнитьПредопределенныеАналитикиСтатейБюджетов();
	Константы.ЗаполненыДвиженияАктивовПассивов.Установить(Истина);
	Константы.ИспользоватьЗаполнениеРаздела7ДекларацииПоНДС.Установить(Истина);
	
КонецПроцедуры

Процедура ОбновлениеУТДоКА() Экспорт
	
	ПланыВидовХарактеристик.АналитикиСтатейБюджетов.ЗаполнитьПредопределенныеАналитикиСтатейБюджетов();
	Константы.ЗаполненыДвиженияАктивовПассивов.Установить(Истина);
	
	ОбновлениеИнформационнойБазыУТ.ЗаполнитьЗначениеРазделенияПоОбластямДанных();
	
	ЗначенияКонстант = Новый Структура;
	ЗначенияКонстант.Вставить("УправлениеТорговлей", Ложь);
	ЗначенияКонстант.Вставить("КомплекснаяАвтоматизация", Истина);
	
#Область Варианты_обособления
	ЗначенияКонстант.Вставить(Метаданные.Константы.ВариантОбособленияМатериаловПриПередачеВПроизводство.Имя,  Перечисления.ВариантыОбособленияМатериаловПриПередачеВПроизводство.НазначениеПолучателя);
	//++ Устарело_Переработка24
	ЗначенияКонстант.Вставить(Метаданные.Константы.ВариантОбособленияМатериаловВПереработке.Имя,              Перечисления.ВариантыОбособленияПриПередачеВПереработку.ЗаказПереработчику);
	//-- Устарело_Переработка24
	ЗначенияКонстант.Вставить(Метаданные.Константы.ВариантОбособленияУПереработчика2_5.Имя,                   Перечисления.ВариантыОбособленияПриПередачеВПереработку.НеОбосабливать);
	ЗначенияКонстант.Вставить(Метаданные.Константы.ВариантОбособленияВПередачеПереработчику2_5.Имя,           Перечисления.ВариантыОбособленияПриПередачеВПереработку.ЗаказПереработчику);
#КонецОбласти
	
	Для Каждого КлючИЗначение Из ЗначенияКонстант Цикл
		Константы[КлючИЗначение.Ключ].Установить(КлючИЗначение.Значение);
	КонецЦикла; 
	
	Если Константы.ИспользоватьУчетНДС.Получить() = Истина Тогда 
		Константы.ИспользоватьЗаполнениеРаздела7ДекларацииПоНДС.Установить(Истина);
	КонецЕсли;
	
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

// Процедура устанавливает значение валюты плановых цен.
// Вызывается при первоначальном заполнении ИБ.
//
Процедура УстановитьВалютуПлановыхЦен()
	
	Если НЕ ЗначениеЗаполнено(Константы.ВалютаПлановойСебестоимостиПродукции.Получить())
		И Не Константы.ИспользоватьНесколькоВалют.Получить()Тогда
		
		Запрос = Новый Запрос(
			"ВЫБРАТЬ ПЕРВЫЕ 2
			|	Валюты.Ссылка КАК Ссылка
			|ИЗ
			|	Справочник.Валюты КАК Валюты
			|ГДЕ
			|	НЕ Валюты.ПометкаУдаления");
		РезультатЗапроса = Запрос.Выполнить();
		
		Если Не РезультатЗапроса.Пустой() Тогда
			Выборка = РезультатЗапроса.Выбрать();
			Если Выборка.Количество() = 1 Тогда
				Выборка.Следующий();
				
				Константы.ВалютаПлановойСебестоимостиПродукции.Установить(Выборка.Ссылка);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Процедура устанавливает значение валюты расценок видов работ.
// Вызывается при первоначальном заполнении ИБ.
//
Процедура УстановитьВалютуРасценокВидовРабот()
	
	Если НЕ ЗначениеЗаполнено(Константы.ВалютаРасценокВидовРабот.Получить())
		И Не Константы.ИспользоватьНесколькоВалют.Получить()Тогда
		
		Запрос = Новый Запрос(
			"ВЫБРАТЬ ПЕРВЫЕ 2
			|	Валюты.Ссылка КАК Ссылка
			|ИЗ
			|	Справочник.Валюты КАК Валюты
			|ГДЕ
			|	НЕ Валюты.ПометкаУдаления");
		РезультатЗапроса = Запрос.Выполнить();
		
		Если Не РезультатЗапроса.Пустой() Тогда
			Выборка = РезультатЗапроса.Выбрать();
			Если Выборка.Количество() = 1 Тогда
				Выборка.Следующий();
				
				Константы.ВалютаРасценокВидовРабот.Установить(Выборка.Ссылка);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// см. ОбновлениеИнформационнойБазыБСП.ПриДобавленииОбработчиковОбновления
Процедура ПриДобавленииОбработчиковОбновленияКА(Обработчики) Экспорт

#Область ПервыйЗапуск

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыКА.ПервыйЗапуск";
	Обработчик.Версия = "";
	Обработчик.РежимВыполнения = "Монопольно";
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.Комментарий = "";

#КонецОбласти

#Область ОчиститьКэшВспомогательныхДанныхВидаБюджета

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыКА.ОчиститьКэшВспомогательныхДанныхВидаБюджета";
	Обработчик.Версия = "2.5.21.62";
	Обработчик.РежимВыполнения = "Монопольно";
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("1c26f542-471a-4927-b3e0-c038c81fe901");
	Обработчик.Комментарий = НСтр("ru = 'Очищает кэш вспомогательных данных вида бюджета"".'");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыСведений.КэшВспомогательныхДанныхВидаБюджета.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");

#КонецОбласти

#Область ОчиститьКэшНастроекЛимитовПоДаннымБюджетирования

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыКА.ОчиститьКэшНастроекЛимитовПоДаннымБюджетирования";
	Обработчик.Версия = "2.5.21.99";
	Обработчик.РежимВыполнения = "Монопольно";
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("287dc94a-93cb-bf4a-87ae-80735cf44656");
	Обработчик.Комментарий = НСтр("ru = 'Очищает кэш настроек лимитов по данным бюджетирования"".'");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыСведений.КэшНастроекЛимитовПоДаннымБюджетирования.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");

#КонецОбласти

#Область УстановитьКонстантуКонтрольЛимитовПоДаннымБюджетирования2_4

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыКА.УстановитьКонстантуКонтрольЛимитовПоДаннымБюджетирования2_4";
	Обработчик.Версия = "2.5.18.11";
	Обработчик.РежимВыполнения = "Монопольно";
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("6cb2fd45-a62a-4961-a847-548522165861");
	Обработчик.Комментарий = НСтр("ru = 'Устанавливает значение константы ""Контроль лимитов по данным бюджетирования 2.4"".'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.Константы.ИспользоватьЛимитыРасходаДенежныхСредствБюджетирования.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Константы.КонтрольЛимитовПоДаннымБюджетирования2_4.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Константы.КонтрольЛимитовПоДаннымБюджетирования2_5.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.Константы.КонтрольЛимитовПоДаннымБюджетирования2_4.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");

#КонецОбласти

#Область УстановитьКонстантуИспользоватьПериодичностьОформленияВыработки
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыКА.УстановитьКонстантуИспользоватьПериодичностьОформленияВыработки";
	Обработчик.Версия = "2.5.20.6";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("4d50d45b-2386-4e6f-8ed2-ca69581ee3a2");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "ОбновлениеИнформационнойБазыКА.ЗарегистрироватьДанныеКОбновлениюКонстанты";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	
	Обработчик.Комментарий = НСтр("ru = 'Устанавливает значение константы ""Использовать периодичность оформления выработки"".'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.Справочники.СтруктураПредприятия.ПолноеИмя());
	
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.Константы.ИспользоватьПериодичностьОформленияВыработки.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
#КонецОбласти

КонецПроцедуры

// Обработчик первого запуска КА.
// Включает константу "ИспользоватьБюджетирование".
//
Процедура ЗаполнитьКонстантуИспользоватьБюджетирование() Экспорт
	
	Если НЕ ПолучитьФункциональнуюОпцию("КомплекснаяАвтоматизация") Тогда
		Возврат;
	КонецЕсли;
	
	Константы.ИспользоватьБюджетирование.Установить(Истина);
	Константы.ИнтерфейсВерсии82.Установить(Ложь);
	
КонецПроцедуры

#Область ОчиститьКэшВспомогательныхДанныхВидаБюджета

Процедура ОчиститьКэшВспомогательныхДанныхВидаБюджета() Экспорт
	
	РегистрыСведений.КэшВспомогательныхДанныхВидаБюджета.СоздатьНаборЗаписей().Записать();
	
КонецПроцедуры

#КонецОбласти

#Область ОчиститьКэшНастроекЛимитовПоДаннымБюджетирования

Процедура ОчиститьКэшНастроекЛимитовПоДаннымБюджетирования() Экспорт
	
	РегистрыСведений.КэшНастроекЛимитовПоДаннымБюджетирования.СоздатьНаборЗаписей().Записать();
	
КонецПроцедуры

#КонецОбласти

#Область УстановитьКонстантуИспользоватьЗаполнениеРаздела7ДекларацииПоНДС

Процедура УстановитьКонстантуИспользоватьЗаполнениеРаздела7ДекларацииПоНДС() Экспорт
	
	Если Константы.ИспользоватьУчетНДС.Получить() = Истина Тогда
		Константы.ИспользоватьЗаполнениеРаздела7ДекларацииПоНДС.Установить(Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область УстановитьКонстантуКонтрольЛимитовПоДаннымБюджетирования2_4

Процедура УстановитьКонстантуКонтрольЛимитовПоДаннымБюджетирования2_4() Экспорт
	
	Если Константы.ИспользоватьЛимитыРасходаДенежныхСредствБюджетирования.Получить() Тогда
		Константы.КонтрольЛимитовПоДаннымБюджетирования2_4.Установить(Не Константы.КонтрольЛимитовПоДаннымБюджетирования2_5.Получить());
	Иначе
		Константы.КонтрольЛимитовПоДаннымБюджетирования2_4.Установить(Ложь);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область УстановитьКонстантуИспользоватьПериодичностьОформленияВыработки

// Пустой обработчик регистрации
Процедура ЗарегистрироватьДанныеКОбновлениюКонстанты(ПараметрыОбновления) Экспорт
	
	// Регистрация не требуется
	Возврат;
	
КонецПроцедуры

Процедура УстановитьКонстантуИспользоватьПериодичностьОформленияВыработки(ПараметрыОбновления) Экспорт
	
	Если Константы.ИспользоватьПериодичностьОформленияВыработки.Получить() Тогда
		ПараметрыОбновления.ОбработкаЗавершена = Истина;
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИСТИНА
	|ИЗ
	|	Справочник.СтруктураПредприятия КАК СтруктураПредприятия
	|ГДЕ
	|	СтруктураПредприятия.ПроизводственноеПодразделение
	|	И СтруктураПредприятия.ПериодичностьОформленияВыработки <> ЗНАЧЕНИЕ(Перечисление.ПериодичностьОформленияВыработкиСотрудников.Месяц)");
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Константы.ИспользоватьПериодичностьОформленияВыработки.Установить(Истина);
	КонецЕсли;
	
	ПараметрыОбновления.ОбработкаЗавершена = Истина;

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецОбласти
