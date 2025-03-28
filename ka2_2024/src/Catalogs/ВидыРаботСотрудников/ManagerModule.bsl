#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Определяется действующая на заданную дату расценка на вид работ.
// Если дата не указана, возвращается последнее заданное значение.
//
// Параметры:
//	ВидРабот - СправочникСсылка.ВидыРаботСотрудников - вид работ,
//	ДатаАктуальности - Дата - дата сведений,
//	КвалификационныйРазряд - СправочникСсылка.РазрядыКатегорииДолжностей, Неопределено - квалификационный разряд.
//
// Возвращаемое значение:
//  Число, Неопределено - действующая расценка или Неопределено, если ни одного значения не задано.
// 
Функция ДействующаяРасценкаВидаРабот(ВидРабот, ДатаАктуальности, КвалификационныйРазряд = Неопределено) Экспорт
	
	Отбор = Новый Структура("ВидРабот", ВидРабот);
	
	Если Не ЗначениеЗаполнено(КвалификационныйРазряд) Тогда
		Отбор.Вставить("КвалификационныйРазряд", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидРабот, "КвалификационныйРазряд"));
	Иначе
		Отбор.Вставить("КвалификационныйРазряд", КвалификационныйРазряд);
	КонецЕсли;
	
	СтруктураРасценки = РегистрыСведений.РасценкиРаботСотрудников.ПолучитьПоследнее(ДатаАктуальности, Отбор);
	
	Возврат СтруктураРасценки.Расценка;
	
КонецФункции

// Определяется настройки отражения в бух. учете по умолчанию для указанного вида работ.
//
// Параметры:
//   ВидРабот - СправочникСсылка.ВидыРаботСотрудников - Вид работ.
//
// Возвращаемое значение:
//   Структура - Описание полей см. в ресурсах регистра сведений БухучетРаботСотрудников.
//
Функция БухучетВидаРабот(ВидРабот) Экспорт
	ДанныеРегистра = Неопределено;
	ИнтеграцияБЗК.ЗаполнитьПоДаннымРегистраБухучетВидаРабот(ДанныеРегистра, ВидРабот);
	Возврат ДанныеРегистра;
КонецФункции

// СтандартныеПодсистемы.ВерсионированиеОбъектов
// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
// Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
КонецПроцедуры
// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Параметры автозаполения трудоемкости.
// 
// Параметры:
//  Объект - СправочникОбъект.ВидыРаботСотрудников
// 
// Возвращаемое значение:
//  Неопределено, Структура - Параметры автозаполения трудоемкости:
// * Трудоемкость - Число
// * КратностьТрудоемкости - Число
Функция ПараметрыАвтозаполенияТрудоемкости(Объект) Экспорт
	
	ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(
		Объект.ЕдиницаИзмерения, "ТипИзмеряемойВеличины,Числитель,Знаменатель");
	
	Если ЗначенияРеквизитов.ТипИзмеряемойВеличины = Перечисления.ТипыИзмеряемыхВеличин.Время
		И ЗначениеЗаполнено(ЗначенияРеквизитов.Числитель)
		И ЗначениеЗаполнено(ЗначенияРеквизитов.Знаменатель) Тогда
		
		Дробь = ПроизводствоСервер.Дробь(ЗначенияРеквизитов.Числитель, 3600 * ЗначенияРеквизитов.Знаменатель);
		ПроизводствоСервер.СократитьДробь(Дробь);
		
		Возврат Новый Структура("Трудоемкость,КратностьТрудоемкости", Дробь.Числитель, Дробь.Знаменатель);
		
	Иначе
		
		Возврат Неопределено;
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецЕсли