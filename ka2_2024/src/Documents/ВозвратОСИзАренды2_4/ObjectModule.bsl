#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ИнициализироватьДокумент();
	
	ТипДанныхЗаполнения = ТипЗнч(ДанныеЗаполнения);
	Если ТипДанныхЗаполнения = Тип("Структура") Тогда
		ЗаполнитьДокументПоОтбору(ДанныеЗаполнения);
	ИначеЕсли ТипДанныхЗаполнения = Тип("СправочникСсылка.ОбъектыЭксплуатации") Тогда
		ЗаполнитьНаОснованииОбъектаЭксплуатации(ДанныеЗаполнения);
	ИначеЕсли ТипДанныхЗаполнения = Тип("ДокументСсылка.ПередачаОСВАренду2_4") Тогда
		ЗаполнитьНаОснованииПередачиОСАрендатору(ДанныеЗаполнения);
	КонецЕсли;
	
	ВозвратОСИзАрендыЛокализация.ОбработкаЗаполнения(ЭтотОбъект, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка);

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	НепроверяемыеРеквизиты = Новый Массив;
	НепроверяемыеРеквизиты.Добавить("ОС.ПорядокУчетаОС");
	НепроверяемыеРеквизиты.Добавить("ОС.СтатьяРасходов");
	
	ВспомогательныеРеквизиты = ВспомогательныеРеквизиты();
	
	ВнеоборотныеАктивы.ПроверитьСоответствиеДатыВерсииУчета(ЭтотОбъект, Истина, Отказ);
	
	ВнеоборотныеАктивы.ПроверитьОтсутствиеДублейВТабличнойЧасти(ЭтотОбъект, "ОС", "ОсновноеСредство", Отказ);
	
	ПараметрыРеквизитовОбъекта = УчетАрендованныхОСКлиентСервер.ЗначенияСвойствЗависимыхРеквизитов_ВозвратОСИзАренды(ЭтотОбъект, ВспомогательныеРеквизиты);
	ОбщегоНазначенияУТ.ОтключитьПроверкуЗаполненияРеквизитовОбъекта(ПараметрыРеквизитовОбъекта, НепроверяемыеРеквизиты);
	
	ПроверитьОсновныеСредства(ВспомогательныеРеквизиты.ВозвратИзФинаренды, Отказ);
	
	ПараметрыВыбораСтатейИАналитик = Документы.ВозвратОСИзАренды2_4.ПараметрыВыбораСтатейИАналитик();
	ДоходыИРасходыСервер.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты, ПараметрыВыбораСтатейИАналитик);
	
	Если ЗначениеЗаполнено(Организация) И ЗначениеЗаполнено(Арендатор) И (Организация = Арендатор) Тогда
		Текст = НСтр("ru='Поля ""Организация"" и ""Арендатор"" должны различаться.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Текст, ЭтотОбъект, "Арендатор",, Отказ);
	КонецЕсли;
	
	ПроверитьНаличиеУАрендатора(ВспомогательныеРеквизиты.ВозвратИзФинаренды, Отказ);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, НепроверяемыеРеквизиты);
	
	ВозвратОСИзАрендыЛокализация.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ДокументОснование = Неопределено;
	
	ИнициализироватьДокумент();
	
	ОбщегоНазначенияУТ.ОчиститьИдентификаторыДокумента(ЭтотОбъект, "ОС");
	
	ВозвратОСИзАрендыЛокализация.ПриКопировании(ЭтотОбъект, ОбъектКопирования);

КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	ПроведениеДокументов.ПередЗаписьюДокумента(ЭтотОбъект, РежимЗаписи, РежимПроведения);
	
	ВозвратИзФинаренды = ЗначениеЗаполнено(Договор);
	
	Если Не Отказ И РежимЗаписи = РежимЗаписиДокумента.Проведение
		И Не ВозвратИзФинаренды Тогда
		ВнеоборотныеАктивыСлужебный.ПроверитьЧтоОСПринятыКУчету(ЭтотОбъект, Отказ);
		ВнеоборотныеАктивыСлужебный.ЗаполнитьОтражениеВУчете(ЭтотОбъект, ОС.Выгрузить().ВыгрузитьКолонку("ОсновноеСредство"));
		ПроверитьЧтоОСНеПереданыВФинАренду(Отказ);
	КонецЕсли;
	
	Если ВозвратИзФинаренды Тогда
		ОтражатьВРеглУчете = Истина;
		ОтражатьВУпрУчете = Истина;
	КонецЕсли;
	
	ОбщегоНазначенияУТ.ЗаполнитьИдентификаторыДокумента(ЭтотОбъект, "ОС");
		
	Если НЕ ЗначениеЗаполнено(АдресМестонахождения) Тогда
		АдресМестонахождения = "";
	КонецЕсли;

	ПараметрыВыбораСтатейИАналитик = Документы.ВозвратОСИзАренды2_4.ПараметрыВыбораСтатейИАналитик();
	ДоходыИРасходыСервер.ПередЗаписью(ЭтотОбъект, ПараметрыВыбораСтатейИАналитик);
	
	// Настройка счетов учета.
	НастройкаСчетовУчетаСервер.ПередЗаписью(ЭтотОбъект, Документы.ВозвратОСИзАренды2_4.ПараметрыНастройкиСчетовУчета());

	ВозвратОСИзАрендыЛокализация.ПередЗаписью(ЭтотОбъект, Отказ, РежимЗаписи, РежимПроведения);

КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПроведениеДокументов.ПриЗаписиДокумента(ЭтотОбъект, Отказ);
	
	ВозвратОСИзАрендыЛокализация.ПриЗаписи(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ЗаблокироватьЧитаемыеДанные();
	
	ПроведениеДокументов.ОбработкаПроведенияДокумента(ЭтотОбъект, Отказ);
	
	ВозвратОСИзАрендыЛокализация.ОбработкаПроведения(ЭтотОбъект, Отказ, РежимПроведения);
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	ПроведениеДокументов.ОбработкаУдаленияПроведенияДокумента(ЭтотОбъект, Отказ);
	
	ВозвратОСИзАрендыЛокализация.ОбработкаУдаленияПроведения(ЭтотОбъект, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Заполнение

Процедура ИнициализироватьДокумент()
	
	Дата = НачалоДня(ТекущаяДатаСеанса());
	Ответственный = Пользователи.ТекущийПользователь();
	Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
	Подразделение = ЗначениеНастроекПовтИсп.ПодразделениеПользователя(Ответственный, Подразделение);
	ПодразделениеПолучатель = Подразделение;
	
	ПараметрыВыбораСтатейИАналитик = Документы.ВозвратОСИзАренды2_4.ПараметрыВыбораСтатейИАналитик();
	ДоходыИРасходыСервер.ОбработкаЗаполнения(ЭтотОбъект, ПараметрыВыбораСтатейИАналитик);
	
КонецПроцедуры

Процедура ЗаполнитьДокументПоОтбору(Основание)

	Если Основание.Свойство("ОсновноеСредство") Тогда
		ЗаполнитьНаОснованииОбъектаЭксплуатации(Основание.ОсновноеСредство);
	КонецЕсли; 
	
КонецПроцедуры

Процедура ЗаполнитьНаОснованииОбъектаЭксплуатации(Основание)
	
	Если НЕ ЗначениеЗаполнено(Основание) Тогда
		Возврат;
	КонецЕсли;
	
	РеквизитыОснования = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Основание, "ЭтоГруппа");
	
	Если РеквизитыОснования.ЭтоГруппа Тогда
		
		ТекстСообщения = НСтр("ru = 'Возврат от арендатора группы ОС невозможен.
			|Выберите ОС. Для раскрытия группы используйте клавиши Ctrl и стрелку вниз.'");
		ВызватьИсключение(ТекстСообщения);
		
	КонецЕсли;
	
	МестонахождениеОС = ВнеоборотныеАктивы.МестонахождениеОС(Основание);
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, МестонахождениеОС);
	Подразделение = МестонахождениеОС.ПодразделениеАрендатора;
	
	СтрокаТабличнойЧасти = ОС.Добавить();
	СтрокаТабличнойЧасти.ОсновноеСредство = Основание;
	
КонецПроцедуры

Процедура ЗаполнитьНаОснованииПередачиОСАрендатору(ДанныеЗаполнения)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ДанныеЗаполнения", ДанныеЗаполнения);
	Запрос.Текст=
	"ВЫБРАТЬ
	|	ПередачаОСВАренду.Организация КАК Организация,
	|	ВЫБОР
	|		КОГДА ПередачаОСВАренду.Договор ССЫЛКА Справочник.ДоговорыКонтрагентов
	|			ТОГДА ВЫБОР
	|					КОГДА ВЫРАЗИТЬ(ПередачаОСВАренду.Договор КАК Справочник.ДоговорыКонтрагентов).ТипДоговора В (&ТипыДоговоровДоходнойАренды)
	|						ТОГДА ПередачаОСВАренду.Договор
	|					ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ДоговорыКонтрагентов.ПустаяСсылка)
	|				КОНЕЦ
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ДоговорыКонтрагентов.ПустаяСсылка)
	|	КОНЕЦ КАК Договор,
	|	ПередачаОСВАренду.ПодразделениеПолучатель КАК Подразделение,
	|	ПередачаОСВАренду.Подразделение КАК ПодразделениеПолучатель,
	|	ПередачаОСВАренду.РасчетыМеждуОрганизациямиАрендатор КАК РасчетыМеждуОрганизациямиАрендатор,
	|	ПередачаОСВАренду.Арендатор КАК Арендатор,
	|	ПередачаОСВАренду.Ссылка КАК ДокументОснование,
	|	ИСТИНА КАК ДокументНаОсновании,
	|	ПередачаОСВАренду.ОС.(
	|		ОсновноеСредство КАК ОсновноеСредство
	|	)
	|ИЗ
	|	Документ.ПередачаОСВАренду2_4 КАК ПередачаОСВАренду
	|ГДЕ
	|	ПередачаОСВАренду.Ссылка = &ДанныеЗаполнения";
	
	Запрос.УстановитьПараметр("ТипыДоговоровДоходнойАренды", УчетАрендованныхОСКлиентСервер.ТипыДоговоровДоходнойАренды());
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Выборка);
	ОС.Загрузить(Выборка.ОС.Выгрузить());
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

