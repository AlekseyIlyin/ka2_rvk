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
	
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ВедомостьПоПереданнойВозвратнойТаре);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "");
	ОписаниеВарианта.Описание = НСтр("ru= 'Сводный анализ оборотов переданной клиентам возвратной тары за определенный период.'");
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ВедомостьПоПереданнойВозвратнойТаре");
	ОписаниеВарианта.Описание = НСтр("ru= 'Сводный анализ оборотов переданной клиентам возвратной тары за определенный период.
		|Какова ее стоимость и количество?'");
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
