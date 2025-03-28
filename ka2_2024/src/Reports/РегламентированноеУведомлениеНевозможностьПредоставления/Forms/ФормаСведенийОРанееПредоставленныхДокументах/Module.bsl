#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Организация = Параметры.Организация;
	Для Каждого Элт Из СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок("ЭБФорма,_ТипДокОтв,_СведДокО,_Период,_ОтчетГод,_НомКорр,_НомДокОтв,_НаимДокОтв,_КодНОДокПред,_КНДПредДок,_ИмяФайлОтв,_ИмяОпис,_ДатаПрмЭ,_ДатаПрмБ,_ДатаДокОтв", ",") Цикл 
		Параметры.Свойство(Элт, ЭтотОбъект[Элт]);
	КонецЦикла;
	Для Каждого Стр Из Параметры._ИмяДокР Цикл 
		ЗаполнитьЗначенияСвойств(_ИмяДокР.Добавить(), Стр);
	КонецЦикла;
	
	Элементы.ВыбратьОтветНаТребование.Видимость = ИнтерфейсыВзаимодействияБРО.ОрганизацияИмеетУчетнуюЗапись(Параметры.Организация);
	УправлениеФормой(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
&НаКлиенте
Процедура ЭБФормаПриИзменении(Элемент)
	УправлениеФормой(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура _СведДокОПриИзменении(Элемент)
	УправлениеФормой(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура _ИмяФайлОтвНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ВыбратьОтветНаТребование(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Ок(Команда)
	Результат = Новый Структура;
	Для Каждого Элт Из СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок("ЭБФорма,_ТипДокОтв,_СведДокО,_Период,_ОтчетГод,_НомКорр,_НомДокОтв,_НаимДокОтв,_КодНОДокПред,_КНДПредДок,_ИмяФайлОтв,_ИмяОпис,_ДатаПрмЭ,_ДатаПрмБ,_ДатаДокОтв", ",") Цикл 
		Результат.Вставить(Элт, ЭтотОбъект[Элт]);
	КонецЦикла;
	Результат.Вставить("_ИмяДокР", _ИмяДокР);
	Результат.Вставить("ТекстовоеОписание", ?(ЭБФорма = 0, "документы предоставлены в электронном виде", "документы предоставлены в бумажном виде"));
	
	Закрыть(Результат);
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьОтветНаТребование(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ВыбратьОтветНаТребование(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗаполнитьФормуПоОтветуНаТребование(ДанныеОтветаНаТребование) Экспорт
	
	Если ДанныеОтветаНаТребование = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	_ИмяФайлОтв = ДанныеОтветаНаТребование._ИмяФайлОтв;
	_ИмяОпис = ДанныеОтветаНаТребование._ИмяОпис;
	_ДатаПрмЭ = ДанныеОтветаНаТребование._ДатаПрмЭ;
	_КодНОДокПред = ДанныеОтветаНаТребование._КодНОДокПред;
	_ИмяДокР.Очистить();
	Для Каждого Элт Из ДанныеОтветаНаТребование._ИмяДокР Цикл 
		НовСтр = _ИмяДокР.Добавить();
		НовСтр.ИмяДокР = Элт;
	КонецЦикла;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	Форма.Элементы.СведенияЭ.Видимость = (Форма.ЭБФорма = 0);
	Форма.Элементы.СведенияБ.Видимость = (Форма.ЭБФорма = 1);
	
	Форма.Элементы.РеквДокОтв.Видимость = (Форма._СведДокО = "01" Или Форма._СведДокО = "02" Или Форма._СведДокО = "99");
	Форма.Элементы.НДДокПредР.Видимость = (Форма._СведДокО = "03");
КонецПроцедуры

#КонецОбласти
