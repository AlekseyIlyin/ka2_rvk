#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает допустимые значения видов мест выплаты зарплаты организаций.
//
// Возвращаемое значение:
// 	Массив - элементы типа ПеречислениеСсылка.ВидыМестВыплатыЗарплаты.
//
Функция ДопустимыеВидыМестВыплаты() Экспорт
	
	ДопустимыеВидыМестВыплаты = Новый Массив;
	ДопустимыеВидыМестВыплаты.Добавить(Перечисления.ВидыМестВыплатыЗарплаты.ЗарплатныйПроект);
	ДопустимыеВидыМестВыплаты.Добавить(Перечисления.ВидыМестВыплатыЗарплаты.Касса);

	Возврат ДопустимыеВидыМестВыплаты
	
КонецФункции	

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	ЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляОтбораПоОрганизации(Настройки);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли