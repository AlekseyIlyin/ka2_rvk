
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(ГоловнаяОрганизация)
	|	И ЗначениеРазрешено(ФизическоеЛицо)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляРегистраПодчиненногоРегистратору(Настройки);
КонецПроцедуры

#КонецОбласти

// Процедура заполняет интервальный регистр сведений ТерриторииСотрудниковИнтервальный.
//
Процедура ЗаполнитьИнтервальныйРегистр(ПараметрыОбновления = Неопределено) Экспорт
	
	ЗарплатаКадрыПериодическиеРегистры.ПеренестиВозвратныйРегистрВИнтервальныйРегистрСведений(
		Метаданные.РегистрыСведений.ТерриторииСотрудников.Имя, ПараметрыОбновления);
	
КонецПроцедуры

// Вызывается для формирования интервального регистра из обработчиков обновления основного.
// В передаваемом МенеджерВременныхТаблиц должна быть создана временная таблица ВТОтборДляПереформирования
// с колонкой Сотрудник.
//
Процедура ОбновитьДвиженияИнтервальногоРегистра(МенеджерВременныхТаблиц) Экспорт
	
	ЗарплатаКадрыПериодическиеРегистры.ОбновитьДвиженияИнтервальногоРегистра(
		Метаданные.РегистрыСведений.ТерриторииСотрудников.Имя, МенеджерВременныхТаблиц);
	
КонецПроцедуры
	
Функция ОписаниеИнтервальногоРегистра() Экспорт
	
	ОписаниеИнтервальногоРегистра = ЗарплатаКадрыПериодическиеРегистры.ОписаниеИнтервальногоРегистра();
	
	ОписаниеИнтервальногоРегистра.ПараметрыНаследованияРесурсов = ПараметрыНаследованияРесурсов();
	ОписаниеИнтервальногоРегистра.ОсновноеИзмерение = "Сотрудник";
	ОписаниеИнтервальногоРегистра.ИзмеренияРасчета = "Сотрудник";
	
	Возврат ОписаниеИнтервальногоРегистра;
	
КонецФункции

Функция ПараметрыНаследованияРесурсов() Экспорт
	Возврат ЗарплатаКадрыПериодическиеРегистры.ПараметрыНаследованияРесурсов(Метаданные.РегистрыСведений.ТерриторииСотрудников.Имя);
КонецФункции

Процедура ПодготовитьОбновлениеЗависимыхДанныхПриОбменеПередЗаписью(Объект) Экспорт
	
	ЗарплатаКадрыПериодическиеРегистры.КонтрольИзмененийПередЗаписью(Объект);
	
КонецПроцедуры

Процедура ПодготовитьОбновлениеЗависимыхДанныхПриОбменеПриЗаписи(Объект) Экспорт
	
	ЗарплатаКадрыПериодическиеРегистры.КонтрольИзмененийПриЗаписи(Объект);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
