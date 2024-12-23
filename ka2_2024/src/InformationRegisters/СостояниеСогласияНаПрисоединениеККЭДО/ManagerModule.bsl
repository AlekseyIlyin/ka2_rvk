#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Устанавливает состояние согласия на присоединение к КЭДО и факт наличия подписи.
//	Параметры:
//		Ссылка - ДокументСсылка.СогласиеНаПрисоединениеККЭДО - документ для которого изменяется состояние;
//		Состояние - ПеречислениеСсылка.СостоянияСогласийНаПрисоединениеККЭДО - устанавливаемое состояние;
//		Подтвержден - Булево - факт наличия подписанного документа (по умолчанию Ложь).
Процедура УстановитьСостояние(Ссылка, Состояние, Подтвержден = Ложь) Экспорт
	МенеджерЗаписи = РегистрыСведений.СостояниеСогласияНаПрисоединениеККЭДО.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Ссылка = Ссылка;
	МенеджерЗаписи.Прочитать();
	МенеджерЗаписи.Ссылка = Ссылка;
	МенеджерЗаписи.Состояние = Состояние;
	МенеджерЗаписи.Подтвержден = Подтвержден;
	МенеджерЗаписи.Записать(Истина);
КонецПроцедуры

// Устанавливает дату окончания действия согласия.
//	Параметры:
//		Ссылка - ДокументСсылка.СогласиеНаПрисоединениеККЭДО - документ прекращающий свое действие;
//		Дата - Дата - дата окончания действия согласия.
Процедура УстановитьДатуПрекращенияДействия(Ссылка, Дата) Экспорт
	МенеджерЗаписи = РегистрыСведений.СостояниеСогласияНаПрисоединениеККЭДО.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Ссылка = Ссылка;
	МенеджерЗаписи.Прочитать();
	МенеджерЗаписи.Ссылка = Ссылка;
	МенеджерЗаписи.ДатаОкончания = Дата;
	МенеджерЗаписи.Записать(Истина);
КонецПроцедуры

// Устанавливает дату начала действия согласия.
//	Параметры:
//      Ссылка - ДокументСсылка.СогласиеНаПрисоединениеККЭДО - документ для которого указывается дата начала; 
//		Дата - Дата - дата начала действия согласия.
Процедура УстановитьДатуНачалаДействия(Ссылка, Дата) Экспорт
	МенеджерЗаписи = РегистрыСведений.СостояниеСогласияНаПрисоединениеККЭДО.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Ссылка = Ссылка;
	МенеджерЗаписи.Прочитать();
	МенеджерЗаписи.Ссылка = Ссылка;
	МенеджерЗаписи.ДатаНачала = Дата;
	МенеджерЗаписи.Записать(Истина);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьДатыНачалаИОкончанияСогласийНаПрисоединениеККЭДООбновление(ПараметрыОбновления = Неопределено) Экспорт
	
	Если Не ПолучитьФункциональнуюОпцию("ВедетсяУчетСогласийНаПрисоединениеККЭДО") Тогда
		ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.УстановитьПараметрОбновления(ПараметрыОбновления, "ОбработкаЗавершена", Истина);
		Возврат;	
	КонецЕсли;
	
	Запрос = Новый Запрос();
	Запрос.Текст = "ВЫБРАТЬ
	               |	СогласиеНаПрисоединениеККЭДО.Ссылка КАК Ссылка,
	               |	СогласиеНаПрисоединениеККЭДО.Организация КАК Организация,
	               |	СогласиеНаПрисоединениеККЭДО.ФизическоеЛицо КАК ФизическоеЛицо,
	               |	СогласиеНаПрисоединениеККЭДО.Дата КАК Дата
	               |ПОМЕСТИТЬ ВТСогласия
	               |ИЗ
	               |	Документ.СогласиеНаПрисоединениеККЭДО КАК СогласиеНаПрисоединениеККЭДО
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СостояниеСогласияНаПрисоединениеККЭДО КАК СостояниеСогласияНаПрисоединениеККЭДО
	               |		ПО (СостояниеСогласияНаПрисоединениеККЭДО.Ссылка = СогласиеНаПрисоединениеККЭДО.Ссылка)
	               |ГДЕ
	               |	(СостояниеСогласияНаПрисоединениеККЭДО.ДатаНачала = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
	               |			ИЛИ СостояниеСогласияНаПрисоединениеККЭДО.ДатаНачала ЕСТЬ NULL)
	               |	И (СостояниеСогласияНаПрисоединениеККЭДО.ДатаОкончания = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
	               |			ИЛИ СостояниеСогласияНаПрисоединениеККЭДО.ДатаОкончания ЕСТЬ NULL)
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ВТСогласия.Ссылка КАК Ссылка,
	               |	ВТСогласия.Дата КАК Дата,
	               |	ТекущиеКадровыеДанныеСотрудников.ДатаУвольнения КАК ДатаУвольнения
	               |ИЗ
	               |	ВТСогласия КАК ВТСогласия
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ТекущиеКадровыеДанныеСотрудников КАК ТекущиеКадровыеДанныеСотрудников
	               |		ПО ВТСогласия.Организация = ТекущиеКадровыеДанныеСотрудников.ГоловнаяОрганизация
	               |			И ВТСогласия.ФизическоеЛицо = ТекущиеКадровыеДанныеСотрудников.ФизическоеЛицо";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.УстановитьПараметрОбновления(ПараметрыОбновления, "ОбработкаЗавершена", Истина);
		Возврат;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	ОбработкаЗавершена = Истина;
	Пока Выборка.Следующий() Цикл
		
		Если Не ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ПодготовитьОбновлениеДанных(ПараметрыОбновления,
																							 "Документ.СогласиеНаПрисоединениеККЭДО",
																							 "Ссылка",
																							 Выборка.Ссылка) Тогда
			ОбработкаЗавершена = Ложь;
			Продолжить;
		КонецЕсли;
		
		НаборЗаписей = РегистрыСведений.СостояниеСогласияНаПрисоединениеККЭДО.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Ссылка.Установить(Выборка.Ссылка);
		НаборЗаписей.Прочитать();
		
		Запись = Неопределено;
		Если НаборЗаписей.Количество() = 0 Тогда
			Запись = НаборЗаписей.Добавить();
			Запись.Ссылка = Выборка.Ссылка;
		Иначе
			Запись = НаборЗаписей[0];
		КонецЕсли;
		Запись.ДатаНачала = Выборка.Дата;
		Если ЗначениеЗаполнено(Выборка.ДатаУвольнения) И Выборка.ДатаУвольнения > Выборка.Дата Тогда
			Запись.ДатаОкончания = Выборка.ДатаУвольнения;
		КонецЕсли;
		
		ОбновлениеИнформационнойБазы.ЗаписатьНаборЗаписей(НаборЗаписей, Истина);
		ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ЗавершитьОбновлениеДанных(ПараметрыОбновления);
		
	КонецЦикла;
	
	ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.УстановитьПараметрОбновления(ПараметрыОбновления, "ОбработкаЗавершена", ОбработкаЗавершена);
	
КонецПроцедуры

#Область КадровыеДанныеСотрудников

Функция ДобавитьПолеСведенийОСогласияхПодключенийККЭДО(ИмяПоля, ТекстыОписанияПолей, ИсточникиДанных) Экспорт
	
	ДобавленоПолеСведений = Ложь;
	Если НеобходимыДанныеОСогласияхПодключенийККЭДО(ИмяПоля) Тогда
		
		ДобавленоПолеСведений = Истина;
		ИсточникиДанных.Вставить("СостояниеСогласияНаПрисоединениеККЭДО", Истина);
		
		ПутьКДанным = ПутьКДаннымСведенийОСогласияхПодключенийККЭДО(ИмяПоля);
		ТекстыОписанияПолей.Добавить(ПутьКДанным + " КАК " + ИмяПоля);
		
	КонецЕсли;
	
	Возврат ДобавленоПолеСведений;
	
КонецФункции

Функция НеобходимыДанныеОСогласияхПодключенийККЭДО(ИмяПоля) Экспорт
	
	ИмяПоля = ВРег(ИмяПоля);
	Возврат ИмяПоля = ВРег("СогласиеНаПрисоединениеККЭДО")
		Или ИмяПоля = ВРег("СогласиеНаПрисоединениеККЭДОСостояние")
		Или ИмяПоля = ВРег("СогласиеНаПрисоединениеККЭДОПодтвержден")
		Или ИмяПоля = ВРег("СогласиеНаПрисоединениеККЭДОДатаНачала")
		Или ИмяПоля = ВРег("СогласиеНаПрисоединениеККЭДОДатаОкончания");
	
