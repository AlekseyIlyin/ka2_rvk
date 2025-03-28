////////////////////////////////////////////////////////////////////////////////
// ЕдиныйНалоговыйСчетИнтеграцияВнутренний
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Функция ДатаНачалаЗапросовЕНС() Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.ДатаНачалаЗапросовЕНС();
	
КонецФункции

Функция ДатаНачалаПримененияЕНС() Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.ДатаНачалаПримененияЕНС();
	
КонецФункции

Процедура ЗаполнитьПоставляемыеДанныеСправочников() Экспорт
	
	ЕдиныйНалоговыйСчетИнтеграция.ЗаполнитьПоставляемыеДанныеСправочников();
	
КонецПроцедуры

Функция ПоследовательностьМетодов(ИспользоватьМетодыСервисаДанныхЕНС = Ложь, СписокЗаявленныхМетодов = "", СписокИсключаемыхМетодов = "") Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.ПоследовательностьМетодов(ИспользоватьМетодыСервисаДанныхЕНС, СписокЗаявленныхМетодов, СписокИсключаемыхМетодов);
	
КонецФункции

Функция СписокСправочников() Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.СписокСправочников();
	
КонецФункции

Функция СписокСправочниковДляЗагрузки(ИспользоватьМетодыСервисаДанныхЕНС) Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.СписокСправочниковДляЗагрузки(ИспользоватьМетодыСервисаДанныхЕНС);
	
КонецФункции

Функция ЭтоМедленныйРежимРаботы() Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.ЭтоМедленныйРежимРаботы();
	
КонецФункции

Функция ИнтервалИсполненияМетодов() Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.ИнтервалИсполненияМетодов();
	
КонецФункции

Функция ПолучитьДатуПоследнегоОбновления(Организация, ВидДанных = Неопределено) Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.ПолучитьДатуПоследнегоОбновления(Организация, ВидДанных);
	
КонецФункции

Функция ПолучитьДатуАктуальности(Организация, ВидДанных = Неопределено) Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.ПолучитьДатуАктуальности(Организация, ВидДанных);
	
КонецФункции

Функция ДанныеКонсистенты(Организация) Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.ДанныеКонсистенты(Организация);
	
КонецФункции

Функция НомерМашиночитаемойДоверенности(Параметры) Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.НомерМашиночитаемойДоверенности(Параметры);
	
КонецФункции

Функция СправочникиТребуютОбновления() Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.СправочникиТребуютОбновления();
	
КонецФункции

Функция СправочникТребуетОбновления(ИмяСправочника) Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.СправочникТребуетОбновления(ИмяСправочника);
	
КонецФункции

Процедура ВосстановитьАрхивнуюКопиюДанных(Параметры) Экспорт
	
	ЕдиныйНалоговыйСчетИнтеграция.ВосстановитьАрхивнуюКопиюДанных(Параметры);
	
КонецПроцедуры

Функция СобытиеЖурналаРегистрации() Экспорт
	
	Возврат ЕдиныйНалоговыйСчетИнтеграция.СобытиеЖурналаРегистрации();
	
КонецФункции

#КонецОбласти
