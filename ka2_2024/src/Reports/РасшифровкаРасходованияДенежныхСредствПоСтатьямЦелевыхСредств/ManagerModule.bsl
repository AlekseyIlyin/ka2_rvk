#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)

	// Отчет доступен только для вызова в качестве расшифровки
	Если НЕ Параметры.Свойство("СформироватьПриОткрытии") Тогда
		Отказ = Истина;
		ВызватьИсключение НСтр("ru= 'Отчет не предназначен для ручного запуска.'");
	КонецЕсли;
	
КонецПроцедуры

#КонецЕсли