Процедура ЗаблокироватьЧитаемыеДанные()

	// Нужно заблокировать данные, которые используются при записи движений.
	// Например, данные регистров сведений, которые используются для заполнения недостающих ресурсов.
	
	Блокировка = Новый БлокировкаДанных;
	
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ПервоначальныеСведенияОС");
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Разделяемый;
	ЭлементБлокировки.ИсточникДанных = ОС;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("ОсновноеСредство", "ОсновноеСредство");
	ЭлементБлокировки.УстановитьЗначение("Организация", Организация);
	
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ПорядокУчетаОС");
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.ИсточникДанных = ОС;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("ОсновноеСредство", "ОсновноеСредство");
	
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.МестонахождениеОС");
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.ИсточникДанных = ОС;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("ОсновноеСредство", "ОсновноеСредство");
	
	Если ОтражатьВУпрУчете Тогда
		
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ПорядокУчетаОСУУ");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.ИсточникДанных = ОС;
		ЭлементБлокировки.ИспользоватьИзИсточникаДанных("ОсновноеСредство", "ОсновноеСредство");
		ЭлементБлокировки.УстановитьЗначение("Организация", Организация);
		
	КонецЕсли; 
	
	Если ОтражатьВРеглУчете Тогда
		
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ПорядокУчетаОСБУ");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.ИсточникДанных = ОС;
		ЭлементБлокировки.ИспользоватьИзИсточникаДанных("ОсновноеСредство", "ОсновноеСредство");
		ЭлементБлокировки.УстановитьЗначение("Организация", Организация);
		
	КонецЕсли;
	
	Блокировка.Заблокировать(); 
	
КонецПроцедуры

