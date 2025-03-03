
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Заголовок = Параметры.КтоРаботал;
	
	СписокМесяцев = Отчеты.РегламентированныйОтчетСтатистикаФормаМПСП.СписокМесяцев();
	// Используем список, чтобы ограничить копируемые данные.
	ЗаполнитьЗначенияСвойств(СписокМесяцев, Параметры);
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, СписокМесяцев);
	// Далее будем использовать список для упорядочения.
	СписокМесяцев.Январь  = 1;
	СписокМесяцев.Февраль = 2;
	СписокМесяцев.Март    = 3;
	СписокМесяцев.Апрель  = 4;
	СписокМесяцев.Май     = 5;
	СписокМесяцев.Июнь    = 6;
	СписокМесяцев.Июль    = 7;
	СписокМесяцев.Август  = 8;
	СписокМесяцев.Сентябрь= 9;
	СписокМесяцев.Октябрь = 10;
	СписокМесяцев.Ноябрь  = 11;
	СписокМесяцев.Декабрь = 12;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ЯнварьПриИзменении(Элемент)
	МесяцПриИзменении(1);
КонецПроцедуры

&НаКлиенте
Процедура ФевральПриИзменении(Элемент)
	МесяцПриИзменении(2);
КонецПроцедуры

&НаКлиенте
Процедура МартПриИзменении(Элемент)
	МесяцПриИзменении(3);
КонецПроцедуры

&НаКлиенте
Процедура АпрельПриИзменении(Элемент)
	МесяцПриИзменении(4);
КонецПроцедуры

&НаКлиенте
Процедура МайПриИзменении(Элемент)
	МесяцПриИзменении(5);
КонецПроцедуры

&НаКлиенте
Процедура ИюньПриИзменении(Элемент)
	МесяцПриИзменении(6);
КонецПроцедуры

&НаКлиенте
Процедура ИюльПриИзменении(Элемент)
	МесяцПриИзменении(7);
КонецПроцедуры

&НаКлиенте
Процедура АвгустПриИзменении(Элемент)
	МесяцПриИзменении(8);
КонецПроцедуры

&НаКлиенте
Процедура СентябрьПриИзменении(Элемент)
	МесяцПриИзменении(9);
КонецПроцедуры

&НаКлиенте
Процедура ОктябрьПриИзменении(Элемент)
	МесяцПриИзменении(10);
КонецПроцедуры

&НаКлиенте
Процедура НоябрьПриИзменении(Элемент)
	МесяцПриИзменении(11);
КонецПроцедуры

&НаКлиенте
Процедура ДекабрьПриИзменении(Элемент)
	МесяцПриИзменении(12);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сохранить(Команда)
	
	Для Каждого ЭлементМесяц Из СписокМесяцев Цикл
		СписокМесяцев.Вставить(ЭлементМесяц.Ключ, ЭтотОбъект[ЭлементМесяц.Ключ]);
	КонецЦикла;
	
	ОповеститьОВыборе(СписокМесяцев);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура МесяцПриИзменении(НомерТекущегоМесяца)
	
	ЗначениеТекущегоМесяца = 0;
	Для Каждого ЭлементМесяц Из СписокМесяцев Цикл
		
		Если ЭлементМесяц.Значение = НомерТекущегоМесяца Тогда
			ЗначениеТекущегоМесяца = ЭтотОбъект[ЭлементМесяц.Ключ];
		ИначеЕсли ЭлементМесяц.Значение > НомерТекущегоМесяца Тогда
			ЭтотОбъект[ЭлементМесяц.Ключ] = ЗначениеТекущегоМесяца;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти