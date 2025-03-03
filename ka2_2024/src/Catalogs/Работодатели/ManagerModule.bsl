#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляРегламентированныхДанных(Настройки);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция РаботодательПоОрганизации(Организация) Экспорт
	
	Работодатель = Неопределено;
	
	Если ЗначениеЗаполнено(Организация) Тогда
		
		РеквизитыОрганизации = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Организация, "ИНН,РегистрацияВНалоговомОргане");
		КПП = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(РеквизитыОрганизации.РегистрацияВНалоговомОргане, "КПП");
		
		Запрос = Новый Запрос;
		Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	Работодатели.Ссылка
		|ИЗ
		|	Справочник.Работодатели КАК Работодатели
		|ГДЕ
		|	Работодатели.ИНН = &ИНН
		|	И Работодатели.КПП = &КПП";
		Запрос.УстановитьПараметр("ИНН", РеквизитыОрганизации.ИНН);
		Запрос.УстановитьПараметр("КПП", КПП);
		Результат = Запрос.Выполнить();
		Если Не Результат.Пустой() Тогда
			Выборка = Результат.Выбрать();
			Выборка.Следующий();
			Работодатель = Выборка.Ссылка;
		КонецЕсли;
		
		Если Работодатель = Неопределено Тогда
			НовыйРаботодатель = СоздатьЭлемент();
			НовыйРаботодатель.Заполнить(Новый Структура("Организация", Организация));
			НовыйРаботодатель.Записать();
			Работодатель = НовыйРаботодатель.Ссылка;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Работодатель; 
	
КонецФункции

#КонецОбласти
	
#КонецЕсли