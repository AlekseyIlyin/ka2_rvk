////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Ввод остатков внеоборотных активов".
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Параметры:
// 	Элемент - ПолеФормы - 
// 	Форма - ФормаКлиентскогоПриложения - 
Процедура ФормаРедактированияСтрокиОС_ПриИзмененииРеквизита(Элемент, Форма) Экспорт

	ДополнительныеПараметры = Неопределено;
	ТребуетсяВызовСервера = Ложь;
	
	//++ Локализация

	Элементы = Форма.Элементы;
	
	Если Элемент.Имя = Элементы.ТекущаяСтоимостьПР.Имя	
		ИЛИ Элемент.Имя = Элементы.ПервоначальнаяСтоимостьПР.Имя
		ИЛИ Элемент.Имя = Элементы.НакопленнаяАмортизацияПР.Имя Тогда	
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Выполнить_ПересчитатьЗависимыеСуммы");
		ДополнительныеПараметры.Вставить("Выполнить_НастроитьЗависимыеЭлементыФормы", Элемент.Имя);
		
	Иначе
		ВызватьИсключение СтрШаблон(НСтр("ru = 'Отсутствует обработка события для элемента ""%1""'"), Элемент.Имя);
	КонецЕсли; 
	
	//-- Локализация
	
	ОбщегоНазначенияУТКлиент.ПродолжитьИзменениеРеквизита(
		Форма, 
		Элемент.Имя, 
		ТребуетсяВызовСервера,
		ДополнительныеПараметры);
	
КонецПроцедуры

// Параметры:
// 	Команда - КомандаФормы - 
// 	Форма - ФормаКлиентскогоПриложения - 
Процедура ФормаОсновныеСредства_ПриВыполненииКоманды(Команда, Форма) Экспорт

	ДополнительныеПараметры = Неопределено;
	ТребуетсяВызовСервера = Ложь;
	ПродолжитьВыполнениеКоманды = Истина;
	
	//++ Локализация
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;

	Если Команда.Имя = Элементы.ОСЗаполнитьПоДаннымОУ.ИмяКоманды Тогда
		ЗаполнитьПоДаннымОУ(Форма, Объект.ОС, Команда.Имя, ТребуетсяВызовСервера, ПродолжитьВыполнениеКоманды);
	КонецЕсли; 
	
	//-- Локализация
	
	Если ПродолжитьВыполнениеКоманды Тогда
		
		ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(
			Форма, 
			Команда.Имя, 
			ТребуетсяВызовСервера,
			ДополнительныеПараметры);
			
	КонецЕсли; 
	
КонецПроцедуры

//++ Локализация

#Область ЗаполнениеПоДаннымОперативногоУчета

Процедура ЗаполнитьПоДаннымОУ(Форма, ТабличнаяЧасть, ИмяКоманды, ТребуетсяВызовСервера, ПродолжитьВыполнениеКоманды)
	
	Если ТабличнаяЧасть.Количество() <> 0 Тогда

		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Форма", Форма);
		ДополнительныеПараметры.Вставить("ИмяКоманды", ИмяКоманды);
		ОповещениеВопросЗаполнитьПоОстаткам = Новый ОписаниеОповещения("ЗаполнитьПоДаннымОУЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ТекстВопроса = НСтр("ru = 'При заполнении текущие данные табличной части будут очищены. Продолжить?'");
		ПоказатьВопрос(ОповещениеВопросЗаполнитьПоОстаткам, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
		ПродолжитьВыполнениеКоманды = Ложь;
		
	Иначе
		
		ТребуетсяВызовСервера = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьПоДаннымОУЗавершение(РезультатВопроса, ДополнительныеПараметры = Неопределено) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		
		ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(
			ДополнительныеПараметры.Форма, 
			ДополнительныеПараметры.ИмяКоманды, 
			Истина,
			Неопределено);
			
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

//-- Локализация

#КонецОбласти
