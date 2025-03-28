
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не Параметры.Свойство("ПрайсЛист", ТорговоеПредложение) 
		Или Не ЗначениеЗаполнено(ТорговоеПредложение) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан("РегистрСведений.ТорговыеПредложенияТорговойПлощадки");
	
	ЗаполнитьНастройкиКратностиУпаковок();
	Модифицированность = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("ПередЗакрытиемПродолжение", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемПродолжение(Результат, ДополнительныеПараметры) Экспорт
	
	Отказ = Ложь;
	ЗаписатьЗакрытьПродолжение(Отказ);
	Если Не Отказ Тогда
		Модифицированность = Ложь; // не выводить подтверждение о закрытии формы еще раз.
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	ЗаписатьЗакрытьПродолжение( , Истина);
КонецПроцедуры

&НаКлиенте
Процедура Записать(Команда)
	ЗаписатьЗакрытьПродолжение();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьНастройкиКратностиУпаковок()
	
	ДанныеТорговыхПредложений = ТорговыеПредложенияСлужебный.
		ДанныеКратностиУпаковокПубликуемыхТорговыхПредложений(ТорговоеПредложение);
	
	Если ДанныеТорговыхПредложений.Количество() > 0 Тогда
		Модифицированность = Истина;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(ДанныеТорговыхПредложений, НастройкиКратностиУпаковок);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьЗакрытьПродолжение(Отказ = Ложь, Закрывать = Ложь)
	
	ОчиститьСообщения();
	
	Если Не Модифицированность Тогда
		Если Закрывать Тогда
			Закрыть();
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	ЗаписатьИЗакрытьНаСервере(Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ОповеститьОбИзменении(ТорговоеПредложение);
	
	Модифицированность = Ложь;
	Если Закрывать Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьИЗакрытьНаСервере(Отказ)
	
	Если Не ПроверитьЗаполнение() Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Для Каждого СтрокаНастроек Из НастройкиКратностиУпаковок Цикл
		
		РегистрыСведений.ТорговыеПредложенияТорговойПлощадки.ИзменитьКратностьУпаковкиЗаписи(
			ТорговоеПредложение, СтрокаНастроек, Отказ);
		
	КонецЦикла;
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыИзменения = ТорговыеПредложенияСлужебныйКлиентСервер.НовыйПараметрыИзмененияСостоянияТорговыхПредложений();
	ПараметрыИзменения.ТорговыеПредложения.Добавить(ТорговоеПредложение);
	РегистрыСведений.СостоянияСинхронизацииТорговыеПредложения.ИзменитьСостояниеПубликацииПрайсЛистов(ПараметрыИзменения);
	
КонецПроцедуры

#КонецОбласти
