#Область ОперацииНДС0

Функция СписокОфшоров(Знач ДатаЗапроса) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ДатаЗапроса) Тогда
		
		ДатаЗапроса = ТекущаяДатаСеанса();
		
	КонецЕсли;
	
	МакетОфшоров = ПолучитьОбщийМакет("ПереченьОфшоров");
	КлассификаторXML = МакетОфшоров.ПолучитьТекст();
	
	Чтение = Новый ЧтениеXML;
	Чтение.УстановитьСтроку(КлассификаторXML);
	ТаблицаОфшоров = СериализаторXDTO.ПрочитатьXML(Чтение); // ТаблицаЗначений
	
	Запрос = Новый Запрос();
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.Параметры.Вставить("ТаблицаОфшоров", ТаблицаОфшоров);
	Запрос.Параметры.Вставить("ДатаЗапроса", ДатаЗапроса);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаОфшоров.Код КАК Код,
	|	ТаблицаОфшоров.ДатаНачала КАК ДатаНачала,
	|	ТаблицаОфшоров.ДатаОкончания КАК ДатаОкончания
	|ПОМЕСТИТЬ Офшоры
	|ИЗ
	|	&ТаблицаОфшоров КАК ТаблицаОфшоров
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Код,
	|	ДатаОкончания,
	|	ДатаНачала
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СтраныМира.Ссылка КАК СтранаРегистрации
	|ИЗ
	|	Справочник.СтраныМира КАК СтраныМира
	|		ЛЕВОЕ СОЕДИНЕНИЕ Офшоры КАК Офшоры
	|		ПО СтраныМира.Код = Офшоры.Код
	|ГДЕ
	|	(Офшоры.ДатаОкончания = ДАТАВРЕМЯ(1, 1, 1)
	|				И Офшоры.ДатаНачала <= &ДатаЗапроса
	|			ИЛИ &ДатаЗапроса МЕЖДУ Офшоры.ДатаНачала И Офшоры.ДатаОкончания)
	|	И СтраныМира.ПометкаУдаления = ЛОЖЬ
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ Офшоры";
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("СтранаРегистрации");
	
КонецФункции

Функция ЯвляетсяОфшором(Знач ДатаЗапроса, Страна) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ДатаЗапроса) Тогда
		ДатаЗапроса = ТекущаяДатаСеанса();
	КонецЕсли;
	
	МакетОфшоров = ПолучитьОбщийМакет("ПереченьОфшоров");
	КлассификаторXML = МакетОфшоров.ПолучитьТекст();
	
	Чтение = Новый ЧтениеXML;
	Чтение.УстановитьСтроку(КлассификаторXML);
	ТаблицаОфшоров = СериализаторXDTO.ПрочитатьXML(Чтение); // ТаблицаЗначений
	
	Запрос = Новый Запрос();
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.Параметры.Вставить("ТаблицаОфшоров", ТаблицаОфшоров);
	Запрос.Параметры.Вставить("ДатаЗапроса", ДатаЗапроса);
	Запрос.Параметры.Вставить("Страна", Страна);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаОфшоров.Код КАК Код,
	|	ТаблицаОфшоров.ДатаНачала КАК ДатаНачала,
	|	ТаблицаОфшоров.ДатаОкончания КАК ДатаОкончания
	|ПОМЕСТИТЬ Офшоры
	|ИЗ
	|	&ТаблицаОфшоров КАК ТаблицаОфшоров
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Код,
	|	ДатаОкончания,
	|	ДатаНачала
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СтраныМира.Ссылка КАК СтранаРегистрации
	|ИЗ
	|	Справочник.СтраныМира КАК СтраныМира
	|		ЛЕВОЕ СОЕДИНЕНИЕ Офшоры КАК Офшоры
	|		ПО СтраныМира.Код = Офшоры.Код
	|ГДЕ
	|	(Офшоры.ДатаОкончания = ДАТАВРЕМЯ(1, 1, 1)
	|				И Офшоры.ДатаНачала <= &ДатаЗапроса
	|			ИЛИ &ДатаЗапроса МЕЖДУ Офшоры.ДатаНачала И Офшоры.ДатаОкончания)
	|	И СтраныМира.Ссылка = &Страна
	|	И СтраныМира.ПометкаУдаления = ЛОЖЬ
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ Офшоры";
	
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции

