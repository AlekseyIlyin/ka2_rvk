#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

//++ НЕ УТ

// Заполняет реквизиты параметров настройки счетов учета расходов, которые влияют на настройку,
// 	соответствующими им именам реквизитов аналитики учета.
//
// Параметры:
// 	СоответствиеИмен - Соответствие - ключом выступает имя реквизита, используемое в настройке счетов учета,
// 		значением является соответствующее имя реквизита аналитики учета.
// 
Процедура ЗаполнитьСоответствиеРеквизитовНастройкиСчетовУчета(СоответствиеИмен) Экспорт
	
	СоответствиеИмен.Доходы = "Доходы";
	СоответствиеИмен.Расходы = "Расходы";
	
КонецПроцедуры
//-- НЕ УТ

#КонецОбласти

#КонецОбласти

#КонецЕсли
