#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Запись.ИсходящийДокумент) Тогда
		ТолькоПросмотр = Истина;
	Иначе
		Элементы.ПоясняющаяНадписьВШапке.Видимость = Ложь;
		Элементы.ИсходныйДокументГруппа.Поведение = ПоведениеОбычнойГруппы.Обычное;
	КонецЕсли;
	
	ЭлементУО = ОбщегоНазначенияБЗК.ДобавитьУсловноеОформление(ЭтотОбъект, "ОшибкиПоСтрокамЗаявление");
	ОбщегоНазначенияБЗК.УстановитьПараметрУсловногоОформления(ЭлементУО, "Видимость", Ложь);
	ОбщегоНазначенияБЗК.УстановитьПараметрУсловногоОформления(ЭлементУО, "Отображать", Ложь);
	ОбщегоНазначенияБЗК.ДобавитьОтборУсловногоОформления(ЭлементУО, "Заявление", ВидСравненияКомпоновкиДанных.НеЗаполнено);
	
	ЭлементУО = ОбщегоНазначенияБЗК.ДобавитьУсловноеОформление(ЭтотОбъект, "ОшибкиПоСтрокамОтветНаЗапрос");
	ОбщегоНазначенияБЗК.УстановитьПараметрУсловногоОформления(ЭлементУО, "Видимость", Ложь);
	ОбщегоНазначенияБЗК.УстановитьПараметрУсловногоОформления(ЭлементУО, "Отображать", Ложь);
	ОбщегоНазначенияБЗК.ДобавитьОтборУсловногоОформления(ЭлементУО, "Заявление", ВидСравненияКомпоновкиДанных.Заполнено);
	ОбщегоНазначенияБЗК.ДобавитьОтборУсловногоОформления(ЭлементУО, "ОтветНаЗапрос", ВидСравненияКомпоновкиДанных.НеЗаполнено);
	
	Менеджер = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ИмяФормы);
	Менеджер.ЗаполнитьСписокВыбораСтатусов(Элементы.РегистрацияСтатус, Запись.РегистрацияСтатус);
	
	ОбновитьЭлементыФормы();
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ЗаполнитьОшибкиПоСтрокам();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ОтветНаЗапросФССДляРасчетаПособия"
		И (Источник = Запись.ИсходящийДокумент Или Не ЗначениеЗаполнено(Источник)) Тогда
		ПодключитьОбработчикОжиданияПрочитать();
		
	ИначеЕсли ИмяСобытия = СЭДОФССКлиент.ИмяСобытияПослеПолученияСообщенийОтФСС()
		Или ИмяСобытия = СЭДОФССКлиент.ИмяСобытияПослеОтправкиПодтвержденияПолучения() Тогда
		ПодключитьОбработчикОжиданияПрочитать();
		
	ИначеЕсли ИмяСобытия = "Запись_РегистрацииОтветовНаЗапросыФССДляРасчетаПособий"
		И (Источник = Запись.ИсходящийДокумент Или Не ЗначениеЗаполнено(Источник)) Тогда
		ПодключитьОбработчикОжиданияПрочитать();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_РегистрацииОтветовНаЗапросыФССДляРасчетаПособий", Запись.ИсходящийДокумент, Запись.ИсходящийДокумент);
	СЭДОФССКлиент.ОповеститьОНеобходимостиОбновитьТекущиеДела();
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПоясняющаяНадписьВШапкеОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОткрытьФорму("Документ.УведомлениеОПрекращенииОтпускаПоУходуЗаРебенком.ФормаОбъекта", Новый Структура("Ключ", Запись.ИсходящийДокумент));
КонецПроцедуры

&НаКлиенте
Процедура ВключитьВозможностьРедактирования(Команда)
	ТолькоПросмотр = Ложь;
	ОбновитьЭлементыФормы();
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовТаблицыФормыОшибкиПоСтрокам

&НаКлиенте
Процедура ОшибкиПоСтрокамВыбор(ТаблицаФормы, ИдентификаторСтроки, Колонка, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	СтрокаТаблицы = ТаблицаФормы.ДанныеСтроки(ИдентификаторСтроки);
	Если СтрокаТаблицы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если Колонка = Элементы.ОшибкиПоСтрокамРебенок Тогда
		Если ЗначениеЗаполнено(СтрокаТаблицы.Ребенок) Тогда
			ПоказатьЗначение(, СтрокаТаблицы.Ребенок);
		КонецЕсли;
	ИначеЕсли Колонка = Элементы.ОшибкиПоСтрокамТекстОшибкиСтроки Тогда
		Если ЗначениеЗаполнено(СтрокаТаблицы.ТекстОшибкиСтроки) Тогда
			ИнформированиеПользователяКлиент.ПоказатьПодробности(СтрокаТаблицы.ТекстОшибкиСтроки);
		КонецЕсли;
	ИначеЕсли Колонка = Элементы.ОшибкиПоСтрокамЗаявление Тогда
		Если ЗначениеЗаполнено(СтрокаТаблицы.Заявление) Тогда
			ПоказатьЗначение(, СтрокаТаблицы.Заявление);
		КонецЕсли;
	ИначеЕсли Колонка = Элементы.ОшибкиПоСтрокамОтветНаЗапрос Тогда
		Если ЗначениеЗаполнено(СтрокаТаблицы.ОтветНаЗапрос) Тогда
			ПоказатьЗначение(, СтрокаТаблицы.ОтветНаЗапрос);
		КонецЕсли;
	ИначеЕсли Колонка = Элементы.ОшибкиПоСтрокамИдентификаторСтроки Тогда
		Если ЗначениеЗаполнено(СтрокаТаблицы.ИдентификаторСтроки) Тогда
			Измерения = Новый Структура;
			Измерения.Вставить("ИдентификаторСообщения", Запись.ИдентификаторСообщения);
			Измерения.Вставить("ИдентификаторСтроки",    СтрокаТаблицы.ИдентификаторСтроки);
			ПараметрыЗаписи = Новый Массив(1);
			ПараметрыЗаписи[0] = Измерения;
			КлючРегистра = Новый(Тип("РегистрСведенийКлючЗаписи.РегистрацииУведомленийОПрекращенииОтпускаПоУходуЗаРебенком"), ПараметрыЗаписи);
			ПараметрыФормы = Новый Структура;
			ПараметрыФормы.Вставить("Ключ", КлючРегистра);
			ОткрытьФорму(
				"РегистрСведений.РегистрацииУведомленийОПрекращенииОтпускаПоУходуЗаРебенком.ФормаЗаписи",
				ПараметрыФормы,
				,
				,
				,
				,
				,
				РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДоставкаИдентификаторТекстXML(Команда)
	СЭДОФССКлиент.ПоказатьТекстXML(Запись.ИдентификаторСообщения);
КонецПроцедуры

&НаКлиенте
Процедура РегистрацияИдентификаторТекстXML(Команда)
	СЭДОФССКлиент.ПоказатьТекстXML(Запись.РегистрацияИдентификатор);
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьОшибкиПоСтрокам()
	УстановитьПривилегированныйРежим(Истина);
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Регистрация.ИдентификаторСтроки КАК ИдентификаторСтроки,
	|	Регистрация.ТекстОшибкиСтроки КАК ТекстОшибкиСтроки,
	|	Регистрация.ИсходящийНомерСтроки КАК ИсходящийНомерСтроки,
	|	ТабличнаяЧасть.Заявление КАК Заявление,
	|	ТабличнаяЧасть.ОтветНаЗапрос КАК ОтветНаЗапрос,
	|	ТабличнаяЧасть.Ребенок КАК Ребенок
	|ИЗ
	|	РегистрСведений.РегистрацииУведомленийОПрекращенииОтпускаПоУходуЗаРебенком КАК Регистрация
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.УведомлениеОПрекращенииОтпускаПоУходуЗаРебенком.ПрекращаемыеЗаявления КАК ТабличнаяЧасть
	|		ПО Регистрация.ИсходящийДокумент = ТабличнаяЧасть.Ссылка
	|			И Регистрация.ИсходящийНомерСтроки = ТабличнаяЧасть.НомерСтроки
	|ГДЕ
	|	Регистрация.ИдентификаторСообщения = &ИдентификаторСообщения
	|	И Регистрация.Страхователь = &Страхователь
	|	И Регистрация.ИдентификаторСтроки <> """"";
	Запрос.УстановитьПараметр("ИдентификаторСообщения", Запись.ИдентификаторСообщения);
	Запрос.УстановитьПараметр("Страхователь",           Запись.Страхователь);
	Таблица = Запрос.Выполнить().Выгрузить();
	ОшибкиПоСтрокам.Загрузить(Таблица);
КонецПроцедуры

&НаКлиенте
Процедура ПодключитьОбработчикОжиданияПрочитать()
	ОтключитьОбработчикОжидания("ОбработчикОжиданияПрочитать");
	ПодключитьОбработчикОжидания("ОбработчикОжиданияПрочитать", 0.2, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОжиданияПрочитать()
	Если Не Модифицированность Тогда
		Прочитать();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыФормы()
	Количество = ОшибкиПоСтрокам.Количество();
	Элементы.ДоставкаИдентификаторТекстXML.Видимость    = ЗначениеЗаполнено(Запись.ИдентификаторСообщения);
	Элементы.РегистрацияИдентификаторТекстXML.Видимость = ЗначениеЗаполнено(Запись.РегистрацияИдентификатор);
	Элементы.ОшибкиПоСтрокам.ВысотаВСтрокахТаблицы      = Количество;
	Элементы.ОшибкиПоСтрокам.Видимость                  = Количество > 0;
	Элементы.ОшибкиПоСтрокамРебенок.Видимость           = СЭДОФСС.ВидимостьПоляРодственник();
	
	ОтправленОператору = (Запись.ОтправленОператору Или ЗначениеЗаполнено(Запись.ДатаОтправкиОператору));
	Элементы.ОтправленОператору.Видимость          = Не ТолькоПросмотр Или ОтправленОператору;
	Элементы.ДатаОтправкиОператору.Видимость       = Не ТолькоПросмотр Или ОтправленОператору;
	Элементы.ДоставкаИдентификаторПакета.Видимость = Не ТолькоПросмотр Или ОтправленОператору
		Или ЗначениеЗаполнено(Запись.ДоставкаИдентификаторПакета);
	
	Элементы.ОшибкиЛогическогоКонтроляГруппа.Видимость = Не ТолькоПросмотр
		Или Запись.ЕстьОшибкиФЛК;
	
	Если РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца Тогда
		Элементы.КоманднаяПанельПодвал.Видимость = Истина;
		КнопкаЗакрыть = Элементы.КнопкаЗакрытьВПодвале;
	Иначе
		Элементы.КоманднаяПанельПодвал.Видимость = Ложь;
		КнопкаЗакрыть = Элементы.КнопкаЗакрытьВШапке;
	КонецЕсли;
	
	Если Запись.ДоставкаУспех
		И Не ЗначениеЗаполнено(Запись.РегистрацияИдентификатор)
		И Не Запись.ЕстьОшибкиФЛК Тогда
		Элементы.ПолучитьНовыеСообщенияСЭДОФСС.КнопкаПоУмолчанию = Истина;
	Иначе
		КнопкаЗакрыть.КнопкаПоУмолчанию = Истина;
	КонецЕсли;
	
	КлючСохраненияПоложенияОкна = Формат(Количество, "ЧН=; ЧГ=")
		+ "/"
		+ Формат(Элементы.ОшибкиЛогическогоКонтроляГруппа.Видимость, "БЛ=0; БИ=1");
	
КонецПроцедуры

#КонецОбласти