#КонецОбласти

#Область КонтролируемыеСделки

// Получение таблицы значений офшоров за заданный период
// Если страна хотя бы один день была офшором в этот период, то она попадет в результат
//
// Параметры:
//  ДатаНачалаПериода - Дата - дата начала периода проверки действия офшорных территорий
//  ДатаКонцаПериода - Дата - дата конца периода проверки действия офшорных территорий
//
// Возвращаемое значение:
//  - ТаблицаЗначений
//		- Колонки:
//			СтранаРегистрации - СправочникСсылка.СтраныМира
//			ДатаНачалаДействияОфшора - Дата
//			ДатаОкончанияДействияОфшора - Дата
Функция ТаблицаОфшоровЗаПериод(Знач ДатаНачалаПериода, Знач ДатаКонцаПериода) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ДатаНачалаПериода) Тогда
		
		ДатаНачалаПериода = ТекущаяДатаСеанса();
		
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ДатаКонцаПериода) Тогда
		
		ДатаКонцаПериода = ТекущаяДатаСеанса();
		
	КонецЕсли;

	Если ДатаКонцаПериода < ДатаНачалаПериода Тогда
		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Невозможно получить таблицу офшоров. Дата начала периода должна быть меньше даты конца периода.";
		Сообщение.Сообщить();
		Возврат Неопределено;
		
	КонецЕсли;
	
	МакетОфшоров = ПолучитьОбщийМакет("ПереченьОфшоров");
	КлассификаторXML = МакетОфшоров.ПолучитьТекст();
	
	Чтение = Новый ЧтениеXML;
	Чтение.УстановитьСтроку(КлассификаторXML);
	ТаблицаОфшоров = СериализаторXDTO.ПрочитатьXML(Чтение); // ТаблицаЗначений
	
	Запрос = Новый Запрос();
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц; 
	
	Запрос.Параметры.Вставить("ТаблицаОфшоров", ТаблицаОфшоров);
	Запрос.Параметры.Вставить("ДатаНачалаПериода", ДатаНачалаПериода);
	Запрос.Параметры.Вставить("ДатаКонцаПериода", ДатаКонцаПериода);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаОфшоров.Код КАК Код,
	|	ТаблицаОфшоров.ДатаНачала КАК ДатаНачала,
	|	ТаблицаОфшоров.ДатаОкончания КАК ДатаОкончания
	|ПОМЕСТИТЬ Офшоры
	|ИЗ
	|	&ТаблицаОфшоров КАК ТаблицаОфшоров
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Код,
	|	ДатаОкончания,
	|	ДатаНачала
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СтраныМира.Ссылка КАК СтранаРегистрации,
	|	Офшоры.ДатаНачала КАК ДатаНачалаДействияОфшора,
	|	Офшоры.ДатаОкончания КАК ДатаОкончанияДействияОфшора
	|ИЗ
	|	Справочник.СтраныМира КАК СтраныМира
	|		ЛЕВОЕ СОЕДИНЕНИЕ Офшоры КАК Офшоры
	|		ПО СтраныМира.Код = Офшоры.Код
	|ГДЕ
	|	(Офшоры.ДатаОкончания = ДАТАВРЕМЯ(1, 1, 1)
	|				И Офшоры.ДатаНачала <= &ДатаКонцаПериода
	|			ИЛИ Офшоры.ДатаОкончания МЕЖДУ &ДатаНачалаПериода И &ДатаКонцаПериода)
	|	И СтраныМира.ПометкаУдаления = ЛОЖЬ
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ Офшоры";
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

#КонецОбласти