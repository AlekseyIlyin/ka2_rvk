///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.МножественныйВыборЗапрещен Тогда
		Элементы.СписокВалют.МножественныйВыбор = Ложь;
	КонецЕсли;
	
	ЗакрыватьПриВыборе = Ложь;
	ЗаполнитьТаблицуВалют();
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		Элементы.Загружается.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Авто;
		Элементы.СтраныИТерритории.Заголовок = НСтр("ru = 'Страны'");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписокВалют

&НаКлиенте
Процедура СписокВалютВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОбработатьВыборВСпискеВалют(СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьВыполнить()
	
	ОбработатьВыборВСпискеВалют();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ТекстВБулево(СтроковоеЗначение)
	
	Если ПустаяСтрока(СтроковоеЗначение) ИЛИ СтроковоеЗначение = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат СокрЛП(СтроковоеЗначение) = "истина";
	
КонецФункции

&НаСервере
Процедура ЗаполнитьТаблицуВалют()

	ТабличныйДокумент = Обработки.МеждународныйКлассификаторВалют.ПолучитьМакет("МеждународныйКлассификаторВалют");
	
	Для СчСтр = 2 По ТабличныйДокумент.ВысотаТаблицы Цикл

		НоваяСтрока = Валюты.Добавить();
		НоваяСтрока.КодВалютыЦифровой = ТабличныйДокумент.Область(СчСтр, 1).Текст;
		НоваяСтрока.КодВалютыБуквенный = ТабличныйДокумент.Область(СчСтр, 2).Текст;
		НоваяСтрока.Наименование = ТабличныйДокумент.Область(СчСтр, 3).Текст;
		НоваяСтрока.СтраныИТерритории = ТабличныйДокумент.Область(СчСтр, 4).Текст;
		НоваяСтрока.ПараметрыПрописи = ТабличныйДокумент.Область(СчСтр, 5).Текст;
		НоваяСтрока.Загружается = ТекстВБулево(ТабличныйДокумент.Область(СчСтр, 6).Текст);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция СохранитьВыбранныеСтроки(Знач ВыбранныеСтроки, ЕстьКурсы)
	
	ЕстьКурсы = Ложь;
	ТекущаяСсылка = Неопределено;
	
	Для каждого НомерСтроки Из ВыбранныеСтроки Цикл
		ТекущиеДанные = Валюты[НомерСтроки];
		
		СтрокаВБазе = Справочники.Валюты.НайтиПоКоду(ТекущиеДанные.КодВалютыЦифровой);
		Если ЗначениеЗаполнено(СтрокаВБазе) Тогда
			Если НомерСтроки = Элементы.СписокВалют.ТекущаяСтрока Или ТекущаяСсылка = Неопределено Тогда
				ТекущаяСсылка = СтрокаВБазе;
			КонецЕсли;
			Продолжить;
		КонецЕсли;
		
		НачатьТранзакцию();
		Попытка
			
			НоваяСтрока = Справочники.Валюты.СоздатьЭлемент();
			НоваяСтрока.Код                       = ТекущиеДанные.КодВалютыЦифровой;
			НоваяСтрока.Наименование              = ТекущиеДанные.КодВалютыБуквенный;
			НоваяСтрока.НаименованиеПолное        = ТекущиеДанные.Наименование;
			Если ТекущиеДанные.Загружается Тогда
				НоваяСтрока.СпособУстановкиКурса = Перечисления.СпособыУстановкиКурсаВалюты.ЗагрузкаИзИнтернета;
			Иначе
				НоваяСтрока.СпособУстановкиКурса = Перечисления.СпособыУстановкиКурсаВалюты.РучнойВвод;
			КонецЕсли;
			НоваяСтрока.ПараметрыПрописи = ТекущиеДанные.ПараметрыПрописи;
			НоваяСтрока.Записать();
			
			РаботаСКурсамиВалютУТ.ПроверитьКорректностьОтносительногоКурсаНа01_01_1980(НоваяСтрока.Ссылка);
			
			Если НомерСтроки = Элементы.СписокВалют.ТекущаяСтрока Или ТекущаяСсылка = Неопределено Тогда
				ТекущаяСсылка = НоваяСтрока.Ссылка;
			КонецЕсли;
			
			Если ТекущиеДанные.Загружается Тогда 
				ЕстьКурсы = Истина;
			КонецЕсли;
			
			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
		
	КонецЦикла;
	
	Возврат ТекущаяСсылка;

КонецФункции

&НаКлиенте
Процедура ОбработатьВыборВСпискеВалют(СтандартнаяОбработка = Неопределено)
	Перем ЕстьКурсы;
	
	// Добавление элемента справочника и вывод результата пользователю.
	СтандартнаяОбработка = Ложь;
	
	ТекущаяСсылка = СохранитьВыбранныеСтроки(Элементы.СписокВалют.ВыделенныеСтроки, ЕстьКурсы);
	
	ОповеститьОВыборе(ТекущаяСсылка);
	Оповестить("Запись_Валюты", ТекущаяСсылка);
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти
