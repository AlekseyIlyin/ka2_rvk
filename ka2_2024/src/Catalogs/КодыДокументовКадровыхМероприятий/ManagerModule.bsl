#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// ТехнологияСервиса.ВыгрузкаЗагрузкаДанных

// Возвращает реквизиты справочника, которые образуют естественный ключ для элементов справочника.
//
// Возвращаемое значение:
//  Массив из Строка - имена реквизитов, образующих естественный ключ.
//
Функция ПоляЕстественногоКлюча() Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить("Код");
	
	Возврат Результат;
	
КонецФункции

// Конец ТехнологияСервиса.ВыгрузкаЗагрузкаДанных

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПервоначальноеЗаполнениеИОбновлениеИнформационнойБазы

// Процедура выполняет первоначальное заполнение статей ТК - оснований увольнения.
Процедура НачальноеЗаполнение() Экспорт
	
	ЗагрузитьКлассификатор();
	
КонецПроцедуры

Процедура ЗагрузитьКлассификатор() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	КодыДокументовКадровыхМероприятий.Ссылка КАК Ссылка,
		|	КодыДокументовКадровыхМероприятий.Код КАК Код
		|ИЗ
		|	Справочник.КодыДокументовКадровыхМероприятий КАК КодыДокументовКадровыхМероприятий";
	
	Классификатор = Запрос.Выполнить().Выгрузить();
	
	ДанныеМакетаКлассификатора = ОбщегоНазначения.ПрочитатьXMLВТаблицу(
		ПолучитьМакет("КодыДокументовКадровыхМероприятий").ПолучитьТекст()).Данные;
	
	Для Каждого СтрокаКлассификатора Из ДанныеМакетаКлассификатора Цикл
		
		ЭтоГруппаКлассификатора = СтрокаКлассификатора.ParentCode = "";
		ЭтоНовыйЭлемент = Ложь;
		
		СтрокаСсылки = Классификатор.Найти(СтрокаКлассификатора.Code, "Код");
		Если СтрокаСсылки = Неопределено Тогда
			ЭтоНовыйЭлемент = Истина;
			Если ЭтоГруппаКлассификатора Тогда
				ОбъектСсылки = Справочники.КодыДокументовКадровыхМероприятий.СоздатьГруппу();
			Иначе
				ОбъектСсылки = Справочники.КодыДокументовКадровыхМероприятий.СоздатьЭлемент();
			КонецЕсли;
			ОбъектСсылки.Код = СтрокаКлассификатора.Code;
		Иначе
			ОбъектСсылки = СтрокаСсылки.Ссылка.ПолучитьОбъект();
		КонецЕсли;
		ОбъектСсылки.НаименованиеПолное = СтрокаКлассификатора.Name;
		Если Не ЭтоГруппаКлассификатора Тогда
			ОбъектСсылки.СсылкаНаНД = СтрокаКлассификатора.Article;
			ОбъектСсылки.ИмяПредопределенныхДанных = СтрокаКлассификатора.Id;
			СтрокаРодителя = Классификатор.Найти(СтрокаКлассификатора.ParentCode, "Код");
			Если СтрокаРодителя <> Неопределено Тогда
				ОбъектСсылки.Родитель = СтрокаРодителя.Ссылка;
			КонецЕсли;
		КонецЕсли;
		ОбновлениеИнформационнойБазы.ЗаписатьОбъект(ОбъектСсылки);
		Если ЭтоНовыйЭлемент Тогда
			НоваяСтрокаКлассификатора = Классификатор.Добавить();
			НоваяСтрокаКлассификатора.Код = ОбъектСсылки.Код;
			НоваяСтрокаКлассификатора.Ссылка = ОбъектСсылки.Ссылка;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли