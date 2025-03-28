#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если Не ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	БлокироватьДляИзменения = Истина;
	
	// Текущее состояние набора помещается во временную таблицу "ДвиженияТоварыКОтгрузкеПередЗаписью",
	// чтобы при записи получить изменение нового набора относительно текущего.

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.УстановитьПараметр("ЭтоНовый",    ДополнительныеСвойства.СвойстваДокумента.ЭтоНовый);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Таблица.ЗаказПоставщику КАК ЗаказПоставщику,
	|	Таблица.Номенклатура    КАК Номенклатура,
	|	Таблица.Характеристика  КАК Характеристика,
	|	Таблица.КодСтроки       КАК КодСтроки,
	|	Таблица.Склад           КАК Склад,
	|	ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|			Таблица.Заказано
	|		ИНАЧЕ
	|			-Таблица.Заказано
	|	КОНЕЦ                  КАК ЗаказаноПередЗаписью,
	|	ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|			Таблица.КОформлению
	|		ИНАЧЕ
	|			-Таблица.КОформлению
	|	КОНЕЦ                   КАК КОформлениюПередЗаписью,
	|	ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|			Таблица.КПоступлению
	|		ИНАЧЕ
	|			-Таблица.КПоступлению
	|	КОНЕЦ                   КАК КПоступлениюПередЗаписью
	|ПОМЕСТИТЬ ДвиженияЗаказыПоставщикамПередЗаписью
	|ИЗ
	|	РегистрНакопления.ЗаказыПоставщикам КАК Таблица
	|ГДЕ
	|	Таблица.Регистратор = &Регистратор
	|	И НЕ &ЭтоНовый
	|";
	Запрос.Выполнить();

КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)

	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.РассчитыватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;

	// Рассчитывается изменение нового набора относительно текущего с учетом накопленных изменений
	// и помещается во временную таблицу.
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаИзменений.ЗаказПоставщику              КАК ЗаказПоставщику,
	|	ТаблицаИзменений.Номенклатура                 КАК Номенклатура,
	|	ТаблицаИзменений.Характеристика               КАК Характеристика,
	|	ТаблицаИзменений.КодСтроки                    КАК КодСтроки,
	|	ТаблицаИзменений.Склад                        КАК Склад,
	|	СУММА(ТаблицаИзменений.ЗаказаноИзменение)     КАК ЗаказаноИзменение,
	|	СУММА(ТаблицаИзменений.КОформлениюИзменение)  КАК КОформлениюИзменение,
	|	СУММА(ТаблицаИзменений.КПоступлениюИзменение) КАК КПоступлениюИзменение
	|ПОМЕСТИТЬ ДвиженияЗаказыПоставщикамИзменение
	|ИЗ
	|	(ВЫБРАТЬ
	|		Таблица.ЗаказПоставщику          КАК ЗаказПоставщику,
	|		Таблица.Номенклатура             КАК Номенклатура,
	|		Таблица.Характеристика           КАК Характеристика,
	|		Таблица.КодСтроки                КАК КодСтроки,
	|		Таблица.Склад                    КАК Склад,
	|		Таблица.ЗаказаноПередЗаписью     КАК ЗаказаноИзменение,
	|		Таблица.КОформлениюПередЗаписью  КАК КОформлениюИзменение,
	|		Таблица.КПоступлениюПередЗаписью КАК КПоступлениюИзменение
	|	ИЗ
	|		ДвиженияЗаказыПоставщикамПередЗаписью КАК Таблица
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Таблица.ЗаказПоставщику        КАК ЗаказПоставщику,
	|		Таблица.Номенклатура           КАК Номенклатура,
	|		Таблица.Характеристика         КАК Характеристика,
	|		Таблица.КодСтроки              КАК КодСтроки,
	|		Таблица.Склад                  КАК Склад,
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|				-Таблица.Заказано
	|			ИНАЧЕ
	|				Таблица.Заказано
	|		КОНЕЦ                  КАК ЗаказаноПередЗаписью,
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|				-Таблица.КОформлению
	|			ИНАЧЕ
	|				Таблица.КОформлению
	|		КОНЕЦ                          КАК КОформлениюИзменение,
	|		ВЫБОР КОГДА Таблица.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
	|				-Таблица.КПоступлению
	|			ИНАЧЕ
	|				Таблица.КПоступлению
	|		КОНЕЦ                          КАК КПоступлениюИзменение
	|	ИЗ
	|		РегистрНакопления.ЗаказыПоставщикам КАК Таблица
	|	ГДЕ
	|		Таблица.Регистратор = &Регистратор) КАК ТаблицаИзменений
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаИзменений.ЗаказПоставщику,
	|	ТаблицаИзменений.Номенклатура,
	|	ТаблицаИзменений.Характеристика,
	|	ТаблицаИзменений.КодСтроки,
	|	ТаблицаИзменений.Склад
	|
	|ИМЕЮЩИЕ
	|	СУММА(ТаблицаИзменений.КОформлениюИзменение) <> 0
	|	ИЛИ СУММА(ТаблицаИзменений.ЗаказаноИзменение) <> 0
	|	ИЛИ СУММА(ТаблицаИзменений.КПоступлениюИзменение) <> 0
	|;
	|УНИЧТОЖИТЬ ДвиженияЗаказыПоставщикамПередЗаписью
	|";
	
	МассивРезультатовЗапроса = Запрос.ВыполнитьПакет();
	РезультатЗапроса = МассивРезультатовЗапроса[0]; // РезультатЗапроса
	Выборка = РезультатЗапроса.Выбрать();
	ЕстьИзменения = Выборка.Следующий() И Выборка.Количество > 0;
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ДвиженияЗаказыПоставщикамИзменение", ЕстьИзменения);
	
	Если ЕстьИзменения
		И ПолучитьФункциональнуюОпцию("ИспользоватьДопустимоеОтклонениеОтгрузкиПриемкиМерныхТоваров") Тогда
	
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("ДопустимоеОтклонениеОтгрузкиПриемкиМерныхТоваров",
			Константы.ДопустимоеОтклонениеОтгрузкиПриемкиМерныхТоваров.Получить());
		Запрос.УстановитьПараметр("МерныеТипыЕдиницИзмерений",
			Справочники.УпаковкиЕдиницыИзмерения.МерныеТипыЕдиницИзмерений());
		Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
		
		ТекстЗапроса = "
		|ВЫБРАТЬ
		|	Таблица.ЗаказПоставщику,
		|	Таблица.Номенклатура,
		|	Таблица.Характеристика,
		|	Таблица.Склад
		|ПОМЕСТИТЬ ДвиженияЗаказыПоставщикамИзменениеМерныеТовары
		|ИЗ
		|	ДвиженияЗаказыПоставщикамИзменение КАК Таблица
		|ГДЕ 
		|	Таблица.Номенклатура.ЕдиницаИзмерения.ТипИзмеряемойВеличины В (&МерныеТипыЕдиницИзмерений)
		|СГРУППИРОВАТЬ ПО
		|	Таблица.ЗаказПоставщику,
		|	Таблица.Номенклатура,
		|	Таблица.Характеристика,
		|	Таблица.Склад
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		// Основная таблица
		ТекстЗапроса = ТекстЗапроса + "
		|ВЫБРАТЬ
		|	ЗаказыПоставщикам.ВидДвижения     КАК ВидДвижения,
		|	ЗаказыПоставщикам.ЗаказПоставщику КАК ЗаказПоставщику,
		|	ЗаказыПоставщикам.Номенклатура    КАК Номенклатура,
		|	ЗаказыПоставщикам.Характеристика  КАК Характеристика,
		|	ЗаказыПоставщикам.Склад           КАК Склад,
		|	ЗаказыПоставщикам.КОформлению     КАК КОформлению,
		|	ЗаказыПоставщикам.КПоступлению    КАК КПоступлению
		|ПОМЕСТИТЬ ВТЗаказыПоставщикам
		|ИЗ
		|	РегистрНакопления.ЗаказыПоставщикам КАК ЗаказыПоставщикам
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
		|		ДвиженияЗаказыПоставщикамИзменение КАК Изменения
		|		ПО ЗаказыПоставщикам.ЗаказПоставщику   = Изменения.ЗаказПоставщику
		|			И ЗаказыПоставщикам.Номенклатура   = Изменения.Номенклатура
		|			И ЗаказыПоставщикам.Характеристика = Изменения.Характеристика
		|			И ЗаказыПоставщикам.Склад          = Изменения.Склад
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		// Допустимые отклонения
		ТекстЗапроса = ТекстЗапроса + "
		|ВЫБРАТЬ
		|	ЗаказыПоставщикам.ЗаказПоставщику КАК ЗаказПоставщику,
		|	ЗаказыПоставщикам.Номенклатура    КАК Номенклатура,
		|	ЗаказыПоставщикам.Характеристика  КАК Характеристика,
		|	ЗаказыПоставщикам.Склад           КАК Склад,
		|	СУММА(ЗаказыПоставщикам.КОформлению
		|		* (&ДопустимоеОтклонениеОтгрузкиПриемкиМерныхТоваров / 100)) КАК ДопустимоеОтклонение,
		|	СУММА(ЗаказыПоставщикам.КПоступлению
		|		* (&ДопустимоеОтклонениеОтгрузкиПриемкиМерныхТоваров / 100)) КАК ДопустимоеОтклонениеКПоступлению
		|ПОМЕСТИТЬ ВТДопустимыеОтклоненияЗаказыПоставщикам
		|ИЗ
		|	ВТЗаказыПоставщикам КАК ЗаказыПоставщикам
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
		|		ДвиженияЗаказыПоставщикамИзменениеМерныеТовары КАК Изменения
		|		ПО ЗаказыПоставщикам.ЗаказПоставщику   = Изменения.ЗаказПоставщику
		|			И ЗаказыПоставщикам.Номенклатура   = Изменения.Номенклатура
		|			И ЗаказыПоставщикам.Характеристика = Изменения.Характеристика
		|			И ЗаказыПоставщикам.Склад          = Изменения.Склад
		|ГДЕ
		|	ЗаказыПоставщикам.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
		|СГРУППИРОВАТЬ ПО
		|	ЗаказыПоставщикам.ЗаказПоставщику,
		|	ЗаказыПоставщикам.Номенклатура,
		|	ЗаказыПоставщикам.Характеристика,
		|	ЗаказыПоставщикам.Склад
		|ИНДЕКСИРОВАТЬ ПО
		|	ЗаказПоставщику,
		|	Номенклатура,
		|	Характеристика,
		|	Склад
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		//Остатки
		ТекстЗапроса = ТекстЗапроса + "
		|ВЫБРАТЬ
		|	ЗаказыПоставщикам.ЗаказПоставщику    КАК ЗаказПоставщику,
		|	ЗаказыПоставщикам.Номенклатура       КАК Номенклатура,
		|	ЗаказыПоставщикам.Характеристика     КАК Характеристика,
		|	ЗаказыПоставщикам.Склад              КАК Склад,
		|	СУММА(ВЫБОР КОГДА ЗаказыПоставщикам.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
		|			ЗаказыПоставщикам.КОформлению
		|		ИНАЧЕ
		|			-ЗаказыПоставщикам.КОформлению
		|	КОНЕЦ)                               КАК КОформлениюОстаток,
		|	СУММА(ВЫБОР КОГДА ЗаказыПоставщикам.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) ТОГДА
		|			ЗаказыПоставщикам.КПоступлению
		|		ИНАЧЕ
		|			-ЗаказыПоставщикам.КПоступлению
		|	КОНЕЦ)                               КАК КПоступлениюОстаток
		|ПОМЕСТИТЬ ВТЗаказыПоставщикамОстатки
		|ИЗ
		|	ВТЗаказыПоставщикам КАК ЗаказыПоставщикам
		|СГРУППИРОВАТЬ ПО
		|	ЗаказыПоставщикам.ЗаказПоставщику,
		|	ЗаказыПоставщикам.Номенклатура,
		|	ЗаказыПоставщикам.Характеристика,
		|	ЗаказыПоставщикам.Склад
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		ТекстЗапроса = ТекстЗапроса + "
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ЗаказыОстатки.ЗаказПоставщику КАК ЗаказПоставщику
		|ИЗ
		|	ВТЗаказыПоставщикамОстатки КАК ЗаказыОстатки
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
		|		ВТДопустимыеОтклоненияЗаказыПоставщикам КАК ДопустимыеОтклонения
		|		ПО
		|			ЗаказыОстатки.ЗаказПоставщику  = ДопустимыеОтклонения.ЗаказПоставщику
		|			И ЗаказыОстатки.Номенклатура   = ДопустимыеОтклонения.Номенклатура
		|			И ЗаказыОстатки.Характеристика = ДопустимыеОтклонения.Характеристика
		|			И ЗаказыОстатки.Склад          = ДопустимыеОтклонения.Склад
		|ГДЕ
		|	ЗаказыОстатки.КОформлениюОстаток <= ДопустимыеОтклонения.ДопустимоеОтклонение
		|	И ЗаказыОстатки.КОформлениюОстаток >= -ДопустимыеОтклонения.ДопустимоеОтклонение
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ЗаказыОстатки.ЗаказПоставщику КАК ЗаказПоставщику
		|ИЗ
		|	ВТЗаказыПоставщикамОстатки КАК ЗаказыОстатки
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
		|		ВТДопустимыеОтклоненияЗаказыПоставщикам КАК ДопустимыеОтклонения
		|		ПО
		|			ЗаказыОстатки.ЗаказПоставщику  = ДопустимыеОтклонения.ЗаказПоставщику
		|			И ЗаказыОстатки.Номенклатура   = ДопустимыеОтклонения.Номенклатура
		|			И ЗаказыОстатки.Характеристика = ДопустимыеОтклонения.Характеристика
		|			И ЗаказыОстатки.Склад          = ДопустимыеОтклонения.Склад
		|ГДЕ
		|	ЗаказыОстатки.КПоступлениюОстаток <= ДопустимыеОтклонения.ДопустимоеОтклонениеКПоступлению
		|	И ЗаказыОстатки.КПоступлениюОстаток >= -ДопустимыеОтклонения.ДопустимоеОтклонениеКПоступлению
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|";
		
		Запрос.Текст = ТекстЗапроса;
		
		ВыборкаЗаказ = Запрос.Выполнить().Выбрать();
		
		Пока ВыборкаЗаказ.Следующий() Цикл
			
			РегистрыСведений.ОчередьЗаказовККорректировкеСтрокМерныхТоваров.ДобавитьЗаказВОчередь(
				ВыборкаЗаказ.ЗаказПоставщику);
			
		КонецЦикла;
	
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли