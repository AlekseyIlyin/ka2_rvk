Функция СведенияОВнешнейОбработке() Экспорт
	
    ПараметрыРегистрации = Новый Структура;
    ПараметрыРегистрации.Вставить("Вид", "ДополнительнаяОбработка");

    ПараметрыРегистрации.Вставить("Наименование", "Создать листы кассовой книги");
    ПараметрыРегистрации.Вставить("Версия", "1.0");
    ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
    ПараметрыРегистрации.Вставить("Информация", "Создать листы кассовой книги");
    ТаблицаКоманд = ПолучитьТаблицуКоманд();
	
	ДобавитьКоманду(
		ТаблицаКоманд,
    	"Создать листы кассовой книги",
    	"СоздатьЛистыКассовойКниги",
    	"ОткрытиеФормы",
    	Истина,
		"");
	
    ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Функция ПолучитьТаблицуКоманд()
    Команды = Новый ТаблицаЗначений;
    Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
    Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
    Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
    Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
    Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));
    Возврат Команды;
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
    НоваяКоманда = ТаблицаКоманд.Добавить();
    НоваяКоманда.Представление = Представление;
    НоваяКоманда.Идентификатор = Идентификатор;
    НоваяКоманда.Использование = Использование;
    НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
    НоваяКоманда.Модификатор = Модификатор;
КонецПроцедуры
