#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

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

#Область СлужебрыйПрограммныйИнтерфейс

Функция ПолучитьПоказателиРасчета(Организация, Резерв, Период) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация",    Организация);
	Запрос.УстановитьПараметр("Резерв",         Резерв);
	Запрос.УстановитьПараметр("Период",         Период);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	НастройкиРасчетаРезервовПоОплатеТруда.Организация КАК Организация,
	|	НастройкиРасчетаРезервовПоОплатеТруда.Резерв КАК Резерв,
	|	НастройкиРасчетаРезервовПоОплатеТруда.Ссылка КАК ПараметрыРасчетаРезерва
	|ПОМЕСТИТЬ ВТ_НастройкиРасчетаРезервовПоОплатеТруда
	|ИЗ
	|	Справочник.НастройкиРасчетаРезервовПоОплатеТруда КАК НастройкиРасчетаРезервовПоОплатеТруда
	|ГДЕ
	|	НастройкиРасчетаРезервовПоОплатеТруда.Организация = &Организация
	|	И НастройкиРасчетаРезервовПоОплатеТруда.Резерв = &Резерв
	|	И &Период МЕЖДУ НастройкиРасчетаРезервовПоОплатеТруда.НачалоПериода И НастройкиРасчетаРезервовПоОплатеТруда.КонецПериода
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_НастройкиРасчетаРезервовПоОплатеТруда.ПараметрыРасчетаРезерва КАК ПараметрыРасчетаРезерва,
	|	ВТ_НастройкиРасчетаРезервовПоОплатеТруда.Организация КАК Организация,
	|	ВТ_НастройкиРасчетаРезервовПоОплатеТруда.Резерв КАК Резерв,
	|	НастройкиРасчетаРезервовПоОплатеТрудаВидыРасчетовРезерва.ВидРасчетаРезерва КАК ВидРасчетаРезерва
	|ПОМЕСТИТЬ ВТ_ВидыРасчетаРезерва
	|ИЗ
	|	ВТ_НастройкиРасчетаРезервовПоОплатеТруда КАК ВТ_НастройкиРасчетаРезервовПоОплатеТруда
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.НастройкиРасчетаРезервовПоОплатеТруда.ВидыРасчетовРезерва КАК НастройкиРасчетаРезервовПоОплатеТрудаВидыРасчетовРезерва
	|		ПО ВТ_НастройкиРасчетаРезервовПоОплатеТруда.ПараметрыРасчетаРезерва = НастройкиРасчетаРезервовПоОплатеТрудаВидыРасчетовРезерва.Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ВидыРасчетаРезерва.Организация КАК Организация,
	|	ВТ_ВидыРасчетаРезерва.Резерв КАК Резерв,
	|	ВТ_ВидыРасчетаРезерва.ПараметрыРасчетаРезерва КАК ПараметрыРасчетаРезерва,
	|	ВТ_ВидыРасчетаРезерва.ВидРасчетаРезерва КАК ВидРасчетаРезерва,
	|	ЗначенияПоказателейРасчетаРезервов.ПоказательРасчета КАК ПоказательРасчета,
	|	ЗначенияПоказателейРасчетаРезервов.Значение КАК Значение
	|ИЗ
	|	ВТ_ВидыРасчетаРезерва КАК ВТ_ВидыРасчетаРезерва
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЗначенияПоказателейРасчетаРезервов КАК ЗначенияПоказателейРасчетаРезервов
	|		ПО ВТ_ВидыРасчетаРезерва.Организация = ЗначенияПоказателейРасчетаРезервов.Организация
	|			И ВТ_ВидыРасчетаРезерва.ПараметрыРасчетаРезерва = ЗначенияПоказателейРасчетаРезервов.ПараметрыРасчетаРезерва
	|			И ВТ_ВидыРасчетаРезерва.ВидРасчетаРезерва = ЗначенияПоказателейРасчетаРезервов.ВидРасчетаРезерва";
	
	Результат = Запрос.Выполнить().Выгрузить();
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли
