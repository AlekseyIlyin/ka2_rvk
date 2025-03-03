
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	ИнициализироватьДокумент(ДанныеЗаполнения);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ПроведениеДокументов.ПередЗаписьюДокумента(ЭтотОбъект, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ПроведениеДокументов.ОбработкаПроведенияДокумента(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	ПроведениеДокументов.ОбработкаУдаленияПроведенияДокумента(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат
	КонецЕсли;
	
	ПроведениеДокументов.ПриЗаписиДокумента(ЭтотОбъект, Отказ);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ИспользуетсяРаздельныйУчетПрибыль = 
		РаздельныйУчетПоНалогуНаПрибыль.ИспользуетсяРаздельныйУчет(Организация, Дата);
	
	Если ЗначениеЗаполнено(Организация) И ЗначениеЗаполнено(Дата) И ИспользуетсяРаздельныйУчетПрибыль Тогда
		
		ПроверяемыеРеквизиты.Добавить("НачисленныйНалог.ВариантНалогообложенияПрибыли");
		ПроверяемыеРеквизиты.Добавить("РасчетДолейБазыНалогаНаПрибыльПоВариантамНалогообложения.ПериодРасчета");
		ПроверяемыеРеквизиты.Добавить("РасчетДолейБазыНалогаНаПрибыльПоВариантамНалогообложения.РегистрацияВНалоговомОргане");
		ПроверяемыеРеквизиты.Добавить("РасчетДолейБазыНалогаНаПрибыльПоВариантамНалогообложения.ВариантНалогообложенияПрибыли");
		ПроверяемыеРеквизиты.Добавить("РасчетДолейБазыНалогаНаПрибыльПоВариантамНалогообложения.НалоговаяБаза");
		ПроверяемыеРеквизиты.Добавить("РасчетДолейБазыНалогаНаПрибыльПоВариантамНалогообложения.ДоляНалоговойБазы");
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ИнициализацияИЗаполнение

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)

	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизаций") Тогда
		Организация = ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
	КонецЕсли;
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		Если ДанныеЗаполнения.Свойство("ХозяйственнаяОперация") Тогда
			ХозяйственнаяОперация = ДанныеЗаполнения.ХозяйственнаяОперация;
		КонецЕсли;
		
		Если ДанныеЗаполнения.Свойство("Комментарий") Тогда
			Комментарий = ДанныеЗаполнения.Комментарий;
		КонецЕсли;
		
		Если ДанныеЗаполнения.Свойство("ЗначениеКопирования") Тогда
			ВводОстатковСервер.ЗаполнитьЗначенияПоСтаромуВводуОстатков(ЭтотОбъект, ДанныеЗаполнения.ЗначениеКопирования);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли