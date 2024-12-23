#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Сервисная экспортная функция. Вызывается в основной программе при регистрации обработки в информационной базе
// Возвращает структуру с параметрами регистрации
//
// Возвращаемое значение:
//		Структура с полями:
//			Вид - строка, вид обработки, один из возможных: "ДополнительнаяОбработка", "ДополнительныйОтчет", 
//					"ЗаполнениеОбъекта", "Отчет", "ПечатнаяФорма", "СозданиеСвязанныхОбъектов"
//			Назначение - Массив строк имен объектов метаданных в формате: 
//					<ИмяКлассаОбъектаМетаданного>.[ * | <ИмяОбъектаМетаданных>]. 
//					Например, "Документ.СчетЗаказ" или "Справочник.*". Параметр имеет смысл только для назначаемых обработок, для глобальных может не задаваться.
//			Наименование - строка - Наименование обработки, которым будет заполнено наименование элемента справочника по умолчанию.
//			Информация  - строка - Краткая информация или описание по обработке.
//			Версия - строка - Версия обработки в формате “<старший номер>.<младший номер>” используется при загрузке обработок в информационную базу.
//			БезопасныйРежим - булево - Принимает значение Истина или Ложь, в зависимости от того, требуется ли устанавливать или отключать безопасный режим 
//							исполнения обработок. Если истина, обработка будет запущена в безопасном режиме. 
//
//
Функция СведенияОВнешнейОбработке() Экспорт
 
	Версия = "1.0";    
	ПараметрыРегистрации = ПараметрыРегистрации("Дистрибьюция По ТП", "Дополнительный отчет 'Дистрибьюция По ТП'", Версия);
    
    ТаблицаКоманд = ТаблицаКоманд();
    ДобавитьКоманду(ТаблицаКоманд, "Дистрибьюция По ТП", "ФормаОтчета", "ОткрытиеФормы", Ложь, "ПечатьMXL");
    ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
 
    Возврат ПараметрыРегистрации;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Формирует структуру с параметрами регистрации регистрации обработки в информационной базе
//
// Параметры:
//	ОбъектыНазначенияФормы - Массив - Массив строк имен объектов метаданных в формате: 
//					<ИмяКлассаОбъектаМетаданного>.[ * | <ИмяОбъектаМетаданных>]. 
//					или строка с именем объекта метаданных 
//	НаименованиеОбработки - строка - Наименование обработки, которым будет заполнено наименование элемента справочника по умолчанию.
//							Необязательно, по умолчанию синоним или представление объекта
//	Информация  - строка - Краткая информация или описание обработки.
//							Необязательно, по умолчанию комментарий объекта
//	Версия - строка - Версия обработки в формате “<старший номер>.<младший номер>” используется при загрузке обработок в информационную базу.
//
//
// Возвращаемое значение:
//		Структура
//
Функция ПараметрыРегистрации(НаименованиеОбработки = "", Информация = "", Версия = "1.0")

	ПараметрыРегистрации = Новый Структура;

	ОбъектыНазначенияФормы = Новый Массив;
	
	ПараметрыРегистрации.Вставить("Вид", "ДополнительныйОтчет");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Истина);
	ПараметрыРегистрации.Вставить("Назначение", ОбъектыНазначенияФормы);
	
	Если Не ЗначениеЗаполнено(НаименованиеОбработки) Тогда
		НаименованиеОбработки = ЭтотОбъект.Метаданные().Представление();
	КонецЕсли; 
	ПараметрыРегистрации.Вставить("Наименование", НаименованиеОбработки);
	
	Если Не ЗначениеЗаполнено(Информация) Тогда
		Информация = ЭтотОбъект.Метаданные().Комментарий;
	КонецЕсли; 
	ПараметрыРегистрации.Вставить("Информация", Информация);
	
	ПараметрыРегистрации.Вставить("Версия", Версия);

	Возврат ПараметрыРегистрации;

КонецФункции

// Формирует таблицу значений с командами печати
//	
// Возвращаемое значение:
//		ТаблицаЗначений
//
Функция ТаблицаКоманд()

	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));

	Возврат Команды;

КонецФункции

// Вспомогательная процедура.
//
Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование = "ВызовСерверногоМетода", ПоказыватьОповещение = Ложь, Модификатор = "ПечатьMXL")

	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление;
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;

КонецПроцедуры

//Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
//	НастройкиСКД = ЭтотОбъект.КомпоновщикНастроек.Настройки;
//	ПараметрыДанныхЭлементы = НастройкиСКД.ПараметрыДанных.Элементы;
//	ЭлементыПользовательскихНастроек = ЭтотОбъект.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы;
//	
//	ИдентификаторПользовательскойНастройкиПараметраТорговыйПредставитель = ПараметрыДанныхЭлементы.Найти("ТорговыйПредставитель").ИдентификаторПользовательскойНастройки;
//	ЭлементПользовательскойНастройкиПараметраТП = ЭлементыПользовательскихНастроек.Найти(ИдентификаторПользовательскойНастройкиПараметраТорговыйПредставитель);
//	ИспользоватьПараметрТП = ЭлементПользовательскойНастройкиПараметраТП.Использование;
//	
//	ИдентификаторПользовательскойНастройкиПараметраПоБрендамВыборочно = ПараметрыДанныхЭлементы.Найти("БрендыВыборочно").ИдентификаторПользовательскойНастройки;
//	ЭлементПользовательскойНастройкиПараметраПоБрендамВыборочно = ЭлементыПользовательскихНастроек.Найти(ИдентификаторПользовательскойНастройкиПараметраПоБрендамВыборочно);
//	ИспользоватьПараметрПоБрендамВыборочно = ЭлементПользовательскойНастройкиПараметраПоБрендамВыборочно.Использование;
//	
//	Для Каждого ЭлементСтруктурыОтчета Из НастройкиСКД.Структура Цикл
//		Если ТипЗнч(ЭлементСтруктурыОтчета) = Тип("НастройкиВложенногоОбъектаКомпоновкиДанных") Тогда
//			Если ЭлементСтруктурыОтчета.ИдентификаторОбъекта = "БрендыВыборочно" Тогда
//				//ИдентификаторПользовательскойНастройкиПараметраПоБрендамВыборочно = ЭлементСтруктурыОтчета.Настройки.ПараметрыДанных.Элементы.Найти("БрендыВыборочно").ИдентификаторПользовательскойНастройки;
//				//ЭлементПользовательскойНастройкиПараметраПоБрендамВыборочно = ЭтотОбъект.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(ИдентификаторПользовательскойНастройкиПараметраПоБрендамВыборочно);
//				//ИспользоватьПараметрПоБрендамВыборочно = ЭлементПользовательскойНастройкиПараметраПоБрендамВыборочно.Использование;
//				ЭлементСтруктурыОтчета.Использование = ИспользоватьПараметрПоБрендамВыборочно;
//			КонецЕсли;
//			ЭлементСтруктурыОтчета.Настройки.ПараметрыДанных.Элементы.Найти("ТорговыйПредставитель").Использование = ИспользоватьПараметрТП;
//		КонецЕсли;
//	КонецЦикла;
//КонецПроцедуры

#КонецОбласти

#КонецЕсли