Процедура ПроверитьНаличиеУАрендатора(ВозвратИзФинаренды, Отказ)

	Если ВозвратИзФинаренды
		ИЛИ НЕ ЗначениеЗаполнено(Арендатор)
		ИЛИ НЕ ЗначениеЗаполнено(Организация)
		ИЛИ НЕ ЗначениеЗаполнено(Подразделение) Тогда
		Возврат;
	КонецЕсли; 
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ТаблицаОС.НомерСтроки КАК НомерСтроки,
	|	ТаблицаОС.ОсновноеСредство КАК ОсновноеСредство
	|ПОМЕСТИТЬ ТаблицаОС
	|ИЗ
	|	&ТаблицаОС КАК ТаблицаОС
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ОсновноеСредство
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаОС.НомерСтроки КАК НомерСтроки,
	|	ВЫРАЗИТЬ(ТаблицаОС.ОсновноеСредство КАК Справочник.ОбъектыЭксплуатации).Представление КАК ОсновноеСредствоПредставление,
	|	МестонахождениеОС.Организация КАК Организация,
	|	МестонахождениеОС.Организация.Представление КАК ОрганизацияПредставление,
	|	МестонахождениеОС.Местонахождение КАК Местонахождение,
	|	МестонахождениеОС.Местонахождение.Представление КАК МестонахождениеПредставление,
	|	МестонахождениеОС.Арендатор КАК Арендатор,
	|	МестонахождениеОС.Арендатор.Представление КАК АрендаторПредставление
	|ИЗ
	|	ТаблицаОС КАК ТаблицаОС
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МестонахождениеОС.СрезПоследних(
	|				&Дата,
	|				Регистратор <> &Регистратор
	|					И ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
	|					И ОсновноеСредство В
	|						(ВЫБРАТЬ
	|							ТаблицаОС.ОсновноеСредство
	|						ИЗ
	|							ТаблицаОС)) КАК МестонахождениеОС
	|		ПО (МестонахождениеОС.ОсновноеСредство = ТаблицаОС.ОсновноеСредство)
	|ГДЕ
	|	(МестонахождениеОС.Организация <> &Организация
	|			ИЛИ МестонахождениеОС.Местонахождение <> &Подразделение
	|			ИЛИ МестонахождениеОС.Арендатор <> &Арендатор
	|			ИЛИ МестонахождениеОС.ОсновноеСредство ЕСТЬ NULL)
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Регистратор", Ссылка);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Подразделение", Подразделение);
	Запрос.УстановитьПараметр("Арендатор", Арендатор);
	Запрос.УстановитьПараметр("ТаблицаОС", ОС.Выгрузить());
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Путь = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ОС", Выборка.НомерСтроки, "ОсновноеСредство");
		
		Если НЕ ЗначениеЗаполнено(Выборка.Арендатор) Тогда
			ТекстСообщения = НСтр("ru = 'Основное средство ""%1"" не числится переданным в аренду на %2'");
			ТекстСообщения = СтрШаблон(ТекстСообщения, Выборка.ОсновноеСредствоПредставление, Формат(Дата, "ДЛФ=D"));
			
		ИначеЕсли Выборка.Организация <> Организация Тогда
			ТекстСообщения = НСтр("ru = 'Основное средство ""%1"" передано в аренду от другой организации ""%2""'");
			ТекстСообщения = СтрШаблон(ТекстСообщения, Выборка.ОсновноеСредствоПредставление, Выборка.ОрганизацияПредставление);
			
		ИначеЕсли Выборка.Арендатор <> Арендатор Тогда
			ТекстСообщения = НСтр("ru = 'Основное средство ""%1"" передано в аренду другому арендатору ""%2""'");
			ТекстСообщения = СтрШаблон(ТекстСообщения, Выборка.ОсновноеСредствоПредставление, Выборка.АрендаторПредставление);
			
		ИначеЕсли Выборка.Местонахождение <> Подразделение Тогда
			ТекстСообщения = НСтр("ru = 'Основное средство ""%1"" числится за другим подразделением ""%2""'");
			ТекстСообщения = СтрШаблон(ТекстСообщения, Выборка.ОсновноеСредствоПредставление, Выборка.МестонахождениеПредставление);
			
		КонецЕсли; 
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, Путь,, Отказ);
	
	КонецЦикла;
	
КонецПроцедуры

