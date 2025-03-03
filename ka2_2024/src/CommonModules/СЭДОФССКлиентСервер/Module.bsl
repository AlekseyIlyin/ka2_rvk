#Область ПрограммныйИнтерфейс

// Возвращает строку - имя флажка который определяет необходимость открытия формы "ТекущиеДелаПоСЭДО" при запуске.
//   Для переопределения значения флажка необходимо в процедуре ПриДобавленииПараметровРаботыКлиентаПриЗапуске
//   модуля ОбщегоНазначенияПереопределяемый добавить следующий код:
// 		Параметры.Вставить(СЭДОФССКлиентСервер.ИмяФлажкаПоказыватьТекущиеДелаПоСЭДО(), <ЗначениеФлажка>);
//
Функция ИмяФлажкаПоказыватьТекущиеДелаПоСЭДО() Экспорт
	Возврат "ПоказыватьТекущиеДелаПоСЭДО";
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область НПИ

Функция ГодНачалаСведенийОСреднемЗаработкеСФР() Экспорт
	Возврат 2017;
КонецФункции

#КонецОбласти

#Область ОбщегоНазначения

Процедура УстановитьСтраницу(Страницы, ТекущаяСтраница) Экспорт
	Для Каждого Страница Из Страницы.ПодчиненныеЭлементы Цикл
		Страница.Видимость = (Страница = ТекущаяСтраница);
	КонецЦикла;
	Если ТекущаяСтраница <> Неопределено Тогда
		Страницы.ТекущаяСтраница = ТекущаяСтраница;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область Картинки

Функция ИндексКартинкиНеПроведен() Экспорт
	Возврат 1;
КонецФункции

Функция ИндексКартинкиПроведен() Экспорт
	Возврат 2;
КонецФункции

Функция ИндексКартинкиУдален() Экспорт
	Возврат 3;
КонецФункции

Функция ИндексКартинкиОстановлен() Экспорт
	Возврат 4;
КонецФункции

Функция ИндексКартинкиНеПланируетсяОтправлять() Экспорт
	Возврат 5;
КонецФункции

Функция ИндексКартинкиПредупреждение() Экспорт
	Возврат 6;
КонецФункции

Функция ИндексКартинкиОтправлен() Экспорт
	Возврат 7;
КонецФункции

Функция ИндексКартинкиНеПринят() Экспорт
	Возврат 8;
КонецФункции

#КонецОбласти

#Область Организации

Функция ОтборыПоОрганизациямФормы(Форма) Экспорт
	Результат = Новый Структура("ГоловнаяОрганизация, Организации");
	
	ИменаРеквизитов = "ГоловнаяОрганизация, Организации, Организация, Страхователь, Объект, Запись, Список";
	РеквизитыФормы = ОбщегоНазначенияБЗККлиентСервер.ЗначенияСвойств(Форма, ИменаРеквизитов);
	
	ИменаРеквизитов = "ГоловнаяОрганизация, Организация, Страхователь";
	Если РеквизитыФормы.Объект = Неопределено Тогда
		РеквизитыОбъекта = ОбщегоНазначенияБЗККлиентСервер.ЗначенияСвойств(РеквизитыФормы.Запись, ИменаРеквизитов);
	Иначе
		РеквизитыОбъекта = ОбщегоНазначенияБЗККлиентСервер.ЗначенияСвойств(РеквизитыФормы.Объект, ИменаРеквизитов);
	КонецЕсли;
	
	Если ТипЗнч(РеквизитыФормы.Организации) = Тип("СписокЗначений") Тогда
		Результат.Организации = СписокЗаполненныхОрганизаций(РеквизитыФормы.Организации);
	ИначеЕсли РеквизитыФормы.Организация <> Неопределено Тогда
		Результат.Организации = СписокЗаполненныхОрганизаций(РеквизитыФормы.Организация);
	ИначеЕсли РеквизитыОбъекта.Организация <> Неопределено Тогда
		Результат.Организации = СписокЗаполненныхОрганизаций(РеквизитыОбъекта.Организация);
	ИначеЕсли СсылкаОрганизацииЗаполнена(РеквизитыФормы.Страхователь) Тогда
		Результат.Организации = СписокЗаполненныхОрганизаций(РеквизитыФормы.Страхователь);
	ИначеЕсли СсылкаОрганизацииЗаполнена(РеквизитыОбъекта.Страхователь) Тогда
		Результат.Организации = СписокЗаполненныхОрганизаций(РеквизитыОбъекта.Страхователь);
	КонецЕсли;
	
	Если СсылкаОрганизацииЗаполнена(РеквизитыФормы.ГоловнаяОрганизация) Тогда
		Результат.ГоловнаяОрганизация = РеквизитыФормы.ГоловнаяОрганизация;
	ИначеЕсли СсылкаОрганизацииЗаполнена(РеквизитыОбъекта.ГоловнаяОрганизация) Тогда
		Результат.ГоловнаяОрганизация = РеквизитыОбъекта.ГоловнаяОрганизация;
	КонецЕсли;
	
	Если Результат.Организации = Неопределено И Результат.ГоловнаяОрганизация = Неопределено Тогда
		ОтборыСпискаНРег = ОтборыСпискаНРег(РеквизитыФормы.Список);
		
		ЗначениеОтбора = ОтборыСпискаНРег[НРег("Организация")];
		Если ЗначениеОтбора <> Неопределено Тогда
			Результат.Организации = СписокЗаполненныхОрганизаций(ЗначениеОтбора);
		КонецЕсли;
		
		СписокЗначений = СписокЗаполненныхОрганизаций(ОтборыСпискаНРег[НРег("ГоловнаяОрганизация")]);
		Если СписокЗначений.Количество() = 1 Тогда
			Результат.ГоловнаяОрганизация = СписокЗначений[0].Значение;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

