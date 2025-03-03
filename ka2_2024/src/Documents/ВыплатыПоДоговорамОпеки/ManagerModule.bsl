#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(ФизическоеЛицо)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаОбъекта.
Функция ОписаниеСоставаОбъекта() Экспорт
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъектаФизическоеЛицоВШапке();
КонецФункции

#Область ОбработчикиРегистрацииФизическихЛиц

Функция ПринадлежностиОбъекта() Экспорт
	Возврат ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве("Организация");
КонецФункции

#КонецОбласти

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляОтбораПоОрганизации(Настройки);
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляОбъектаСПрисоединеннымиФайлами(Настройки);
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляРегистрацииДвижений(Настройки);
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляСовместноРегистрируемыхОбъектов(Настройки);
КонецПроцедуры

#КонецОбласти

#Область ОбменДанными

// Регистрирует изменение организации или структурного подразделения для сотрудников и физических лиц
//
// Параметры:
//		МассивДокументов - Массив - Массив объектов заполненный при загрузке сообщения обмена
//
Процедура ЗарегистрироватьЗависимыеОбъектыПослеЗагрузкиОбменаДанными(МассивДокументов) Экспорт
	
	// Зарегистрируем сотрудников по виду документа, изменяющего принадлежность к организации
	Для Каждого ДокументОбъект Из МассивДокументов Цикл
		Если ЗначениеЗаполнено(ДокументОбъект.Сотрудник) И ОбщегоНазначения.СсылкаСуществует(ДокументОбъект.Сотрудник) Тогда
			ПланыОбмена.ЗарегистрироватьИзменения(ДокументОбъект.ОбменДанными.Получатели, ДокументОбъект.Сотрудник);
		КонецЕсли;
		
		СинхронизацияДанныхЗарплатаКадры.ПринадлежностьФизлицаОрганизацииПриЗаписи(ДокументОбъект);
		СинхронизацияДанныхЗарплатаКадры.ОрганизацииСотрудниковПриЗаписи(ДокументОбъект);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// Обновление данных о времени в договорах ГПХ.
//
// Параметры:
//   ПараметрыОбновления - Структура - Параметры отложенного обновления.
//
Процедура ОбновитьДанныеОВремениДляСреднегоФСС(ПараметрыОбновления = Неопределено) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Шапка.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.ВыплатыПоДоговорамОпеки КАК Шапка
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ДанныеОВремениДляРасчетаСреднегоФСС КАК Регистр
	|		ПО Шапка.Ссылка = Регистр.Регистратор
	|ГДЕ
	|	Шапка.ДатаОкончания >= &ДатаОбъединенияВзносов
	|	И Не Шапка.ПолучаетСтраховуюПенсию
	|	И Шапка.Проведен
	|	И Регистр.Регистратор ЕСТЬ NULL
	|	И Шапка.Организация <> ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)
	|	И Шапка.ФизическоеЛицо <> ЗНАЧЕНИЕ(Справочник.ФизическиеЛица.ПустаяСсылка)
	|	И Шапка.ДатаНачала > ДАТАВРЕМЯ(1, 1, 1)
	|	И Шапка.ДатаНачала <= Шапка.ДатаОкончания";
	Запрос.УстановитьПараметр("ДатаОбъединенияВзносов", УчетСтраховыхВзносов.ДатаОбъединенияВзносов());
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ДокументОбъект = Выборка.Ссылка.ПолучитьОбъект();
		ДокументОбъект.ЗарегистрироватьДанныеОВремениДляРасчетаСреднегоФСС();
		Если ДокументОбъект.Движения.ДанныеОВремениДляРасчетаСреднегоФСС.Записывать Тогда
			ДокументОбъект.Движения.ДанныеОВремениДляРасчетаСреднегоФСС.Записать();
			ДокументОбъект.Движения.ДанныеОВремениДляРасчетаСреднегоФСС.Записывать = Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Если ПараметрыОбновления <> Неопределено Тогда
		ПараметрыОбновления.ОбработкаЗавершена = Истина;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры
	
#КонецОбласти

