
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Если Параметры.Отбор.Свойство("Партнер") Тогда
		Элементы.КлиентПоставщик.Видимость = Ложь;
		Возврат;
	КонецЕсли;

	Партнер = Настройки.Получить("Партнер");
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Партнер",Партнер, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Партнер));
	
	Ответственный  = Настройки.Получить("Ответственный");
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Ответственный", Ответственный, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Ответственный));

	Статус = Настройки.Получить("Статус");
	Если Статус = "Новые" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",Перечисления.СтатусыПретензийКлиентов.Зарегистрирована,ВидСравненияКомпоновкиДанных.Равно,Истина);
	ИначеЕсли Статус = "Обрабатывается" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",Перечисления.СтатусыПретензийКлиентов.Обрабатывается,ВидСравненияКомпоновкиДанных.Равно,Истина);
	ИначеЕсли Статус = "Удовлетворено" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",Перечисления.СтатусыПретензийКлиентов.Удовлетворена,ВидСравненияКомпоновкиДанных.Равно,Истина);
	ИначеЕсли Статус = "НеУдовлетворено" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",Перечисления.СтатусыПретензийКлиентов.НеУдовлетворена,ВидСравненияКомпоновкиДанных.Равно,Истина);
	ИначеЕсли Статус = "Завершенные" Тогда
		СписокСтатусов = Новый СписокЗначений;
		СписокСтатусов.Добавить(Перечисления.СтатусыПретензийКлиентов.Удовлетворена);
		СписокСтатусов.Добавить(Перечисления.СтатусыПретензийКлиентов.НеУдовлетворена);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",СписокСтатусов,ВидСравненияКомпоновкиДанных.ВСписке,Истина); 
	ИначеЕсли Статус = "НеЗавершенные" Тогда
		СписокСтатусов = Новый СписокЗначений;
		СписокСтатусов.Добавить(Перечисления.СтатусыПретензийКлиентов.Удовлетворена);
		СписокСтатусов.Добавить(Перечисления.СтатусыПретензийКлиентов.НеУдовлетворена);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",СписокСтатусов,ВидСравненияКомпоновкиДанных.НеВСписке,Истина);
	КонецЕсли;
	
	Если ПустаяСтрока(Статус) Тогда
		Статус = "Все";
		Настройки.Удалить("Статус");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Статус = "Все";
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	// ИнтеграцияС1СДокументооборотом
	ИнтеграцияС1СДокументооборотБазоваяФункциональность.ПриСозданииНаСервере(ЭтаФорма, Элементы.СписокКоманднаяПанель);
	// Конец ИнтеграцияС1СДокументооборотом

	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
КонецПроцедуры 

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование" И ВводДоступен() Тогда
		Если ИмяСобытия = "ScanData" И МенеджерОборудованияУТКлиент.ЕстьНеобработанноеСобытие() Тогда
			ОбработатьШтрихкоды(МенеджерОборудованияУТКлиент.ПреобразоватьДанныеСоСканераВСтруктуру(Параметр));
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КлиентПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Партнер", Партнер, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Партнер));
	
КонецПроцедуры

&НаКлиенте
Процедура ОтветственныйОтборПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Ответственный", Ответственный, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Ответственный));
	
КонецПроцедуры

&НаКлиенте
Процедура СтатусОтборПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Список, "Завершен");
	ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Список, "Статус");
	
	Если Статус = "Новые" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",ПредопределенноеЗначение("Перечисление.СтатусыПретензийКлиентов.Зарегистрирована"),ВидСравненияКомпоновкиДанных.Равно,Истина);
	ИначеЕсли Статус = "Обрабатывается" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",ПредопределенноеЗначение("Перечисление.СтатусыПретензийКлиентов.Обрабатывается"),ВидСравненияКомпоновкиДанных.Равно,Истина);
	ИначеЕсли Статус = "Удовлетворено" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",ПредопределенноеЗначение("Перечисление.СтатусыПретензийКлиентов.Удовлетворена"),ВидСравненияКомпоновкиДанных.Равно,Истина);
	ИначеЕсли Статус = "НеУдовлетворено" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",ПредопределенноеЗначение("Перечисление.СтатусыПретензийКлиентов.НеУдовлетворена"),ВидСравненияКомпоновкиДанных.Равно,Истина);
	ИначеЕсли Статус = "Завершенные" Тогда
		СписокСтатусов = Новый СписокЗначений;
		СписокСтатусов.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыПретензийКлиентов.Удовлетворена"));
		СписокСтатусов.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыПретензийКлиентов.НеУдовлетворена"));
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",СписокСтатусов,ВидСравненияКомпоновкиДанных.ВСписке,Истина);
	ИначеЕсли Статус = "НеЗавершенные" Тогда
		СписокСтатусов = Новый СписокЗначений;
		СписокСтатусов.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыПретензийКлиентов.Удовлетворена"));
		СписокСтатусов.Добавить(ПредопределенноеЗначение("Перечисление.СтатусыПретензийКлиентов.НеУдовлетворена"));
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,"Статус",СписокСтатусов,ВидСравненияКомпоновкиДанных.НеВСписке,Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СтатусОтборОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Статус = "Все";
	СтатусОтборПриИзменении(Элемент);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовУправленияФормы

&НаКлиенте
Процедура СписокПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	// СтандартныеПодсистемы.Взаимодействия
	ВзаимодействияКлиент.СписокПредметПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле);
	// Конец СтандартныеПодсистемы.Взаимодействия
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	// СтандартныеПодсистемы.Взаимодействия
	ВзаимодействияКлиент.СписокПредметПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле);
	// Конец СтандартныеПодсистемы.Взаимодействия

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// ИнтеграцияС1СДокументооборотом
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	ИнтеграцияС1СДокументооборотБазоваяФункциональностьКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(Команда, ЭтаФорма, Элементы.Список);
	
КонецПроцедуры
// Конец ИнтеграцияС1СДокументооборотом

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ШтрихкодыИТорговоеОборудование

&НаКлиенте
Процедура ОбработатьШтрихкоды(Данные)
	
	МассивСсылок = СсылкаНаЭлементСпискаПоШтрихкоду(Данные.Штрихкод);
	Если МассивСсылок.Количество() > 0 Тогда
		Элементы.Список.ТекущаяСтрока = МассивСсылок[0];
		ПоказатьЗначение(Неопределено, МассивСсылок[0]);
	Иначе
		ШтрихкодированиеПечатныхФормКлиент.ОбъектНеНайден(Данные.Штрихкод);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция СсылкаНаЭлементСпискаПоШтрихкоду(Штрихкод)
	
	Менеджеры = Новый Массив();
	Менеджеры.Добавить(ПредопределенноеЗначение("Справочник.Претензии.ПустаяСсылка"));
	Возврат ШтрихкодированиеПечатныхФормКлиент.ПолучитьСсылкуПоШтрихкодуТабличногоДокумента(Штрихкод, Менеджеры);
	
КонецФункции

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
