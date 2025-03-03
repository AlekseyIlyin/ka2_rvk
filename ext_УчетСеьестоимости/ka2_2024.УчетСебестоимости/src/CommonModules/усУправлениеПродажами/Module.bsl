
#Область ПрограммныйИнтерфейс

Процедура ДобавитьДвиженияПродажи(Регистратор) Экспорт

	Если Не ЭтоРегистраторПродаж(Регистратор) Тогда
		Возврат;
	КонецЕсли;

	НаборЗаписей = РегистрыНакопления.усПродажи.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Регистратор);

	ТаблицаДвижений = ТаблицаДвижений(Регистратор);
	Если ЗначениеЗаполнено(ТаблицаДвижений) Тогда
		НаборЗаписей.Загрузить(ТаблицаДвижений);
	КонецЕсли;
	
	НаборЗаписей.Записать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЭтоРегистраторПродаж(Регистратор)
	Возврат Регистратор.Метаданные().Движения.Содержит(Метаданные.РегистрыНакопления.усПродажи);
КонецФункции

Функция ТаблицаДвижений(Регистратор)

	НаборЗаписейВыручкаИСебестоимостьПродаж = РегистрыНакопления.ВыручкаИСебестоимостьПродаж.СоздатьНаборЗаписей();
	НаборЗаписейВыручкаИСебестоимостьПродаж.Отбор.Регистратор.Установить(Регистратор);
	НаборЗаписейВыручкаИСебестоимостьПродаж.Прочитать();

	Колонки = "АналитикаУчетаНоменклатуры,АналитикаУчетаПоПартнерам,Количество,СуммаВыручки";

	ТаблицаДвиженийВыручкаИСебестоимостьПродаж = НаборЗаписейВыручкаИСебестоимостьПродаж.Выгрузить(, Колонки);
	
	Если ЗначениеЗаполнено(ТаблицаДвиженийВыручкаИСебестоимостьПродаж) Тогда

		ПерваяСтрока = НаборЗаписейВыручкаИСебестоимостьПродаж[0];
		Период = ПерваяСтрока.Период;
		МоментВремени = Регистратор.МоментВремени();
		
		ТаблицаДвиженийВыручкаИСебестоимостьПродаж.Свернуть("АналитикаУчетаНоменклатуры,АналитикаУчетаПоПартнерам", "Количество,СуммаВыручки");
		ТаблицаДвижений = НоваяТаблицаДвижений(МоментВремени, Период, Регистратор, ТаблицаДвиженийВыручкаИСебестоимостьПродаж);

	КонецЕсли;
	
	Возврат ТаблицаДвижений;

КонецФункции

