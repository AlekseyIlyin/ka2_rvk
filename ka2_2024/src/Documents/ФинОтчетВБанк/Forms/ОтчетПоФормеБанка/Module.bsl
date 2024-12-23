
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПараметрыОтчета = Параметры.ПараметрыОтчета;
	
	Заголовок = ПараметрыОтчета.ЗаголовокОтчета;
	
	ПараметрыОтчетаВХранилище = ПоместитьВоВременноеХранилище(ПараметрыОтчета, УникальныйИдентификатор);
	СформироватьОтчетНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РезультатПриАктивизации(Элемент)
	
	БухгалтерскиеОтчетыКлиент.НачатьРасчетСуммыВыделенныхЯчеек(
		Элементы.Результат,
		ЭтотОбъект,
		"Подключаемый_РезультатПриАктивизацииПодключаемый");
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатПриИзменении(Элемент)
	
	РучнаяКорректировка = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выгрузить(Команда)
	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("Результат", Результат);
	ПараметрыОтчета.Вставить("РучнаяКорректировка", РучнаяКорректировка);
	Закрыть(ПараметрыОтчета);
КонецПроцедуры

&НаКлиенте
Процедура СформироватьОтчет(Команда)
	
	СформироватьОтчетНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьКак(Команда)
	
	БухгалтерскиеОтчетыКлиент.ОтчетСохранитьКак(ЭтотОбъект);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьОтчетНаСервере()
	
	ПараметрыОтчета = ПолучитьИзВременногоХранилища(ПараметрыОтчетаВХранилище);
	РезультатФормированияОтчета = ЗаполнениеФинОтчетностиВБанки.СформироватьОтчетПоФормеБанка(ПараметрыОтчета);
	
	Если НЕ РезультатФормированияОтчета.Выполнено Тогда
		
		ОписаниеОшибки = ?(ПустаяСтрока(РезультатФормированияОтчета.ПодробноеПредставлениеОшибки),
			РезультатФормированияОтчета.КраткоеПредставлениеОшибки, РезультатФормированияОтчета.ПодробноеПредставлениеОшибки);
			
		ВызватьИсключение ОписаниеОшибки;
		
	КонецЕсли;
	
	Результат = РезультатФормированияОтчета.Результат;
	
КонецПроцедуры

&НаСервере
Процедура ВычислитьСуммуВыделенныхЯчеекТабличногоДокументаВКонтекстеНаСервере()
	
	ПолеСумма = БухгалтерскиеОтчетыВызовСервера.ВычислитьСуммуВыделенныхЯчеекТабличногоДокумента(
		Результат, КэшВыделеннойОбласти);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РезультатПриАктивизацииПодключаемый()
	
	НеобходимоВычислятьНаСервере = Ложь;
	БухгалтерскиеОтчетыКлиент.ВычислитьСуммуВыделенныхЯчеекТабличногоДокумента(
		ПолеСумма, Результат, Элементы.Результат, КэшВыделеннойОбласти, НеобходимоВычислятьНаСервере);
	
	Если НеобходимоВычислятьНаСервере Тогда
		ВычислитьСуммуВыделенныхЯчеекТабличногоДокументаВКонтекстеНаСервере();
	КонецЕсли;
	
	ОтключитьОбработчикОжидания("Подключаемый_РезультатПриАктивизацииПодключаемый");
	
КонецПроцедуры

#КонецОбласти