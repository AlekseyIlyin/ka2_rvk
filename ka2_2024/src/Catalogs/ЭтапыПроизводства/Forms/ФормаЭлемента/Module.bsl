#Область ОписаниеПеременных

&НаКлиенте
Перем КэшированныеЗначения; //используется механизмом обработки изменения реквизитов

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	ОсновнаяЕдиницаВремениБуфера = Справочники.ЭтапыПроизводства.ОсновнаяЕдиницаВремениБуфера();
	ОсновнаяЕдиницаВремениДлительностиЭтапаУББВ = Справочники.ЭтапыПроизводства.ОсновнаяЕдиницаВремениДлительностиЭтапаУББВ();
	
	Параметры.Свойство("Режим", Режим);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииСозданииНаСервере();
	КонецЕсли;
	
//++ Устарело_Производство21


//-- Устарело_Производство21
	
		Элементы.АльтернативнаяКоманднаяПанель.Видимость = Ложь;
		Элементы.ВидыРабочихЦентровИспользовать.Видимость = Ложь;
		
		// СтандартныеПодсистемы.Свойства
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Объект", Объект);
		ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "СтраницаДополнительныеРеквизиты");
		ДополнительныеПараметры.Вставить("ОтложеннаяИнициализация", Истина);
		УправлениеСвойствами.ПриСозданииНаСервере(ЭтаФорма, ДополнительныеПараметры);
		// Конец СтандартныеПодсистемы.Свойства

//++ Устарело_Производство21