Функция СписокЗаполненныхОрганизаций(ЗначениеОтбора) Экспорт
	Результат = Новый СписокЗначений;
	Если ТипЗнч(ЗначениеОтбора) = Тип("Массив") Тогда
		Для Каждого Организация Из ЗначениеОтбора Цикл
			Если СсылкаОрганизацииЗаполнена(Организация) Тогда
				Результат.Добавить(Организация);
			КонецЕсли;
		КонецЦикла;
	ИначеЕсли ТипЗнч(ЗначениеОтбора) = Тип("СписокЗначений") Тогда
		Для Каждого ЭлементСписка Из ЗначениеОтбора Цикл
			Если СсылкаОрганизацииЗаполнена(ЭлементСписка.Значение) Тогда
				Результат.Добавить(ЭлементСписка.Значение);
			КонецЕсли;
		КонецЦикла;
	ИначеЕсли СсылкаОрганизацииЗаполнена(ЗначениеОтбора) Тогда
		Результат.Добавить(ЗначениеОтбора);
	КонецЕсли;
	Возврат Результат;
КонецФункции

Функция СсылкаОрганизацииЗаполнена(Организация) Экспорт
	Возврат ТипЗнч(Организация) = Тип("СправочникСсылка.Организации") И Не Организация.Пустая();
КонецФункции

Функция ОтборыСпискаНРег(Список) Экспорт
	Результат = Новый Соответствие;
	Если ТипЗнч(Список) <> Тип("ДинамическийСписок") Тогда
		Возврат Результат;
	КонецЕсли;
	
	КоллекцииОтборов = Новый Массив;
	КоллекцииОтборов.Добавить(Список.КомпоновщикНастроек.Настройки.Отбор.Элементы);
	БыстрыйПоискПользовательскихНастроек = Новый Соответствие;
	Для каждого НастройкаКД Из Список.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы Цикл
		Если ТипЗнч(НастройкаКД) = Тип("ОтборКомпоновкиДанных") Тогда
			КоллекцииОтборов.Добавить(НастройкаКД.Элементы);
		Иначе
			БыстрыйПоискПользовательскихНастроек.Вставить(НастройкаКД.ИдентификаторПользовательскойНастройки, НастройкаКД);
		КонецЕсли;
	КонецЦикла;
	КоллекцииОтборов.Добавить(Список.КомпоновщикНастроек.ФиксированныеНастройки.Отбор.Элементы);
	
	ВГраница = КоллекцииОтборов.ВГраница();
	Индекс = -1;
	Пока Истина Цикл
		Индекс = Индекс + 1;
		Если Индекс > ВГраница Тогда
			Прервать;
		КонецЕсли;
		КоллекцияОтборов = КоллекцииОтборов[Индекс];
		Если Индекс = ВГраница Тогда // Фиксированные настройки не выводятся в пользовательские.
			БыстрыйПоискПользовательскихНастроек.Очистить();
		КонецЕсли;
		Для Каждого ЭлементОтбораКД Из КоллекцияОтборов Цикл
			НастройкаКД = Неопределено;
			Если ЗначениеЗаполнено(ЭлементОтбораКД.ИдентификаторПользовательскойНастройки)
				И ЭлементОтбораКД.РежимОтображения <> РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный Тогда
				НастройкаКД = БыстрыйПоискПользовательскихНастроек[ЭлементОтбораКД.ИдентификаторПользовательскойНастройки];
			КонецЕсли;
			Если НастройкаКД = Неопределено Тогда
				НастройкаКД = ЭлементОтбораКД;
			КонецЕсли;
			Если Не НастройкаКД.Использование Тогда
				Продолжить;
			КонецЕсли;
			
			Если ТипЗнч(ЭлементОтбораКД) = Тип("ЭлементОтбораКомпоновкиДанных") Тогда
				Если НастройкаКД.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке
					Или НастройкаКД.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСпискеПоИерархии Тогда
					Если ТипЗнч(НастройкаКД.ПравоеЗначение) = Тип("Массив") Тогда
						Массив = НастройкаКД.ПравоеЗначение;
					ИначеЕсли ТипЗнч(НастройкаКД.ПравоеЗначение) = Тип("ФиксированныйМассив") Тогда
						Массив = Новый Массив(НастройкаКД.ПравоеЗначение);
					ИначеЕсли ТипЗнч(НастройкаКД.ПравоеЗначение) = Тип("СписокЗначений") Тогда
						Массив = НастройкаКД.ПравоеЗначение.ВыгрузитьЗначения();
					Иначе
						Результат.Вставить(НРег(ЭлементОтбораКД.ЛевоеЗначение), НастройкаКД.ПравоеЗначение);
						Продолжить;
					КонецЕсли;
					Результат.Вставить(НРег(ЭлементОтбораКД.ЛевоеЗначение), Массив);
				ИначеЕсли НастройкаКД.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно
					Или НастройкаКД.ВидСравнения = ВидСравненияКомпоновкиДанных.Подобно
					Или НастройкаКД.ВидСравнения = ВидСравненияКомпоновкиДанных.Содержит Тогда
					Результат.Вставить(НРег(ЭлементОтбораКД.ЛевоеЗначение), НастройкаКД.ПравоеЗначение);
				КонецЕсли;
			ИначеЕсли ТипЗнч(ЭлементОтбораКД) = Тип("ГруппаЭлементовОтбораКомпоновкиДанных")
				И НастройкаКД.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ Тогда
				КоллекцииОтборов.Вставить(Индекс + 1, ЭлементОтбораКД.Элементы);
				ВГраница = ВГраница + 1;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти

#КонецОбласти