Функция НоваяТаблицаДвижений(МоментВремени, Период, Регистратор, ТаблицаДвиженийВыручкаИСебестоимостьПродаж)

	ТаблицаДвижений = ТаблицаДвиженийВыручкаИСебестоимостьПродаж.СкопироватьКолонки();
	ТаблицаДвижений.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата",,,,, Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)));
	ТаблицаДвижений.Колонки.Добавить("Партия", Метаданные.ОпределяемыеТипы.ДокументПартии.Тип);
	ТаблицаДвижений.Колонки.Добавить("Маржа", Новый ОписаниеТипов("Число"));
	ТаблицаДвижений.Колонки.Добавить("ИдентификаторСтроки", Новый ОписаниеТипов("Строка",,,, Новый КвалификаторыСтроки(36, ДопустимаяДлина.Переменная)));
	ТаблицаДвижений.Колонки.Добавить("Стоимость", Новый ОписаниеТипов("Число"));

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ВыручкаИСебестоимостьПродаж.АналитикаУчетаНоменклатуры,
		|	ВыручкаИСебестоимостьПродаж.АналитикаУчетаПоПартнерам,
		|	ВыручкаИСебестоимостьПродаж.Количество КАК Количество,
		|	ВыручкаИСебестоимостьПродаж.СуммаВыручки КАК СуммаВыручки
		|ПОМЕСТИТЬ ВТ_ВыручкаИСебестоимостьПродаж
		|ИЗ
		|	&ТЗ_ВыручкаИСебестоимостьПродаж КАК ВыручкаИСебестоимостьПродаж
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	усОстаткиПоПартиям.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
		|	усОстаткиПоПартиям.ИдентификаторСтроки КАК ИдентификаторСтроки,
		|	усОстаткиПоПартиям.Партия,
		|	усОстаткиПоПартиям.Количество,
		|	усОстаткиПоПартиям.Стоимость
		|ПОМЕСТИТЬ ВТ_ОстаткиПоПартиям
		|ИЗ
		|	РегистрНакопления.усОстаткиПоПартиям КАК усОстаткиПоПартиям
		|ГДЕ
		|	усОстаткиПоПартиям.Регистратор = &Регистратор
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ВыручкаИСебестоимостьПродаж.АналитикаУчетаНоменклатуры КАК АналитикаУчетаНоменклатуры,
		|	ВТ_ВыручкаИСебестоимостьПродаж.АналитикаУчетаПоПартнерам,
		|	ВТ_ОстаткиПоПартиям.ИдентификаторСтроки КАК ИдентификаторСтроки,
		|	ВТ_ВыручкаИСебестоимостьПродаж.Количество КАК КоличествоПоВыручке,
		|	ВТ_ВыручкаИСебестоимостьПродаж.СуммаВыручки КАК СуммаВыручки,
		|	ВТ_ОстаткиПоПартиям.Партия,
		|	ВТ_ОстаткиПоПартиям.Количество КАК КоличествоПоПартии,
		|	ВТ_ОстаткиПоПартиям.Стоимость КАК СтоимостьПоПартии
		|ИЗ
		|	ВТ_ВыручкаИСебестоимостьПродаж КАК ВТ_ВыручкаИСебестоимостьПродаж
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_ОстаткиПоПартиям КАК ВТ_ОстаткиПоПартиям
		|		ПО ВТ_ОстаткиПоПартиям.АналитикаУчетаНоменклатуры = ВТ_ВыручкаИСебестоимостьПродаж.АналитикаУчетаНоменклатуры
		|ИТОГИ
		|	МАКСИМУМ(КоличествоПоВыручке) КАК КоличествоПоВыручке,
		|	МАКСИМУМ(СуммаВыручки) КАК СуммаВыручки
		|ПО
		|	АналитикаУчетаНоменклатуры";
	
	Запрос.УстановитьПараметр("ТЗ_ВыручкаИСебестоимостьПродаж", ТаблицаДвиженийВыручкаИСебестоимостьПродаж);
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаАналитикаУчетаНоменклатуры = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаАналитикаУчетаНоменклатуры.Следующий() Цикл

		ОстатокКоличествоПродаж = ВыборкаАналитикаУчетаНоменклатуры.КоличествоПоВыручке;
		ОстатокСуммаПродаж = ВыборкаАналитикаУчетаНоменклатуры.СуммаВыручки;
		
		ВыборкаПартии = ВыборкаАналитикаУчетаНоменклатуры.Выбрать();
		Пока ОстатокСуммаПродаж <> 0 И ВыборкаПартии.Следующий() Цикл
			
			КоличествоСписания = Мин(ОстатокКоличествоПродаж, ВыборкаПартии.КоличествоПоПартии);
			
			СтоимостьСписания = ?(КоличествоСписания = ВыборкаПартии.КоличествоПоПартии,
				ВыборкаПартии.СтоимостьПоПартии,
				ВыборкаПартии.СтоимостьПоПартии / ВыборкаПартии.КоличествоПоПартии * КоличествоСписания);
				
			СуммаПродажСписание = ?(КоличествоСписания = ОстатокКоличествоПродаж,
				ОстатокСуммаПродаж,
				ОстатокСуммаПродаж / ОстатокКоличествоПродаж * КоличествоСписания);
				
			Маржа = СуммаПродажСписание - СтоимостьСписания;
			
			НоваяСтрокаПродаж = ТаблицаДвижений.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрокаПродаж, ВыборкаПартии, "АналитикаУчетаНоменклатуры,АналитикаУчетаПоПартнерам,ИдентификаторСтроки,Партия");
			НоваяСтрокаПродаж.Количество = КоличествоСписания;
			НоваяСтрокаПродаж.Стоимость = СтоимостьСписания;
			НоваяСтрокаПродаж.СуммаВыручки = СуммаПродажСписание;
			НоваяСтрокаПродаж.Маржа = Маржа;
			НоваяСтрокаПродаж.Период = Период;
			
			ОстатокКоличествоПродаж = ОстатокКоличествоПродаж - КоличествоСписания;
			ОстатокСуммаПродаж = ОстатокСуммаПродаж - СуммаПродажСписание;
		КонецЦикла;
		
	КонецЦикла;

	Возврат ТаблицаДвижений;
	
КонецФункции

#КонецОбласти

