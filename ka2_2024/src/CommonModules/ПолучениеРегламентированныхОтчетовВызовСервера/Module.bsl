///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "ИнтернетПоддержкаПользователей.ПолучениеРегламентированныхОтчетов".
// ОбщийМодуль.ПолучениеРегламентированныхОтчетовВызовСервера.
//
// Серверные процедуры и функции загрузки регламентированных отчетов:
//  - настройка режима обновления регламентированных отчетов.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Определяет расписание регламентного задания обновления регламентированных отчетов.
//
// Возвращаемое значение:
//  РасписаниеРегламентногоЗадания - расписание обновления регламентированных отчетов.
//
Функция НастройкиОбновленияРегламентированныхОтчетов() Экспорт
	
	// Расписание и вариант обновления регламентированных отчетов не являются секретной информацией
	// и может быть получена любым пользователем ИБ.
	Если ПолучениеРегламентированныхОтчетов.ИнтерактивнаяЗагрузкаРегламентированныхОтчетовДоступна() Тогда
		УстановитьПривилегированныйРежим(Истина);
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("Расписание",        Неопределено);
	Результат.Вставить("ВариантОбновления", Константы.ВариантОбновленияРегламентированныхОтчетов.Получить());
	
	ЗаданияОбновления = ПолучениеРегламентированныхОтчетов.ЗаданияОбновлениеРегламентированныхОтчетов();
	Если ЗаданияОбновления.Количество() <> 0 Тогда
		Результат.Расписание = ЗаданияОбновления[0].Расписание;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Задает расписание регламентного задания.
//
// Параметры:
//  Расписание - РасписаниеРегламентногоЗадания - расписание обновления регламентированных отчетов.
//
Процедура ЗаписатьРасписаниеОбновления(Знач Расписание) Экспорт
	
	Если ПолучениеРегламентированныхОтчетов.ИнтерактивнаяЗагрузкаРегламентированныхОтчетовДоступна() Тогда
		УстановитьПривилегированныйРежим(Истина);
	КонецЕсли;
	
	ЗаданияОбновления = ПолучениеРегламентированныхОтчетов.ЗаданияОбновлениеРегламентированныхОтчетов();
	Если ЗаданияОбновления.Количество() <> 0 Тогда
		РегламентныеЗаданияСервер.УстановитьРасписаниеРегламентногоЗадания(
			ЗаданияОбновления[0],
			Расписание);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