Функция ДанныеДляРегистрацииВУчетаСтажаПФР(МассивСсылок) Экспорт
	ДанныеДляРегистрацииВУчете = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВыплатыПоДоговорамОпеки.Сотрудник КАК Сотрудник,
	|	ВыплатыПоДоговорамОпеки.ДатаНачала КАК ДатаНачала,
	|	ВыплатыПоДоговорамОпеки.ДатаНачалаПФР КАК ДатаНачалаПФР,
	|	ВыплатыПоДоговорамОпеки.ДатаОкончания КАК ДатаОкончания,
	|	ВыплатыПоДоговорамОпеки.Ссылка КАК Ссылка,
	|	ВыплатыПоДоговорамОпеки.Организация КАК Организация,
	|	ВыплатыПоДоговорамОпеки.Подразделение КАК Подразделение,
	|	ВыплатыПоДоговорамОпеки.Территория КАК Территория
	|ИЗ
	|	Документ.ВыплатыПоДоговорамОпеки КАК ВыплатыПоДоговорамОпеки
	|ГДЕ
	|	НЕ ВыплатыПоДоговорамОпеки.ПолучаетСтраховуюПенсию
	|	И ВыплатыПоДоговорамОпеки.Ссылка В(&МассивСсылок)";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ДанныеДляРегистрацииВУчетеПоДокументу = УчетСтажаПФР.ДанныеДляРегистрацииДоговоровГПХВУчетеСтажаПФР();
		ДанныеДляРегистрацииВУчете.Вставить(Выборка.Ссылка, ДанныеДляРегистрацииВУчетеПоДокументу); 
		
		ОписаниеПериода = УчетСтажаПФР.ОписаниеРегистрируемогоПериода();
		ОписаниеПериода.Сотрудник = Выборка.Сотрудник;	
		ОписаниеПериода.ДатаНачалаПериода = Макс(Выборка.ДатаНачала, Выборка.ДатаНачалаПФР);
		ОписаниеПериода.ДатаОкончанияПериода = Выборка.ДатаОкончания;
		ОписаниеПериода.Состояние = Перечисления.СостоянияСотрудника.Работа;

		РегистрируемыйПериод = УчетСтажаПФР.ДобавитьЗаписьВДанныеДляРегистрацииВУчета(ДанныеДляРегистрацииВУчетеПоДокументу, ОписаниеПериода);
		
		УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "ВидСтажаПФР", Перечисления.ВидыСтажаПФР2014.ВключаетсяВСтажДляДосрочногоНазначенияПенсии);
		УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "Организация", Выборка.Организация);
		УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "Подразделение", Выборка.Подразделение);
		УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "Территория", Выборка.Территория);
	КонецЦикла;	
		
	Возврат ДанныеДляРегистрацииВУчете;
															
КонецФункции	

Функция ДанныеДляПроведенияМероприятияТрудовойДеятельности(СсылкаНаДокумент) Экспорт
	
	ДанныеДляПроведения = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", СсылкаНаДокумент);
	Запрос.УстановитьПараметр("ДатаНачалаПриемаЕФС1", ЗарплатаКадрыПовтИсп.ДатаВступленияВСилуНА("ДатаНачалаПриемаЕФС1"));
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ТаблицаДокумента.Ссылка КАК Ссылка,
		|	ТаблицаДокумента.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ТаблицаДокумента.Организация КАК Организация,
		|	ТаблицаДокумента.Сотрудник КАК Сотрудник,
		|	ТаблицаДокумента.ДатаНачала КАК ДатаМероприятия,
		|	ЗНАЧЕНИЕ(Перечисление.ВидыМероприятийТрудовойДеятельности.НачалоДоговораГПХ) КАК ВидМероприятия,
		|	ВЫБОР
		|		КОГДА ТаблицаДокумента.ОблагаетсяФСС_НС
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.ТрудовыеФункции.ДГПХФЛНС)
		|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ТрудовыеФункции.ДГПХ)
		|	КОНЕЦ КАК ТрудоваяФункция,
		|	ТаблицаДокумента.НаименованиеДокумента КАК НаименованиеДокументаОснования,
		|	ТаблицаДокумента.Дата КАК ДатаДокументаОснования,
		|	"""" КАК СерияДокументаОснования,
		|	ТаблицаДокумента.Номер КАК НомерДокументаОснования,
		|	ТаблицаДокумента.Подразделение КАК ПодразделениеТерриториальныхУсловийПФР,
		|	ТаблицаДокумента.Территория КАК ТерриторияТерриториальныхУсловийПФР,
		|	ТаблицаДокумента.КодПоОКЗ КАК КодПоОКЗ,
		|	ТаблицаДокумента.Номер КАК Номер
		|ИЗ
		|	Документ.ВыплатыПоДоговорамОпеки КАК ТаблицаДокумента
		|ГДЕ
		|	ТаблицаДокумента.Ссылка В(&Ссылка)
		|	И ТаблицаДокумента.ОтразитьТрудовуюДеятельность
		|	И ТаблицаДокумента.ДатаНачала >= &ДатаНачалаПриемаЕФС1
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ТаблицаДокумента.Ссылка,
		|	ТаблицаДокумента.ФизическоеЛицо,
		|	ТаблицаДокумента.Организация,
		|	ТаблицаДокумента.Сотрудник,
		|	ТаблицаДокумента.ДатаОкончания,
		|	ЗНАЧЕНИЕ(Перечисление.ВидыМероприятийТрудовойДеятельности.ОкончаниеДоговораГПХ),
		|	ВЫБОР
		|		КОГДА ТаблицаДокумента.ОблагаетсяФСС_НС
		|			ТОГДА ЗНАЧЕНИЕ(Справочник.ТрудовыеФункции.ДГПХФЛНС)
		|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ТрудовыеФункции.ДГПХ)
		|	КОНЕЦ,
		|	ТаблицаДокумента.НаименованиеДокумента,
		|	ТаблицаДокумента.ДатаОкончания,
		|	"""",
		|	ТаблицаДокумента.Номер,
		|	ТаблицаДокумента.Подразделение,
		|	ТаблицаДокумента.Территория,
		|	ТаблицаДокумента.КодПоОКЗ,
		|	ТаблицаДокумента.Номер
		|ИЗ
		|	Документ.ВыплатыПоДоговорамОпеки КАК ТаблицаДокумента
		|ГДЕ
		|	ТаблицаДокумента.Ссылка В(&Ссылка)
		|	И ТаблицаДокумента.ОтразитьТрудовуюДеятельность
		|
		|УПОРЯДОЧИТЬ ПО
		|	Ссылка,
		|	ДатаМероприятия";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.СледующийПоЗначениюПоля("Ссылка") Цикл
		
		ДвиженияДокумента = Новый Массив;
		ДанныеДляПроведения.Вставить(Выборка.Ссылка, ДвиженияДокумента);
		
		Пока Выборка.Следующий() Цикл
			ДанныеМероприятия = ЭлектронныеТрудовыеКнижки.ЗаписьДвиженияМероприятияТрудовойДеятельности(Выборка);
			Если ЗначениеЗаполнено(Выборка.ТерриторияТерриториальныхУсловийПФР) Тогда
				ДанныеМероприятия.ТерриториальныеУсловия = ЭлектронныеТрудовыеКнижкиПовтИсп.ТерриториальныеУсловияПФР(
					Выборка.ДатаМероприятия, Выборка.Организация, Выборка.ТерриторияТерриториальныхУсловийПФР);
			Иначе
				ДанныеМероприятия.ТерриториальныеУсловия = ЭлектронныеТрудовыеКнижкиПовтИсп.ТерриториальныеУсловияПФР(
					Выборка.ДатаМероприятия, Выборка.Организация, Выборка.ПодразделениеТерриториальныхУсловийПФР);
			КонецЕсли;
			ДвиженияДокумента.Добавить(ДанныеМероприятия);
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ДанныеДляПроведения;
	
КонецФункции

#Область ПервоначальноеЗаполнениеИОбновлениеИнформационнойБазы

