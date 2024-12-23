
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УчетнаяЗапись = Параметры.УчетнаяЗапись;
	
	ИспользоватьПричиныОтменыЗаказовКлиентов = ПолучитьФункциональнуюОпцию("ИспользоватьПричиныОтменыЗаказовКлиентов");
	
	Элементы.ПричинаОтмены.Видимость        = ИспользоватьПричиныОтменыЗаказовКлиентов;
	Элементы.ПричинаОтменыСтрокой.Видимость = Не ИспользоватьПричиныОтменыЗаказовКлиентов;
	
	Если Не ИспользоватьПричиныОтменыЗаказовКлиентов Тогда
		ЗаполнитьПричиныОтменыСтрокойНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПодключитьОбработчикОжидания("ЗаполнитьПричиныОтменыНаКлиенте", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КодПричиныПриИзменении(Элемент)
	
	КодПричиныПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	Если Не ЗначениеЗаполнено(КодПричины) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(
			НСтр("ru = 'Не указана причина отмены'"),
			, 
			"КодПричины",
			, 
			Истина);
			
	ИначеЕсли Не ЗначениеЗаполнено(ПричинаОтмены) И ИспользоватьПричиныОтменыЗаказовКлиентов Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(
			НСтр("ru = 'Не указана причина отмены'"),
			, 
			"ПричинаОтмены",
			, 
			Истина);
			
	ИначеЕсли Не ЗначениеЗаполнено(ПричинаОтменыСтрокой) И Не ИспользоватьПричиныОтменыЗаказовКлиентов Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(
			НСтр("ru = 'Не указана причина отмены'"),
			, 
			"ПричинаОтменыСтрокой",
			, 
			Истина);
		
	Иначе
		Результат = ВыбратьНаСервере();
		Закрыть(Результат);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗаполнитьПричиныОтменыНаКлиенте()
	
	ДлительнаяОперация    = ЗаполнитьПричиныОтменыНаСервере();
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ЗаполнитьПричиныОтменыФрагмент", ЭтотОбъект);
	
	Если ДлительнаяОперация.Статус = "Выполнено" Тогда
		ВыполнитьОбработкуОповещения(ОповещениеОЗавершении, ДлительнаяОперация);
		
	Иначе
		ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
		ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
		
		ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЗаполнитьПричиныОтменыНаСервере()
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияФункции(УникальныйИдентификатор);
	ПараметрыВыполнения.ОжидатьЗавершение            = 0;
	ПараметрыВыполнения.НаименованиеФоновогоЗадания  = НСтр("ru = 'Заполнение списка причин отмены для торговой площадки.'");
	ПараметрыВыполнения.ЗапуститьВФоне               = Истина;
	ПараметрыВыполнения.ПрерватьВыполнениеЕслиОшибка = Истина;

	ИмяМетода = "ИнтеграцияСМаркетплейсамиСервер.ПолучитьПричиныОтмены";

	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения, 
		ИмяМетода, 
		УчетнаяЗапись,
		Неопределено);
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьПричиныОтменыФрагмент(Результат, ДополнительныеПараметры) Экспорт

	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		Если Результат.Статус = "Ошибка" Тогда
			ОбщегоНазначенияКлиент.СообщитьПользователю(Результат.ПодробноеПредставлениеОшибки);
		
		ИначеЕсли Результат.Статус = "Выполнено" 
		 			И Результат.Свойство("АдресРезультата") Тогда
			Ошибка = ЗаполнитьПричиныОтменыЗавершениеНаСервере(Результат.АдресРезультата);
			ИнтеграцияСМаркетплейсомOzonКлиент.ВывестиСостояние(Ошибка, ДополнительныеПараметры, Истина);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЗаполнитьПричиныОтменыЗавершениеНаСервере(Знач АдресРезультата)
	
	Элементы.КодПричины.СписокВыбора.Очистить();
	Элементы.КодПричины.ПодсказкаВвода = НСтр("ru = 'Заполнение списка ...'");
	
	Результат = ПолучитьИзВременногоХранилища(АдресРезультата);
	УдалитьИзВременногоХранилища(АдресРезультата);
		
	Если ПустаяСтрока(Результат.КодОшибки) Тогда
		Для Каждого ЭлементКоллекции Из Результат.Детализация Цикл
			Элементы.КодПричины.СписокВыбора.Добавить(ЭлементКоллекции.Идентификатор, ЭлементКоллекции.Наименование);
		КонецЦикла;
		
	Иначе
		Элементы.КодПричины.СписокВыбора.Добавить("352", НСтр("ru = 'Товар закончился на складе продавца'"));
		Элементы.КодПричины.СписокВыбора.Добавить("400", НСтр("ru = 'Остался только бракованный товар'"));
		Элементы.КодПричины.СписокВыбора.Добавить("402", НСтр("ru = 'Другое (вина продавца)'"));
	КонецЕсли;
	
	Элементы.КодПричины.ПодсказкаВвода = "";
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура КодПричиныПриИзмененииНаСервере()
	
	ПричинаОтмены = РегистрыСведений.СоответствияОбъектовМаркетплейсов.ПолучитьОбъектСоответствия(
		УчетнаяЗапись, 
		ПредопределенноеЗначение("Перечисление.ВидыОбъектовМаркетплейсов.ПричинаОтмены"), 
		КодПричины,
		Тип("СправочникСсылка.ПричиныОтменыЗаказовКлиентов"));
		
	Если Не ИспользоватьПричиныОтменыЗаказовКлиентов Тогда
		ПричинаОтменыСтрокой = Строка(ПричинаОтмены);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПричиныОтменыСтрокойНаСервере()
	
	Элементы.ПричинаОтменыСтрокой.СписокВыбора.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПричиныОтменыЗаказовКлиентов.Ссылка КАК Ссылка,
		|	ПричиныОтменыЗаказовКлиентов.Наименование КАК Наименование
		|ИЗ
		|	Справочник.ПричиныОтменыЗаказовКлиентов КАК ПричиныОтменыЗаказовКлиентов";
	
	Запрос.УстановитьПараметр("УчетнаяЗапись",          УчетнаяЗапись);
	Запрос.УстановитьПараметр("ВидОбъектаМаркетплейса", Перечисления.ВидыОбъектовМаркетплейсов.ПричинаОтмены);
	
	УстановитьПривилегированныйРежим(Истина);
	ВыборкаДанных = Запрос.Выполнить().Выбрать();
	УстановитьПривилегированныйРежим(Ложь);
	
	Пока ВыборкаДанных.Следующий() Цикл
		Элементы.ПричинаОтменыСтрокой.СписокВыбора.Добавить(ВыборкаДанных.Ссылка, ВыборкаДанных.Наименование);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ВыбратьНаСервере()
	
	Если Не ИспользоватьПричиныОтменыЗаказовКлиентов Тогда
		ПричинаОтмены = Справочники.ПричиныОтменыЗаказовКлиентов.НайтиПоНаименованию(ПричинаОтменыСтрокой, Истина);
		
		Если Не ЗначениеЗаполнено(ПричинаОтмены) Тогда
			НачатьТранзакцию();
			
			Попытка
				ПричинаОтменыОбъект = Справочники.ПричиныОтменыЗаказовКлиентов.СоздатьЭлемент();
				ПричинаОтменыОбъект.Наименование = ПричинаОтменыСтрокой;
				ПричинаОтменыОбъект.Записать();
				
				ПричинаОтмены = ПричинаОтменыОбъект.Ссылка;
				
				ЗафиксироватьТранзакцию();
				
			Исключение
				ОтменитьТранзакцию();
				
				ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'При записи причины отмены ""%1"" возникла ошибка: %2'", 
						ОбщегоНазначения.КодОсновногоЯзыка()),
					ПричинаОтменыСтрокой, 
					ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
					
				ЗаписьЖурналаРегистрации(ИнтеграцияСМаркетплейсамиСервер.СобытиеЖурналаРегистрации(),
					УровеньЖурналаРегистрации.Ошибка,,,
					ТекстОшибки);
			КонецПопытки;
		КонецЕсли;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПричинаОтмены) Тогда
		РегистрыСведений.СоответствияОбъектовМаркетплейсов.ЗаписатьОбъектСоответствия(
			УчетнаяЗапись, 
			ПредопределенноеЗначение("Перечисление.ВидыОбъектовМаркетплейсов.ПричинаОтмены"), 
			КодПричины, 
			ПричинаОтмены, 
			Новый Структура("НаименованиеОбъектаМаркетплейса", 
				Элементы.КодПричины.СписокВыбора.НайтиПоЗначению(КодПричины).Представление));
	Иначе
		НастройкиУчетнойЗаписи = Справочники.УчетныеЗаписиМаркетплейсов.НастройкиУчетнойЗаписи(УчетнаяЗапись);
		ПричинаОтмены          = НастройкиУчетнойЗаписи.ПричинаОтменыПоУмолчанию;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("Идентификатор", Число(КодПричины));
	Результат.Вставить("Наименование",  Строка(ПричинаОтмены));
	Результат.Вставить("Ссылка",        ПричинаОтмены);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
