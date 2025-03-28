#Область ОписаниеПеременных

&НаКлиенте
Перем КэшированныеЗначения; //используется механизмом обработки изменения реквизитов ТЧ.

&НаКлиенте
Перем ПараметрыДляЗаписи Экспорт;

&НаКлиенте
Перем ТекущиеДанныеИдентификатор;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Справочники.Назначения.ФормаДокументаПриСозданииНаСервере(ЭтотОбъект);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		ПриЧтенииСозданииНаСервере();
		
	КонецЕсли;
	
	УстановитьДоступностьКомандБуфераОбмена();
	
	ИсправлениеДокументов.ПриСозданииНаСервере(ЭтотОбъект, Элементы.СтрокаИсправление);
	
	// СтандартныеПодсистемы.ПодключаемоеОборудование
	ОбщегоНазначенияУТ.НастроитьПодключаемоеОборудование(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемоеОборудование
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	ДополнительныеПараметры.Вставить("ОтложеннаяИнициализация", Истина);
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.СобытияФорм
	СобытияФорм.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	// Конец СтандартныеПодсистемы.СобытияФорм
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриЧтенииСозданииНаСервере();
	
	ИсправлениеДокументов.ПриЧтенииНаСервере(ЭтотОбъект, Элементы.СтрокаИсправление);
	
	// СтандартныеПодсистемы.ДатыЗапрета
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапрета
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	МодификацияКонфигурацииПереопределяемый.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	
	СобытияФорм.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	НоменклатураКлиент.ОбновитьКешированныеЗначенияДляУчетаСерий(Элементы.Товары, КэшированныеЗначения, ПараметрыУказанияСерий);
	
	// СтандартныеПодсистемы.ПодключаемоеОборудование
	МенеджерОборудованияКлиент.НачатьПодключениеОборудованиеПриОткрытииФормы(Неопределено, ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемоеОборудование
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если НоменклатураКлиент.ЭтоУказаниеСерий(ИсточникВыбора) Тогда
		НоменклатураКлиент.ОбработатьУказаниеСерии(ЭтотОбъект, ПараметрыУказанияСерий, ВыбранноеЗначение);
	ИначеЕсли ИсточникВыбора.ИмяФормы = "РегистрНакопления.РНПТМатериаловВПроизводстве.Форма.ПодборРНПТПоОстаткам" Тогда
		ОбработкаПодбораПоОстаткам(ВыбранноеЗначение);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование" И ВводДоступен() Тогда
		Если ИмяСобытия = "ScanData" И МенеджерОборудованияУТКлиент.ЕстьНеобработанноеСобытие() Тогда
			ОбработатьШтрихкоды(МенеджерОборудованияУТКлиент.ПреобразоватьДанныеСоСканераВМассив(Параметр));
		КонецЕсли;
	КонецЕсли;
	
	// Неизвестные штрихкоды
	Если Источник = "ПодключаемоеОборудование"
		И ИмяСобытия = "НеизвестныеШтрихкоды"
		И Параметр.ФормаВладелец = УникальныйИдентификатор Тогда
		
		КэшированныеЗначения.Штрихкоды.Очистить();
		ДанныеШтрихкодов = Новый Массив;
		Для Каждого ПолученныйШтрихкод Из Параметр.ПолученыНовыеШтрихкоды Цикл
			ДанныеШтрихкодов.Добавить(ПолученныйШтрихкод);
		КонецЦикла;
		Для Каждого ПолученныйШтрихкод Из Параметр.ЗарегистрированныеШтрихкоды Цикл
			ДанныеШтрихкодов.Добавить(ПолученныйШтрихкод);
		КонецЦикла;
		
		ОбработатьШтрихкоды(ДанныеШтрихкодов);
		
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ПодключаемоеОборудование
	
	// СтандартныеПодсистемы.БуферОбмена
	Если ИмяСобытия = "КопированиеСтрокВБуферОбмена" Тогда
		УстановитьДоступностьКомандБуфераОбменаНаКлиенте();
	КонецЕсли;
	// Конец СтандартныеПодсистемы.БуферОбмена
	
	ИсправлениеДокументовКлиент.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	СобытияФормКлиент.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	СобытияФормКлиент.ПередЗаписью(ЭтотОбъект, Отказ, ПараметрыЗаписи);

	Если НеВыполнятьПроверкуПередЗаписью Тогда
		НеВыполнятьПроверкуПередЗаписью = Ложь;
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияУТКлиент.ЗаписатьОбъектПриНеобходимости(ЭтотОбъект, ПараметрыЗаписи, Отказ);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	МодификацияКонфигурацииПереопределяемый.ПередЗаписьюНаСервере(ЭтотОбъект, Отказ, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_ВыбытиеРНПТМатериаловИзПроизводства");
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	МодификацияКонфигурацииКлиентПереопределяемый.ПослеЗаписи(ЭтотОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ЗаполнитьСлужебныеРеквизитыФормы();
	
	МодификацияКонфигурацииПереопределяемый.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	
	СобытияФорм.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ПринудительноЗакрытьФорму = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	// СтандартныеПодсистемы.ПодключаемоеОборудование
	МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПриЗакрытииФормы(Неопределено, ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемоеОборудование
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ГруппаСтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	// СтандартныеПодсистемы.Свойства
	Если ЭтотОбъект.ПараметрыСвойств.Свойство(ТекущаяСтраница.Имя)
		И Не ЭтотОбъект.ПараметрыСвойств.ВыполненаОтложеннаяИнициализация Тогда
		СвойстваВыполнитьОтложеннуюИнициализацию();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура СтрокаИсправлениеОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	ИсправлениеДокументовКлиент.СтрокаИсправлениеОбработкаНавигационныйСсылки(
		ЭтотОбъект, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
		
КонецПроцедуры

#Область ОбработчикиСобытийЭлементовШапкиФормыВкладкаОсновное

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	ДатаПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	НоменклатураКлиент.ОбновитьКешированныеЗначенияДляУчетаСерий(Элемент, КэшированныеЗначения, ПараметрыУказанияСерий, Копирование);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	Если НоменклатураКлиент.НеобходимоОбновитьСтатусыСерий(Элемент, КэшированныеЗначения, ПараметрыУказанияСерий) Тогда
		
		ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
		ТоварыПослеРедактированияНаСервере(ТекущиеДанные.ПолучитьИдентификатор(), КэшированныеЗначения);
		НоменклатураКлиент.ОбновитьКешированныеЗначенияДляУчетаСерий(Элемент, КэшированныеЗначения, ПараметрыУказанияСерий);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПередУдалением(Элемент, Отказ)
	
	НоменклатураКлиент.ОбновитьКешированныеЗначенияДляУчетаСерий(Элемент, КэшированныеЗначения, ПараметрыУказанияСерий);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПослеУдаления(Элемент)
	
	Если НоменклатураКлиент.НеобходимоОбновитьСтатусыСерий(Элемент, КэшированныеЗначения, ПараметрыУказанияСерий, Истина) Тогда
		
		ТоварыПослеРедактированияНаСервере(Неопределено, КэшированныеЗначения);
		НоменклатураКлиент.ОбновитьКешированныеЗначенияДляУчетаСерий(Элемент, КэшированныеЗначения, ПараметрыУказанияСерий);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПартияПроизводстваНачалоВыбора(Элемент, ДанныеВыбора, ВыборДобавлением, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтруктураОтбора = Новый Структура;
	СтруктураОтбора.Вставить("Организация",                    Объект.Организация);
	СтруктураОтбора.Вставить("ИсключатьПроизводствоНаСтороне", Истина);
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("НачалоПериода",    НачалоМесяца(Объект.Дата));
	ПараметрыФормы.Вставить("ОкончаниеПериода", КонецМесяца(Объект.Дата));
	ПараметрыФормы.Вставить("СтруктураОтбора",  СтруктураОтбора);
	ПараметрыФормы.Вставить("ОдиночныйВыбор",   Истина);
	
	Оповещение = Новый ОписаниеОповещения("ТоварыПартияПроизводстваНачалоВыбораЗавершение", ЭтотОбъект);
	
	ОткрытьФорму("ОбщаяФорма.ПодборПартийПроизводства",
		ПараметрыФормы,
		ЭтотОбъект,,,,
		Оповещение,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПодразделениеПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	
	ДобавитьВСтруктуруДействияПоСериям(СтруктураДействий, ТекущиеДанные.Подразделение, ПараметрыУказанияСерий);
	УчетПрослеживаемыхТоваровКлиентСерверЛокализация.ДополнитьОписаниеНастроекПересчетаРеквизитовТабличнойЧасти(
		Объект,
		СтруктураДействий,
		"Подразделение",
		Истина);
	
	ПакетнаяОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущиеДанные, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	ДобавитьВСтруктуруДействияПриИзмененииНоменклатурыТаблицы(ЭтотОбъект, СтруктураДействий);
	ДобавитьВСтруктуруДействияПоСериям(СтруктураДействий, ТекущиеДанные.Подразделение, ПараметрыУказанияСерий);
	
	ПакетнаяОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущиеДанные, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыХарактеристикаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить(
		"ХарактеристикаПриИзмененииПереопределяемый",
		Новый Структура("ИмяФормы, ИмяТабличнойЧасти", ИмяФормы, "Товары"));
	
	ПакетнаяОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущиеДанные, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	ДобавитьВСтруктуруДействияПриИзмененииКоличестваТаблицы(ЭтотОбъект, СтруктураДействий);
	
	ПакетнаяОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущиеДанные, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСерияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьПодборСерий(Элемент.ТекстРедактирования);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСерияПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	ВыбранноеЗначение = НоменклатураКлиентСервер.ВыбраннаяСерия();
	
	ВыбранноеЗначение.Значение                   = ТекущиеДанные.Серия;
	ВыбранноеЗначение.ИдентификаторТекущейСтроки = ТекущиеДанные.ПолучитьИдентификатор();
	
	НоменклатураКлиент.ОбработатьУказаниеСерии(ЭтотОбъект, ПараметрыУказанияСерий, ВыбранноеЗначение);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыНомерГТДПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураДействий = Новый Структура;
	УчетПрослеживаемыхТоваровКлиентСерверЛокализация.ДополнитьОписаниеНастроекПересчетаРеквизитовТабличнойЧасти(
		Объект,
		СтруктураДействий,
		"Подразделение",
		Истина);
	
	ПакетнаяОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущиеДанные, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура РазбитьСтроку(Команда)
	
	ТаблицаФормы  = Элементы.Товары;
	ДанныеТаблицы = Объект.Товары;
	
	ПараметрыРазбиенияСтроки = РаботаСТабличнымиЧастямиКлиент.ПараметрыРазбиенияСтроки();
	ПараметрыРазбиенияСтроки.ИмяПоляКоличество = "Количество";
	
	Оповещение = Новый ОписаниеОповещения("РазбитьСтрокуЗавершение", ЭтотОбъект);
	РаботаСТабличнымиЧастямиКлиент.РазбитьСтроку(ДанныеТаблицы, ТаблицаФормы, Оповещение, ПараметрыРазбиенияСтроки);
	
КонецПроцедуры

&НаКлиенте
Процедура ВставитьСтроки(Команда)
	
	КоличествоТоваровДоВставки = Объект.Товары.Количество();
	
	ПолучитьСтрокиИзБуфераОбмена();
	
	КоличествоВставленных = Объект.Товары.Количество()-КоличествоТоваровДоВставки;
	РаботаСТабличнымиЧастямиКлиент.ОповеститьПользователяОВставкеСтрок(КоличествоВставленных);
	
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьСтроки(Команда)
	
	Если РаботаСТабличнымиЧастямиКлиент.ВыбранаСтрокаДляВыполненияКоманды(Элементы.Товары) Тогда
		СкопироватьСтрокиНаСервере();
		РаботаСТабличнымиЧастямиКлиент.ОповеститьПользователяОКопированииСтрок(Элементы.Товары.ВыделенныеСтроки.Количество());
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоискПоШтрихкоду(Команда)
	
	ОчиститьСообщения();
	
	Оповещение = Новый ОписаниеОповещения("ПоискПоШтрихкодуЗавершение", ЭтотОбъект);
	ШтрихкодированиеНоменклатурыКлиент.ПоказатьВводШтрихкода(Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьРекомендуемымиКВыбытию(Команда)
	
	Если Не Объект.Товары.Количество() = 0 Тогда
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ЗаполнитьРекомендуемымиКВыбытиюЗавершение", ЭтотОбъект);
		ТекстВопроса = НСтр("ru = 'Таблица РНПТ материалов будет перезаполнена. Продолжить?'");
		
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		
	Иначе
		ЗаполнитьРекомендуемымиКВыбытиюЗавершение(КодВозвратаДиалога.Да, Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоОстаткам(Команда)
	
	ПараметрыЗаполнения = Новый Структура;
	ПараметрыЗаполнения.Вставить("Организация", Объект.Организация);
	ПараметрыЗаполнения.Вставить("Регистратор", Объект.Ссылка);
	ПараметрыЗаполнения.Вставить("Дата",        Объект.Дата);
	
	ЗаполнитьПоОстаткамНаСервере(ПараметрыЗаполнения);
	
	ОткрытьФорму(
		"РегистрНакопления.РНПТМатериаловВПроизводстве.Форма.ПодборРНПТПоОстаткам",
		ПараметрыЗаполнения,
		ЭтотОбъект,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура УказатьСерии(Команда)
	
	ОткрытьПодборСерий("");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПартиюПроизводства(Команда)
	
	Если Элементы.Товары.ВыделенныеСтроки.Количество() = 0 Тогда
		ТекстПредупреждения = НСтр("ru='Необходимо выбрать строки, для которых необходимо заполнить партию производства.'");
		ПоказатьПредупреждение(, ТекстПредупреждения);
		Возврат;
	КонецЕсли;
	
	СтруктураОтбора = Новый Структура;
	СтруктураОтбора.Вставить("Организация",                    Объект.Организация);
	СтруктураОтбора.Вставить("ИсключатьПроизводствоНаСтороне", Истина);
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("НачалоПериода",    НачалоМесяца(Объект.Дата));
	ПараметрыФормы.Вставить("ОкончаниеПериода", КонецМесяца(Объект.Дата));
	ПараметрыФормы.Вставить("СтруктураОтбора",  СтруктураОтбора);
	ПараметрыФормы.Вставить("ОдиночныйВыбор",   Истина);
	
	Оповещение = Новый ОписаниеОповещения("ЗаполнитьПартиюПроизводстваЗавершение", ЭтотОбъект);
	
	ОткрытьФорму("ОбщаяФорма.ПодборПартийПроизводства",
		ПараметрыФормы,
		ЭтотОбъект,,,,
		Оповещение,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПодразделение(Команда)
	
	Если Элементы.Товары.ВыделенныеСтроки.Количество() = 0 Тогда
		ТекстПредупреждения = НСтр("ru='Необходимо выбрать строки, для которых необходимо заполнить подразделение.'");
		ПоказатьПредупреждение(, ТекстПредупреждения);
		Возврат;
	КонецЕсли;
	
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("ПроизводственноеПодразделение", Истина);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отбор", ПараметрыОтбора);
	ПараметрыФормы.Вставить("МножественныйВыбор", Ложь);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ЗаполнитьПодразделениеЗавершение", ЭтотОбъект);
	ОткрытьФорму("Справочник.СтруктураПредприятия.ФормаВыбора", ПараметрыФормы,,,,, ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНомерГТД(Команда)
	
	Если Элементы.Товары.ВыделенныеСтроки.Количество() = 0 Тогда
		ТекстПредупреждения = НСтр("ru='Необходимо выбрать строки, для которых необходимо заполнить РНПТ.'");
		ПоказатьПредупреждение(, ТекстПредупреждения);
		Возврат;
	КонецЕсли;
	
	СписокТиповГТД = Новый СписокЗначений;
	СписокТиповГТД.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНомеровГТД.НомерРНПТ"));
	СписокТиповГТД.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНомеровГТД.НомерРНПТКомплекта"));
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("СписокТиповГТД",     СписокТиповГТД);
	ПараметрыФормы.Вставить("МножественныйВыбор", Ложь);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ЗаполнитьНомерГТДЗавершение", ЭтотОбъект);
	ОткрытьФорму("Справочник.НомераГТД.ФормаВыбора", ПараметрыФормы,,,,, ОписаниеОповещения);
	
КонецПроцедуры

#Область ОбработчикиКомандОбъекта

&НаКлиенте
Процедура ПровестиДокумент(Команда)
	
	ОбщегоНазначенияУТКлиент.Провести(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПровестиИЗакрыть(Команда)
	
	ОбщегоНазначенияУТКлиент.ПровестиИЗакрыть(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьДокумент(Команда)
	
	ОбщегоНазначенияУТКлиент.Записать(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометкуУдаленияДокумента(Команда)
	
	ОбщегоНазначенияУТКлиент.УстановитьПометкуУдаленияДокумента(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область НастройкиФормы

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	#Область СтандартноеОформление
	
	НоменклатураСервер.УстановитьУсловноеОформлениеХарактеристикНоменклатуры(ЭтотОбъект);
	НоменклатураСервер.УстановитьУсловноеОформлениеНазначенияНоменклатуры(ЭтотОбъект,,, Ложь);
	
	НоменклатураСервер.УстановитьУсловноеОформлениеСерийНоменклатуры(ЭтотОбъект, Ложь);
	НоменклатураСервер.УстановитьУсловноеОформлениеСтатусовУказанияСерий(ЭтотОбъект, Истина);
	
	#Область Прослеживаемость
	
	УчетПрослеживаемыхТоваровЛокализация.УстановитьУсловноеОформлениеНомераГТД(ЭтотОбъект);
	УчетПрослеживаемыхТоваровЛокализация.УстановитьУсловноеОформлениеКоличестваПоРНПТ(ЭтотОбъект);
	
	#КонецОбласти
	
	#КонецОбласти
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыВыбораНомераГТД()
	
	СписокТиповГТД = Новый СписокЗначений;
	СписокТиповГТД.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНомеровГТД.НомерРНПТ"));
	СписокТиповГТД.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНомеровГТД.НомерРНПТКомплекта"));
	
	МассивПараметров = Новый Массив;
	МассивПараметров.Добавить(Новый ПараметрВыбора("СписокТиповГТД", СписокТиповГТД));
	
	Элементы.ТоварыНомерГТД.ПараметрыВыбора = Новый ФиксированныйМассив(МассивПараметров);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеОбработчикиСобытийФормы

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	
	ЗаполнитьСлужебныеРеквизитыФормы();
	
	ПараметрыУказанияСерий = Новый ФиксированнаяСтруктура(НоменклатураСервер.ПараметрыУказанияСерий(Объект, Документы.ВыбытиеРНПТМатериаловИзПроизводства));
	
	НастроитьЭлементыСерий();
	УстановитьПараметрыВыбораНомераГТД();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСлужебныеРеквизитыФормы()
	
	ЗаполнитьСлужебныеРеквизитыТаблицы();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСлужебныеРеквизитыТаблицы()
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ЗаполнитьПризнакАртикул",                    Новый Структура("Номенклатура", "Артикул"));
	СтруктураДействий.Вставить("ЗаполнитьПризнакТипНоменклатуры",            Новый Структура("Номенклатура", "ТипНоменклатуры"));
	СтруктураДействий.Вставить("ЗаполнитьПризнакХарактеристикиИспользуются", Новый Структура("Номенклатура", "ХарактеристикиИспользуются"));
	
	УчетПрослеживаемыхТоваровКлиентСерверЛокализация.ДополнитьОписаниеНастроекЗаполненияСлужебныхРеквизитовТабличнойЧасти(СтруктураДействий);
	
	ПакетнаяОбработкаТабличнойЧастиСервер.ОбработатьТЧ(Объект.Товары, СтруктураДействий);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПодбораПоОстаткам(ВыбранноеЗначение)
	
	Объект.Товары.Загрузить(ПолучитьИзВременногоХранилища(ВыбранноеЗначение.АдресТаблицаТоваров));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеОбработчикиСобытийЭлементовФормы

&НаСервере
Процедура ДатаПриИзмененииНаСервере()
	
	ПодготовитьЗаполнитьУстановитьВидимостьСерий();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаСервере
Процедура ТоварыПослеРедактированияНаСервере(ИдентификаторСтроки, КэшированныеЗначения)
	
	ЗаполнитьСтатусыУказанияСерийПриОкончанииРедактированияСтрокиТЧ(ИдентификаторСтроки, КэшированныеЗначения);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПартияПроизводстваНачалоВыбораЗавершение(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	ТекущиеДанные.ПартияПроизводства = Результат;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеОбработчикиКомандФормы

&НаКлиенте
Процедура РазбитьСтрокуЗавершение(НоваяСтрока, ДополнительныеПараметры) Экспорт
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	
	Если НоваяСтрока <> Неопределено Тогда
		
		СтруктураДействий = Новый Структура;
		ДобавитьВСтруктуруДействияПриИзмененииКоличестваТаблицы(ЭтотОбъект, СтруктураДействий);
		
		ПакетнаяОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);
		ПакетнаяОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(НоваяСтрока, СтруктураДействий, КэшированныеЗначения);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоискПоШтрихкодуЗавершение(ДанныхШтрихкода, ДополнительныеПараметры) Экспорт
	
	ОбработатьШтрихкоды(ДанныхШтрихкода);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьРекомендуемымиКВыбытиюЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ЗаполнитьРекомендуемымиКВыбытиюНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьРекомендуемымиКВыбытиюНаСервере()
	
	ПараметрыОстатков = УчетПрослеживаемыхТоваровВПроизводстве.ПараметрыЗапросаОстатковРНПТМатериаловВПроизводстве();
	ПараметрыОстатков.ЗаполнитьРекомендуетсяВыбытие = Истина;
	ПараметрыОстатков.ЗначенияПараметровОтбора.Вставить("Организация", Объект.Организация);
	ОбщегоНазначенияУТ.ДобавитьЭлементОтбораВКоллекцию(ПараметрыОстатков.Отбор, "ОстаткиТоваров.Организация", "&Организация", "=");
	
	ОстаткиРНПТ = РегистрыНакопления.РНПТМатериаловВПроизводстве.ОстаткиРНПТМатериаловВПроизводстве(ПараметрыОстатков);
	Объект.Товары.Загрузить(ОстаткиРНПТ);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПоОстаткамНаСервере(ПараметрыЗаполнения)
	
	ПараметрыЗаполнения.Вставить("АдресТаблицаТоваров", ПоместитьВоВременноеХранилище(Объект.Товары.Выгрузить(), УникальныйИдентификатор));
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПартиюПроизводстваЗавершение(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// &ЗамерПроизводительности
	ОценкаПроизводительностиКлиент.ЗамерВремени(
		"Документ.ВыбытиеРНПТМатериаловИзПроизводства.Форма.ФормаДокумента.ЗаполнитьПартиюПроизводства");
	
	Для Каждого ИдентификаторСтроки Из Элементы.Товары.ВыделенныеСтроки Цикл
		
		ТекущиеДанные = Объект.Товары.НайтиПоИдентификатору(ИдентификаторСтроки);
		ТекущиеДанные.ПартияПроизводства = Результат;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПодразделениеЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// &ЗамерПроизводительности
	ОценкаПроизводительностиКлиент.ЗамерВремени(
		"Документ.ВыбытиеРНПТМатериаловИзПроизводства.Форма.ФормаДокумента.ЗаполнитьПодразделение");
	
	ЗаполнитьПодразделениеЗавершениеНаСервере(Результат);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПодразделениеЗавершениеНаСервере(Результат)
	
	ОбрабатываемыеСтроки = Новый Массив;
	Для Каждого ИдентификаторСтроки Из Элементы.Товары.ВыделенныеСтроки Цикл
		
		ТекущиеДанные = Объект.Товары.НайтиПоИдентификатору(ИдентификаторСтроки);
		ТекущиеДанные.Подразделение = Результат;
		
		ОбрабатываемыеСтроки.Добавить(ТекущиеДанные);
		
	КонецЦикла;
	
	ЗаполнитьСтатусыУказанияСерий(ОбрабатываемыеСтроки);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНомерГТДЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// &ЗамерПроизводительности
	ОценкаПроизводительностиКлиент.ЗамерВремени(
		"Документ.ВыбытиеРНПТМатериаловИзПроизводства.Форма.ФормаДокумента.ЗаполнитьНомерГТД");
	
	ЗаполнитьНомерГТДЗавершениеНаСервере(Результат);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНомерГТДЗавершениеНаСервере(НомерГТД)
	
	СтруктураДействий = Новый Структура;
	УчетПрослеживаемыхТоваровКлиентСерверЛокализация.ДополнитьОписаниеНастроекПересчетаРеквизитовТабличнойЧасти(
		Объект,
		СтруктураДействий,
		"Подразделение",
		Истина);
	
	ОбрабатываемыеСтроки = Новый Массив();
	Для Каждого ИдентификаторСтроки Из Элементы.Товары.ВыделенныеСтроки Цикл
		
		ТекущиеДанные = Объект.Товары.НайтиПоИдентификатору(ИдентификаторСтроки);
		ТекущиеДанные.НомерГТД = НомерГТД;
		
		ОбрабатываемыеСтроки.Добавить(ТекущиеДанные);
		
	КонецЦикла;
	
	ПакетнаяОбработкаТабличнойЧастиСервер.ОбработатьСтрокиТЧ(
		ОбрабатываемыеСтроки,
		СтруктураДействий,
		Объект.Товары);
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСБуферомОбмена

&НаСервере
Процедура СкопироватьСтрокиНаСервере()
	
	РаботаСТабличнымиЧастями.СкопироватьСтрокиВБуферОбмена(Объект.Товары, Элементы.Товары.ВыделенныеСтроки);
	
КонецПроцедуры

&НаСервере
Процедура ПолучитьСтрокиИзБуфераОбмена()
	
	ПараметрыОтбора = Новый Соответствие;
	ПараметрыОтбора.Вставить("Номенклатура.ТипНоменклатуры", НоменклатураКлиентСервер.ОтборПоТоваруМногооборотнойТареРаботе(Ложь));
	
	Колонки = "ПартияПроизводства,Подразделение,Номенклатура,Характеристика,Назначение,Количество,КоличествоПоРНПТ,НомерГТД";
	
	ТаблицаТоваров = РаботаСТабличнымиЧастями.СтрокиИзБуфераОбмена(ПараметрыОтбора, Колонки);
	
	Если Не ЗначениеЗаполнено(ТаблицаТоваров) Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураДействий = Новый Структура;
	ДобавитьВСтруктуруДействияПриИзмененииНоменклатурыТаблицы(ЭтотОбъект, СтруктураДействий);
	ДобавитьВСтруктуруДействияПриИзмененииКоличестваТаблицы(ЭтотОбъект, СтруктураДействий);
	
	КэшированныеЗначения = ПакетнаяОбработкаТабличнойЧастиКлиентСервер.ПолучитьСтруктуруКэшируемыеЗначения();
	
	ОбрабатываемыеСтроки = Новый Массив();
	Для Каждого СтрокаТовара Из ТаблицаТоваров Цикл
		
		ТекущиеДанные = Объект.Товары.Добавить();
		ЗаполнитьЗначенияСвойств(ТекущиеДанные, СтрокаТовара);
		
		ОбрабатываемыеСтроки.Добавить(ТекущиеДанные);
		
	КонецЦикла;
	
	ПакетнаяОбработкаТабличнойЧастиСервер.ОбработатьСтрокиТЧ(
		ОбрабатываемыеСтроки,
		СтруктураДействий,
		Объект.Товары,
		КэшированныеЗначения);
	
	НоменклатураСервер.ЗаполнитьСтатусыУказанияСерий(Объект, ПараметрыУказанияСерий);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьКомандБуфераОбмена()
	
	МассивЭлементов = Новый Массив();
	МассивЭлементов.Добавить("ТоварыВставитьСтроки");
	МассивЭлементов.Добавить("ТоварыКонтекстноеМенюВставитьСтроки");
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(
		Элементы,
		МассивЭлементов,
		"Доступность",
		РаботаСТабличнымиЧастями.ЕстьСтрокиВБуфереОбмена());
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьКомандБуфераОбменаНаКлиенте()
	
	МассивЭлементов = Новый Массив();
	МассивЭлементов.Добавить("ТоварыВставитьСтроки");
	МассивЭлементов.Добавить("ТоварыКонтекстноеМенюВставитьСтроки");
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(Элементы, МассивЭлементов, "Доступность", Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ШтрихкодыИТорговоеОборудование

&НаСервере
Процедура ОбработатьШтрихкодыСервер(СтруктураПараметровДействия,КэшированныеЗначения)
	
	ШтрихкодированиеНоменклатурыСервер.ОбработатьШтрихкоды(ЭтотОбъект, Объект, СтруктураПараметровДействия, КэшированныеЗначения);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьШтрихкоды(ДанныеШтрихкодов)
	
	Модифицированность = Истина;
	
	СтруктураДействийСДобавленнымиСтроками = Новый Структура;
	ДобавитьВСтруктуруДействияПриИзмененииНоменклатурыТаблицы(ЭтотОбъект, СтруктураДействийСДобавленнымиСтроками);
	ДобавитьВСтруктуруДействияПриИзмененииКоличестваТаблицы(ЭтотОбъект, СтруктураДействийСДобавленнымиСтроками);
	
	СтруктураДействийСИзмененнымиСтроками = Новый Структура;
	ДобавитьВСтруктуруДействияПриИзмененииКоличестваТаблицы(ЭтотОбъект, СтруктураДействийСИзмененнымиСтроками);

	СтруктураДействий = ШтрихкодированиеНоменклатурыКлиент.ПараметрыОбработкиШтрихкодов();

	СтруктураДействий.Штрихкоды                              = ДанныеШтрихкодов;
	СтруктураДействий.СтруктураДействийСДобавленнымиСтроками = СтруктураДействийСДобавленнымиСтроками;
	СтруктураДействий.СтруктураДействийСИзмененнымиСтроками  = СтруктураДействийСИзмененнымиСтроками;
	СтруктураДействий.ИмяКолонкиКоличество                   = "Количество";
	СтруктураДействий.НеИспользоватьУпаковки                 = Истина;
	СтруктураДействий.ПараметрыУказанияСерий                 = ПараметрыУказанияСерий;
	СтруктураДействий.ТолькоТоварыИРабота                    = Истина;
	СтруктураДействий.ДополнятьТарой                         = Ложь;
	
	ОбработатьШтрихкодыСервер(СтруктураДействий,КэшированныеЗначения);
	
	ШтрихкодированиеНоменклатурыКлиент.ОбработатьНеизвестныеШтрихкоды(СтруктураДействий, КэшированныеЗначения, ЭтотОбъект);
	
	Если ШтрихкодированиеНоменклатурыКлиент.НужноОткрытьФормуУказанияСерийПослеОбработкиШтрихкодов(СтруктураДействий) Тогда
		ТекущиеДанныеИдентификатор = СтруктураДействий.МассивСтрокССериями[0];
		ПодключитьОбработчикОжидания("ОткрытьПодборСерийПриСканированииШтрихкодаНоменклатуры", 0.1, Истина);
	КонецЕсли;
	
	Если СтруктураДействий.ТекущаяСтрока <> Неопределено Тогда
		Элементы.Товары.ТекущаяСтрока = СтруктураДействий.ТекущаяСтрока;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Серии

&НаСервере
Функция ПараметрыФормыУказанияСерий(ТекущиеДанныеИдентификатор)
	
	Возврат НоменклатураСервер.ПараметрыФормыУказанияСерий(Объект, ПараметрыУказанияСерий, ТекущиеДанныеИдентификатор, ЭтотОбъект);
	
КонецФункции

&НаСервере
Процедура ОбработатьУказаниеСерийСервер(ПараметрыФормыУказанияСерий)
	
	СтруктураДействий = Новый Структура;
	НоменклатураСервер.ОбработатьУказаниеСерий(Объект, ПараметрыУказанияСерий, ПараметрыФормыУказанияСерий, СтруктураДействий);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСтатусыУказанияСерийПриОкончанииРедактированияСтрокиТЧ(ТекущаяСтрокаИдентификатор, КэшированныеЗначения)

	НоменклатураСервер.ЗаполнитьСтатусыУказанияСерийПриОкончанииРедактированияСтрокиТЧ(
		Объект, ПараметрыУказанияСерий, ТекущаяСтрокаИдентификатор, КэшированныеЗначения);

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСтатусыУказанияСерий(СтрокиТоваровДляОбработки = Неопределено, СтрокиСерийДляОбработки = Неопределено)
	
	НоменклатураСервер.ЗаполнитьСтатусыУказанияСерий(
		Объект,
		ПараметрыУказанияСерий,
		СтрокиТоваровДляОбработки,
		СтрокиСерийДляОбработки);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПодборСерийПриСканированииШтрихкодаНоменклатуры()
	
	Если ТекущиеДанныеИдентификатор = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Объект.Товары.НайтиПоИдентификатору(ТекущиеДанныеИдентификатор);
	ОткрытьПодборСерий("", ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПодборСерий(Текст, ТекущиеДанные = Неопределено)
	
	Если НоменклатураКлиент.ДляУказанияСерийНуженСерверныйВызов(ЭтотОбъект, ПараметрыУказанияСерий, Текст) Тогда
		
		Если ТекущиеДанные = Неопределено Тогда
			ТекущиеДанныеИдентификатор = Элементы.Товары.ТекущиеДанные.ПолучитьИдентификатор();
		Иначе
			ТекущиеДанныеИдентификатор = ТекущиеДанные.ПолучитьИдентификатор();
		КонецЕсли;
		
		ПараметрыФормыУказанияСерий = ПараметрыФормыУказанияСерий(ТекущиеДанныеИдентификатор);
		
		ОписаниеОповещения =
			Новый ОписаниеОповещения(
					"ОткрытьПодборСерийЗавершение",
					ЭтотОбъект,
					Новый Структура("ПараметрыФормыУказанияСерий", ПараметрыФормыУказанияСерий));
		
		ОткрытьФорму(
			ПараметрыФормыУказанияСерий.ИмяФормы,
			ПараметрыФормыУказанияСерий,
			ЭтотОбъект,,,,
			ОписаниеОповещения,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПодборСерийЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	ПараметрыФормыУказанияСерий = ДополнительныеПараметры.ПараметрыФормыУказанияСерий;
	
	Если Результат <> Неопределено Тогда
		ОбработатьУказаниеСерийСервер(ПараметрыФормыУказанияСерий);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПодготовитьЗаполнитьУстановитьВидимостьСерий()
	
	ПараметрыУказанияСерий = Новый ФиксированнаяСтруктура(НоменклатураСервер.ПараметрыУказанияСерий(Объект, Документы.ВыбытиеРНПТМатериаловИзПроизводства));
	
	НоменклатураСервер.ЗаполнитьСтатусыУказанияСерий(Объект, ПараметрыУказанияСерий);
	
	НастроитьЭлементыСерий();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьЭлементыСерий()
	
	Элементы.ТоварыСтатусУказанияСерий.Видимость = ПараметрыУказанияСерий.ИспользоватьСерииНоменклатуры;
	Элементы.ТоварыУказатьСерии.Видимость        = ПараметрыУказанияСерий.ИспользоватьСерииНоменклатуры;
	Элементы.ТоварыСерия.Видимость               = ПараметрыУказанияСерий.ИспользоватьСерииНоменклатуры;
	
КонецПроцедуры

#КонецОбласти

#Область Свойства

// СтандартныеПодсистемы.Свойства

&НаСервере
Процедура СвойстваВыполнитьОтложеннуюИнициализацию()
	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#Область ОбработкаСтруктурыДействий

&НаКлиентеНаСервереБезКонтекста
Процедура ДобавитьВСтруктуруДействияПриИзмененииНоменклатурыТаблицы(Форма, СтруктураДействий)

	СтруктураДействий.Вставить("ЗаполнитьПризнакАртикул", Новый Структура("Номенклатура", "Артикул"));
	СтруктураДействий.Вставить("ЗаполнитьПризнакТипНоменклатуры", Новый Структура("Номенклатура", "ТипНоменклатуры"));
	
	СтруктураДействий.Вставить(
		"ЗаполнитьПризнакХарактеристикиИспользуются",
		Новый Структура("Номенклатура", "ХарактеристикиИспользуются"));
	
	СтруктураДействий.Вставить("ПроверитьХарактеристикуПоВладельцу");
	
	СтруктураДействий.Вставить(
		"НоменклатураПриИзмененииПереопределяемый",
		Новый Структура("ИмяФормы, ИмяТабличнойЧасти", Форма.ИмяФормы, "Товары"));
	
	УчетПрослеживаемыхТоваровКлиентСерверЛокализация.ДополнитьОписаниеНастроекЗаполненияСлужебныхРеквизитовТабличнойЧасти(СтруктураДействий);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ДобавитьВСтруктуруДействияПриИзмененииКоличестваТаблицы(Форма, СтруктураДействий)

	УчетПрослеживаемыхТоваровКлиентСерверЛокализация.ДополнитьОписаниеНастроекПересчетаРеквизитовТабличнойЧасти(
		Форма.Объект,
		СтруктураДействий,
		"Подразделение",
		Истина);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ДобавитьВСтруктуруДействияПоСериям(СтруктураДействий, Склад, ПараметрыУказанияСерий)
	
	ПараметрыПроверкиСерий = Новый Структура("Склад, ПараметрыУказанияСерий", Склад, ПараметрыУказанияСерий);
	СтруктураДействий.Вставить("ПроверитьСериюРассчитатьСтатус", ПараметрыПроверкиСерий);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