Функция ВспомогательныеРеквизиты()

	ВспомогательныеРеквизиты = Новый Структура;
	
	ВспомогательныеРеквизиты.Вставить(
		"ИспользуетсяУчетАрендыПоФСБУ25_2018",
		УчетАрендованныхОС.ИспользуетсяУчетАрендыПоФСБУ25_2018(Организация, Дата));
	
	ВспомогательныеРеквизиты.Вставить(
		"РеглУчетВНАВедетсяНезависимо",
		НастройкиНалоговУчетныхПолитикПовтИсп.РеглУчетВНАВедетсяНезависимо(Организация, КонецМесяца(?(Дата <> '000101010000', Дата, ТекущаяДатаСеанса()))));
		
	ВспомогательныеРеквизиты.Вставить(
		"ВозвратИзФинаренды",
		ЗначениеЗаполнено(Договор));
	
	Возврат ВспомогательныеРеквизиты;
	
КонецФункции

Процедура ПроверитьОсновныеСредства(ПередачаПоФСБУ25, Отказ)
	
	Если НЕ ПередачаПоФСБУ25 Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаОС.НомерСтроки КАК НомерСтроки,
	|	ТаблицаОС.ОсновноеСредство КАК ОсновноеСредство,
	|	ТаблицаОС.ПорядокУчетаОС КАК ПорядокУчетаОС,
	|	ТаблицаОС.СтатьяРасходов КАК СтатьяРасходов
	|ПОМЕСТИТЬ втТаблицаОС
	|ИЗ
	|	&ТаблицаОС КАК ТаблицаОС
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ОсновноеСредство
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПереданныеВАрендуОССрезПоследних.ОсновноеСредство КАК ОсновноеСредство
	|ПОМЕСТИТЬ втПереданныеВАрендуОС
	|ИЗ
	|	РегистрСведений.ПереданныеВАрендуОС.СрезПоследних(
	|			&Дата,
	|			ОсновноеСредство В
	|					(ВЫБРАТЬ
	|						втТаблицаОС.ОсновноеСредство
	|					ИЗ
	|						втТаблицаОС КАК втТаблицаОС)
	|				И Регистратор <> &Ссылка) КАК ПереданныеВАрендуОССрезПоследних
	|ГДЕ
	|	ПереданныеВАрендуОССрезПоследних.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПереданоВАренду)
	|	И ПереданныеВАрендуОССрезПоследних.Контрагент = &Контрагент
	|	И ПереданныеВАрендуОССрезПоследних.Договор = &Договор
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ОсновноеСредство
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втТаблицаОС.НомерСтроки КАК НомерСтроки,
	|	втТаблицаОС.ОсновноеСредство КАК ОсновноеСредство,
	|	втПереданныеВАрендуОС.ОсновноеСредство ЕСТЬ NULL КАК НеПереданоВАренду,
	|	ВЫБОР
	|		КОГДА втТаблицаОС.ПорядокУчетаОС = ЗНАЧЕНИЕ(Перечисление.ВариантыУчетаОСПриВозвратеИзАренды.ПустаяСсылка)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК НеЗаполненПорядокУчетаОС,
	|	ВЫБОР
	|		КОГДА втТаблицаОС.ПорядокУчетаОС <> ЗНАЧЕНИЕ(Перечисление.ВариантыУчетаОСПриВозвратеИзАренды.УчитыватьВСоставеОС)
	|				И (втТаблицаОС.СтатьяРасходов = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка)
	|					ИЛИ втТаблицаОС.СтатьяРасходов = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиАктивовПассивов.ПустаяСсылка))
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК НеЗаполненаСтатьяРасходов
	|ИЗ
	|	втТаблицаОС КАК втТаблицаОС
	|		ЛЕВОЕ СОЕДИНЕНИЕ втПереданныеВАрендуОС КАК втПереданныеВАрендуОС
	|		ПО втТаблицаОС.ОсновноеСредство = втПереданныеВАрендуОС.ОсновноеСредство
	|ГДЕ
	|	втПереданныеВАрендуОС.ОсновноеСредство ЕСТЬ NULL
	|	ИЛИ втТаблицаОС.ПорядокУчетаОС = ЗНАЧЕНИЕ(Перечисление.ВариантыУчетаОСПриВозвратеИзАренды.ПустаяСсылка)
	|	ИЛИ (втТаблицаОС.ПорядокУчетаОС <> ЗНАЧЕНИЕ(Перечисление.ВариантыУчетаОСПриВозвратеИзАренды.УчитыватьВСоставеОС)
	|		И (втТаблицаОС.СтатьяРасходов = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка)
	|		ИЛИ втТаблицаОС.СтатьяРасходов = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиАктивовПассивов.ПустаяСсылка)))";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Контрагент", Арендатор);
	Запрос.УстановитьПараметр("Договор", Договор);
	Запрос.УстановитьПараметр("ТаблицаОС", ОС.Выгрузить(, "НомерСтроки,ОсновноеСредство,ПорядокУчетаОС,СтатьяРасходов"));
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	ШаблонСообщенияНеПереданоВАренду =
		НСтр("ru = 'Объект учета в строке %1 списка ""Основные средства"" не передан в аренду по выбранному договору'");
	ШаблонСообщенияПорядокУчетаОС =
		НСтр("ru = 'Не заполнена колонка ""Порядок учета ОС"" в строке %1 списка ""Основные средства""'");
	ШаблонСообщенияСтатьяРасходов
		= НСтр("ru = 'Не заполнена колонка ""Статья расходов"" в строке %1 списка ""Основные средства""'");
	
	Пока Выборка.Следующий() Цикл
		
		Если Выборка.НеПереданоВАренду Тогда
			ТекстСообщения = СтрШаблон(ШаблонСообщенияНеПереданоВАренду, Выборка.НомерСтроки);
			Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ОС", Выборка.НомерСтроки, "ОсновноеСредство");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, Поле, "", Отказ);
			Продолжить;
		КонецЕсли;
		
		Если Выборка.НеЗаполненПорядокУчетаОС Тогда
			ТекстСообщения = СтрШаблон(ШаблонСообщенияПорядокУчетаОС, Выборка.НомерСтроки);
			Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ОС", Выборка.НомерСтроки, "ПорядокУчетаОС");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, Поле, "", Отказ);
		КонецЕсли;
		
		Если Выборка.НеЗаполненаСтатьяРасходов Тогда
			ТекстСообщения = СтрШаблон(ШаблонСообщенияСтатьяРасходов, Выборка.НомерСтроки);
			Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ОС", Выборка.НомерСтроки, "СтатьяРасходов");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, Поле, "", Отказ);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПроверитьЧтоОСНеПереданыВФинАренду(Отказ)
	
	Если НЕ ПолучитьФункциональнуюОпцию("ИспользуетсяПередачаВАрендуСубарендуПоФСБУ25") Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ПереданныеВАрендуОС.ОсновноеСредство КАК Ссылка,
	|	ПереданныеВАрендуОС.ОсновноеСредство.Представление КАК Представление
	|ИЗ
	|	РегистрСведений.ПереданныеВАрендуОС.СрезПоследних(
	|		&Период, 
	|		Регистратор <> &Ссылка 
	|			И ОсновноеСредство В (&СписокОС)) КАК ПереданныеВАрендуОС
	|
	|ГДЕ
	|	ПереданныеВАрендуОС.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПереданоВАренду)
	|	И ВЫРАЗИТЬ(ПереданныеВАрендуОС.Договор КАК Справочник.ДоговорыКонтрагентов).ТипДоговора В (&ТипыДоговоровПоФСБУ25)
	|";
		
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Период", Дата);
	Запрос.УстановитьПараметр("ТипыДоговоровПоФСБУ25", УчетАрендованныхОСКлиентСервер.ТипыДоговоровДоходнойАренды());
	
	СписокОС = ОС.ВыгрузитьКолонку("ОсновноеСредство");
		
	Запрос.УстановитьПараметр("СписокОС", СписокОС);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		ТекстСообщения = НСтр("ru = 'Основное средство ""%1"" было передано в финансовую аренду.
							  |Необходимо указать договор в документе.'");
		ТекстСообщения = СтрШаблон(ТекстСообщения, Выборка.Представление);
		
		ДанныеСтроки = ОС.Найти(Выборка.Ссылка, "ОсновноеСредство");
		Путь = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("ОС", ДанныеСтроки.НомерСтроки, "ОсновноеСредство");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, Путь,, Отказ);
		
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
