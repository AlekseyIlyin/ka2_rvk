#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Заполняет список выбора статуса
//
// Параметры:
//  ДанныеВыбора			 - СписокЗначений	 - заполняемый список значений
//
Процедура ЗаполнитьСписокВыбора(ДанныеВыбора) Экспорт
	
	ДанныеВыбора.Очистить();
	
	// Безусловные статусы
	ДанныеВыбора.Добавить(Перечисления.СтатусыЗаказовМатериаловВПроизводство.КВыполнению);
	ДанныеВыбора.Добавить(Перечисления.СтатусыЗаказовМатериаловВПроизводство.Закрыт);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли