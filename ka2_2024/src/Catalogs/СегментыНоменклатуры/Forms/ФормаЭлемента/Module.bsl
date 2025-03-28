
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	РазделениеВключено = ОбщегоНазначения.РазделениеВключено();

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);

	// подсистема запрета редактирования ключевых реквизитов объектов	
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
	
	СегментыСервер.ПриСозданииНаСервере(ЭтаФорма);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	СегментыСервер.ПередЗаписьюНаСервере(ЭтаФорма,ТекущийОбъект);

	МодификацияКонфигурацииПереопределяемый.ПередЗаписьюНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	 УправлениеДоступностью();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// Обработчик подсистемы запрета редактирования реквизитов объектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);

	МодификацияКонфигурацииПереопределяемый.ПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

	МодификацияКонфигурацииКлиентПереопределяемый.ПослеЗаписи(ЭтаФорма, ПараметрыЗаписи);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	МодификацияКонфигурацииПереопределяемый.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СпособФормированияПриИзменении(Элемент)
	
	Если НЕ Объект.Ссылка.Пустая() И Объект.СпособФормирования <> ПредыдущийСпособФормирования Тогда
		ОбработчикОповещенияЗавершения = Новый ОписаниеОповещения("ИзменениеСпособаФормированияВопросПриЗавершения", ЭтотОбъект);
		ПоказатьВопрос(ОбработчикОповещенияЗавершения,НСтр("ru = 'Способ формирования был изменен. Текущий состав сегмента будет очищен. Продолжить?'"), РежимДиалогаВопрос.ОКОтмена); 
	Иначе
		ПриИзмененииСпособаФормирования();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СпособФормированияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если НЕ Объект.Ссылка.Пустая() Тогда
		
		ПредыдущийСпособФормирования = Объект.СпособФормирования;
		
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ИзменениеСпособаФормированияВопросПриЗавершения(ОтветНаВопрос, ДополнительныеПараметры) Экспорт

	Если ОтветНаВопрос = КодВозвратаДиалога.ОК Тогда
		СегментыВызовСервера.Очистить(Объект.Ссылка);
		ПриИзмененииСпособаФормирования();
	Иначе
		Объект.СпособФормирования = ПредыдущийСпособФормирования;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииСпособаФормирования()

	Если Объект.СпособФормирования <>
		ПредопределенноеЗначение("Перечисление.СпособыФормированияСегментов.ФормироватьВручную") Тогда
		Элементы.ДатаОчистки.ТолькоПросмотр = Истина;
		Объект.ДатаОчистки = '00010101';
	Иначе
		Элементы.ДатаОчистки.ТолькоПросмотр = Ложь;
	КонецЕсли;
	
	УправлениеДоступностью();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сформировать(Команда)

	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru='Сначала необходимо записать сегмент.'"));
		Возврат;
	КонецЕсли;

	Если Объект.СпособФормирования =
			ПредопределенноеЗначение("Перечисление.СпособыФормированияСегментов.ФормироватьДинамически") Тогда
		ПоказатьПредупреждение(Неопределено, НСтр("ru='Формирование доступно только для нединамических сегментов.'"));
		Возврат;
	КонецЕсли;
	
	Если Модифицированность Тогда
		
		Ответ = Неопределено;

		
		ПоказатьВопрос(Новый ОписаниеОповещения("СформироватьЗавершение", ЭтотОбъект), 
		НСтр("ru='Перед формированием необходимо записать сегмент. Записать?'"),
		РежимДиалогаВопрос.ДаНет);
		Возврат;
	КонецЕсли;

	СформироватьФрагмент();
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьФрагмент()
	
	ОбработчикЗавершения = Новый ОписаниеОповещения( "ПриОтветеНаВопросФормированиеСегмента", ЭтотОбъект);
	ПоказатьВопрос(ОбработчикЗавершения,
	               НСтр("ru = 'Состав сегмента будет переформирован в соответствии с настройками схемы компоновки. Продолжить?'"),
	               РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура МаркетинговыеМероприятия(Команда)

	ПараметрыОтбора = Новый Структура("СегментНоменклатуры",Объект.Ссылка);
	
	ОткрытьФорму("Справочник.МаркетинговыеМероприятия.ФормаСписка",
		Новый Структура("Отбор", ПараметрыОтбора),
		ЭтаФорма,
		КлючУникальности,
		Окно);

КонецПроцедуры

&НаКлиенте
Процедура Настройки(Команда)

	ЗаголовокФормыНастройкиСхемыКомпоновкиДанных = НСтр("ru = 'Настройки сегмента ""%ИмяСегмента%""'");
	ЗаголовокФормыНастройкиСхемыКомпоновкиДанных = СтрЗаменить(ЗаголовокФормыНастройкиСхемыКомпоновкиДанных, "%ИмяСегмента%", Объект.Наименование);
	
	Адреса = СегментыВызовСервера.ПолучитьАдресаСхемыКомпоновкиДанныхВоВременномХранилище(
		Объект.Ссылка,
		Объект.ИмяШаблонаСКД,
		АдресСКД, 
		АдресНастроекСКД,
		УникальныйИдентификатор);
	
	Результат = Неопределено;
	
	ПараметрыОткрытияФормы = Новый Структура;
	ПараметрыОткрытияФормы.Вставить("АдресСхемыКомпоновкиДанных", Адреса.СхемаКомпоновкиДанных);
	ПараметрыОткрытияФормы.Вставить("АдресНастроекКомпоновкиДанных", Адреса.НастройкиКомпоновкиДанных);
	ПараметрыОткрытияФормы.Вставить("ИсточникШаблонов", Объект.Ссылка);
	ПараметрыОткрытияФормы.Вставить("Заголовок", ЗаголовокФормыНастройкиСхемыКомпоновкиДанных);
	ПараметрыОткрытияФормы.Вставить("НеПомещатьНастройкиВСхемуКомпоновкиДанных", Истина);
	ПараметрыОткрытияФормы.Вставить("НеНастраиватьУсловноеОформление", Истина);
	ПараметрыОткрытияФормы.Вставить("НеНастраиватьПорядок", Истина);
	ПараметрыОткрытияФормы.Вставить("НеНастраиватьВыбор", Истина);
	ПараметрыОткрытияФормы.Вставить("УникальныйИдентификатор", УникальныйИдентификатор);
	ПараметрыОткрытияФормы.Вставить("ИмяШаблонаСКД", Объект.ИмяШаблонаСКД);
	ПараметрыОткрытияФормы.Вставить("ВозвращатьИмяТекущегоШаблонаСКД", Истина);
	
	ОткрытьФорму("ОбщаяФорма.УпрощеннаяНастройкаСхемыКомпоновкиДанных",
		ПараметрыОткрытияФормы,,,,, 
		Новый ОписаниеОповещения("НастройкиЗавершение", ЭтотОбъект, Новый Структура("Адреса", Адреса)),
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);

КонецПроцедуры

&НаКлиенте
Процедура НастройкиЗавершение(Результат, ДополнительныеПараметры) Экспорт
    
    Адреса = ДополнительныеПараметры.Адреса;
    
    
    Если Результат <> Неопределено Тогда
        
        Объект.ИмяШаблонаСКД = Результат.ИмяТекущегоШаблонаСКД;
        
        Изменения = СегментыВызовСервера.ПрименитьИзмененияКСхемеКомпоновкиДанных(
        Объект.Ссылка,
        Объект.ИмяШаблонаСКД, 
        Адреса.СхемаКомпоновкиДанных,
        Результат.АдресХранилищаНастройкиКомпоновщика,
        УникальныйИдентификатор);
        
        Объект.ИмяШаблонаСКД = Изменения.ИмяШаблонаСКД;
        ПредставлениеШаблонаСКД = Изменения.ПредставлениеШаблонаСКД;
        АдресСКД = Изменения.АдресСКД;
        АдресНастроекСКД = Изменения.АдресНастроекСКД;
        
    КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура НастроитьРасписание(Команда)
	
	ДиалогРасписания = Новый ДиалогРасписанияРегламентногоЗадания(Расписание);
	ДиалогРасписания.Показать(Новый ОписаниеОповещения("НастроитьРасписаниеЗавершение", ЭтотОбъект, Новый Структура("ДиалогРасписания", ДиалогРасписания)));
	
КонецПроцедуры

&НаКлиенте
Процедура НастроитьРасписаниеЗавершение(Расписание1, ДополнительныеПараметры) Экспорт
	
	ДиалогРасписания = ДополнительныеПараметры.ДиалогРасписания;
	
	
	Если Расписание1 <> Неопределено Тогда
		
		Модифицированность = Истина;
		Расписание         = ДиалогРасписания.Расписание;
		Если РазделениеВключено 
			И Расписание.ПериодПовтораВТечениеДня > 0
			И Расписание.ПериодПовтораВТечениеДня < 3600 Тогда
			
			Расписание.ПериодПовтораВТечениеДня = 3600;
			
		КонецЕсли;
		РасписаниеСтрокой  = Строка(Расписание);
		
	КонецЕсли;
	
КонецПроцедуры

// Команда подсистемы "Запрет редактирования реквизитов"
&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	Если НЕ Объект.Ссылка.Пустая() Тогда
		
		Результат = Неопределено;

		
		ОткрытьФорму("Справочник.СегментыНоменклатуры.Форма.РазблокированиеРеквизитов",,,,,, Новый ОписаниеОповещения("Подключаемый_РазрешитьРедактированиеРеквизитовОбъектаЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъектаЗавершение(Результат, ДополнительныеПараметры) Экспорт
    
    Если ТипЗнч(Результат) = Тип("Массив") И Результат.Количество() > 0 Тогда
        
        ЗапретРедактированияРеквизитовОбъектовКлиент.УстановитьДоступностьЭлементовФормы(ЭтаФорма, Результат);
        
    КонецЕсли;

КонецПроцедуры 

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура СформироватьЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Ответ = РезультатВопроса;
	
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		Возврат;
	Иначе
		Записать();
	КонецЕсли;
	
	СформироватьФрагмент();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОтветеНаВопросФормированиеСегмента(КодВозврата, ДополнительныеПараметры) Экспорт
	
	Если КодВозврата = КодВозвратаДиалога.Да Тогда
		
		СегментыВызовСервера.Сформировать(Объект.Ссылка);
		ПоказатьОповещениеПользователя(
		НСтр("ru='Формирование сегмента номенклатуры'"),,
		НСтр("ru='Сегмент сформирован.'"));
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УправлениеДоступностью()
	
	Элементы.СтраницаРасписание.Доступность =
		(Объект.СпособФормирования = ПредопределенноеЗначение("Перечисление.СпособыФормированияСегментов.ПериодическиОбновлять"));
	
КонецПроцедуры

#КонецОбласти
