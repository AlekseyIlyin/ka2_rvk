
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		ПриЧтенииСозданииНаСервере();
		
	КонецЕсли;
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриЧтенииСозданииНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	НастройкаСчетовУчетаСервер.ПриЗаписиОбъектаНастройкиСчетовУчета(ЭтотОбъект, Отказ, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	НастройкаСчетовУчетаСервер.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидАктиваПриИзменении(Элемент)
	
	ВидАктиваПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииСчетаУчета(Элемент)
	
	НастройкаСчетовУчетаКлиент.ПриИзмененииСчетаУчета(Элемент, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()

	ВидАктиваДоИзменения = Объект.ВидАктива;
	
	НастройкаСчетовУчетаСервер.ПриЧтенииСозданииОбъектаНастройкиСчетовУчета(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ВидАктиваПриИзмененииНаСервере()

	ИзменилсяВидАктива = (ЗначениеЗаполнено(Объект.ВидАктива) И Объект.ВидАктива <> ВидАктиваДоИзменения);
	
	Если ИзменилсяВидАктива Тогда
		НастройкаСчетовУчетаКлиентСервер.ПриИзмененииРеквизита(ЭтотОбъект);
	КонецЕсли;
	
	ВидАктиваДоИзменения = Объект.ВидАктива;
	
КонецПроцедуры

#КонецОбласти
