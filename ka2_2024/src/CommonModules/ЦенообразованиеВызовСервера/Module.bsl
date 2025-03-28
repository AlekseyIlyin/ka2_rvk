
#Область ПрограммныйИнтерфейс

// Определяет, используется ли ценообразование версии 2.5 на указанную дату.
//
// Параметры:
//	Дата - Дата - дата, для которой надо определить режим ценообразования.
//
// Возвращаемое значение:
//	Булево - признак использования ценообразования версии 2.5 на указанную дату
//	Если дата не указана, то она приравнивается к текущей.
//
Функция ИспользуетсяЦенообразование25(Знач Дата = Неопределено) Экспорт

	Если НЕ ПолучитьФункциональнуюОпцию("ИспользуетсяЦенообразование25") Тогда
		Возврат Ложь; // ценообразование 2.5 выключено
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Дата) Тогда
		Дата = ТекущаяДатаСеанса();
	КонецЕсли;
	
	ИспользуетсяЦенообразование25 = (Дата >= ДатаПереходаНаЦенообразованиеВерсии25());
	
	Возврат ИспользуетсяЦенообразование25;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Вид цены прайс лист.
// 
// Параметры:
//  ЦенаВключаетНДС - Неопределено, Булево - Цена включает НДС
// 
// Возвращаемое значение:
//  Неопределено, Произвольный - Вид цены прайс лист
Функция ВидЦеныПрайсЛист(ЦенаВключаетНДС = Неопределено) Экспорт

	Если ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВидовЦен") Тогда
		Возврат Неопределено;
	Иначе
		Возврат Ценообразование.ВидЦеныПрайсЛист(ЦенаВключаетНДС);
	КонецЕсли;

КонецФункции

// Возвращает дату перехода на ценообразование версии 2.5.
// Дата может быть пустой - значит ценообразование версии 2.5 включено для всех периодов.
//
// Возвращаемое значение:
//	Дата - начало дня перехода на ценообразование версии 2.5.
//
Функция ДатаПереходаНаЦенообразованиеВерсии25() Экспорт
	
	ДатаПереходаНаЦенообразованиеВерсии25 = НачалоДня(Константы.ДатаПереходаНаЦенообразование25.Получить());
	
	Возврат ДатаПереходаНаЦенообразованиеВерсии25;
	
КонецФункции

// Получить схему по версии ценообразования.
// 
// Параметры:
//  СхемаКомпоновкиДанных - СхемаКомпоновкиДанных - 
//  ИзменятьИмяНабора - Булево - Истина, удалять постфикс
Процедура ПолучитьСхемуПоВерсииЦенообразования(СхемаКомпоновкиДанных, ИзменятьИмяНабора = Ложь) Экспорт
	ИспользуетсяЦенообразование25 = ИспользуетсяЦенообразование25();
	счНаборов = СхемаКомпоновкиДанных.НаборыДанных.Количество()-1;
	Если счНаборов > 0 Тогда
		Пока счНаборов >= 0 Цикл
			Набор = СхемаКомпоновкиДанных.НаборыДанных[счНаборов];//НаборДанныхОбъектСхемыКомпоновкиДанных
			Если ИспользуетсяЦенообразование25 Тогда
				Если СтрНайти(Набор.Имя, "25", НаправлениеПоиска.СКонца) = 0  Тогда
					СхемаКомпоновкиДанных.НаборыДанных.Удалить(Набор);
				ИначеЕсли ИзменятьИмяНабора Тогда
					Набор.Имя = СтрЗаменить(Набор.Имя, "25", "");
				КонецЕсли;
			Иначе	
				Если НЕ СтрНайти(Набор.Имя, "25", НаправлениеПоиска.СКонца) = 0  Тогда
					СхемаКомпоновкиДанных.НаборыДанных.Удалить(Набор);
				КонецЕсли;
			КонецЕсли;	
			счНаборов = счНаборов - 1;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

// Определяет необходимость пересчита цены при изменении серии.
// 
// Параметры:
//  Номенклатура - СправочникСсылка.Номенклатура - номенклатура проверки
//  ИмяРеквизита - Строка - "Серия" или "Упаковка". имя изменяемого реквизита
//  Дата - Неопределено, Дата - Дата проверки
// 
// Возвращаемое значение:
//  Булево - Истина, Необходимо пересчитать цены
Функция НеобходимПересчетЦеныПриИзменении(Номенклатура, ИмяРеквизита, Дата) Экспорт

	ПересчетНеобходим = Ложь;
	
	Если Не ИспользуетсяЦенообразование25(Дата) Тогда
		Возврат ПересчетНеобходим;
	КонецЕсли;
	
	ТекстЗапроса = "Выбрать
	|	&ПересчетНеобходим КАК ПересчетНеобходим
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВидыНоменклатуры КАК ВидыНоменклатуры
	|		ПО Номенклатура.ВидНоменклатуры = ВидыНоменклатуры.Ссылка
	|ГДЕ
	|	Номенклатура.Ссылка = &НоменклатураСсылка";
	
	Если ИмяРеквизита = "Серия" Тогда
		СтрокаЗамены = "ВЫБОР
						|		КОГДА ВидыНоменклатуры.НастройкиКлючаЦенПоСерии = ЗНАЧЕНИЕ(Перечисление.ВариантОтбораДляКлючаЦен.НеИспользовать)
						|			ТОГДА ЛОЖЬ
						|		ИНАЧЕ ИСТИНА
						|	КОНЕЦ";
	ИначеЕсли ИмяРеквизита = "Упаковка" Тогда
		СтрокаЗамены = "ВЫБОР
						|		КОГДА ВидыНоменклатуры.НастройкиКлючаЦенПоУпаковке = ЗНАЧЕНИЕ(Перечисление.ВариантОтбораДляКлючаЦен.НеИспользовать)
						|			ТОГДА ЛОЖЬ
						|		ИНАЧЕ ИСТИНА
						|	КОНЕЦ";
	Иначе
		Возврат ПересчетНеобходим;
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПересчетНеобходим", СтрокаЗамены);
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("НоменклатураСсылка", Номенклатура);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		ПересчетНеобходим = Выборка.ПересчетНеобходим;
	Иначе
		ПересчетНеобходим = Ложь;
	КонецЕсли;
	
	Возврат ПересчетНеобходим;

КонецФункции

#КонецОбласти
