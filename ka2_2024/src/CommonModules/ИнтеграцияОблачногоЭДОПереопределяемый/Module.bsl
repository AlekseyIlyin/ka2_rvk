
// @strict-types

#Область ПрограммныйИнтерфейс

// При определении ключевых реквизитов организаций.
// 
// Параметры:
//  КлючевыеРеквизитыОрганизаций - ТаблицаЗначений:
//  * Организация - ОпределяемыйТип.Организация
//  * ИНН - Строка
//  * КПП - Строка
Процедура ПриЗаполненииКлючевыхРеквизитовОрганизаций(КлючевыеРеквизитыОрганизаций) Экспорт
	
КонецПроцедуры

// При определении ключевых реквизитов контрагентов.
// 
// Параметры:
//  КлючевыеРеквизитыКонтрагентов - ТаблицаЗначений:
//  * Контрагент - ОпределяемыйТип.КонтрагентБЭД
//  * Наименование - Строка
//  * ИНН - Строка
//  * КПП - Строка
Процедура ПриЗаполненииКлючевыхРеквизитовКонтрагентов(КлючевыеРеквизитыКонтрагентов) Экспорт
	
КонецПроцедуры

// При определении ключевых реквизитов договоров.
// 
// Параметры:
//  КлючевыеРеквизитыДоговоров - ТаблицаЗначений:
//  * Договор - ОпределяемыйТип.ДоговорСКонтрагентомЭДО
//  * Наименование - Строка
//  * Номер - Строка
//  * Дата - Дата
//  * Организация - ОпределяемыйТип.Организация
//  * Контрагент - ОпределяемыйТип.КонтрагентБЭД
Процедура ПриЗаполненииКлючевыхРеквизитовДоговоров(КлючевыеРеквизитыДоговоров) Экспорт
	
КонецПроцедуры

// При заполнении организаций по ключевым реквизитам.
// 
// Параметры:
//  КлючевыеРеквизитыОрганизаций - ТаблицаЗначений:
//  * Организация - ОпределяемыйТип.Организация
//  * ИНН - Строка
//  * КПП - Строка
Процедура ПриЗаполненииОрганизацийПоКлючевымРеквизитам(КлючевыеРеквизитыОрганизаций) Экспорт
	
КонецПроцедуры

// При заполнении контрагентов по ключевым реквизитам.
// 
// Параметры:
//  КлючевыеРеквизитыКонтрагентов - ТаблицаЗначений:
//  * Контрагент - ОпределяемыйТип.КонтрагентБЭД
//  * ИНН - Строка
//  * КПП - Строка
Процедура ПриЗаполненииКонтрагентовПоКлючевымРеквизитам(КлючевыеРеквизитыКонтрагентов) Экспорт
	
КонецПроцедуры

// При заполнении договоров по ключевым реквизитам.
// 
// Параметры:
//  КлючевыеРеквизитыДоговоров - ТаблицаЗначений:
//  * Договор - ОпределяемыйТип.ДоговорСКонтрагентомЭДО
//  * Наименование - Строка
//  * Номер - Строка
//  * Дата - Дата
//  * Организация - ОпределяемыйТип.Организация
//  * Контрагент - ОпределяемыйТип.КонтрагентБЭД
Процедура ПриЗаполненииДоговоровПоКлючевымРеквизитам(КлючевыеРеквизитыДоговоров) Экспорт
	
КонецПроцедуры

#КонецОбласти
