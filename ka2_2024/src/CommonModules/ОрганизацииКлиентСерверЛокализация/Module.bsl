#Область СлужебныйПрограммныйИнтерфейс

//++ Локализация

//++ НЕ УТ

Процедура УправлениеДокументооборотом(Форма) Экспорт
	Если Форма.Объект.ВидОбменаСКонтролирующимиОрганами = ПредопределенноеЗначение("Перечисление.ВидыОбменаСКонтролирующимиОрганами.ОбменВУниверсальномФормате") Тогда
		Форма.ВидОбменаСКонтролирующимиОрганамиПредставление = НСтр("ru='Обмен в универсальном формате'");
	ИначеЕсли Форма.Объект.ВидОбменаСКонтролирующимиОрганами = ПредопределенноеЗначение("Перечисление.ВидыОбменаСКонтролирующимиОрганами.ОбменЧерезСпринтер") Тогда
		Форма.ВидОбменаСКонтролирующимиОрганамиПредставление = НСтр("ru='Обмен посредством ПК ""Спринтер""'");
	Иначе
		Форма.ВидОбменаСКонтролирующимиОрганамиПредставление = НСтр("ru='Не используется'");
	КонецЕсли;
	
	Форма.Элементы.ВидОбменаСКонтролирующимиОрганамиПредставление.ПропускатьПриВводе = ЗначениеЗаполнено(Форма.Объект.ВидОбменаСКонтролирующимиОрганами);
КонецПроцедуры

//-- НЕ УТ

Процедура УправлениеДоступностью(Форма) Экспорт
	
	ПартнерыИКонтрагентыЛокализацияКлиентСервер.УстановитьДоступностьКнопкиЗаполнитьПоИНН(Форма,
	                                                                       Форма.Объект.ЮрФизЛицо,
	                                                                       Форма.Объект.ИНН,
	                                                                       Форма.Объект.ОбособленноеПодразделение,
	                                                                       Форма.НастройкиПодключенияКСервисуИППЗаданы,
	                                                                       Ложь);
	
	Если Форма.Объект.ЮрФизЛицо = ПредопределенноеЗначение("Перечисление.ЮрФизЛицо.ЮрЛицоНеРезидент")
		И Форма.Объект.СтранаРегистрации = ПредопределенноеЗначение("Справочник.СтраныМира.Россия") Тогда
		
		Форма.Объект.СтранаРегистрации = ПредопределенноеЗначение("Справочник.СтраныМира.ПустаяСсылка");
		
	КонецЕсли;
	
КонецПроцедуры
//-- Локализация

#КонецОбласти
