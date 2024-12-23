// @strict-types

#Область ОписаниеПеременных

&НаКлиенте
Перем ОбновитьИнтерфейс;	//Булево - Истина - Произвести отложенное обновление интерфейса

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ОбновитьЗначениеРеквизитов("Константа_ИспользоватьИнтеграциюСЭТПБидзаарДляПокупателей");
	ОбновитьЗначениеРеквизитов("Константа_ИспользоватьИнтеграциюСЭТПБидзаарДляПоставщиков");
	ОбновитьЗначениеРеквизитов("Константа_ИспользоватьЗапросыКоммерческихПредложенийПоставщиков");
	ОбновитьЗначениеРеквизитов("Константа_ИспользоватьКоммерческиеПредложенияПоставщиков");

	Если Не Константа_ИспользоватьЗапросыКоммерческихПредложенийПоставщиков
		Или Не Константа_ИспользоватьКоммерческиеПредложенияПоставщиков Тогда
		ПодсистемаОбъектыУТКАУПСуществует = ОбщегоНазначения.ПодсистемаСуществует("СлужебныеПодсистемы.ОбъектыУТКАУП");
		ЧастиЗаголовка = Новый Массив; // Массив из строка
		ЧастиЗаголовка.Добавить(НСтр("ru = 'Невозможно включение интеграции для покупателей по следующим причинам:'"));
		Если Не Константа_ИспользоватьЗапросыКоммерческихПредложенийПоставщиков Тогда
			ЧастиЗаголовка.Добавить(Символы.ПС);
			ЧастиЗаголовка.Добавить(НСтр("ru = '- запросы коммерческих предложений не ведутся'"));
			Если ПодсистемаОбъектыУТКАУПСуществует Тогда
				ЧастиЗаголовка.Добавить(" (");
				ЧастиЗаголовка.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Перейти'"), ,
					ЦветаСтиля.ЦветТекстаАвтоматическиИзСервисаБЭД, ,
					"e1cib/app/Обработка.ПанельАдминистрированияУТ.Форма.Закупки"));
				ЧастиЗаголовка.Добавить(")");
			КонецЕсли;
		КонецЕсли;
		Если Не Константа_ИспользоватьКоммерческиеПредложенияПоставщиков Тогда
			ЧастиЗаголовка.Добавить(Символы.ПС);
			ЧастиЗаголовка.Добавить(НСтр("ru = '- коммерческие предложения не ведутся'"));
			Если ПодсистемаОбъектыУТКАУПСуществует Тогда
				ЧастиЗаголовка.Добавить(" (");
				ЧастиЗаголовка.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Перейти'"), ,
					ЦветаСтиля.ЦветТекстаАвтоматическиИзСервисаБЭД, ,
					"e1cib/app/Обработка.ПанельАдминистрированияУТ.Форма.Закупки"));
				ЧастиЗаголовка.Добавить(")");
			КонецЕсли;
		КонецЕсли;
		Элементы.КомментарийПокупатели.Заголовок = Новый ФорматированнаяСтрока(ЧастиЗаголовка);
	Иначе
		Элементы.ГруппаКомментарийПокупатели.Видимость = Ложь;
	КонецЕсли;

	ИнтеграцияСЭлектроннымиТорговымиПлощадкамиПереопределяемый.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);

	УправлениеВидимостьюДоступностью(ЭтотОбъект);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьИнтеграциюСЭТПБидзаарДляПоставщиковПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент, Истина);
	
	УправлениеВидимостьюДоступностью(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьИнтеграциюСЭТПБидзаарДляПокупателейПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент, Истина);
	
	УправлениеВидимостьюДоступностью(ЭтотОбъект);
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НастройкиПодключенийБидзаарДляПокупателей(Команда)

	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РазделУчета", ИнтеграцияСЭлектроннымиТорговымиПлощадкамиКлиентСервер.РазделУчетаПокупатели());

	ОткрытьФорму("Обработка.УправлениеВыгрузкамиВБидзаар.Форма.СписокПодключенийКСервису", ПараметрыФормы, ЭтотОбъект,
		Истина);

КонецПроцедуры