//-- Устарело_Производство21
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
		
		// СтандартныеПодсистемы.Свойства
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
		// Конец СтандартныеПодсистемы.Свойства
		
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриЧтенииСозданииНаСервере();
	
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	
	МодификацияКонфигурацииПереопределяемый.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.МаксимальноеКоличествоЕдиницПартийИзделия = МаксимальноеКоличествоЕдиницПартийИзделия;
	
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	МодификацияКонфигурацииПереопределяемый.ПередЗаписьюНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_ЭтапыПроизводства",, Объект.Ссылка);
	
	МодификацияКонфигурацииКлиентПереопределяемый.ПослеЗаписи(ЭтаФорма, ПараметрыЗаписи);
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ЗаполнитьСлужебныеРеквизитыУслугиПереработчика();
	
	НастроитьЭлементыФормы();
	
	МодификацияКонфигурацииПереопределяемый.ПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	
	// Некоторые механизмы недоступны в режиме редактирования спецификации заказа
	Если Режим <> "СпецификацияЗаказа" Тогда		
		// Подсистема "Свойства"
		Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтаФорма, ИмяСобытия, Параметр) Тогда
			ОбновитьЭлементыДополнительныхРеквизитов();
			УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
		КонецЕсли;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	//++ Устарело_Производство21
	Если Режим = "СпецификацияЗаказа" Тогда
		
		СтандартнаяОбработка = Ложь;
		
		Если Модифицированность Тогда
			
			Отказ = Истина;
			ТекстВопроса = Нстр("ru = 'Данные были изменены. Перенести изменения?'");
			ОписаниеОповещения = Новый ОписаниеОповещения("ВопросПередЗакрытием", ЭтаФорма);
			ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена);
			
		КонецЕсли;
		
	КонецЕсли;
	//-- Устарело_Производство21
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Возврат;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Режим <> "СпецификацияЗаказа" Тогда
		// СтандартныеПодсистемы.Свойства
		УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтаФорма, Отказ, ПроверяемыеРеквизиты);
		// Конец СтандартныеПодсистемы.Свойства
	КонецЕсли;
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	Если НЕ РазбиватьМаршрутныеЛисты 
		Тогда
		МассивНепроверяемыхРеквизитов.Добавить("МаксимальноеКоличествоЕдиницПартийИзделия");
	КонецЕсли; 
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СпособПроизводстваПриИзменении(Элемент)

	Объект.ПроизводствоНаСтороне = Булево(СпособПроизводства);
	СписокРеквизитов = "СпособПроизводства";
	
	Если Объект.ПроизводствоНаСтороне Тогда
		
		Объект.ПланироватьРаботуВидовРабочихЦентров = Ложь;
		Объект.МаршрутнаяКарта  = Неопределено;
		Объект.КоэффициентМаршрутнойКарты = 0;
		
		СписокРеквизитов = СписокРеквизитов + ",ПланироватьРаботуВидовРабочихЦентров,МаршрутнаяКарта";
		
		ПолеПартнер = Элементы.Партнер;
		
	Иначе
		ПолеПартнер = Элементы.Организация;
	КонецЕсли;
	
	Объект.Партнер = ПолеПартнер.ОграничениеТипа.ПривестиЗначение(Объект.Партнер);
	
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, СписокРеквизитов);
	
	РедакторПроизводственногоПроцессаКлиентСервер.ЗаполнитьПояснениеОсновныхНастроек(Объект, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПодразделениеПриИзменении(Элемент)
	
	ПодразделениеПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура МаршрутнаяКартаПриИзменении(Элемент)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ПланироватьРаботуВидовРабочихЦентровПриИзменении(Элемент)
	
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, "ПланироватьРаботуВидовРабочихЦентров");
	
	РассчитатьДлительность();
	
	РедакторПроизводственногоПроцессаКлиентСервер.ЗаполнитьПояснениеОсновныхНастроек(Объект, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ЕдиницаИзмеренияДлительностиЭтапаПриИзменении(Элемент)
	
	Если Объект.ЕдиницаИзмеренияДлительностиЭтапа.Пустая() Тогда
		Объект.ЕдиницаИзмеренияДлительностиЭтапа = ОсновнаяЕдиницаВремениДлительностиЭтапаУББВ;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЕдиницаИзмеренияПредварительногоБуфераПриИзменении(Элемент)
	
	Если Объект.ЕдиницаИзмеренияПредварительногоБуфера.Пустая() Тогда
		
		Объект.ЕдиницаИзмеренияПредварительногоБуфера = ОсновнаяЕдиницаВремениБуфера;
		
	КонецЕсли;
	
	РассчитатьДлительность();
	
КонецПроцедуры

&НаКлиенте
Процедура ЕдиницаИзмеренияЗавершающегоБуфераПриИзменении(Элемент)
	
	Если Объект.ЕдиницаИзмеренияЗавершающегоБуфера.Пустая() Тогда
		
		Объект.ЕдиницаИзмеренияЗавершающегоБуфера = ОсновнаяЕдиницаВремениБуфера;
		
	КонецЕсли;
	
	РассчитатьДлительность();
	
КонецПроцедуры

&НаКлиенте
Процедура ОдновременноПроизводимоеКоличествоЕдиницПартийИзделийПриИзменении(Элемент)
	
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, "ОдновременноПроизводимоеКоличествоЕдиницПартийИзделий");
	
КонецПроцедуры

&НаКлиенте
Процедура РазбиватьМаршрутныеЛистыПриИзменении(Элемент)
	
	РедакторПроизводственногоПроцессаКлиент.УстановитьМаксимальноеКоличествоЕдиницПартийИзделия(
		РазбиватьМаршрутныеЛисты, МаксимальноеКоличествоЕдиницПартийИзделия);
	
	НастроитьЗависимыеЭлементыФормы(ЭтаФорма, "РазбиватьМаршрутныеЛисты");
	
КонецПроцедуры

&НаКлиенте
Процедура ПредварительныйБуферПриИзменении(Элемент)
	
	УстановитьОтметкуНезаполненногоДляБуферов(ЭтотОбъект);
	
	РассчитатьДлительность();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершающийБуферПриИзменении(Элемент)
	
	УстановитьОтметкуНезаполненногоДляБуферов(ЭтотОбъект);
	
	РассчитатьДлительность();
	
КонецПроцедуры

