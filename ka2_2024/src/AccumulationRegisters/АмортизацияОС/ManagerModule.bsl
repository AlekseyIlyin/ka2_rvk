#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Заполняет параметры отражения движений регистра в финансовом учете
//
// Параметры:
//  МетаданныеРегистра - ОбъектМетаданныхРегистрНакопления - Метаданные регистра накопления
//  РегистрацияКОтражению - Булево - Признак получения параметров для регистрации к отражению в учете
//
// Возвращаемое значение:
// 	см. ФинансовыйУчетПоДаннымБалансовыхРегистров.ПараметрыОтраженияДвиженийВФинансовомУчете
//
Функция ПараметрыОтраженияДвиженийВФинансовомУчете(МетаданныеРегистра = Неопределено, РегистрацияКОтражению = Ложь) Экспорт
	
	ПараметрыОтражения = ФинансовыйУчетПоДаннымБалансовыхРегистров.ПараметрыОтраженияДвиженийВФинансовомУчете(РегистрацияКОтражению);
	
	Если РегистрацияКОтражению Тогда
		Возврат ПараметрыОтражения;
	КонецЕсли;
	
	ПараметрыОтражения.ПутьКДаннымОбъектНастройки = "ГруппаФинансовогоУчета";
	ПараметрыОтражения.ПутьКДаннымМестоУчета = "Подразделение";
	ПараметрыОтражения.ПутьКДаннымНаправлениеДеятельности = "НаправлениеДеятельности";
	ПараметрыОтражения.ПутьКДаннымПодразделение = "Подразделение";
	ПараметрыОтражения.РесурсыУпр.Добавить("Амортизация");
	ПараметрыОтражения.РесурсыРегл.Добавить("АмортизацияРегл");
	ПараметрыОтражения.РесурсыРегл.Добавить("АмортизацияЦФ");
	ПараметрыОтражения.ТипДанныхУчета = Перечисления.ТипыДанныхУчета.ПрочиеАктивыПассивы;
	ПараметрыОтражения.СтруктураАналитики = ОбщегоНазначения.СкопироватьРекурсивно(ИсточникиДанныхПовтИсп.СтруктураАналитикиПоТипуДанныхУчета(ПараметрыОтражения.ТипДанныхУчета));
	ПараметрыОтражения.СтруктураАналитики.СтатьяАктивовПассивов.Вставить("Значение", ПланыВидовХарактеристик.СтатьиАктивовПассивов.УпрБалансОсновныеСредства);
	ПараметрыОтражения.СтруктураАналитики.АналитикаАктивовПассивов.ПутьКДанным = "ОсновноеСредство";
	ПараметрыОтражения.СтруктураАналитики.Контрагент.Вставить("Значение", Неопределено);
	
	Если МетаданныеРегистра = Неопределено Тогда
		МетаданныеРегистра = СоздатьНаборЗаписей().Метаданные();
	КонецЕсли;
	
	ФинансовыйУчетПоДаннымБалансовыхРегистров.ЗаполнитьПараметрыОтраженияПоМетаданнымРегистра(ПараметрыОтражения, МетаданныеРегистра);
	
	Возврат ПараметрыОтражения;
	
КонецФункции


// Определяет показатели регистра.
//
//
// Параметры:
//  Свойства - Структура - содержащая ключи СвойстваПоказателей, СвойстваРесурсов.
//
// Возвращаемое значение:
//  Соответствие - Ключ - имя показателя.
//                 Значение - структура свойств показателя.
//
Функция Показатели(Свойства) Экспорт

	Показатели = Новый Соответствие;
	
	СвойстваПоказателей = Свойства.СвойстваПоказателей;
	СвойстваРесурсов = Свойства.СвойстваРесурсов;
	
	МассивРесурсов = Новый Массив;
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "Амортизация", "ВалютаУпр"));
	МассивРесурсов.Добавить(Новый Структура(СвойстваРесурсов, "АмортизацияРегл", "ВалютаРегл"));//АмортизацияРегл = АмортизацияРегл + АмортизацияЦФ
	Показатели.Вставить(Перечисления.ПоказателиАналитическихРегистров.Сумма, Новый Структура(СвойстваПоказателей, МассивРесурсов));
	
	Возврат Показатели;
	
КонецФункции

// Собирает структуру из текстов запросов для дальнейшей проверки даты запрета.
// 
// Параметры:
// 	Запрос - Запрос - Запрос по проверке даты запрета, можно установить параметры
// Возвращаемое значение:
// 	Структура - см. ЗакрытиеМесяцаСервер.ИнициализироватьСтруктуруТекстовЗапросов
Функция ТекстЗапросаКонтрольДатыЗапрета(Запрос) Экспорт
	ИмяРегистра = Метаданные.РегистрыНакопления.АмортизацияОС.Имя;
	ИмяТаблицыИзменений = "АмортизацияОСИзменение"; 
	СтруктураТекстовЗапросов = ПроведениеДокументов.ШаблонТекстЗапросаКонтрольДатыЗапрета(Запрос, 
		ИмяРегистра, 
		ИмяТаблицыИзменений, 
		"ФинансовыйКонтур");
	Возврат СтруктураТекстовЗапросов

КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// Параметры:
//   Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли
