#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

//++ Локализация

// Функция получает список договоров и настроек подключений к СБП для рабочего места клиента.
//
// Параметры:
//  Организация - СправочникСсылка.Организации - Организация в договоре с платеж. системой
//  КассаККМ - СправочникСсылка.КассыККМ - Касса ККМ для определения настройки подключения
//  Склад - СправочникСсылка.Склады - Склад (магазин) для определения настройки подключения
//
// Возвращаемое значение:
//	ТаблицаЗначений - Таблица с колонками:
//		* Договор					- СправочникСсылка.ДоговорыЭквайринга - Договор подключения к платежной системе.
//		* НастройкаПодключения		- СправочникСсылка.НастройкиПодключенияКСистемеБыстрыхПлатежей - Настройка интеграции.- Формат даты выработки
//
Функция СписокДоговоровИПодключенийСБП(Организация, КассаККМ = Неопределено, Склад = Неопределено) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	КассыККМ = Новый Массив;
	Склады = Новый Массив;
	СкладыКассККМ = Новый Массив;
	
	Если ЗначениеЗаполнено(КассаККМ) Тогда
		КассыККМ.Добавить(КассаККМ);
		СкладыКассККМ = РозничныеПродажи.СкладыКассККМВИерархии(КассыККМ);
	ИначеЕсли ЗначениеЗаполнено(Склад) Тогда
		Склады.Добавить(Склад);
		СкладыКассККМ = РозничныеПродажи.СкладыКассСРодителямиВИерархии(Склады);
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Интеграция КАК НастройкаПодключения,
	|	НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Договор КАК Договор
	|ПОМЕСТИТЬ НастройкиИнтеграцииПоОрганизацииНаМагазины
	|ИЗ
	|	РегистрСведений.НастройкиИнтеграцииСПлатежнымиСистемамиУТ КАК НастройкиИнтеграцииСПлатежнымиСистемамиУТ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ДоговорыЭквайринга КАК ДоговорыЭквайринга
	|		ПО НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Договор = ДоговорыЭквайринга.Ссылка
	|		И (ДоговорыЭквайринга.Организация = &Организация)
	|ГДЕ
	|	НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Магазин В (&СкладыКассККМ)
	|	И НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Интеграция.Используется = ИСТИНА
	|	И НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Договор.ПометкаУдаления = ЛОЖЬ
	|	;
	|	
	|	////////////////////////////////////////////////////////////////////////////////
	|	ВЫБРАТЬ
	|		НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Интеграция КАК НастройкаПодключения,
	|		НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Договор КАК Договор
	|	ПОМЕСТИТЬ НастройкиИнтеграцииПоОрганизацииОбщие
	|	ИЗ
	|		РегистрСведений.НастройкиИнтеграцииСПлатежнымиСистемамиУТ КАК НастройкиИнтеграцииСПлатежнымиСистемамиУТ
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ДоговорыЭквайринга КАК ДоговорыЭквайринга
	|			ПО НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Договор = ДоговорыЭквайринга.Ссылка
	|			И (ДоговорыЭквайринга.Организация = &Организация)
	|	ГДЕ
	|		НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Магазин = &СкладПустой
	|		И НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Интеграция.Используется = ИСТИНА
	|		И НастройкиИнтеграцииСПлатежнымиСистемамиУТ.Договор.ПометкаУдаления = ЛОЖЬ
	|	;
	|	
	|	////////////////////////////////////////////////////////////////////////////////
	|	ВЫБРАТЬ
	|		НастройкиРМКПлатежныеСистемы.ДоговорПодключенияКПлатежнойСистеме КАК ДоговорПодключения,
	|		НастройкиРМКПлатежныеСистемы.Ссылка.ВидСсылкиСБП КАК ВидСсылкиСБП,
	|		НастройкиРМКПлатежныеСистемы.КассоваяСсылка КАК КассоваяСсылка,
	|		НастройкиРМКПлатежныеСистемы.ИдентификаторОплаты КАК ИдентификаторОплаты,
	|		НастройкиИнтеграцииПоОрганизацииНаМагазины.НастройкаПодключения КАК НастройкаПодключения
	|	ИЗ
	|		Справочник.НастройкиРМК.ПлатежныеСистемы КАК НастройкиРМКПлатежныеСистемы
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ НастройкиИнтеграцииПоОрганизацииНаМагазины КАК НастройкиИнтеграцииПоОрганизацииНаМагазины
	|			ПО НастройкиРМКПлатежныеСистемы.ДоговорПодключенияКПлатежнойСистеме = НастройкиИнтеграцииПоОрганизацииНаМагазины.Договор
	|	ГДЕ
	|		НастройкиРМКПлатежныеСистемы.Ссылка.РабочееМесто = &РабочееМесто
	|	;
	|	
	|	////////////////////////////////////////////////////////////////////////////////
	|	ВЫБРАТЬ
	|		НастройкиРМКПлатежныеСистемы.ДоговорПодключенияКПлатежнойСистеме КАК ДоговорПодключения,
	|		НастройкиРМКПлатежныеСистемы.Ссылка.ВидСсылкиСБП КАК ВидСсылкиСБП,
	|		НастройкиРМКПлатежныеСистемы.КассоваяСсылка КАК КассоваяСсылка,
	|		НастройкиРМКПлатежныеСистемы.ИдентификаторОплаты КАК ИдентификаторОплаты,
	|		НастройкиИнтеграцииПоОрганизацииОбщие.НастройкаПодключения КАК НастройкаПодключения
	|	ИЗ
	|		Справочник.НастройкиРМК.ПлатежныеСистемы КАК НастройкиРМКПлатежныеСистемы
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ НастройкиИнтеграцииПоОрганизацииОбщие КАК НастройкиИнтеграцииПоОрганизацииОбщие
	|			ПО НастройкиРМКПлатежныеСистемы.ДоговорПодключенияКПлатежнойСистеме = НастройкиИнтеграцииПоОрганизацииОбщие.Договор
	|	ГДЕ
	|		НастройкиРМКПлатежныеСистемы.Ссылка.РабочееМесто = &РабочееМесто";

	РабочееМестоКлиента = МенеджерОборудованияВызовСервера.РабочееМестоКлиента();
	Запрос.УстановитьПараметр("РабочееМесто", РабочееМестоКлиента);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("СкладыКассККМ", СкладыКассККМ);
	Запрос.УстановитьПараметр("СкладПустой", Справочники.Склады.ПустаяСсылка());
	Запрос.УстановитьПараметр("ТипКассыФискальныйРегистратор", Перечисления.ТипыКассККМ.ФискальныйРегистратор);
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	НастройкиИнтеграцииПоОрганизацииНаМагазины = МассивРезультатов[2].Выгрузить();
	НастройкиИнтеграцииПоОрганизацииОбщие = МассивРезультатов[3].Выгрузить();
	
	Если НастройкиИнтеграцииПоОрганизацииНаМагазины.Количество() > 0 Тогда
		Возврат НастройкиИнтеграцииПоОрганизацииНаМагазины;
	Иначе
		Возврат НастройкиИнтеграцииПоОрганизацииОбщие;
	КонецЕсли;
	