Процедура ВписатьНовыйВидДоходаПоНДФЛ(ПараметрыОбновления = Неопределено) Экспорт

	ДатаВыделенияДоходовПоДоговоруОпеки = УчетНДФЛ.ДатаВыделенияДоходовПоДоговоруОпеки();
	НовыйВидДохода = УчетНДФЛ.ВидДоходаПоДоговоруОпеки(ДатаВыделенияДоходовПоДоговоруОпеки);	

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("ДатаВыделенияДоходовПоДоговоруОпеки", ДатаВыделенияДоходовПоДоговоруОпеки);
	Запрос.УстановитьПараметр("НовыйВидДохода", НовыйВидДохода);
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1000
	|	УсловияДоговораОпеки.Регистратор КАК Регистратор
	|ПОМЕСТИТЬ ВТРегистраторы
	|ИЗ
	|	РегистрСведений.УсловияДоговораОпеки КАК УсловияДоговораОпеки
	|ГДЕ
	|	УсловияДоговораОпеки.КодДохода <> &НовыйВидДохода
	|	И УсловияДоговораОпеки.ДатаОкончания >= &ДатаВыделенияДоходовПоДоговоруОпеки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	УсловияДоговораОпеки.Регистратор КАК Регистратор,
	|	*
	|ИЗ
	|	ВТРегистраторы КАК Регистраторы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.УсловияДоговораОпеки КАК УсловияДоговораОпеки
	|		ПО Регистраторы.Регистратор = УсловияДоговораОпеки.Регистратор
	|
	|УПОРЯДОЧИТЬ ПО
	|	Регистратор";
	Если ПараметрыОбновления = Неопределено Тогда
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, " ПЕРВЫЕ 1000", "");
	КонецЕсли;
	Запрос.Текст = ТекстЗапроса;
	
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.УстановитьПараметрОбновления(ПараметрыОбновления, "ОбработкаЗавершена", Ложь);
		Выборка = Результат.Выбрать();
		Пока Выборка.СледующийПоЗначениюПоля("Регистратор") Цикл
			Если Не ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ПодготовитьОбновлениеДанных(ПараметрыОбновления, "РегистрСведений.УсловияДоговораОпеки.НаборЗаписей", "Регистратор", Выборка.Регистратор) Тогда
				Продолжить;
			КонецЕсли;
			НаборЗаписей = РегистрыСведений.УсловияДоговораОпеки.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Регистратор.Установить(Выборка.Регистратор);
			Пока Выборка.Следующий() Цикл
				Если Выборка.КодДохода <> НовыйВидДохода И Выборка.ДатаОкончания >= ДатаВыделенияДоходовПоДоговоруОпеки Тогда
					Если Выборка.ДатаНачала < ДатаВыделенияДоходовПоДоговоруОпеки Тогда
						НоваяЗапись = НаборЗаписей.Добавить();
						ЗаполнитьЗначенияСвойств(НоваяЗапись, Выборка);
						НоваяЗапись.ДатаОкончания = ДатаВыделенияДоходовПоДоговоруОпеки - 1;
						Если НоваяЗапись.Период = ДатаВыделенияДоходовПоДоговоруОпеки Тогда
							НоваяЗапись.Период = Выборка.ДатаНачала
						КонецЕсли;
						НоваяЗапись = НаборЗаписей.Добавить();
						ЗаполнитьЗначенияСвойств(НоваяЗапись, Выборка);
						НоваяЗапись.Период = ДатаВыделенияДоходовПоДоговоруОпеки;
						НоваяЗапись.ДатаНачала = ДатаВыделенияДоходовПоДоговоруОпеки;
						НоваяЗапись.КодДохода = НовыйВидДохода;
					Иначе
						НоваяЗапись = НаборЗаписей.Добавить();
						ЗаполнитьЗначенияСвойств(НоваяЗапись, Выборка);
						НоваяЗапись.КодДохода = НовыйВидДохода
					КонецЕсли;
				Иначе
					ЗаполнитьЗначенияСвойств(НаборЗаписей.Добавить(), Выборка);
				КонецЕсли;
			КонецЦикла;
			ОбновлениеИнформационнойБазы.ЗаписатьДанные(НаборЗаписей);
			ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ЗавершитьОбновлениеДанных(ПараметрыОбновления);
		КонецЦикла;
	Иначе
		ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.УстановитьПараметрОбновления(ПараметрыОбновления, "ОбработкаЗавершена", Истина)
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
