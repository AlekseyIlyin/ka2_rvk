#Область ПрограммныйИнтерфейс

// Обработчик рег. задания ОбновлениеСостоянияЗаявокНаЛьготныйКредит
// 
Процедура ОбновитьСостояниеЛьготныхЗаявок() Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания();
	Документы.ЗаявкиНаЛьготныйКредит.ОбновитьСостоянияЗаявокВФоне();
		
КонецПроцедуры

// Проверка, что организация имеет право на льготный кредит по данным веб-сервиса ФНС.
//
// Параметры:
//  СписокИНН	 - Массив - Массив ИНН организаций, которые нужно проверить, что они имеют право на льготный кредит
// 
// Возвращаемое значение:
//   Массив, Неопределено - Массив ИНН организаций, которые имеют право на льготный кредит
//            В случае недоступности веб-сервиса возвращается Неопределено;
//            В случае отсутствия подсистемы ЛьготныеКредиты2020 возвращается Неопределено;
//
Функция ОрганизацииИмеющиеПравоНаЛьготныйКредит(СписокИНН) Экспорт
	
	Возврат Документы.ЗаявкиНаЛьготныйКредит.ОрганизацииИмеющиеПравоНаЛьготныйКредит(СписокИНН);
	
КонецФункции

// Получение по данным базы всех организаций, которые отправляли заявки на льготный кредит.
// Если организация создала заявку, но не отправила, то такие организации в результат не попадут.
// 
// Возвращаемое значение:
//  Массив, Неопределено - Массив организаций, которые уже отправляли заявки на льготный кредит
//            В случае отсутствия подсистемы ЛьготныеКредиты2020 возвращается Неопределено;
//
Функция ОрганизацииОтправлявшиеЗаявкиНаЛьготныйКредит() Экспорт
	Возврат Документы.ЗаявкиНаЛьготныйКредит.ОрганизацииОтправлявшиеЗаявкиНаЛьготныйКредит();
КонецФункции

Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
	
	// Заглушка от проверки конфигурации
	Отключены = Истина;
	
КонецПроцедуры

// См. ОчередьЗаданийПереопределяемый.ПриПолученииСпискаШаблонов.
//
Процедура ПриПолученииСпискаШаблонов(ШаблоныЗаданий) Экспорт
	
	// Заглушка от проверки конфигурации
	Отключены = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИспользуетсяРежимТестирования() Экспорт

	// Т.к. может не быть роли ПравоНаЗащищенныйДокументооборотСКонтролирующимиОрганами
	УстановитьПривилегированныйРежим(Истина);
	Возврат ДокументооборотСКОВызовСервера.ИспользуетсяРежимТестирования();
	
КонецФункции

#КонецОбласти