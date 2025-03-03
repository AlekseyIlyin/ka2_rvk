#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ДоступноИзменениеНастроек = ПравоДоступа("Изменение", Метаданные.РегистрыСведений.РедактируемыеРеквизитыВидаВычетаНДФЛ);
	Элементы.ФормаЗаписатьИЗакрыть.Доступность = ДоступноИзменениеНастроек;
	Элементы.ФормаВосстановитьСтандартныеНастройки.Доступность = ДоступноИзменениеНастроек;
	
	ЗаполнитьТаблицу();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗаписатьИЗакрытьНаСервере();
	ОбновитьПовторноИспользуемыеЗначения();
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ВосстановитьСтандартныеНастройки(Команда)
	ВосстановитьСтандартныеНастройкиНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыНастройкаПорядка

&НаКлиенте
Процедура НастройкаПорядкаПереместитьВверх(Команда)
	
	ТекущиеДанные = Элементы.НастройкаПорядка.ТекущиеДанные;
	
	Если Не ТекущиеДанные.Доступен Тогда
		Возврат;
	КонецЕсли;
	
	ИндексТекущейСтроки = НастройкаПорядка.Индекс(Элементы.НастройкаПорядка.ТекущиеДанные);
	
	Если ИндексТекущейСтроки > 0 Тогда
		ИндексВерхнейСтроки = ИндексТекущейСтроки - 1;
		Пока ИндексВерхнейСтроки >= 0 Цикл
			Если НастройкаПорядка[ИндексВерхнейСтроки].Доступен Тогда
				ПорядковыйНомерВерхнейСтроки = НастройкаПорядка[ИндексВерхнейСтроки].ПорядковыйНомерВРасчетеНалога;
				НастройкаПорядка[ИндексВерхнейСтроки].ПорядковыйНомерВРасчетеНалога = НастройкаПорядка[ИндексТекущейСтроки].ПорядковыйНомерВРасчетеНалога;
				НастройкаПорядка[ИндексТекущейСтроки].ПорядковыйНомерВРасчетеНалога = ПорядковыйНомерВерхнейСтроки;
				Прервать;
			КонецЕсли;
			ИндексВерхнейСтроки = ИндексВерхнейСтроки - 1;
		КонецЦикла;
		Если ИндексВерхнейСтроки <> - 1 Тогда
			НастройкаПорядка.Сдвинуть(ИндексТекущейСтроки,ИндексВерхнейСтроки-ИндексТекущейСтроки);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура НастройкаПорядкаПереместитьВниз(Команда)
	
	ТекущиеДанные = Элементы.НастройкаПорядка.ТекущиеДанные;
	
	Если Не ТекущиеДанные.Доступен Тогда
		Возврат;
	КонецЕсли;
	
	ИндексТекущейСтроки = НастройкаПорядка.Индекс(Элементы.НастройкаПорядка.ТекущиеДанные);
	ВсегоСтрок = НастройкаПорядка.Количество();
	
	Если ИндексТекущейСтроки < ВсегоСтрок Тогда
		ИндексНижнейСтроки = ИндексТекущейСтроки + 1;
		Пока ИндексНижнейСтроки < ВсегоСтрок Цикл
			Если НастройкаПорядка[ИндексНижнейСтроки].Доступен Тогда
				ПорядковыйНомерВерхнейСтроки = НастройкаПорядка[ИндексНижнейСтроки].ПорядковыйНомерВРасчетеНалога;
				НастройкаПорядка[ИндексНижнейСтроки].ПорядковыйНомерВРасчетеНалога  = НастройкаПорядка[ИндексТекущейСтроки].ПорядковыйНомерВРасчетеНалога;
				НастройкаПорядка[ИндексТекущейСтроки].ПорядковыйНомерВРасчетеНалога = ПорядковыйНомерВерхнейСтроки;
				Прервать;
			КонецЕсли;
			ИндексНижнейСтроки = ИндексНижнейСтроки + 1;
		КонецЦикла;
		Если ИндексНижнейСтроки <> ВсегоСтрок Тогда
			НастройкаПорядка.Сдвинуть(ИндексТекущейСтроки,ИндексНижнейСтроки-ИндексТекущейСтроки);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьТаблицу()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	РедактируемыеРеквизитыВидаВычетаНДФЛ.ВидВычета КАК ВидВычета,
	|	РедактируемыеРеквизитыВидаВычетаНДФЛ.ПорядковыйНомерВРасчетеНалога КАК ПорядковыйНомерВРасчетеНалога,
	|	РедактируемыеРеквизитыВидаВычетаНДФЛ.ВидВычета.Наименование КАК ВидВычетаНаименование,
	|	ВЫБОР
	|		КОГДА РедактируемыеРеквизитыВидаВычетаНДФЛ.ВидВычета.ГруппаВычета В (ЗНАЧЕНИЕ(Перечисление.ГруппыВычетовПоНДФЛ.Имущественные), ЗНАЧЕНИЕ(Перечисление.ГруппыВычетовПоНДФЛ.СоциальныеПоУведомлениюНО))
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК Доступен
	|ИЗ
	|	РегистрСведений.РедактируемыеРеквизитыВидаВычетаНДФЛ КАК РедактируемыеРеквизитыВидаВычетаНДФЛ
	|
	|УПОРЯДОЧИТЬ ПО
	|	РедактируемыеРеквизитыВидаВычетаНДФЛ.ПорядковыйНомерВРасчетеНалога УБЫВ";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВидыВычетовНДФЛ.Ссылка КАК ВидВычета,
		|	ВидыВычетовНДФЛ.ПорядковыйНомерВРасчетеНалога КАК ПорядковыйНомерВРасчетеНалога,
		|	ВидыВычетовНДФЛ.Ссылка.Наименование КАК ВидВычетаНаименование,
		|	ВЫБОР
		|		КОГДА ВидыВычетовНДФЛ.Ссылка.ГруппаВычета В (ЗНАЧЕНИЕ(Перечисление.ГруппыВычетовПоНДФЛ.Имущественные), ЗНАЧЕНИЕ(Перечисление.ГруппыВычетовПоНДФЛ.СоциальныеПоУведомлениюНО))
		|			ТОГДА ИСТИНА
		|		ИНАЧЕ ЛОЖЬ
		|	КОНЕЦ КАК Доступен
		|ИЗ
		|	Справочник.ВидыВычетовНДФЛ КАК ВидыВычетовНДФЛ
		|
		|УПОРЯДОЧИТЬ ПО
		|	ПорядковыйНомерВРасчетеНалога УБЫВ";
		Результат = Запрос.Выполнить();
	КонецЕсли;
	
	НастройкаПорядка.Загрузить(Результат.Выгрузить());
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьИЗакрытьНаСервере()
	
	// Если настройки соответствуют настройкам по умолчанию, то очищаем записи в РС
	НастройкиПоУмолчаниюРазличаются = Истина;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаНастроек.ВидВычета КАК ВидВычета,
	|	ТаблицаНастроек.ПорядковыйНомерВРасчетеНалога КАК ПорядковыйНомерВРасчетеНалога
	|ПОМЕСТИТЬ ВТНовыеНастройки
	|ИЗ
	|	&ТаблицаНастроек КАК ТаблицаНастроек
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	ВидыВычетовНДФЛ.Ссылка КАК ВидВычета,
	|	ВидыВычетовНДФЛ.ПорядковыйНомерВРасчетеНалога КАК ПорядковыйНомерВРасчетеНалога
	|ИЗ
	|	Справочник.ВидыВычетовНДФЛ КАК ВидыВычетовНДФЛ
	|		ПОЛНОЕ СОЕДИНЕНИЕ ВТНовыеНастройки КАК ВТНовыеНастройки
	|		ПО ВидыВычетовНДФЛ.Ссылка = ВТНовыеНастройки.ВидВычета
	|ГДЕ
	|	ЕСТЬNULL(ВидыВычетовНДФЛ.ПорядковыйНомерВРасчетеНалога, -1) <> ЕСТЬNULL(ВТНовыеНастройки.ПорядковыйНомерВРасчетеНалога, -1)";
	Запрос.УстановитьПараметр("ТаблицаНастроек",НастройкаПорядка.Выгрузить());
	НастройкиПоУмолчаниюРазличаются = НЕ Запрос.Выполнить().Пустой();
	
	НаборЗаписей = РегистрыСведений.РедактируемыеРеквизитыВидаВычетаНДФЛ.СоздатьНаборЗаписей();
	Если НастройкиПоУмолчаниюРазличаются Тогда
		НаборЗаписей.Загрузить(НастройкаПорядка.Выгрузить());
	КонецЕсли;
	НаборЗаписей.Записать();
	
КонецПроцедуры

&НаСервере
Процедура ВосстановитьСтандартныеНастройкиНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВидыВычетовНДФЛ.Ссылка КАК ВидВычета,
	|	ВидыВычетовНДФЛ.ПорядковыйНомерВРасчетеНалога КАК ПорядковыйНомерВРасчетеНалога,
	|	ВидыВычетовНДФЛ.Ссылка.Наименование КАК ВидВычетаНаименование,
	|	ВЫБОР
	|		КОГДА ВидыВычетовНДФЛ.Ссылка.ГруппаВычета В (ЗНАЧЕНИЕ(Перечисление.ГруппыВычетовПоНДФЛ.Имущественные), ЗНАЧЕНИЕ(Перечисление.ГруппыВычетовПоНДФЛ.СоциальныеПоУведомлениюНО))
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК Доступен
	|ИЗ
	|	Справочник.ВидыВычетовНДФЛ КАК ВидыВычетовНДФЛ
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПорядковыйНомерВРасчетеНалога УБЫВ";
	
	НастройкаПорядка.Загрузить(Запрос.Выполнить().Выгрузить());
	
КонецПроцедуры

#КонецОбласти