#Область ОписаниеПеременных

&НаКлиенте
Перем МодульМТ; // Общий клиентский модуль со спецификой мобильной торговли

// ОписаниеПеременных
#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтррКонтекст = Новый Структура; // общие значения модуля формы
	СтррКонтекст.Вставить("СпрТоргТочки"); // KT2000_Alcohol_Trade признаки для получения свойств конфигурации и торговых точек
	
	ТекОбъект = РеквизитФормыВЗначение("Объект");		
	ТекОбъект.КонтекстФормыИнициализировать(СтррКонтекст, Параметры);
	ТекОбъект.ВОКонтекстФормыДополнить(СтррКонтекст, "_Мерчендайзинг", Истина);
	
	ПрочестьОбъектИзХранилища();

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// Загружаем общий клиентский модуль "МодульОбщийМТ". В параметре "Параметры" важно передавать структуру с заполненным
	// свойством "ВХОбщиеПараметры" - оно используется для предотвращения повторной загрузки текущей обработки.
	//@skip-check use-non-recommended-method
	//@skip-check form-self-reference
	МодульМТ = ПолучитьФорму(СтррКонтекст.ПутьКФорме + "МодульОбщийМТ", СтррКонтекст, ЭтаФорма, "АгентПлюсМодульОбщийМТ"); // в СтррКонтекст есть заполненное свойство "ВХОбщиеПараметры"
	МодульМТ.ВОПриОткрытии(ЭтотОбъект);		
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если МодульМТ.ОбработкаОповещенияФормы(ЭтотОбъект, ИмяСобытия, Параметр, Источник) Тогда
	ИначеЕсли ИмяСобытия = "АПДокументЗаписан_" + СтррКонтекст.ВО.ВидОбъекта Тогда // записан новый документ или обновлен существующий
		ПрочестьОбъектИзХранилища();
		МодульМТ.ВОЭлементыВыделить(ЭтотОбъект, Параметр);
	ИначеЕсли ИмяСобытия = "АПЗагруженыНовыеДанныеИзМУ" Тогда // загружены новые данные из МУ
		ПрочестьОбъектИзХранилища();
	КонецЕсли;
	
КонецПроцедуры

// ОбработчикиСобытийФормы
#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТПЭлементы

&НаКлиенте
Процедура ТПЭлементыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)

	Отказ = Истина;
	МодульМТ.ВООткрытьФормуИзФормыСписка(ЭтотОбъект, Истина, Копирование);
	
КонецПроцедуры

&НаКлиенте
Процедура ТПЭлементыПередУдалением(Элемент, Отказ)
	
	МодульМТ.ВОЭлементыПередПометкойУдаления(ЭтотОбъект, Элемент, Отказ);
	
КонецПроцедуры                      	

&НаКлиенте
Процедура ТПЭлементыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;	
	МодульМТ.ВОЭлементыВыбор(ЭтотОбъект);
	
КонецПроцедуры

// ОбработчикиСобытийЭлементовТаблицыФормыТПЭлементы
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаВыполнить(Команда)
	
	МодульМТ.КомандаВыполнить(Команда, ЭтотОбъект)
	
КонецПроцедуры

// ОбработчикиКомандФормы
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область СлужебныеПроцедурыИФункции_Хранилище

&НаСервере
Процедура ПрочестьОбъектИзХранилища()

	ТекОбъект = РеквизитФормыВЗначение("Объект");
	
	ТЗн = ТекОбъект.ВОТЗЗагрузить(СтррКонтекст.ВО);
	ТекОбъект[СтррКонтекст.ВО.РеквизитОбработки] = ТЗн;
	
	ЗначениеВРеквизитФормы(ТекОбъект, "Объект");

КонецПроцедуры

// СлужебныеПроцедурыИФункции_Хранилище
#КонецОбласти 

// СлужебныеПроцедурыИФункции
#КонецОбласти 
