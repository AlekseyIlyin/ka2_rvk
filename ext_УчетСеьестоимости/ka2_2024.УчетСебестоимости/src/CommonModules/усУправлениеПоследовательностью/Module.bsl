#Область ПрограммныйИнтерфейс

Процедура УстановитьГраницуПоследовательности(Период) Экспорт

	Параметр = ПланыВидовХарактеристик.усПараметрыПодсистемы.ГраницаПоследовательности;

	НаборЗаписей = РегистрыСведений.усПараметрыПодсистемы.СоздатьНаборЗаписей();
	НаборЗаписей.ДополнительныеСвойства.Вставить("ОбновитьПовторноИспользуемыеЗначения", Ложь);
	НаборЗаписей.Отбор.Параметр.Установить(Параметр);
	Запись = НаборЗаписей.Добавить();
	Запись.Параметр = Параметр;
	Запись.Значение = Период;
	НаборЗаписей.Записать();

КонецПроцедуры

Функция ГраницаПоследовательности() Экспорт

	Результат = '00010101';

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	усПараметрыПодсистемы.Значение
		|ИЗ
		|	РегистрСведений.усПараметрыПодсистемы КАК усПараметрыПодсистемы
		|ГДЕ
		|	усПараметрыПодсистемы.Параметр = ЗНАЧЕНИЕ(ПланВидовХарактеристик.усПараметрыПодсистемы.ГраницаПоследовательности)";

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Если ВыборкаДетальныеЗаписи.Следующий() Тогда
		Результат = ВыборкаДетальныеЗаписи.Значение;
	КонецЕсли;

	Возврат Результат;

КонецФункции

Функция ВосстановитьПоследовательность() Экспорт

	Ошибки = Новый Массив;

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	СебестоимостьТоваровОбороты.Регистратор КАК Регистратор
		|ИЗ
		|	РегистрНакопления.СебестоимостьТоваров.Обороты(&ДатаНачала,, Регистратор,) КАК СебестоимостьТоваровОбороты
		|
		|УПОРЯДОЧИТЬ ПО
		|	Регистратор.МоментВремени";

	Период = ГраницаПоследовательности();
	Запрос.УстановитьПараметр("ДатаНачала", Новый Граница(Период, ВидГраницы.Исключая));

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Результат = СформироватьДвиженияРегистратора(Выборка.Регистратор);
		Если Результат.Отказ Тогда
			Ошибки.Добавить(Результат);
		КонецЕсли;
	КонецЦикла;

	Возврат Ошибки;

КонецФункции

Функция СформироватьДвиженияРегистратора(Регистратор) Экспорт

	Результат = Новый Структура();
	Результат.Вставить("Отказ", Ложь);
	Результат.Вставить("ТекстОшибки", "");

	НачатьТранзакцию();

	Попытка
		РезультатДобавитьДвиженияОстаткиПоПартиям = усУправлениеСебестоимостью.ДобавитьДвиженияОстаткиПоПартиям(Регистратор);
		Если РезультатДобавитьДвиженияОстаткиПоПартиям.Отказ Тогда
			ОтменитьТранзакцию();
			ЗаполнитьЗначенияСвойств(Результат, РезультатДобавитьДвиженияОстаткиПоПартиям);
		КонецЕсли;
		усУправлениеПродажами.ДобавитьДвиженияПродажи(Регистратор);
		ЗафиксироватьТранзакцию();

	Исключение
		ОтменитьТранзакцию();
		Результат.Отказ = Истина;
		Результат.ТекстОшибки = ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());

	КонецПопытки;

	Возврат Результат;

КонецФункции

Функция ГраницаПоследовательностиРаньше(Период) Экспорт

	ГраницаПоследовательности = ГраницаПоследовательности();
	Результат = ГраницаПоследовательности < Период;

	Возврат Результат;

КонецФункции

Функция ЕстьДвиженияПосле(Период) Экспорт

	Результат = Ложь;

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	МАКСИМУМ(СебестоимостьТоваров.Период) КАК Период
		|ИЗ
		|	РегистрНакопления.СебестоимостьТоваров КАК СебестоимостьТоваров";

	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Выборка.Период > Период;
	КонецЕсли;

	Возврат Результат;

КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
// Код процедур и функций
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти