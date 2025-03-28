
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Сообщение = Параметры.Сообщение;
	Если Сообщение = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Заголовок = Сообщение.Описание;
	
	ТекстСообщенияXML = РаботаСXMLИС.ФорматироватьXMLСПараметрами(
			Сообщение.ТекстСообщенияXML,
			РаботаСXMLИС.ПараметрыФорматированияXML(Истина));
	
	ТабличныйДокументТекстСообщенияXML.УстановитьТекст(ТекстСообщенияXML);
	
	ОбщегоНазначенияСобытияФормИСПереопределяемый.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти