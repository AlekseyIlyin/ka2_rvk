
#Область ПрограммныйИнтерфейс

//Вызывается при начальном заполнении справочника.
//
// Параметры:
//  КодыЯзыков - Массив - список языков конфигурации. Актуально для мультиязычных конфигураций.
//  Элементы   - ТаблицаЗначений - данные заполнения. Состав колонок соответствует набору реквизитов справочника.
//  ТабличныеЧасти - Структура - Ключ - Имя табличной части объекта.
//                               Значение - Выгрузка в таблицу значений пустой табличной части.
//
Процедура ПриНачальномЗаполненииЭлементов(КодыЯзыков, Элементы, ТабличныеЧасти) Экспорт

	//++ Локализация
	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ЕдиныйНалоговыйПлатеж";
	Элемент.ИдентификаторЭлемента = "ЕдиныйНалоговыйПлатеж";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ЕНВД";
	Элемент.ИдентификаторЭлемента = "ЕНВД";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ЕСХН";
	Элемент.ИдентификаторЭлемента = "ЕСХН";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ЗемельныйНалог";
	Элемент.ИдентификаторЭлемента = "ЗемельныйНалог";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НалогНаИмущество";
	Элемент.ИдентификаторЭлемента = "НалогНаИмущество";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НалогНаПрибыль_РегиональныйБюджет";
	Элемент.ИдентификаторЭлемента = "НалогНаПрибыль_РегиональныйБюджет";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НалогНаПрибыль_ФедеральныйБюджет";
	Элемент.ИдентификаторЭлемента = "НалогНаПрибыль_ФедеральныйБюджет";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НалогНаПрибыль_НалоговыйАгент";
	Элемент.ИдентификаторЭлемента = "НалогНаПрибыль_НалоговыйАгент";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДС";
	Элемент.ИдентификаторЭлемента = "НДС";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДС_ВвозимыеТовары";
	Элемент.ИдентификаторЭлемента = "НДС_ВвозимыеТовары";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДС_НалоговыйАгент";
	Элемент.ИдентификаторЭлемента = "НДС_НалоговыйАгент";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛ";
	Элемент.ИдентификаторЭлемента = "НДФЛ";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛ_ИП";
	Элемент.ИдентификаторЭлемента = "НДФЛ_ИП";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПрочиеНалогиИСборы";
	Элемент.ИдентификаторЭлемента = "ПрочиеНалогиИСборы";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ТорговыйСбор";
	Элемент.ИдентификаторЭлемента = "ТорговыйСбор";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ТранспортныйНалог";
	Элемент.ИдентификаторЭлемента = "ТранспортныйНалог";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "УСН_Доходы";
	Элемент.ИдентификаторЭлемента = "УСН_Доходы";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "УСН_ДоходыМинусРасходы";
	Элемент.ИдентификаторЭлемента = "УСН_ДоходыМинусРасходы";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "УСН_МинимальныйНалог";
	Элемент.ИдентификаторЭлемента = "УСН_МинимальныйНалог";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПФРПоСуммарномуТарифу";
	Элемент.ИдентификаторЭлемента = "ПФРПоСуммарномуТарифу";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПФРСтраховаяЧасть";
	Элемент.ИдентификаторЭлемента = "ПФРСтраховаяЧасть";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПФРНакопительнаяЧасть";
	Элемент.ИдентификаторЭлемента = "ПФРНакопительнаяЧасть";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПФРДополнительныйТарифЛЭ";
	Элемент.ИдентификаторЭлемента = "ПФРДополнительныйТарифЛЭ";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПФРДополнительныйТарифШахтеры";
	Элемент.ИдентификаторЭлемента = "ПФРДополнительныйТарифШахтеры";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПФРЗаЗанятыхНаПодземныхИВредныхРаботах";
	Элемент.ИдентификаторЭлемента = "ПФРЗаЗанятыхНаПодземныхИВредныхРаботах";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПФРЗаЗанятыхНаТяжелыхИПрочихРаботах";
	Элемент.ИдентификаторЭлемента = "ПФРЗаЗанятыхНаТяжелыхИПрочихРаботах";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПФРСПревышения";
	Элемент.ИдентификаторЭлемента = "ПФРСПревышения";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ФФОМС";
	Элемент.ИдентификаторЭлемента = "ФФОМС";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ТФОМС";
	Элемент.ИдентификаторЭлемента = "ТФОМС";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ФСС";
	Элемент.ИдентификаторЭлемента = "ФСС";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ФССНС";
	Элемент.ИдентификаторЭлемента = "ФССНС";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛДоходыКонтрагентов";
	Элемент.ИдентификаторЭлемента = "НДФЛДоходыКонтрагентов";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛДивиденды";
	Элемент.ИдентификаторЭлемента = "НДФЛДивиденды";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛДивидендыСотрудникам";
	Элемент.ИдентификаторЭлемента = "НДФЛДивидендыСотрудникам";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛДоначисленныйПоРезультатамПроверки";
	Элемент.ИдентификаторЭлемента = "НДФЛДоначисленныйПоРезультатамПроверки";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛПередачаЗадолженностиВНалоговыйОрган";
	Элемент.ИдентификаторЭлемента = "НДФЛПередачаЗадолженностиВНалоговыйОрган";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛПрочиеРасчетыСПерсоналом";
	Элемент.ИдентификаторЭлемента = "НДФЛПрочиеРасчетыСПерсоналом";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛСПревышения";
	Элемент.ИдентификаторЭлемента = "НДФЛСПревышения";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДФЛДивидендыСПревышения";
	Элемент.ИдентификаторЭлемента = "НДФЛДивидендыСПревышения";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ПФРДоПредельнойВеличины";
	Элемент.ИдентификаторЭлемента = "ПФРДоПредельнойВеличины";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "НДС_ОбратноеОбложение";
	Элемент.ИдентификаторЭлемента = "НДС_ОбратноеОбложение";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "АУСН";
	Элемент.ИдентификаторЭлемента = "АУСН";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "СтраховыеВзносыЕдиныйТариф";
	Элемент.ИдентификаторЭлемента = "СтраховыеВзносыЕдиныйТариф";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ОПСИностранныхРаботников";
	Элемент.ИдентификаторЭлемента = "ОПСИностранныхРаботников";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ОМСИностранныхРаботников";
	Элемент.ИдентификаторЭлемента = "ОМСИностранныхРаботников";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ОССИностранныхРаботников";
	Элемент.ИдентификаторЭлемента = "ОССИностранныхРаботников";
	МультиязычностьСервер.ЗаполнитьМультиязычныйРеквизит(Элемент, "Наименование", 
		Справочники.ВидыНалоговВзносов.НаименованиеПредопределенногоЭлемента(Элемент.ИмяПредопределенныхДанных), КодыЯзыков);
	//-- Локализация
	

КонецПроцедуры

#КонецОбласти
