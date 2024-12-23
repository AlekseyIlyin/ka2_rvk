////////////////////////////////////////////////////////////////////////////////
// Подсистема "Сервис доставки".
// ОбщийМодуль.СервисДоставкиКлиентПереопределяемый.
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработчик события АвтоПодбор поля формы контактной информации для подбора вариантов адреса по введенной строке.
//
// Параметры:
//     Элемент                  - ПолеФормы      - элемент формы, содержащий представление контактной информации.
//     Текст                    - Строка         - строка текста, введенная пользователем в поле контактной информации.
//     ДанныеВыбора             - СписокЗначений Из Строка - содержит список значений, который будет использован при стандартной
//                                                 обработке события.
//     ПараметрыПолученияДанных - Структура
//                              - Неопределено - содержит параметры поиска, которые будут переданы
//                                в метод ПолучитьДанныеВыбора. Подробнее см. описание расширения поля формы для
//                                поля ввода АвтоПодбор в синтакс-помощнике.
//     Ожидание -   Число       - интервал в секундах после ввода текста, через который произошло событие.
//                                Если 0, то это означает, что событие было вызвано не по поводу ввода текста,
//                                а для формирования списка быстрого выбора. 
//     СтандартнаяОбработка     - Булево         - в данный параметр передается признак выполнения стандартной
//                                системной) обработки события. Если в теле процедуры-обработчика
//                                установить данному параметру значение Ложь, стандартная обработка события
//                                производиться не будет.
//
Процедура АвтоПодборАдреса(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка) Экспорт
	
	УправлениеКонтактнойИнформациейКлиент.АвтоПодборАдреса(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка);
	
КонецПроцедуры

// Устанавливает имя формы выбора объекта, если она отличается от формы выбора по умолчанию.
//
// Параметры:
//  ИмяОбъекта - Строка - имя объекта метаданных.
//  ИмяФормыВыбора - Строка - полное имя формы выбора объекта. Например, "Документ.ЗаказПокупателя.ФормаВыбора".
//
Процедура УстановитьИмяФормыВыбораОбъектаПоИмени(ИмяОбъекта, ИмяФормыВыбора) Экспорт
	//
КонецПроцедуры

// Открытие формы нового заказа на доставку, создаваемого на основании переданного объекта
// в параметре "МассивСсылок". Вызывается из подсистемы "ПодключаемыеКоманды".
//
// Параметры:
//  МассивСсылок - Массив из ЛюбаяСсылка - объект или список объектов.
//  ПараметрыВыполнения - см. ПодключаемыеКомандыКлиентСервер.ПараметрыВыполненияКоманды
//
Процедура ЗаказНаДоставкуСоздатьНаОсновании(МассивСсылок, ПараметрыВыполнения) Экспорт
	
	ПараметрыВыполненияКоманды = Новый Структура;
	ПараметрыВыполненияКоманды.Вставить("Источник");
	ПараметрыВыполненияКоманды.Вставить("Уникальность");
	ПараметрыВыполненияКоманды.Вставить("Окно");
	ПараметрыВыполненияКоманды.Вставить("НавигационнаяСсылка");
	ОписаниеКоманды = ПараметрыВыполнения.ОписаниеКоманды; // Структура
	ЗаполнитьЗначенияСвойств(ПараметрыВыполненияКоманды, ОписаниеКоманды.ДополнительныеПараметры); 
	
	ПараметрыОткрытия = Новый Структура();
	ПараметрыОткрытия.Вставить("ПараметрыВыполненияКоманды", ПараметрыВыполненияКоманды);
	
	СписокОснований = Новый СписокЗначений();
	Если ТипЗнч(МассивСсылок) = Тип("Массив")
			И МассивСсылок.Количество() > 0 Тогда
		СписокОснований.ЗагрузитьЗначения(МассивСсылок);
	Иначе
		СписокОснований.Добавить(МассивСсылок);
	КонецЕсли;
	
	ТипГрузоперевозки = 0;
	
	Если ОписаниеКоманды.Идентификатор = "СоздатьНовыйЗаказНаДоставку" Тогда
		ТипГрузоперевозки = 1;
	ИначеЕсли ОписаниеКоманды.Идентификатор = "СоздатьНовыйЗаказНаКурьерскуюДоставку" Тогда
		ТипГрузоперевозки = 2;
	ИначеЕсли ОписаниеКоманды.Идентификатор = "СоздатьНовыйЗаказНаДоставкуКурьерика" Тогда
		ТипГрузоперевозки = 3;
	КонецЕсли;
	
	Если ТипГрузоперевозки <> 0 Тогда
		ПараметрыОткрытия.Вставить("ТипГрузоперевозки", ТипГрузоперевозки);
	КонецЕсли;
	
	ПараметрыОткрытия.Вставить("ДокументыОснования", СписокОснований);
	
	Если Не (ТипГрузоперевозки = 3 И СписокОснований.Количество() > 1) Тогда
		ПроверитьСуществованиеЗаказовНаДоставкуПоОснованию(ПараметрыОткрытия);
		Возврат;
	КонецЕсли;
	
	СервисДоставкиКлиент.ОткрытьФормуКарточкиЗаказаНаДоставку(ПараметрыОткрытия);
	
