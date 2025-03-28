
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(ФизическоеЛицо)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиПравилРегистрации

// См. ЗарплатаКадрыРасширенныйСинхронизацияДанных.ШаблонОбработчика
Процедура ПриЗаполненииНастроекОбработчиковПравилРегистрации(Настройки) Экспорт
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыРасширеннаяПодсистемы") Тогда
		МодульЗарплатаКадрыРасширенныйСинхронизацияДанных = ОбщегоНазначения.ОбщийМодуль("ЗарплатаКадрыРасширенныйСинхронизацияДанных");
		МодульЗарплатаКадрыРасширенныйСинхронизацияДанных.ДляНезависимогоРегистра(Настройки, "ФизическоеЛицо", "ОбщиеДанные");
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

// Создает новую структуру для сведений о состоянии в браке.
// 
// Возвращаемое значение:
//  Структура - Новое состояние в браке:
// * СостояниеВБраке - СправочникСсылка.СостояниеВБраке -
// * Период - Дата -
Функция НовоеСостояниеВБраке() Экспорт
	
	СтруктураЗаписи = ОбщегоНазначенияБЗК.СтруктураПоИмениРегистраСведений("СостоянияВБракеФизическихЛиц");
	
	СостояниеВБраке = Новый Структура();
	СостояниеВБраке.Вставить("СостояниеВБраке", СтруктураЗаписи.СостояниеВБраке);
	СостояниеВБраке.Вставить("Период", СтруктураЗаписи.Период);
	
	Возврат СостояниеВБраке;
		
КонецФункции

// Добавляет запись о состояния в браке физического лица.
// 
// Параметры:
//  ФизическоеЛицо - СправочникСсылка.ФизическиеЛица
//  СостояниеВБраке - СправочникСсылка.СостояниеВБраке
//  Период - Дата
Процедура ДобавитьСостояниеВБракеФизическогоЛица(ФизическоеЛицо, СостояниеВБраке, Период = Неопределено) Экспорт
	
	НаборЗаписей = РегистрыСведений.СостоянияВБракеФизическихЛиц.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ФизическоеЛицо.Установить(ФизическоеЛицо);
	
	НоваяЗапись = НаборЗаписей.Добавить();
	НаборЗаписей.Заполнить(Неопределено);
	Если Период <> Неопределено Тогда
		НоваяЗапись.Период = Период;
	КонецЕсли;
	НоваяЗапись.ФизическоеЛицо = ФизическоеЛицо;
	НоваяЗапись.СостояниеВБраке = СостояниеВБраке;
	
	НаборЗаписей.ДополнительныеСвойства.Вставить("ОтключитьПроверкуДатыЗапретаИзменения", Истина);
	НаборЗаписей.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
