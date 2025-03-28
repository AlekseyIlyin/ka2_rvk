#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс


// Проверяет, действует ли модель бюджетирования.
//
// Параметры:
// 	МодельБюджетирования - СправочникСсылка.МоделиБюджетирования - Модель бюджетирования для проверки.
//
// Возвращаемое значение:
// 	Булево - Истина, если модель бюджетирования действует.
// 				Ложь, если модель бюджетирования не действует.
//
Функция МодельБюджетированияДействует(МодельБюджетирования) Экспорт
	
	Если НЕ ЗначениеЗаполнено(МодельБюджетирования) Тогда
		Действует = Ложь;
	Иначе
		РеквизитыОбъекта = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(МодельБюджетирования, 
			Новый Структура("ПометкаУдаления, Статус"));
			
		Действует = НЕ РеквизитыОбъекта.ПометкаУдаления
				И РеквизитыОбъекта.Статус = Перечисления.СтатусыМоделейБюджетирования.Действует;
	КонецЕсли;
		
	Возврат Действует;
	
КонецФункции

// Возвращает количество действующих моделей бюджетирования.
//
// Возвращаемое значение:
// 	 Число - Количество действующих моделей.
//
Функция КоличествоДействующихМоделейБюджетирования() Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ
		|	СУММА(1) КАК Количество
		|ИЗ
		|	Справочник.МоделиБюджетирования КАК МоделиБюджетирования
		|ГДЕ
		|	МоделиБюджетирования.Статус = &Статус
		|	И НЕ МоделиБюджетирования.ПометкаУдаления");
	Запрос.УстановитьПараметр("Статус", Перечисления.СтатусыМоделейБюджетирования.Действует);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Возврат ?(Выборка.Следующий(), Выборка.Количество, 0);
	
КонецФункции

// Получает модель бюджетирования по умолчанию для подстановки.
//
// Возвращаемое значение:
// 	СправочникСсылка.МоделиБюджетирования - Модель бюджетирования по умолчанию или найденная по статистике.
// 	Неопределено - Если действующих моделей бюджетирования нет.
//
Функция МодельБюджетированияПоУмолчанию() Экспорт
	
	МодельБюджетированияПоУмолчанию = Неопределено;
	
	СтатусДействует = Перечисления.СтатусыМоделейБюджетирования.Действует;
	
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 2
		|	МоделиБюджетирования.Ссылка КАК МодельБюджетирования
		|ИЗ
		|	Справочник.МоделиБюджетирования КАК МоделиБюджетирования
		|ГДЕ
		|	МоделиБюджетирования.Статус = &Статус
		|	И НЕ МоделиБюджетирования.ПометкаУдаления");
	Запрос.УстановитьПараметр("Статус", СтатусДействует);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Количество() = 1 Тогда
		
		Выборка.Следующий();
		МодельБюджетированияПоУмолчанию = Выборка.МодельБюджетирования;
		
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(МодельБюджетированияПоУмолчанию) И Выборка.Количество() > 1 Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		ОписаниеРеквизитов = Новый Структура;
		ЗаполнениеОбъектовПоСтатистике.ДобавитьОписаниеЗаполняемыхРеквизитов(ОписаниеРеквизитов, "МодельБюджетирования");
		ЗаполняемыеРеквизиты = ЗаполнениеОбъектовПоСтатистике.ПолучитьЗначенияРеквизитов(
			Документы.ЭкземплярБюджета.ПустаяСсылка(), ОписаниеРеквизитов);
		УстановитьПривилегированныйРежим(Ложь);
		
		Если ЗначениеЗаполнено(ЗаполняемыеРеквизиты.МодельБюджетирования)
			И МодельБюджетированияДействует(ЗаполняемыеРеквизиты.МодельБюджетирования) Тогда
			МодельБюджетированияПоУмолчанию = ЗаполняемыеРеквизиты.МодельБюджетирования;
		КонецЕсли;
	КонецЕсли;
	
	Возврат МодельБюджетированияПоУмолчанию;
	
КонецФункции

// Получает модель бюджетирования с использованием утверждения бюджетов
//
// Возвращаемое значение:
// 	СправочникСсылка.МоделиБюджетирования - Модель бюджетирования с использованием утверждения бюджетов.
// 	Неопределено - Если подходящих моделей бюджетирования нет.
//
Функция МодельБюджетирования_ИспользоватьУтверждениеБюджетов() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	МоделиБюджетирования.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.МоделиБюджетирования КАК МоделиБюджетирования
	|ГДЕ
	|	МоделиБюджетирования.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыМоделейБюджетирования.Действует)
	|	И НЕ МоделиБюджетирования.ПометкаУдаления
	|	И МоделиБюджетирования.ИспользоватьУтверждениеБюджетов";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Возвращает имена блокируемых реквизитов для механизма блокирования реквизитов БСП.
// 
// Возвращаемое значение:
// 	Массив - имена блокируемых реквизитов:
//		* БлокируемыйРеквизит - Строка - Имя блокируемого реквизита.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("Периодичность");
	Результат.Добавить("НачалоДействия");
	Результат.Добавить("КонецДействия");
	Результат.Добавить("БюджетыПоОрганизациям");
	Результат.Добавить("БюджетыПоПодразделениям");
	Результат.Добавить("ИспользоватьУтверждениеБюджетов");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	Дата = '00010101';
	НачалоПериода = '00010101';
	ОкончаниеПериода = '00010101';
	
	ПереопределенныеДанныеВыбора = Неопределено;
	Если Параметры.Свойство("Дата", Дата) Тогда
		
		ПереопределенныеДанныеВыбора = БюджетнаяОтчетностьВызовСервера.МоделиБюджетированияСОтборомПоДате(Дата);
		
	ИначеЕсли Параметры.Свойство("НачалоПериода", НачалоПериода)
			И Параметры.Свойство("ОкончаниеПериода", ОкончаниеПериода) Тогда
		
		ПереопределенныеДанныеВыбора = БюджетнаяОтчетностьВызовСервера.МоделиБюджетированияСОтборомПоПериоду(НачалоПериода, ОкончаниеПериода);
		
	КонецЕсли;
	
	Если ПереопределенныеДанныеВыбора <> Неопределено Тогда
		
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = ПереопределенныеДанныеВыбора;
		
	Иначе
		
		Параметры.Отбор.Вставить("ПометкаУдаления", Ложь);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции


#КонецОбласти

#КонецЕсли