&НаКлиенте
Процедура УслугаПереработчикаПриИзменении(Элемент)
	
	ТекущаяСтрока = Новый Структура("Номенклатура, Характеристика, ХарактеристикиИспользуются");
	ТекущаяСтрока.Номенклатура = УслугаПереработчика;
	ТекущаяСтрока.Характеристика = ХарактеристикаУслугиПереработчика;
	ТекущаяСтрока.ХарактеристикиИспользуются = ХарактеристикиИспользуются;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПроверитьХарактеристикуПоВладельцу", ХарактеристикаУслугиПереработчика);
	ПакетнаяОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);
	
	ХарактеристикиИспользуются = ТекущаяСтрока.ХарактеристикиИспользуются;
	
	НастроитьЗависимыеЭлементыФормы(ЭтотОбъект, "Переработка");
	
КонецПроцедуры

&НаКлиенте
Процедура СтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	// СтандартныеПодсистемы.Свойства
	Если ТекущаяСтраница.Имя = "СтраницаДополнительныеРеквизиты"
		И Не ЭтотОбъект.ПараметрыСвойств.ВыполненаОтложеннаяИнициализация Тогда
		
		СвойстваВыполнитьОтложеннуюИнициализацию();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
		
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПорядокРаботыВидовРабочихЦентровПриИзменении(Элемент)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыВидыРабочихЦентров

&НаКлиенте
Процедура ВидыРабочихЦентровПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровПередУдалением(Элемент, Отказ)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровПослеУдаления(Элемент)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровИспользоватьПриИзменении(Элемент)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровВидРабочегоЦентраПриИзменении(Элемент)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровВариантНаладкиПриИзменении(Элемент)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровВремяРаботыПриИзменении(Элемент)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура ВидыРабочихЦентровЕдиницаИзмеренияПриИзменении(Элемент)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслугиПереработчика

&НаКлиенте
Процедура УслугиПереработчикаНоменклатураПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.УслугиПереработчика.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПроверитьХарактеристикуПоВладельцу", ТекущиеДанные.Характеристика);
	
	ПакетнаяОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущиеДанные, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаЗаполнитьВидыРабочихЦентровПоМаршрутнойКарте(Команда)
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаОтбораПоСвойствамИРасчетаПоФормулам(Команда)
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	//++ Устарело_Производство21
	ПеренестиДанныеВСпецификациюЗаказаИЗакрыть();
	//-- Устарело_Производство21
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаДобавитьАльтернативныйВидРЦ(Команда)
	
	Возврат;
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьКоэффициентМаршрутнойКарты(Команда)
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
	
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область СтандартныеПодсистемы

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтаФорма);
	
КонецПроцедуры

// СтандартныеПодсистемы.Свойства

&НаСервере
Процедура СвойстваВыполнитьОтложеннуюИнициализацию()
	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти


#Область Прочее

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	
	НастройкиПодсистемыПроизводство = ПроизводствоСервер.НастройкиПодсистемыПроизводство();
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, НастройкиПодсистемыПроизводство);

	ИспользоватьПланированиеПроизводства = Константы.ИспользоватьПланированиеПроизводства.Получить();
	УправлениеПредприятием = ПолучитьФункциональнуюОпцию("УправлениеПредприятием");
	
	ИспользоватьПараметризациюРесурсныхСпецификаций = 
		ПолучитьФункциональнуюОпцию("ИспользоватьПараметризациюРесурсныхСпецификаций");
	
	ХранитьОперацииВРесурсныхСпецификациях = ПолучитьФункциональнуюОпцию("ХранитьОперацииВРесурсныхСпецификациях");
	ИспользоватьМаршрутныеКарты            = ПолучитьФункциональнуюОпцию("ИспользоватьМаршрутныеКарты");
	
	СпособПроизводства = Число(Объект.ПроизводствоНаСтороне);
	ПрочитатьРеквизитыПодразделения(Истина);
	
	ДоступноОписаниеПартииВыпуска = УправлениеДаннымиОбИзделиях.ДоступноОписаниеПартииВыпуска();
	ЗаполнитьОписаниеПартииВыпуска();
	
	
	УстановитьОтметкуНезаполненногоДляБуферов(ЭтотОбъект);
	
	//++ Устарело_Производство21
	ХарактеристикиИспользуются = Справочники.Номенклатура.ХарактеристикиИспользуются(УслугаПереработчика);
	Элементы.ХарактеристикаУслугиПереработчика.Доступность = ХарактеристикиИспользуются;
	//-- Устарело_Производство21
	
	ЗаполнитьСлужебныеРеквизитыУслугиПереработчика();
	
	РедакторПроизводственногоПроцессаКлиентСервер.ЗаполнитьПояснениеОсновныхНастроек(Объект, ЭтотОбъект);
	
	УстановитьДоступностьПоСтатусуСервер();
	НастроитьЭлементыФормы();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	// ОтметкаНезаполненного для партии маршрутных листов
	#Область МаксимальноеКоличествоЕдиницПартийИзделияОтметка
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.МаксимальноеКоличествоЕдиницПартийИзделия.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("РазбиватьМаршрутныеЛисты");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Ложь);
	#КонецОбласти
	
	
	#Область Прочее
	
	//++ Устарело_Производство21
	НоменклатураСервер.УстановитьУсловноеОформлениеХарактеристикНоменклатуры(ЭтаФорма,
		"ХарактеристикаУслугиПереработчика",
		"ХарактеристикиИспользуются");
	//-- Устарело_Производство21

	НоменклатураСервер.УстановитьУсловноеОформлениеХарактеристикНоменклатуры(ЭтаФорма,
		"УслугиПереработчикаХарактеристика",
		"Объект.УслугиПереработчика.ХарактеристикиИспользуются");
	
	#КонецОбласти
	
КонецПроцедуры

&НаСервере
Процедура НастроитьЭлементыФормы()
	
	ДанныеСпецификации = ДанныеРесурснойСпецификации();
	
	Элементы.СпособПроизводства.Видимость =
		(ИспользуетсяПроизводствоНаСтороне2_5
			//++ Устарело_Переработка24
			ИЛИ ИспользуетсяПроизводствоНаСтороне
			//-- Устарело_Переработка24
			ИЛИ Ложь)
		И Не ДанныеСпецификации.МногоэтапныйПроизводственныйПроцесс;
	
	
	Элементы.НастройкаОтбораПоСвойствамИРасчетаПоФормулам.Видимость = НЕ ИспользуетсяПроизводство21;
	
	Элементы.ГруппаМаршрутнаяКарта.ТолькоПросмотр = ХранитьОперацииВРесурсныхСпецификациях;
	
	Элементы.Организация.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.Организации");
	Элементы.Партнер.ОграничениеТипа     = Новый ОписаниеТипов("СправочникСсылка.Партнеры");
	
	УправлениеДаннымиОбИзделияхКлиентСервер.УстановитьПараметрыВводаКоличестваЕдиницПартий(
		ДанныеСпецификации.ВыпускПроизвольнымиПорциями И ДоступноОписаниеПартииВыпуска,
		Элементы.ОдновременноПроизводимоеКоличествоЕдиницПартийИзделий);
	
	Элементы.СтраницаОписание.Картинка = ОбщегоНазначенияКлиентСервер.КартинкаКомментария(Объект.Описание);

	НастроитьЗависимыеЭлементыФормы(ЭтаФорма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура НастроитьЗависимыеЭлементыФормы(Форма, СписокРеквизитов = "")
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы; // ЭлементыФормы
	
	Инициализация = ПустаяСтрока(СписокРеквизитов);
	СтруктураРеквизитов = Новый Структура(СписокРеквизитов);
	
	Если СтруктураРеквизитов.Свойство("СпособПроизводства")
		ИЛИ Инициализация Тогда
		
		СобственноеПроизводство = НЕ Объект.ПроизводствоНаСтороне;
		
		Элементы.СтраницаПереработка.Видимость = НЕ СобственноеПроизводство;
		
		Элементы.ПланироватьРаботуВидовРабочихЦентров.Видимость = СобственноеПроизводство;
		
		Элементы.ГруппаМаршрутнаяКарта.Видимость = Форма.УправлениеПредприятием
			И Форма.ИспользоватьМаршрутныеКарты
			И СобственноеПроизводство;
			
		Элементы.СтраницыРазбиватьМаршрутныеЛисты.Видимость = Форма.УправлениеПредприятием
			И Форма.ИспользуетсяПроизводство21
			И СобственноеПроизводство;
		
		Элементы.Организация.Видимость = Ложь;
		
	КонецЕсли;
	
	Если СтруктураРеквизитов.Свойство("ПланироватьРаботуВидовРабочихЦентров")
		ИЛИ Инициализация Тогда
		
		РедакторПроизводственногоПроцессаКлиентСервер.НастроитьЭлементыГруппыВидыРабочихЦентров(Объект, Форма);
		
		РедакторПроизводственногоПроцессаКлиентСервер.НастроитьЭлементыГруппыДлительностьЭтапа(Объект, Форма);
		
	КонецЕсли;
	
	
	Если СтруктураРеквизитов.Свойство("РазбиватьМаршрутныеЛисты")
		ИЛИ Инициализация Тогда
		
		Элементы.МаксимальноеКоличествоЕдиницПартийИзделия.ТолькоПросмотр = 
			НЕ (Форма.РазбиватьМаршрутныеЛисты И НЕ Форма.СпецификацияЗакрыта);
		
	КонецЕсли;
	
	
	// Одновременно производимое количество единиц/партий изделий
	Если СтруктураРеквизитов.Свойство("ОдновременноПроизводимоеКоличествоЕдиницПартийИзделий")
		ИЛИ Инициализация Тогда
		
		Элементы.ОдновременноПроизводимоеКоличествоЕдиницПартийИзделий.Подсказка =
			УправлениеДаннымиОбИзделияхКлиентСервер.ПредставлениеЕдиницыИзмеренияПартииВыпуска(
				Форма.ОписаниеПартииВыпуска,
				Объект.ОдновременноПроизводимоеКоличествоЕдиницПартийИзделий);
		
	КонецЕсли;
	
	// Страница реквизитов переработчика
	Если СтруктураРеквизитов.Свойство("Переработка")
		ИЛИ Инициализация Тогда
		
		Элементы.ХарактеристикаУслугиПереработчика.Доступность = Форма.ХарактеристикиИспользуются;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьПоСтатусуСервер()
	
	Если Режим = "СпецификацияЗаказа" ИЛИ ТолькоПросмотр ИЛИ Объект.Владелец.Пустая() Тогда
		Возврат;
	КонецЕсли;
	
	СтатусВладельца = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Владелец, "Статус");
	ДоступностьРеквизитов = (СтатусВладельца = Перечисления.СтатусыСпецификаций.ВРазработке);
	СпецификацияЗакрыта = (СтатусВладельца = Перечисления.СтатусыСпецификаций.Закрыта);
	
	Элементы.МаршрутнаяКарта.ТолькоПросмотр = НЕ ДоступностьРеквизитов;
	Элементы.КоэффициентМаршрутнойКарты.ТолькоПросмотр = НЕ ДоступностьРеквизитов;
	
	Элементы.РазбиватьМаршрутныеЛисты.ТолькоПросмотр = СпецификацияЗакрыта;
	Элементы.МаксимальноеКоличествоЕдиницПартийИзделия.ТолькоПросмотр = СпецификацияЗакрыта;
	
	РедакторПроизводственногоПроцесса.УстановитьДоступностьЭлементовЭтапаПоСтатусу(ЭтотОбъект, ДоступностьРеквизитов, СпецификацияЗакрыта);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОписаниеПартииВыпуска()
	
	Если Режим <> "СпецификацияЗаказа" И ДоступноОписаниеПартииВыпуска Тогда
	
		Если Параметры.Свойство("ОписаниеПартииВыпуска")
			И Параметры.ОписаниеПартииВыпуска <> Неопределено Тогда
			
			ОписаниеПартииВыпуска = Параметры.ОписаниеПартииВыпуска;
			
		Иначе
			
			ОписаниеПартииВыпуска = Справочники.РесурсныеСпецификации.ОписаниеПартииВыпуска(Объект.Владелец);
			
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция ДанныеРесурснойСпецификации()
	
	Если Режим <> "СпецификацияЗаказа" И ЗначениеЗаполнено(Объект.Владелец) Тогда
		СоставРеквизитов = "ТипПроизводственногоПроцесса,ВыпускПроизвольнымиПорциями,МногоэтапныйПроизводственныйПроцесс";
		ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Объект.Владелец, СоставРеквизитов);
	Иначе
		ЗначенияРеквизитов = Новый Структура("
		|ТипПроизводственногоПроцесса,
		|ВыпускПроизвольнымиПорциями,
		|МногоэтапныйПроизводственныйПроцесс",
		Перечисления.ТипыПроизводственныхПроцессов.Сборка, Ложь, Ложь);
	КонецЕсли;
	
	Возврат ЗначенияРеквизитов;

КонецФункции

&НаСервере
Процедура ПрочитатьРеквизитыПодразделения(ЭтоЧтениеОбъекта)

	ПараметрыПодразделения = ПроизводствоСервер.ПараметрыПроизводственногоПодразделения(Объект.Подразделение);
	
	
	РедакторПроизводственногоПроцесса.ЗаполнитьВыборЕдиницыИзмеренияБуфера(
			ИнтервалПланирования,
			Элементы.ЕдиницаИзмеренияПредварительногоБуфера.СписокВыбора);
	
	РедакторПроизводственногоПроцесса.ЗаполнитьВыборЕдиницыИзмеренияБуфера(
			ИнтервалПланирования,
			Элементы.ЕдиницаИзмеренияЗавершающегоБуфера.СписокВыбора);
	
	РедакторПроизводственногоПроцесса.ПроверитьВыборЕдиницыИзмеренияБуферов(Объект, ЭтотОбъект, НЕ ЭтоЧтениеОбъекта);
	
КонецПроцедуры


&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтметкуНезаполненногоДляБуферов(Форма)
	
	ОбязательностьЗаполнения = РедакторПроизводственногоПроцессаКлиентСервер.ОбязательностьЗаполненияЕдиницИзмеренияБуферов(
		Форма.Объект);
	Для каждого КлючИЗначение Из ОбязательностьЗаполнения Цикл
		Форма.Элементы[КлючИЗначение.Ключ].ОтметкаНезаполненного = КлючИЗначение.Значение;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьДлительность()
	
	
	Возврат; // пустой обработчик
	
КонецПроцедуры


&НаСервере
Процедура ЗаполнитьСлужебныеРеквизитыУслугиПереработчика()
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ЗаполнитьПризнакХарактеристикиИспользуются", Новый Структура("Номенклатура", "ХарактеристикиИспользуются"));
	
	НоменклатураСервер.ЗаполнитьСлужебныеРеквизитыПоНоменклатуреВКоллекции(
		Объект.УслугиПереработчика, СтруктураДействий);
	
КонецПроцедуры

&НаСервере
Процедура ПодразделениеПриИзмененииНаСервере()

	ПрочитатьРеквизитыПодразделения(Ложь);

КонецПроцедуры

//++ Устарело_Производство21

&НаКлиенте
Процедура ВопросПередЗакрытием(РезультатВопроса, ДополнительныеПараметры) Экспорт

	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ПеренестиДанныеВСпецификациюЗаказаИЗакрыть();
	ИначеЕсли РезультатВопроса = КодВозвратаДиалога.Нет Тогда
		Модифицированность = Ложь;
		Закрыть();
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция ПроверитьЗаполнениеЭтапа()

	
	Если НЕ ПроверитьЗаполнение() Тогда
		Возврат Ложь;
	КонецЕсли; 
	
	ЭтапОбъект = РеквизитФормыВЗначение("Объект");
	
	Возврат ЭтапОбъект.ПроверитьЗаполнениеРеквизитов(Ложь);
	