КонецФункции

Функция ПутьКДаннымСведенийОСогласияхПодключенийККЭДО(ИмяПоля)
	
	ИмяПоляВВерхнемРегистре = ВРег(ИмяПоля);
	ПутьКДанным = "";
	
	Если ИмяПоляВВерхнемРегистре = ВРег("СогласиеНаПрисоединениеККЭДО") Тогда
		ПутьКДанным = "	СостояниеСогласияНаПрисоединениеККЭДО.Ссылка";
	ИначеЕсли ИмяПоляВВерхнемРегистре = ВРег("СогласиеНаПрисоединениеККЭДОСостояние") Тогда
		ПутьКДанным = "	СостояниеСогласияНаПрисоединениеККЭДО.Состояние";
	ИначеЕсли ИмяПоляВВерхнемРегистре = ВРег("СогласиеНаПрисоединениеККЭДОПодтвержден") Тогда
		ПутьКДанным = "	СостояниеСогласияНаПрисоединениеККЭДО.Подтвержден";
	ИначеЕсли ИмяПоляВВерхнемРегистре = ВРег("СогласиеНаПрисоединениеККЭДОДатаНачала") Тогда
		ПутьКДанным = "	СостояниеСогласияНаПрисоединениеККЭДО.ДатаНачала";
	ИначеЕсли ИмяПоляВВерхнемРегистре = ВРег("СогласиеНаПрисоединениеККЭДОДатаОкончания") Тогда
		ПутьКДанным = "	СостояниеСогласияНаПрисоединениеККЭДО.ДатаОкончания";
	КонецЕсли;
	
	Возврат ПутьКДанным;
	
КонецФункции

Процедура ДобавитьТекстЗапросаВТСведенияОСогласияхПодключенийККЭДО(Запрос, ТолькоРазрешенные, ОписательВременнойТаблицыОтборов, ИсточникиДанных) Экспорт
	
	Если ИсточникиДанных.Получить("СостояниеСогласияНаПрисоединениеККЭДО") = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЧастиЗапроса = Новый Массив;
	ЧастиЗапроса.Добавить(Запрос.Текст);
	ЧастиЗапроса.Добавить(
		"	{ЛЕВОЕ СОЕДИНЕНИЕ Документ.СогласиеНаПрисоединениеККЭДО Как СогласиеНаПрисоединениеККЭДО
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СостояниеСогласияНаПрисоединениеККЭДО КАК СостояниеСогласияНаПрисоединениеККЭДО
		|			ПО СогласиеНаПрисоединениеККЭДО.Ссылка = СостояниеСогласияНаПрисоединениеККЭДО.Ссылка
		|		ПО Не СогласиеНаПрисоединениеККЭДО.ПометкаУдаления
		|			И ТаблицаОтборов." + ОписательВременнойТаблицыОтборов.ИмяПоляСотрудник + ".ФизическоеЛицо = СогласиеНаПрисоединениеККЭДО.ФизическоеЛицо
		|			И ТаблицаОтборов." + ОписательВременнойТаблицыОтборов.ИмяПоляСотрудник + ".ГоловнаяОрганизация = СогласиеНаПрисоединениеККЭДО.Организация
		|			И ТаблицаОтборов." + ОписательВременнойТаблицыОтборов.ИмяПоляПериод + " МЕЖДУ СостояниеСогласияНаПрисоединениеККЭДО.ДатаНачала
		|			И ВЫБОР
		|				КОГДА СостояниеСогласияНаПрисоединениеККЭДО.ДатаОкончания = ДАТАВРЕМЯ(1, 1, 1)
		|					ТОГДА ДАТАВРЕМЯ(3999, 12, 31, 23, 59, 59)
		|				ИНАЧЕ СостояниеСогласияНаПрисоединениеККЭДО.ДатаОкончания
		|			КОНЕЦ}");
	
	Запрос.Текст = СтрСоединить(ЧастиЗапроса, Символы.ПС);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
