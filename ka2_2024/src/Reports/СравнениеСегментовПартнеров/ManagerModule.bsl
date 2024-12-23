//@strict-types

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// Задает расширенные настройки отчета
//
// Параметры:
//   Настройки - см. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.Настройки.
//
Процедура НастроитьВариантыОтчета(Настройки) Экспорт
	
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.СравнениеСегментовПартнеров);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Сколько клиентов в сегментах?
		|Какой объем продаж по сегментам?
		|Какое количество сделок и их состояние.'");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "Основной");
	ОписаниеВарианта.Описание = НСтр("ru= 'Сколько клиентов в сегментах?
		|Какой объем продаж по сегментам?
		|Какое количество сделок и их состояние.'");
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
