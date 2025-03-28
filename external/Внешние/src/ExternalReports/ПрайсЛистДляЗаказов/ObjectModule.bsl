//
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ РЕГИСТРАЦИИ ОБРАБОТКИ
//

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
	
	// Объявим переменную, в которой мы сохраним и вернем "наружу" необходимые данные
 
    ПараметрыРегистрации = Новый Структура;
    
    // Объявим еще одну переменную, которая нам потребуется ниже
 
    МассивНазначений = Новый Массив;
    
    // Первый параметр, который мы должны указать - это какой вид обработки системе должна зарегистрировать. 
 
    // Допустимые типы: ДополнительнаяОбработка, ДополнительныйОтчет, ЗаполнениеОбъекта, Отчет, ПечатнаяФорма, СозданиеСвязанныхОбъектов
 
    ПараметрыРегистрации.Вставить("Вид", "ДополнительныйОтчет");
            
    ПараметрыРегистрации.Вставить("Назначение", МассивНазначений);
    
    // Теперь зададим имя, под которым ВПФ будет зарегистрирована в справочнике внешних обработок
 
    ПараметрыРегистрации.Вставить("Наименование", "'Прайс-лист внешний");
    
    // Зададим право обработке на использование безопасного режима. Более подробно можно узнать в справке к платформе (метод УстановитьБезопасныйРежим)
 
    ПараметрыРегистрации.Вставить("БезопасныйРежим", Истина);
    
    // Следующие два параметра играют больше информационную роль, т.е. это то, что будет видеть пользователь в информации к обработке
 
    ПараметрыРегистрации.Вставить("Версия", "1.01");    
    ПараметрыРегистрации.Вставить("Информация", "Дополнительный отчет 'Прайс-лист внешний'");
    
    // Создадим таблицу команд (подробнее смотрим ниже)
 
    ТаблицаКоманд = ПолучитьТаблицуКоманд();
    
    // Добавим команду в таблицу
 
    ДобавитьКоманду(ТаблицаКоманд, "Прайс-лист внешний", "ФормаОтчета", "ОткрытиеФормы", Ложь, "ПечатьMXL");
    
    // Сохраним таблицу команд в параметры регистрации обработки
 
    ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
    
    // Теперь вернем системе наши параметры
 
    Возврат ПараметрыРегистрации;

КонецФункции

//
// ВСПОМОГАТЕЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ РЕГИСТРАЦИИ ОБРАБОТКИ
//

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
Функция ПолучитьПараметрыРегистрации(ОбъектыНазначенияФормы = Неопределено, НаименованиеОбработки = "", Информация = "", Версия = "1.0")

	Если ТипЗнч(ОбъектыНазначенияФормы) = Тип("Строка") Тогда
		ОбъектНазначенияФормы = ОбъектыНазначенияФормы;
		ОбъектыНазначенияФормы = Новый Массив;
		ОбъектыНазначенияФормы.Добавить(ОбъектНазначенияФормы);
	КонецЕсли; 
	
	ПараметрыРегистрации = Новый Структура;
	ПараметрыРегистрации.Вставить("Вид", "ПечатнаяФорма");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
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
Функция ПолучитьТаблицуКоманд()

	Команды = Новый ТаблицаЗначений;
	
	//Представление команды в пользовательском интерфейсе
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	
	//Уникальный идентификатор команды или имя макета печати
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	
	//Способ вызова команды: "ОткрытиеФормы", "ВызовКлиентскогоМетода", "ВызовСерверногоМетода"
	// "ОткрытиеФормы" - применяется только для отчетов и дополнительных отчетов
	// "ВызовКлиентскогоМетода" - вызов процедуры Печать(), определённой в модуле формы обработки
	// "ВызовСерверногоМетода" - вызов процедуры Печать(), определённой в модуле объекта обработки
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	
	//Показывать оповещение.
	//Если Истина, требуется показать оповещение при начале и при завершении работы обработки. 
	//Имеет смысл только при запуске обработки без открытия формы
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	
	//Дополнительный модификатор команды. 
	//Используется для дополнительных обработок печатных форм на основе табличных макетов.
	//Для таких команд должен содержать строку ПечатьMXL
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