КонецФункции

//-- Локализация

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Печать

// Заполняет список команд печати.
//
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	ОписанияКоманд = Новый Структура;

	//++ Локализация

	ОписанияКоманд = ОписаниеКомандПечатиКассовойСсылки();

	//-- Локализация

	СписокСортировки = Новый СписокЗначений;
	Для каждого Элем Из ОписанияКоманд Цикл
		СписокСортировки.Добавить(Элем.Ключ, Элем.Значение.Представление);
	КонецЦикла;
	СписокСортировки.СортироватьПоПредставлению();

	Для каждого ЭлемСписка Из СписокСортировки Цикл
		ОписаниеКоманды = ОписанияКоманд[ЭлемСписка.Значение];
		КомандаПечати = КомандыПечати.Добавить();
		КомандаПечати.Идентификатор = ЭлемСписка.Значение;
		КомандаПечати.Представление = ОписаниеКоманды.Представление;
		КомандаПечати.Обработчик = ОписаниеКоманды.Обработчик;
	
	КонецЦикла;
	
КонецПроцедуры

//++ Локализация

// Возвращаемое значение:
//   Структура:
//		*Ключ - идентификатор команды
//		*Значение - Структура:
//			**Представление - Строка
//			**Обработчик - Строка
//			**ФорматПечати - Число - значения см. ПереводыСБПc2b.КарточкаКассовойСсылки
//
Функция ОписаниеКомандПечатиКассовойСсылки() Экспорт
	
	ЕдиныйОбработчик = "Форма.ПечатьКассовойСсылкиПоШаблону";
	
	ШаблонЗначения = Новый Структура("Представление, Обработчик, ФорматПечати", 
										"", ЕдиныйОбработчик, 0);
	
	Результат = Новый Структура;
	
	Ключ = "КассоваяСсылкаА5Широкий";
	ВсеЗначения = ОбщегоНазначения.СкопироватьРекурсивно(ШаблонЗначения);
	ВсеЗначения.Представление = НСтр("ru = 'Кассовый QR-код (А5 широкий)'");
	ВсеЗначения.ФорматПечати = 1;
	Результат.Вставить(Ключ, ВсеЗначения);
	
	Ключ = "КассоваяСсылкаА5ТолькоЛого";
	ВсеЗначения = ОбщегоНазначения.СкопироватьРекурсивно(ШаблонЗначения);
	ВсеЗначения.Представление = НСтр("ru = 'Кассовый QR-код (А5 только логотипы)'");
	ВсеЗначения.ФорматПечати = 2;
	Результат.Вставить(Ключ, ВсеЗначения);
	
	Ключ = "КассоваяСсылкаА5Узкий";
	ВсеЗначения = ОбщегоНазначения.СкопироватьРекурсивно(ШаблонЗначения);
	ВсеЗначения.Представление = НСтр("ru = 'Кассовый QR-код (А5 узкий)'");
	ВсеЗначения.ФорматПечати = 3;
	Результат.Вставить(Ключ, ВсеЗначения);
	
	Ключ = "КассоваяСсылкаА5УзкийГоризонтальный";
	ВсеЗначения = ОбщегоНазначения.СкопироватьРекурсивно(ШаблонЗначения);
	ВсеЗначения.Представление = НСтр("ru = 'Кассовый QR-код (А5 узкий горизонтальный)'");
	ВсеЗначения.ФорматПечати = 4;
	Результат.Вставить(Ключ, ВсеЗначения);
	
	Ключ = "КассоваяСсылкаА6Квадратный";
	ВсеЗначения = ОбщегоНазначения.СкопироватьРекурсивно(ШаблонЗначения);
	ВсеЗначения.Представление = НСтр("ru = 'Кассовый QR-код (А6 квадратный)'");
	ВсеЗначения.ФорматПечати = 5;
	Результат.Вставить(Ключ, ВсеЗначения);
	
	Ключ = "КассоваяСсылкаА6Круглый";
	ВсеЗначения = ОбщегоНазначения.СкопироватьРекурсивно(ШаблонЗначения);
	ВсеЗначения.Представление = НСтр("ru = 'Кассовый QR-код (А6 круглый)'");
	ВсеЗначения.ФорматПечати = 6;
	Результат.Вставить(Ключ, ВсеЗначения);
	
	Возврат Результат;
	
КонецФункции

//-- Локализация

#КонецОбласти

#КонецОбласти

#КонецЕсли