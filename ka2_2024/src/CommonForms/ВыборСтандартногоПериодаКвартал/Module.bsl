
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры, "НачалоПериода, КонецПериода, МинимальныйПериод");
	ДатаНачалаГода = ?(ЗначениеЗаполнено(КонецПериода), НачалоГода(КонецПериода), НачалоГода(ТекущаяДатаСеанса()));
	
	МинимальныйМесяц = Месяц(НачалоКвартала(МинимальныйПериод));
	МинимальныйПериод = НачалоГода(МинимальныйПериод);
	
	Если ДатаНачалаГода < МинимальныйПериод Тогда
		Отказ = Истина;
		ВызватьИсключение НСтр("ru = 'Неверные параметры выбора периода'");
	КонецЕсли;
	
	НарастающимИтогом = Параметры.Свойство("НарастающимИтогом") И Параметры.НарастающимИтогом;
	
	Элементы.ГруппаНарастающимИтогом.Видимость = НарастающимИтогом;
	Элементы.ГруппаКварталы.Видимость          = НЕ НарастающимИтогом;
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьАктивныйПериод();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПерейтиНаГодНазад(Команда)
	
	ДатаНачалаГода = НачалоГода(ДатаНачалаГода - 1);
	
	УстановитьАктивныйПериод();
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиНаГодВперед(Команда)
	
	ДатаНачалаГода = КонецГода(ДатаНачалаГода) + 1;
	
	УстановитьАктивныйПериод();
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал1(Команда)
	
	ВыбратьКвартал(1);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал2(Команда)
	
	ВыбратьКвартал(2);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал3(Команда)
	
	ВыбратьКвартал(3);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал4(Команда)
	
	ВыбратьКвартал(4);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Элементы = Форма.Элементы;
	
	ПрошлыйГодДоступен = Форма.ДатаНачалаГода > Форма.МинимальныйПериод;
	
	Элементы.ПерейтиНаГодНазад.Видимость           = ПрошлыйГодДоступен;
	Элементы.ПерейтиНаГодНазадНедоступно.Видимость = НЕ ПрошлыйГодДоступен;
	
	СуффиксТипПериода = ?(Форма.НарастающимИтогом, "Нарастающим", "");
	
	Если НЕ ПрошлыйГодДоступен И Форма.МинимальныйМесяц <> 1 Тогда
		
		// Установим доступность выбора кварталов
		ЭлементФормы = Элементы["ВыбратьКвартал1" + СуффиксТипПериода]; // ПолеФормы, КнопкаФормы -
		ЭлементФормы.Доступность = Ложь;
		ЭлементФормы = Элементы["ВыбратьКвартал2" + СуффиксТипПериода]; // ПолеФормы, КнопкаФормы -
		ЭлементФормы.Доступность = Форма.МинимальныйМесяц < 7;
		ЭлементФормы = Элементы["ВыбратьКвартал3" + СуффиксТипПериода]; // ПолеФормы, КнопкаФормы -
		ЭлементФормы.Доступность = Форма.МинимальныйМесяц < 10;
	Иначе
		ЭлементФормы = Элементы["ВыбратьКвартал1" + СуффиксТипПериода]; // ПолеФормы, КнопкаФормы -
		ЭлементФормы.Доступность = Истина;
		ЭлементФормы = Элементы["ВыбратьКвартал2" + СуффиксТипПериода]; // ПолеФормы, КнопкаФормы -
		ЭлементФормы.Доступность = Истина;
		ЭлементФормы = Элементы["ВыбратьКвартал3" + СуффиксТипПериода]; // ПолеФормы, КнопкаФормы -
		ЭлементФормы.Доступность = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьАктивныйПериод()
	
	Если НарастающимИтогом Тогда
		НомерКвартала = Месяц(КонецКвартала(КонецПериода)) / 3;
		ТекущийЭлемент = Элементы["ВыбратьКвартал" + НомерКвартала + "Нарастающим"];
	Иначе
		Если НачалоКвартала(НачалоПериода) = НачалоКвартала(КонецПериода) Тогда
			НомерКвартала = Месяц(КонецКвартала(НачалоПериода)) / 3;
			ТекущийЭлемент = Элементы["ВыбратьКвартал" + НомерКвартала];
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьВыборПериода()
	
	РезультатВыбора = Новый Структура("НачалоПериода, КонецПериода", НачалоПериода, КонецДня(КонецПериода));
	ОповеститьОВыборе(РезультатВыбора);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКвартал(НомерКвартала)
	
	НачалоПериодаКвартал = Дата(Год(ДатаНачалаГода), НомерКвартала * 3 - 2, 1);
	КонецПериода = КонецКвартала(НачалоПериодаКвартал);
	Если НарастающимИтогом Тогда
		НачалоПериода = ДатаНачалаГода;
	Иначе
		НачалоПериода = НачалоПериодаКвартал;
	КонецЕсли;
	
	ВыполнитьВыборПериода();
	
КонецПроцедуры

#КонецОбласти
