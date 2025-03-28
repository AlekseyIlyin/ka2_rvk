#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// См. ОбновлениеИнформационнойБазыБСП.ПриДобавленииОбработчиковОбновления.
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	Если ЗарплатаКадры.АвтономнаяРаботаРазрешеноИзменениеДанных(Метаданные.РегистрыСведений.МаксимальныйРазмерЕжемесячнойСтраховойВыплаты) Тогда
		Обработчик = Обработчики.Добавить();
		Обработчик.Версия = "3.1.30.123";
		Обработчик.Процедура = "РегистрыСведений.МаксимальныйРазмерЕжемесячнойСтраховойВыплаты.НачальноеЗаполнение";
		Обработчик.ОбщиеДанные = Истина;
		Обработчик.НачальноеЗаполнение = Истина;
		Обработчик.РежимВыполнения = "Оперативно";
	КонецЕсли;
КонецПроцедуры

// Начальное заполнение и обновление информационной базы.
Процедура НачальноеЗаполнение() Экспорт
	Обновить(ПолучитьМакет("ПредопределенныеЗначения").ПолучитьТекст(), Ложь);
КонецПроцедуры

// Обновляет данные регистра.
Процедура Обновить(ТекстXML, ПолучатьДанныеИзСервиса = Истина) Экспорт
	ЗарплатаКадры.ОбновитьКлассификатор(ТекстXML, ПолучатьДанныеИзСервиса);
КонецПроцедуры

#КонецОбласти

#КонецЕсли