&НаКлиенте
Процедура НастройкиПодключенийБидзаарДляПоставщиков(Команда)
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РазделУчета", ИнтеграцияСЭлектроннымиТорговымиПлощадкамиКлиентСервер.РазделУчетаПоставщики());

	ОткрытьФорму("Обработка.УправлениеВыгрузкамиВБидзаар.Форма.СписокПодключенийКСервису", ПараметрыФормы, ЭтотОбъект,
		Истина);
КонецПроцедуры

&НаКлиенте
Процедура НастройкаВыгрузки(Команда)
	ОткрытьФорму("Обработка.УправлениеВыгрузкамиВБидзаар.Форма.ВыгрузкаДанных");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Клиент

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Ложь)
	
	ИмяРеквизита = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	
	Если ОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	ОбновитьИнтерфейс = Ложь;
	ОбщегоНазначенияКлиент.ОбновитьИнтерфейсПрограммы();
	
КонецПроцедуры

#КонецОбласти

#Область ВызовСервера

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	
	ИмяРеквизита = СохранитьЗначениеРеквизита(РеквизитПутьКДанным,  Новый Структура);
	
	ОбновитьЗначениеРеквизитов(РеквизитПутьКДанным);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Возврат ИмяРеквизита;
	
КонецФункции

#КонецОбласти

#Область Сервер

// Сохранить значение реквизита.
// 
// Параметры:
//  РеквизитПутьКДанным - Строка - Реквизит путь к данным
//  Результат - Структура - Результат
// 
// Возвращаемое значение:
//  Строка - Сохранить значение реквизита
&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным, Результат)

	УстановитьПривилегированныйРежим(Истина);

	Если РеквизитПутьКДанным = "" Тогда
		Возврат "";
	КонецЕсли;
	
	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 10)) = НРег("Константа_") Тогда
		КонстантаИмя = Сред(РеквизитПутьКДанным, 11);
	КонецЕсли;
	
	// Сохранения значения константы.
	Если КонстантаИмя <> "" Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];

		Если НРег(Лев(РеквизитПутьКДанным, 10)) = НРег("Константа_") Тогда
			КонстантаЗначение = ЭтотОбъект[РеквизитПутьКДанным];	//Булево
		КонецЕсли;

		Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
			КонстантаМенеджер.Установить(КонстантаЗначение);
		КонецЕсли;

	КонецЕсли;

	УстановитьПривилегированныйРежим(Ложь);

	Возврат КонстантаИмя;

КонецФункции

&НаСервере
Процедура ОбновитьЗначениеРеквизитов(РеквизитПутьКДанным = "")
	
	УстановитьПривилегированныйРежим(Истина);
	
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 10)) = НРег("Константа_") Тогда
		КонстантаИмя = Сред(РеквизитПутьКДанным, 11);
	КонецЕсли;
	
	Если КонстантаИмя <> "" Тогда
		ЭтотОбъект[РеквизитПутьКДанным] = Константы[КонстантаИмя].Получить();
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

#КонецОбласти

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеВидимостьюДоступностью(Форма)
	
	Форма.Элементы.НастройкиПодключенийБидзаарДляПоставщиков.Доступность = Форма.Константа_ИспользоватьИнтеграциюСЭТПБидзаарДляПоставщиков;
	Форма.Элементы.НастройкаВыгрузки.Доступность = Форма.Константа_ИспользоватьИнтеграциюСЭТПБидзаарДляПоставщиков;
	
	Форма.Элементы.НастройкиПодключенийБидзаарДляПокупателей.Доступность = Форма.Константа_ИспользоватьИнтеграциюСЭТПБидзаарДляПокупателей;
	
	ЕстьДоступКП = Форма.Константа_ИспользоватьЗапросыКоммерческихПредложенийПоставщиков 
		И Форма.Константа_ИспользоватьКоммерческиеПредложенияПоставщиков;
	
	Форма.Элементы.ГруппаКомментарийПокупатели.Видимость = Не ЕстьДоступКП;

	Форма.Элементы.ИспользоватьИнтеграциюСЭТПБидзаарДляПокупателей.Доступность = ЕстьДоступКП
		Или Форма.Константа_ИспользоватьИнтеграциюСЭТПБидзаарДляПокупателей;
	
КонецПроцедуры

#КонецОбласти
