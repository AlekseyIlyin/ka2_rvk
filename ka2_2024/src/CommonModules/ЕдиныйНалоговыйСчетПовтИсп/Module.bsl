#Область СлужебныйПрограммныйИнтерфейс

Функция ОбслуживаемыеСчетаУчета(Период) Экспорт
	
	МассивСчетов = Новый Массив;
	МассивСчетов.Добавить(ПланыСчетов.Хозрасчетный.РасчетыПоНалогам);
	МассивСчетов.Добавить(ПланыСчетов.Хозрасчетный.РасчетыПоСоциальномуСтрахованию);
	
	СчетаПоОтбору = БухгалтерскийУчет.СформироватьМассивСубсчетов(МассивСчетов);
	
	СчетаИсключения = Новый Массив;
	СчетаИсключения.Добавить(ПланыСчетов.Хозрасчетный.ФСС_НСиПЗ);
	СчетаИсключения.Добавить(ПланыСчетов.Хозрасчетный.ФСС_СтраховойГод);
	
	Для Каждого СчетИсключения Из СчетаИсключения Цикл
		ИндексЗаписи = СчетаПоОтбору.Найти(СчетИсключения);
		Если ИндексЗаписи <> Неопределено Тогда
			СчетаПоОтбору.Удалить(ИндексЗаписи);
		КонецЕсли;
	КонецЦикла;
	
	Возврат СчетаПоОтбору;
	
КонецФункции

Функция ВидыНалоговУплачиваемыеОтдельно() Экспорт
	
	МассивВидовНалогов = Новый Массив;
	МассивВидовНалогов.Добавить(Перечисления.ВидыНалогов.ЕдиныйНалоговыйПлатеж);
	МассивВидовНалогов.Добавить(Перечисления.ВидыНалогов.СтраховыеВзносы_ФСС_НСиПЗ);
	МассивВидовНалогов.Добавить(Перечисления.ВидыНалогов.ФиксированныеВзносы_ФСС);
	МассивВидовНалогов.Добавить(Перечисления.ВидыНалогов.СтраховыеВзносы_ПФР_Добровольные);
	МассивВидовНалогов.Добавить(Перечисления.ВидыНалогов.ФиксированныеВзносы_ПФР_Добровольные);
	МассивВидовНалогов.Добавить(Перечисления.ВидыНалогов.НалогНаПрофессиональныйДоход);
	
	Возврат МассивВидовНалогов
	
КонецФункции

Функция МассивДоступныхВидовНалогов() Экспорт
	
	МассивВидовНалогов = Новый Массив;
	МассивВидовНалогов.Добавить(Перечисления.ВидыНалогов.ПустаяСсылка());
	МассивВидовНалогов.Добавить(Перечисления.ВидыНалогов.ПрочиеНалогиИСборы);
	МассивВидовНалогов.Добавить(Перечисления.ВидыНалогов.Госпошлина_ГосрегистрацияОрганизаций);
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивВидовНалогов, ВидыНалоговУплачиваемыеОтдельно());
	
	Возврат МассивВидовНалогов
	
КонецФункции

Функция НалогиУплачиваемыеПоквартально() Экспорт
	
	МассивВидовНалогов = Новый Массив;
	
	// УСН
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.УСН_Доходы);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.УСН_ДоходыМинусРасходы);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.УСН_МинимальныйНалог);
	
	// ЕСХН
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ЕСХН);
	
	// Прибыль
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НалогНаПрибыль_РегиональныйБюджет);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НалогНаПрибыль_ФедеральныйБюджет);
	
	// Имущественные налоги
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивВидовНалогов, ВидыНалоговНаИмущество());
	
	// НДФЛ ИП
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивВидовНалогов, ВидыНалоговНДФЛПредпринимателя());
	
	Возврат Новый ФиксированныйМассив(МассивВидовНалогов);
	
КонецФункции

Функция НалогиУплачиваемыеЕжемесячно() Экспорт
	
	МассивВидовНалогов = Новый Массив;
	
	// Прибыль агента
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НалогНаПрибыль_НалоговыйАгент);
	
	// Страховые взносы
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ПФРНакопительнаяЧасть);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ПФРСтраховаяЧасть);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ФФОМС);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.СтраховыеВзносыЕдиныйТариф);
	
	// Иностранцы
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ОПСИностранныхРаботников);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ОМСИностранныхРаботников);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ОССИностранныхРаботников);
	
	// НДФЛ агента
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивВидовНалогов, ВидыНалоговНДФЛНалоговогоАгента());
	
	Возврат Новый ФиксированныйМассив(МассивВидовНалогов);
	
КонецФункции

Функция ВсеВидыНалоговНДФЛ() Экспорт
	
	МассивВидовНалогов = Новый Массив;
	
	// Дополним НДФЛ агента
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивВидовНалогов, ВидыНалоговНДФЛНалоговогоАгента());
	
	// Дополним НДФЛ предпринимателя
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(МассивВидовНалогов, ВидыНалоговНДФЛПредпринимателя());
	
	// Вернем весь НДФЛ
	Возврат Новый ФиксированныйМассив(МассивВидовНалогов);
	
КонецФункции

Функция ВидыНалоговНДФЛНалоговогоАгента() Экспорт
	
	МассивВидовНалогов = Новый Массив;
	
	// НДФЛ налогового агента
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛ);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛДивиденды);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛДивидендыСотрудникам);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛДоначисленныйПоРезультатамПроверки);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛДоходыКонтрагентов);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛПередачаЗадолженностиВНалоговыйОрган);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛПрочиеРасчетыСПерсоналом);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛСПревышения);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛДивидендыСПревышения);
	
	Возврат Новый ФиксированныйМассив(МассивВидовНалогов);
	
КонецФункции

Функция ВидыНалоговНДФЛПредпринимателя() Экспорт
	
	МассивВидовНалогов = Новый Массив;
	
	// НДФЛ предпринимателя
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НДФЛ_ИП);
	
	Возврат Новый ФиксированныйМассив(МассивВидовНалогов);
	
КонецФункции

Функция ВидыНалоговНаИмущество() Экспорт
	
	МассивВидовНалогов = Новый Массив;
	
	// Имущество
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.НалогНаИмущество);
	
	// Транспорт
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ТранспортныйНалог);
	
	// Земля
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ЗемельныйНалог);
	
	Возврат Новый ФиксированныйМассив(МассивВидовНалогов);
	
КонецФункции

Функция ВидыНалоговСтраховыеВзносы() Экспорт
	
	МассивВидовНалогов = Новый Массив;
	
	// ПФР - кроме добровольных
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ПФРСтраховаяЧасть);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ПФРНакопительнаяЧасть);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ПФРДополнительныйТарифЛЭ);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ПФРДополнительныйТарифШахтеры);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ПФРЗаЗанятыхНаПодземныхИВредныхРаботах);
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ПФРЗаЗанятыхНаТяжелыхИПрочихРаботах);
	
	// ФСС - кроме НС и ПЗ и фиксированных взносов
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ФСС);
	
	// ФФОМС
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.ФФОМС);
	
	// Единый тариф
	МассивВидовНалогов.Добавить(Справочники.ВидыНалоговВзносов.СтраховыеВзносыЕдиныйТариф);
	
	Возврат Новый ФиксированныйМассив(МассивВидовНалогов);
	
КонецФункции

#КонецОбласти
