#Область СлужебныеПроцедурыИФункции

&Вместо("ДобавитьСтрокуСвязейНеудаленных")
Процедура рвк_ДобавитьСтрокуСвязейНеудаленных(ТаблицаСвязиНеУдаленных, Причина, ИнформацияОТипах, Реквизиты, УдалятьТехнологическиеОбъекты)

	НомерКартинки = 0;
	Вид = "";
	ОбнаруженныйСтатус = "";

	Если Причина.Метаданные <> Неопределено И Метаданные.Константы.Содержит(Причина.Метаданные) Тогда
		ТипОбъекта = Тип("КонстантаМенеджерЗначения." + Причина.Метаданные.Имя);
	Иначе
		ТипОбъекта = ТипЗнч(Причина.МестоИспользования);
	КонецЕсли;

	СтрокаТаблицы = ТаблицаСвязиНеУдаленных.Добавить();
	СтрокаТаблицы.УдаляемыйСсылка    = Причина.УдаляемыйСсылка;
	СтрокаТаблицы.ЭтоОшибка          = ЗначениеЗаполнено(Причина.ОписаниеОшибки);
	СтрокаТаблицы.ОбнаруженныйСсылка = ?(СтрокаТаблицы.ЭтоОшибка, Причина.ОписаниеОшибки, Причина.МестоИспользования);

	Если СтрокаТаблицы.ЭтоОшибка Или Причина.Метаданные = Неопределено Тогда
		СтрокаТаблицы.Представление = Причина.ПодробноеОписаниеОшибки;
		СтрокаТаблицы.НомерКартинки = 11;
	ИначеЕсли Причина.МестоИспользования = Неопределено Тогда
		СтрокаТаблицы.ОбнаруженныйСсылка = Причина.Метаданные.ПолноеИмя();
		СтрокаТаблицы.ЭтоКонстанта = Истина;
		СтрокаТаблицы.СсылочногоТипа = Ложь;
		СтрокаТаблицы.Представление = ОбщегоНазначения.ПредставлениеОбъекта(Причина.Метаданные) + " (" + НСтр(
			"ru = 'Константа'") + ")";
		Вид = "КОНСТАНТА";
	Иначе
		ИнформацияОТипе = ИнформацияОТипе(ТипОбъекта, ИнформацияОТипах);
		Если ИнформацияОТипе.Вид = "ДОКУМЕНТ" Тогда
			Значения = Реквизиты[Причина.МестоИспользования];
			// +
			Если Значения = Неопределено Тогда
				Возврат;
			КонецЕсли;
			// -
			ОбнаруженныйСтатус = ?(Значения.ПометкаУдаления, "Удален", ?(Значения.Проведен, "Проведен", ""));
		ИначеЕсли ИнформацияОТипе.Ссылочный Тогда
			Значения = Реквизиты[Причина.МестоИспользования];
			// +
			Если Значения = Неопределено Тогда
				Возврат;
			КонецЕсли;
			// -
			ОбнаруженныйСтатус = ?(Значения.ПометкаУдаления, "Удален", "");
		КонецЕсли;

		СтрокаТаблицы.СсылочногоТипа = ИнформацияОТипе.Ссылочный;
		Если ОбщегоНазначения.ЭтоРегистр(Причина.Метаданные) Тогда
			СтрокаТаблицы.Представление = ОбщегоНазначения.ПредставлениеОбъекта(Причина.Метаданные) + " (" + НСтр(
				"ru = 'Регистр'") + ")";
		Иначе
			СтрокаТаблицы.Представление = Строка(Причина.МестоИспользования) + " ("
				+ ИнформацияОТипе.ПредставлениеЭлемента + ")";
		КонецЕсли;
		ИнформацияОбУдаляемом = ИнформацияОТипе(ТипЗнч(Причина.УдаляемыйСсылка), ИнформацияОТипах);
		Если ИнформацияОбУдаляемом.Технический И Не УдалятьТехнологическиеОбъекты Тогда // для оптимизации
			СтрокаТаблицы.ПредставлениеУдаляемый = ИнформацияОбУдаляемом.ПредставлениеЭлемента;
		Иначе
			СтрокаТаблицы.ПредставлениеУдаляемый = Строка(Причина.УдаляемыйСсылка);
		КонецЕсли;

		Вид = ИнформацияОТипе.Вид;
	КонецЕсли;

	НомерКартинки = СтрокаТаблицы.НомерКартинки;
	СтрокаТаблицы.НомерКартинки = ?(НомерКартинки <> 0, НомерКартинки, НомерКартинки(СтрокаТаблицы.ОбнаруженныйСсылка,
		СтрокаТаблицы.СсылочногоТипа, Вид, ОбнаруженныйСтатус));
КонецПроцедуры

#КонецОбласти