КонецПроцедуры

// Открытие формы нового заказа на доставку, создаваемого на основании документа.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма документа.
//
Процедура ОткрытьФормуНовогоЗаказаНаДоставку(Форма) Экспорт
	
	// Запись в форме объекта.
	Если Не Форма.Объект.Проведен Или Форма.Модифицированность Тогда
			
		ТекстВопроса = НСтр("ru = 'Для создания заказа на доставку
			|документ будет проведен. Продолжить?'");
		
		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить(КодВозвратаДиалога.ОК, НСтр("ru = 'Провести и продолжить'"));
		Кнопки.Добавить(КодВозвратаДиалога.Отмена);
		
		Обработчик = Новый ОписаниеОповещения("ПродолжитьВыполнениеКомандыОткрытьФормуНовогоЗаказаНаДоставку", ЭтотОбъект, Форма);
		
		ПоказатьВопрос(Обработчик, ТекстВопроса, Кнопки);
		Возврат;
		
	КонецЕсли;
	
	ПроверитьСуществованиеЗаказовНаДоставкуПоОснованию(Форма);
	
КонецПроцедуры

// Обработка выбора заказа на доставку из списка выбора заказов.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма документа.
//  ВыбранныйЗаказ - ДанныеФормыЭлементКоллекции, Неопределено - Строка списка заказов.
//  ИмяПроцедурыОбработки - Строка - Имя процедуры обработки выбора заказа в списке заказов.
//
Процедура ОбработатьРезультатВыбораЗаказаНаДоставку(Форма, ВыбранныйЗаказ, ИмяПроцедурыОбработки) Экспорт
	//
КонецПроцедуры

// Перейти к списку платежных документов.
Процедура ПерейтиКСпискуПлатежныхДокументов() Экспорт
	
	ОткрытьФорму("Документ.ОперацияПоПлатежнойКарте.ФормаСписка");
	
КонецПроцедуры

// Открывает форму настроек, если требуется
//
Процедура ОткрытьФормуНастройкиСозданиеПлатежныхДокументов() Экспорт
	
	ОткрытьФорму("РегистрСведений.НастройкиЗагрузкиНаложенныхПлатежейСервисДоставки.ФормаСписка");
	
КонецПроцедуры

#Область НаложенныеПлатежи

// Заполняет перечень типов документов-оснований, для которых можно оформить оплату доставки наложенным платежом.
//  
// Параметры:
//	КоллекцияТиповДокументов - Массив из ОписаниеТипов
Процедура ТипыОснованийДляНаложенногоПлатежа(КоллекцияТиповДокументов) Экспорт
	
	КоллекцияТиповДокументов.Добавить(Тип("ДокументСсылка.ЗаказКлиента"));
	КоллекцияТиповДокументов.Добавить(Тип("ДокументСсылка.РеализацияТоваровУслуг"));
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Параметры:
//	Ответ - КодВозвратаДиалога
//	Форма - ФормаКлиентскогоПриложения - форма
Процедура ПродолжитьВыполнениеКомандыОткрытьФормуНовогоЗаказаНаДоставку(Ответ, Форма) Экспорт
	
	Если Ответ = КодВозвратаДиалога.ОК Тогда
		
		ОчиститьСообщения();
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Форма", Форма);
		ДействиеПослеЗаписи = Новый ОписаниеОповещения("ПослеПроведенияДокумента", ЭтотОбъект, ДополнительныеПараметры);
		
		ПараметрыЗаписи = Новый Структура;
		ПараметрыЗаписи.Вставить("РежимЗаписи", РежимЗаписиДокумента.Проведение);
		ПараметрыЗаписи.Вставить("ДействиеПослеЗаписи", ДействиеПослеЗаписи);
		
		Форма.Записать(ПараметрыЗаписи);
		
	КонецЕсли;
	
КонецПроцедуры

// После проведения документа.
// 
// Параметры:
//  Результат - Булево - Результат проведения документа
//  ДополнительныеПараметры:
//   * Форма - ФормаКлиентскогоПриложения
Процедура ПослеПроведенияДокумента(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Истина Тогда
		Форма = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(ДополнительныеПараметры, "Форма");
		Если Форма <> Неопределено Тогда
			ПроверитьСуществованиеЗаказовНаДоставкуПоОснованию(Форма);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Параметры:
//	Контекст - ФормаКлиентскогоПриложения - форма
//		* Объект - Структура - коллекция реквизитов заказа на доставку:
//		** Ссылка - ДокументСсылка, Неопределено - ссылка на документ,
//			 - Структура - Контекст открытия формы.
Процедура ЗавершитьВыполнениеКомандыОткрытьФормуНовогоЗаказаНаДоставку(Контекст)
	
	Если ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда

		ПараметрыОткрытия = Новый Структура;

		Если ЗначениеЗаполнено(Контекст.Объект.Ссылка) Тогда
			ПараметрыОткрытия.Вставить("ДокументОснование", Контекст.Объект.Ссылка);
		КонецЕсли;

		ПараметрыОткрытия.Вставить("Форма", Контекст);
		ПараметрыОткрытия.Вставить("Элемент", Контекст.ТекущийЭлемент);

	Иначе

		ПараметрыОткрытия = Контекст;

	КонецЕсли;
	
	СервисДоставкиКлиент.ОткрытьФормуКарточкиЗаказаНаДоставку(ПараметрыОткрытия);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Проверить существование заказов на доставку по переданным параметрам.
// 
// Параметры:
//	Контекст - ФормаКлиентскогоПриложения - форма
//		* Объект - Структура - коллекция реквизитов заказа на доставку:
//		** Ссылка - ДокументСсылка, Неопределено - ссылка на документ,
//			 - Структура - Контекст открытия формы.
Процедура ПроверитьСуществованиеЗаказовНаДоставкуПоОснованию(Контекст)
	
	Если ТипЗнч(Контекст) = Тип("Структура") Тогда
		ДокументОснование = Контекст.ДокументыОснования[0].Значение;
	Иначе
		ДокументОснование = Контекст.Объект.Ссылка;
	КонецЕсли;
	
	КоличествоЗаказов = СервисДоставкиВызовСервера.КоличествоЗаказовПоОснованию(ДокументОснование);
	
	Если КоличествоЗаказов > 0 Тогда
	
		ТекстВопроса = Стршаблон(
			НСтр("ru = 'На основании документа есть введенные заказы на доставку (%1). Продолжить?'"),
			КоличествоЗаказов);
		
		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить(КодВозвратаДиалога.ОК, НСтр("ru = 'Продолжить'"));
		Кнопки.Добавить(КодВозвратаДиалога.Отмена);
		
		Обработчик = Новый ОписаниеОповещения("ПродолжитьПроверитьСуществованиеЗаказовНаДоставкуПоОснованию", ЭтотОбъект, Контекст);
		
		ПоказатьВопрос(Обработчик, ТекстВопроса, Кнопки);
		Возврат;
	
	КонецЕсли;
	
	ЗавершитьВыполнениеКомандыОткрытьФормуНовогоЗаказаНаДоставку(Контекст);
	
КонецПроцедуры

// Параметры:
//	Ответ - КодВозвратаДиалога
//	Контекст - ФормаКлиентскогоПриложения - форма
//		* Объект - Структура - коллекция реквизитов заказа на доставку:
//		** Ссылка - ДокументСсылка, Неопределено - ссылка на документ,
//			 - Структура - Контекст открытия формы.
Процедура ПродолжитьПроверитьСуществованиеЗаказовНаДоставкуПоОснованию(Ответ, Контекст) Экспорт
	
	Если Ответ = КодВозвратаДиалога.ОК Тогда
		ОчиститьСообщения();
		ЗавершитьВыполнениеКомандыОткрытьФормуНовогоЗаказаНаДоставку(Контекст);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