КонецФункции

&НаСервере
Функция ДанныеЭтапаВХранилище()
	
	
	СвойстваЭтапа = Новый Структура;
	
	СвойстваЭтапа.Вставить("Подразделение",                          Объект.Подразделение);
	СвойстваЭтапа.Вставить("ОдновременноПроизводимоеКоличествоЕдиницПартийИзделий",         Объект.ОдновременноПроизводимоеКоличествоЕдиницПартийИзделий);
	СвойстваЭтапа.Вставить("МаршрутнаяКарта",                        Объект.МаршрутнаяКарта);
	СвойстваЭтапа.Вставить("ПланироватьРаботуВидовРабочихЦентров",   Объект.ПланироватьРаботуВидовРабочихЦентров);
	СвойстваЭтапа.Вставить("Описание",                               Объект.Описание);
	СвойстваЭтапа.Вставить("ДлительностьЭтапа",                      Объект.ДлительностьЭтапа);
	СвойстваЭтапа.Вставить("ЕдиницаИзмеренияДлительностиЭтапа",      Объект.ЕдиницаИзмеренияДлительностиЭтапа);
	СвойстваЭтапа.Вставить("ПредварительныйБуфер",                   Объект.ПредварительныйБуфер);
	СвойстваЭтапа.Вставить("ЗавершающийБуфер",                       Объект.ЗавершающийБуфер);
	СвойстваЭтапа.Вставить("ЕдиницаИзмеренияПредварительногоБуфера", Объект.ЕдиницаИзмеренияПредварительногоБуфера);
	СвойстваЭтапа.Вставить("ЕдиницаИзмеренияЗавершающегоБуфера",     Объект.ЕдиницаИзмеренияЗавершающегоБуфера);
	СвойстваЭтапа.Вставить("НаименованиеЭтапа",                      Объект.Наименование);
	СвойстваЭтапа.Вставить("Непрерывный",                            Объект.Непрерывный);
	
	СвойстваЭтапа.Вставить("ПроизводствоНаСтороне",                  Объект.ПроизводствоНаСтороне);
	СвойстваЭтапа.Вставить("Партнер",                                Объект.Партнер);
	СвойстваЭтапа.Вставить("ГрафикРаботыПартнера",                   Объект.ГрафикРаботыПартнера);
	
	СвойстваЭтапа.Вставить("УслугаПереработчика",                    УслугаПереработчика);
	СвойстваЭтапа.Вставить("ХарактеристикаУслугиПереработчика",      ХарактеристикаУслугиПереработчика);
	СвойстваЭтапа.Вставить("СтатьяКалькуляции",                      СтатьяКалькуляции);
	 
	СвойстваЭтапа.Вставить("ВидыРабочихЦентров",                     Объект.ВидыРабочихЦентров.Выгрузить());
	СвойстваЭтапа.Вставить("АльтернативныеВидыРабочихЦентров",       Объект.АльтернативныеВидыРабочихЦентров.Выгрузить());
	
	Возврат ПоместитьВоВременноеХранилище(СвойстваЭтапа, УникальныйИдентификатор);
	
КонецФункции

&НаКлиенте
Процедура ПеренестиДанныеВСпецификациюЗаказаИЗакрыть()
	
	Если Модифицированность Тогда
		
		ОчиститьСообщения();
		
		Если НЕ ПроверитьЗаполнениеЭтапа() Тогда
			Возврат;
		КонецЕсли; 
		
		Модифицированность = Ложь;
			
		ВыбранноеЗначение = Новый Структура("ВыполняемаяОперация, АдресВХранилище", "РедактированиеЭтапаПроизводства", ДанныеЭтапаВХранилище());
			
		ОповеститьОВыборе(ВыбранноеЗначение);
		
	Иначе
		
		Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

//-- Устарело_Производство21

#КонецОбласти

#КонецОбласти
