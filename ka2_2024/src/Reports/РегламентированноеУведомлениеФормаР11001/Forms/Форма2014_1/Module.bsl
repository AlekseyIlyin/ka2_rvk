
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;

	Данные = Неопределено;
	ПараметрыЗаполнения = Неопределено;
	Параметры.Свойство("Данные", Данные);
	Параметры.Свойство("ПараметрыЗаполнения", ПараметрыЗаполнения);
	
	Объект.ВидУведомления = Перечисления.ВидыУведомленийОСпецрежимахНалогообложения.ФормаР11001;
	УведомлениеОСпецрежимахНалогообложения.НачальныеОперацииПриСозданииНаСервере(ЭтотОбъект);
	УведомлениеОСпецрежимахНалогообложения.СформироватьСпискиВыбора(ЭтотОбъект, "СпискиВыбора2014_1");
	
	Если Параметры.Свойство("Ключ") И ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Объект.Организация = Параметры.Ключ.Организация;
		ЗагрузитьДанные(Параметры.Ключ);
	ИначеЕсли Параметры.Свойство("ЗначениеКопирования") И ЗначениеЗаполнено(Параметры.ЗначениеКопирования) Тогда
		Объект.Организация = Параметры.ЗначениеКопирования.Организация;
		ЗагрузитьДанные(Параметры.ЗначениеКопирования);
	Иначе
		Параметры.Свойство("Организация", Объект.Организация);
		СформироватьДеревоСтраниц();
		
		ВходящийКонтейнер = Новый Структура("ИмяФормы, ДеревоСтраниц", ИмяФормы, РеквизитФормыВЗначение("ДеревоСтраниц"));
		РезультатКонтейнер = Новый Структура;
		УведомлениеОСпецрежимахНалогообложения.СформироватьКонтейнерДанныхУведомления(ВходящийКонтейнер, РезультатКонтейнер, Истина);
		Для Каждого КЗ Из РезультатКонтейнер Цикл 
			ЭтотОбъект[КЗ.Ключ] = КЗ.Значение;
		КонецЦикла;
		
		РезультатКонтейнер.Очистить();
		УведомлениеОСпецрежимахНалогообложения.НачальныеОперацииСКонтейнеромМногострочныхБлоков(ВходящийКонтейнер, РезультатКонтейнер);
		Для Каждого КЗ Из РезультатКонтейнер Цикл 
			ЗначениеВРеквизитФормы(КЗ.Значение, КЗ.Ключ);
		КонецЦикла;
		УведомлениеОСпецрежимахНалогообложения.ДополнитьСлужебнымиСтруктурамиАдреса(ЭтотОбъект["ДанныеУведомления"], ЭтотОбъект["ДанныеМногостраничныхРазделов"]);
	КонецЕсли;
	
	Если Параметры.СформироватьФормуОтчетаАвтоматически Тогда 
		ЗаполнитьАвтоНаСервере(ПараметрыЗаполнения);
	КонецЕсли;
	
	Если Параметры.СформироватьПечатнуюФорму Тогда
		Модифицированность = Истина;
		СохранитьДанные();
		Отказ = Истина;
		Если ЗначениеЗаполнено(Объект.Ссылка) Тогда 
			РазблокироватьДанныеДляРедактирования(Объект.Ссылка, УникальныйИдентификатор);
		КонецЕсли;
		
		Возврат;
	КонецЕсли;
	
	УведомлениеОСпецрежимахНалогообложения.ЗаполнитьТаблицуФорматов(ЭтотОбъект, "Форматы2014_1");
	ИдДляСвор = УведомлениеОСпецрежимахНалогообложения.ПолучитьИдентификаторыДляСворачивания(ЭтотОбъект);
	ЭтотОбъект["СворачиваемыеЭлементы"] = ПоместитьВоВременноеХранилище(ИдДляСвор);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Если Модифицированность Тогда
		ПриЗакрытииНаСервере();
	КонецЕсли;
	Оповестить("Запись_УведомлениеОСпецрежимахНалогообложения",,Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	РегламентированнаяОтчетностьКлиент.ПередЗакрытиемРегламентированногоОтчета(ЭтотОбъект, Отказ, СтандартнаяОбработка, ЗавершениеРаботы, ТекстПредупреждения);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ПриОткрытии(ЭтотОбъект, Отказ);
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура Очистить(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ОчиститьУведомление(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ОчисткаОтчета() Экспорт
	СформироватьДеревоСтраниц();
	
	ВходящийКонтейнер = Новый Структура("ИмяФормы, ДеревоСтраниц", ИмяФормы, РеквизитФормыВЗначение("ДеревоСтраниц"));
	РезультатКонтейнер = Новый Структура;
	УведомлениеОСпецрежимахНалогообложения.СформироватьКонтейнерДанныхУведомления(ВходящийКонтейнер, РезультатКонтейнер, Истина);
	Для Каждого КЗ Из РезультатКонтейнер Цикл 
		ЭтотОбъект[КЗ.Ключ] = КЗ.Значение;
	КонецЦикла;
	
	РезультатКонтейнер.Очистить();
	УведомлениеОСпецрежимахНалогообложения.НачальныеОперацииСКонтейнеромМногострочныхБлоков(ВходящийКонтейнер, РезультатКонтейнер);
	Для Каждого КЗ Из РезультатКонтейнер Цикл 
		ЗначениеВРеквизитФормы(КЗ.Значение, КЗ.Ключ);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьАвтоНаСервере(ПараметрыЗаполнения = Неопределено)
	ПараметрыОтчета = Новый Структура();
	ПараметрыОтчета.Вставить("Организация", 			     Объект.Организация);
	ПараметрыОтчета.Вставить("УникальныйИдентификаторФормы", УникальныйИдентификатор);
	ПараметрыОтчета.Вставить("ПараметрыЗаполнения",          ПараметрыЗаполнения);
	
	Контейнер = СформироватьКонтейнерДляАвтозаполнения();
	РегламентированнаяОтчетностьПереопределяемый.ЗаполнитьОтчет(Объект.ИмяОтчета, Объект.ИмяФормы, ПараметрыОтчета, Контейнер);
	ЗагрузитьПодготовленныеДанные(Контейнер);
КонецПроцедуры

&НаСервере
Функция СформироватьКонтейнерДляАвтозаполнения()
	Контейнер = Новый Структура;
	Для Каждого КЗ Из ЭтотОбъект["ДанныеУведомления"]Цикл 
		Контейнер.Вставить(КЗ.Ключ, ОбщегоНазначения.СкопироватьРекурсивно(КЗ.Значение));
	КонецЦикла;
	
	Контейнер.Вставить("МногострочнаяЧасть1", РеквизитФормыВЗначение("МногострочнаяЧасть1"));
	
	СтруктураДерева = Новый Соответствие;
	Для Каждого КЗ Из ЭтотОбъект["ДанныеМногостраничныхРазделов"] Цикл 
		Для Каждого Стр Из КЗ.Значение Цикл 
			СтруктураДерева[Стр.Значение.УИД] = Новый Структура("Раздел, Данные", КЗ.Ключ, ОбщегоНазначения.СкопироватьРекурсивно(Стр.Значение));
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого КЗ Из СтруктураДерева Цикл 
		Если КЗ.Значение.Данные.Свойство("УИДРодителя") Тогда 
			Родитель = СтруктураДерева[КЗ.Значение.Данные.УИДРодителя];
			Если Не Родитель.Данные.Свойство(КЗ.Значение.Раздел) Тогда 
				Родитель.Данные.Вставить(КЗ.Значение.Раздел, Новый СписокЗначений);
			КонецЕсли;
			Родитель.Данные[КЗ.Значение.Раздел].Добавить(КЗ.Значение.Данные);
		ИначеЕсли Не Контейнер.Свойство(КЗ.Значение.Раздел) Тогда 
			Контейнер.Вставить(КЗ.Значение.Раздел, Новый СписокЗначений);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого КЗ Из СтруктураДерева Цикл 
		КЗ.Значение.Данные.Удалить("УИД");
		КЗ.Значение.Данные.Удалить("УИДРодителя");
	КонецЦикла;
	
	Для Каждого КЗ Из СтруктураДерева Цикл 
		Если Контейнер.Свойство(КЗ.Значение.Раздел) Тогда 
			Контейнер[КЗ.Значение.Раздел].Добавить(КЗ.Значение.Данные);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Контейнер;
КонецФункции

&НаСервере
Процедура ЗагрузитьПодготовленныеДанные(Контейнер)
	КУдалению = Новый Массив;
	Для Каждого КЗ Из ЭтотОбъект["ДанныеМногостраничныхРазделов"] Цикл
		КЗ.Значение.Очистить();
	КонецЦикла;
	
	Для Каждого КЗ Из Контейнер Цикл 
		Если ЭтотОбъект["ДанныеУведомления"].Свойство(КЗ.Ключ) Тогда 
			ЗаполнитьЗначенияСвойств(ЭтотОбъект["ДанныеУведомления"][КЗ.Ключ], КЗ.Значение);
		ИначеЕсли ЭтотОбъект["ДанныеМногостраничныхРазделов"].Свойство(КЗ.Ключ) Тогда 
			Для Каждого Стр Из КЗ.Значение Цикл 
				ВставляемыеДанные = ОбщегоНазначения.СкопироватьРекурсивно(Стр.Значение);
				ВставляемыеДанные.Вставить("УИД", Новый УникальныйИдентификатор);
				ЭтотОбъект["ДанныеМногостраничныхРазделов"][КЗ.Ключ].Добавить(ВставляемыеДанные);
				ДобавитьДочерниеСтраницы(ВставляемыеДанные);
				КУдалению.Добавить(КЗ.Ключ);
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Элт Из КУдалению Цикл
		ВставляемыеДанные.Удалить(Элт);
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(Контейнер.МногострочнаяЧасть1, "МногострочнаяЧасть1");
	СформироватьДеревоСтраницПоДанным();
КонецПроцедуры

&НаСервере
Процедура ДобавитьДочерниеСтраницы(ВставляемыеДанные)
	КУдалению = Новый Массив;
	
	Для Каждого КЗ Из ВставляемыеДанные Цикл 
		Если ТипЗнч(КЗ.Значение) = Тип("СписокЗначений")
			И ЭтотОбъект["ДанныеМногостраничныхРазделов"].Свойство(КЗ.Ключ) Тогда
			
			Для Каждого Стр Из КЗ.Значение Цикл
				ДочерниеВставляемыеДанные = ОбщегоНазначения.СкопироватьРекурсивно(Стр.Значение);
				ДочерниеВставляемыеДанные.Вставить("УИД", Новый УникальныйИдентификатор);
				ДочерниеВставляемыеДанные.Вставить("УИДРодителя", ВставляемыеДанные.УИД);
				ЭтотОбъект["ДанныеМногостраничныхРазделов"][КЗ.Ключ].Добавить(ДочерниеВставляемыеДанные);
				ДобавитьДочерниеСтраницы(ДочерниеВставляемыеДанные);
				КУдалению.Добавить(КЗ.Ключ);
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Элт Из КУдалению Цикл
		ВставляемыеДанные.Удалить(Элт);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура СформироватьДеревоСтраницПоДанным()
	ДеревоСтраниц.ПолучитьЭлементы().Очистить();
	
	КорневойУровень = ДеревоСтраниц.ПолучитьЭлементы();
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Стр. 001";
	Стр001.ИндексКартинки = 1;
	Стр001.ИмяМакета = "Форма2014_1_Страница1";
	Стр001.Многостраничность = Ложь;
	Стр001.Многострочность = Ложь;
	Стр001.ИДНаименования = "Лист001";
	Стр001.УИД = Новый УникальныйИдентификатор;
	Стр001.МакетыПФ = "Печать_Форма2014_1_Страница1_1;Печать_Форма2014_1_Страница1_2";
	
#Область ЛистыАБВ
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы А";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистА"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаА";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистА";
	КонецЦикла;
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы Б";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистБ"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаБ";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистБ";
	КонецЦикла;
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы В";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистВ"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаВ";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистВ";
		Стр001Нов.МакетыПФ = "Печать_Форма2014_1_СтраницаВ1;Печать_Форма2014_1_СтраницаВ2";
	КонецЦикла;
#КонецОбласти

#Область ЛистыГ
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы Г 1";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистГ1"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаГ1";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистГ1";
		Стр001Нов.МакетыПФ = "Печать_Форма2014_1_СтраницаГ1";
		
		Стр002 = Стр001Нов.ПолучитьЭлементы().Добавить();
		Стр002.Наименование = "Листы Г 2-3";
		Стр002.ИндексКартинки = 1;
		Стр002.Многостраничность = Истина;
		Стр002.Многострочность = Ложь;
		
		НомерСтр2 = 0;
		Для Каждого СтрПодч Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистГ2_3"] Цикл 
			Если СтрПодч.Значение.УИДРодителя <> Стр.Значение.УИД Тогда 
				Продолжить;
			КонецЕсли;
			
			НомерСтр2 = НомерСтр2 + 1;
			Стр001Нов = Стр002.ПолучитьЭлементы().Добавить();
			Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр2, "ЧГ=");
			Стр001Нов.ИндексКартинки = 1;
			Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаГ2_3";
			Стр001Нов.Многостраничность = Истина;
			Стр001Нов.Многострочность = Ложь;
			Стр001Нов.УИД = СтрПодч.Значение.УИД;
			Стр001Нов.ИДНаименования = "ЛистГ2_3";
			Стр001Нов.МакетыПФ = "Печать_Форма2014_1_СтраницаГ2;Печать_Форма2014_1_СтраницаГ3";
		КонецЦикла;
	КонецЦикла;
#КонецОбласти

#Область ЛистыДЕЖЗИ
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы Д";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистД"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаД";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистД";
	КонецЦикла;
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы Е";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистЕ"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаЕ";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистЕ";
		Стр001Нов.МакетыПФ = "Печать_Форма2014_1_СтраницаЕ1;Печать_Форма2014_1_СтраницаЕ2";
	КонецЦикла;
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы Ж";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистЖ"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаЖ";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистЖ";
		Стр001Нов.МакетыПФ = "Печать_Форма2014_1_СтраницаЖ1;Печать_Форма2014_1_СтраницаЖ2;Печать_Форма2014_1_СтраницаЖ3";
	КонецЦикла;
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы З";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистЗ"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаЗ";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистЗ";
		Стр001Нов.МакетыПФ = "Печать_Форма2014_1_СтраницаЗ1;Печать_Форма2014_1_СтраницаЗ2";
	КонецЦикла;
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Лист И";
	Стр001.ИндексКартинки = 1;
	Стр001.ИмяМакета = "Форма2014_1_СтраницаИ";
	Стр001.Многостраничность = Ложь;
	Стр001.Многострочность = Истина;
	Стр001.УИД = Новый УникальныйИдентификатор;
	Стр001.ИДНаименования = "ЛистИ";
	Стр001.МногострочныеЧасти.Добавить("МногострочнаяЧасть1");
#КонецОбласти

#Область ЛистыКЛМН
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Лист К";
	Стр001.ИндексКартинки = 1;
	Стр001.ИмяМакета = "Форма2014_1_СтраницаК";
	Стр001.Многостраничность = Ложь;
	Стр001.Многострочность = Ложь;
	Стр001.УИД = Новый УникальныйИдентификатор;
	Стр001.ИДНаименования = "ЛистК";
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы Л";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистЛ"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаЛ";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистЛ";
	КонецЦикла;
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Лист М";
	Стр001.ИндексКартинки = 1;
	Стр001.ИмяМакета = "Форма2014_1_СтраницаМ";
	Стр001.Многостраничность = Ложь;
	Стр001.Многострочность = Ложь;
	Стр001.УИД = Новый УникальныйИдентификатор;
	Стр001.ИДНаименования = "ЛистМ";
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Листы Н";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	НомерСтр = 0;
	Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"]["ЛистН"] Цикл 
		НомерСтр = НомерСтр + 1;
		Стр001Нов = Стр001.ПолучитьЭлементы().Добавить();
		Стр001Нов.Наименование = "Стр. " + Формат(НомерСтр, "ЧГ=");
		Стр001Нов.ИндексКартинки = 1;
		Стр001Нов.ИмяМакета = "Форма2014_1_СтраницаН";
		Стр001Нов.Многостраничность = Истина;
		Стр001Нов.Многострочность = Ложь;
		Стр001Нов.УИД = Стр.Значение.УИД;
		Стр001Нов.ИДНаименования = "ЛистН";
		Стр001Нов.МакетыПФ = "Печать_Форма2014_1_СтраницаН1;Печать_Форма2014_1_СтраницаН2;Печать_Форма2014_1_СтраницаН3";
	КонецЦикла;
#КонецОбласти
КонецПроцедуры

&НаСервере
Процедура СформироватьДеревоСтраниц() Экспорт
	Разложение = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИмяФормы, ".");
	ДС = Отчеты[Разложение[1]].СформироватьДеревоСтраниц(Разложение[3]);
	ЗначениеВРеквизитФормы(ДС, "ДеревоСтраниц");
КонецПроцедуры

&НаКлиенте
Процедура ДеревоСтраницПриАктивизацииСтроки(Элемент)
	Если УведомлениеОСпецрежимахНалогообложенияКлиент.НеобходимоФормированиеТабличногоДокумента(ЭтотОбъект, Элемент, ЭтотОбъект["УИДПереключение"]) Тогда
		ОтключитьОбработчикОжидания("ДеревоСтраницПриАктивизацииСтрокиЗавершение");
		ПодключитьОбработчикОжидания("ДеревоСтраницПриАктивизацииСтрокиЗавершение", 0.1, Истина);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоСтраницПриАктивизацииСтрокиЗавершение() Экспорт 
	ПредУИД = ЭтотОбъект["УИДПереключение"];
	Элемент = Элементы.ДеревоСтраниц;
	
	Если Элемент.ТекущиеДанные.Многостраничность Тогда 
		ИмяМакета = УведомлениеОСпецрежимахНалогообложенияКлиент.ПолучитьИмяВыводимогоМакета(Элемент.ТекущиеДанные);
		ПоказатьТекущуюМногостраничнуюСтраницу(ИмяМакета);
	Иначе 
		ПоказатьТекущуюСтраницу(Элемент.ТекущиеДанные.ИмяМакета);
		
		Если Элемент.ТекущиеДанные.Многострочность Тогда
			ВывестиМногострочнуюЧасть("МногострочнаяЧасть1");
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПоказатьТекущуюСтраницу(ИмяМакета)
	ПредставлениеУведомления.Очистить();
	ПредставлениеУведомления.Вывести(УведомлениеОСпецрежимахНалогообложения.ПолучитьМакетТабличногоДокумента(ЭтотОбъект, ИмяМакета));
	УведомлениеОСпецрежимахНалогообложения.УстановитьФорматыВПолях(ЭтотОбъект);
	СтрДанных = ЭтотОбъект["ДанныеУведомления"][ЭтотОбъект["ТекущееИДНаименования"]];
	Для Каждого Обл Из ПредставлениеУведомления.Области Цикл 
		Если Обл.ТипОбласти = ТипОбластиЯчеекТабличногоДокумента.Прямоугольник
			И Обл.СодержитЗначение Тогда 
			
			СтрДанных.Свойство(Обл.Имя, Обл.Значение);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ПоказатьТекущуюМногостраничнуюСтраницу(ИмяМакета)
	ПредставлениеУведомления.Очистить();
	ПредставлениеУведомления.Вывести(УведомлениеОСпецрежимахНалогообложения.ПолучитьМакетТабличногоДокумента(ЭтотОбъект, ИмяМакета));
	УведомлениеОСпецрежимахНалогообложения.УстановитьФорматыВПолях(ЭтотОбъект);
	СтрДанных = Неопределено;
	Для Каждого Элт Из ЭтотОбъект["ДанныеМногостраничныхРазделов"][ЭтотОбъект["ТекущееИДНаименования"]] Цикл 
		Если Элт.Значение.УИД = ЭтотОбъект["УИДТекущаяСтраница"] Тогда 
			СтрДанных = Элт.Значение;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Обл Из ПредставлениеУведомления.Области Цикл 
		Если Обл.ТипОбласти = ТипОбластиЯчеекТабличногоДокумента.Прямоугольник
			И Обл.СодержитЗначение Тогда 
			
			СтрДанных.Свойство(Обл.Имя, Обл.Значение);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеУведомленияПриИзмененииСодержимогоОбласти(Элемент, Область)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ПриИзмененииСодержимогоОбласти(ЭтотОбъект, Область, Истина);
КонецПроцедуры

&НаСервере
Процедура СохранитьДанные() Экспорт
	Если ЗначениеЗаполнено(Объект.Ссылка) И Не Модифицированность Тогда 
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Объект.Дата = ТекущаяДатаСеанса() 
	КонецЕсли;
	
	СтруктураПараметров = Новый Структура("ДанныеУведомления, ДанныеМногостраничныхРазделов, ДеревоСтраниц, МногострочнаяЧасть1",
			ЭтотОбъект["ДанныеУведомления"], ЭтотОбъект["ДанныеМногостраничныхРазделов"],
			РеквизитФормыВЗначение("ДеревоСтраниц"), РеквизитФормыВЗначение("МногострочнаяЧасть1"));
	
	УведомлениеОСпецрежимахНалогообложения.СохранитьДанные(ЭтотОбъект, СтруктураПараметров);
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьДанные();
	Оповестить("Запись_УведомлениеОСпецрежимахНалогообложения",,Объект.Ссылка);
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьДанные(СсылкаНаДанные)
	СтруктураПараметров = УведомлениеОСпецрежимахНалогообложения.ЗагрузкаДанныхУведомления(ЭтотОбъект, СсылкаНаДанные);
	МногострочнаяЧасть1.Загрузить(СтруктураПараметров.МногострочнаяЧасть1);
КонецПроцедуры

&НаКлиенте
Функция ЭтоОбластьОКСМ(Область)
	Если (Область.Имя = "Б01020100" И ЭтотОбъект["ТекущееИДНаименования"] = "ЛистБ") 
		Или (Область.Имя = "В01060201" И ЭтотОбъект["ТекущееИДНаименования"] = "ЛистВ") 
		Или (Область.Имя = "Г0302050201" И ЭтотОбъект["ТекущееИДНаименования"] = "ЛистГ2_3")
		Или (Область.Имя = "Е06020100" И ЭтотОбъект["ТекущееИДНаименования"] = "ЛистЕ")
		Или (Область.Имя = "Ж08050201" И ЭтотОбъект["ТекущееИДНаименования"] = "ЛистЖ")
		Или (Область.Имя = "Ж04010000" И ЭтотОбъект["ТекущееИДНаименования"] = "ЛистЖ")
		Или (Область.Имя = "Н04050201" И ЭтотОбъект["ТекущееИДНаименования"] = "ЛистН") Тогда
		
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
КонецФункции

&НаКлиенте
Процедура ПредставлениеУведомленияВыбор(Элемент, Область, СтандартнаяОбработка)
	Если СтрЧислоВхождений(Область.Имя, "ДобавитьСтроку") > 0 Тогда
		ДобавитьСтроку();
		СтандартнаяОбработка = Ложь;
		Модифицированность = Истина;
		Возврат;
	ИначеЕсли СтрЧислоВхождений(Область.Имя, "УдалитьСтроку") > 0 Тогда
		УдалитьСтроку(Область);
		СтандартнаяОбработка = Ложь;
		Модифицированность = Истина;
		Возврат;
	ИначеЕсли СтрЧислоВхождений(Область.Имя, "ДобавитьСтраницу") > 0 Тогда
		ДобавитьСтраницу(Неопределено);
		СтандартнаяОбработка = Ложь;
		Возврат;
	ИначеЕсли СтрЧислоВхождений(Область.Имя, "УдалитьСтраницу") > 0 Тогда
		УведомлениеОСпецрежимахНалогообложенияКлиент.УдалитьСтраницу(ЭтотОбъект);
		СтандартнаяОбработка = Ложь;
		Возврат;
	КонецЕсли;
	
	Если ЭтотОбъект["РучнойВвод"] Тогда 
		Возврат;
	КонецЕсли;
	
	УведомлениеОСпецрежимахНалогообложенияКлиент.ПредставлениеУведомленияВыбор(ЭтотОбъект, Область, СтандартнаяОбработка, Истина);
	
	Если СтандартнаяОбработка Тогда 
		ОбработкаАдреса(Область, СтандартнаяОбработка);
	КонецЕсли;
	
	Если СтандартнаяОбработка И ЭтоОбластьОКСМ(Область) Тогда 
		УведомлениеОСпецрежимахНалогообложенияКлиент.ВыборКодаСтраныИзСправочника(ЭтотОбъект, Область, СтандартнаяОбработка);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСтраницу(Команда)
	ДобавитьСтраницуНаСервере();
КонецПроцедуры

&НаСервере
Процедура ДобавитьСтраницуНаСервере()
	УведомлениеОСпецрежимахНалогообложения.ДобавитьСтраницуУведомления(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура УдалитьСтраницу() Экспорт
	УдалитьСтраницуНаСервере();
КонецПроцедуры

&НаСервере
Процедура УдалитьСтраницуНаСервере()
	УведомлениеОСпецрежимахНалогообложения.УдалитьСтраницуНаСервере(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ПриЗакрытииНаСервере()
	СохранитьДанные();
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаАдреса(Область, СтандартнаяОбработка) Экспорт
	РоссийскийАдрес = Неопределено;
	ЗначенияПолей = Неопределено;
	ПредставлениеАдреса = Неопределено;
	УведомлениеОСпецрежимахНалогообложенияКлиент.ОбработкаАдреса(ЭтотОбъект, Область, РоссийскийАдрес, ЗначенияПолей, ПредставлениеАдреса, СтандартнаяОбработка);
	Если СтандартнаяОбработка Тогда 
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Заголовок",				"Ввод адреса");
	ПараметрыФормы.Вставить("ЗначенияПолей", 			ЗначенияПолей);
	ПараметрыФормы.Вставить("Представление", 			ПредставлениеАдреса);
	ПараметрыФормы.Вставить("ВидКонтактнойИнформации",	ПредопределенноеЗначение("Справочник.ВидыКонтактнойИнформации.АдресМестаПроживанияФизическиеЛица"));
	
	ПрефиксПоляАдреса = ?(СтрНачинаетсяС(Область.Имя, "АДДР"), Лев(Область.Имя, 6), "");
	ТекСтраницаДанные = Неопределено;
	Если ЭтотОбъект["ДанныеУведомления"].Свойство(ЭтотОбъект["ТекущееИДНаименования"]) Тогда 
		ТекСтраницаДанные = ЭтотОбъект["ДанныеУведомления"][ЭтотОбъект["ТекущееИДНаименования"]];
	Иначе
		Для Каждого Стр Из ЭтотОбъект["ДанныеМногостраничныхРазделов"][ЭтотОбъект["ТекущееИДНаименования"]] Цикл 
			Если Стр.Значение.УИД = ЭтотОбъект["УИДТекущаяСтраница"] Тогда 
				ТекСтраницаДанные = Стр.Значение;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если ТекСтраницаДанные <> Неопределено Тогда 
		Если ТекСтраницаДанные.Свойство(ПрефиксПоляАдреса + "АдресJSON")
			И ЗначениеЗаполнено(ТекСтраницаДанные[ПрефиксПоляАдреса + "АдресJSON"]) Тогда
			
			ПараметрыФормы.Вставить("КонтактнаяИнформация", ТекСтраницаДанные[ПрефиксПоляАдреса + "АдресJSON"]);
			ПараметрыФормы.Вставить("ЗначенияПолей", ТекСтраницаДанные[ПрефиксПоляАдреса + "АдресJSON"]);
		ИначеЕсли ТекСтраницаДанные.Свойство(ПрефиксПоляАдреса + "АдресXML")
			И ЗначениеЗаполнено(ТекСтраницаДанные[ПрефиксПоляАдреса + "АдресXML"]) Тогда
			
			ПараметрыФормы.Вставить("КонтактнаяИнформация", ТекСтраницаДанные[ПрефиксПоляАдреса + "АдресXML"]);
			ПараметрыФормы.Вставить("ЗначенияПолей", ТекСтраницаДанные[ПрефиксПоляАдреса + "АдресXML"]);
		КонецЕсли;
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("РоссийскийАдрес", РоссийскийАдрес);
	ДополнительныеПараметры.Вставить("Префикс", ПрефиксПоляАдреса);
	ДополнительныеПараметры.Вставить("ТекСтраницаДанные", ТекСтраницаДанные);
	
	ТипЗначения = Тип("ОписаниеОповещения");
	ПараметрыКонструктора = Новый Массив(3);
	ПараметрыКонструктора[0] = "ОткрытьФормуКонтактнойИнформацииЗавершение";
	ПараметрыКонструктора[1] = ЭтотОбъект;
	ПараметрыКонструктора[2] = ДополнительныеПараметры;
	
	Оповещение = Новый (ТипЗначения, ПараметрыКонструктора);
	
	ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент").ОткрытьФормуКонтактнойИнформации(ПараметрыФормы, , Оповещение);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуКонтактнойИнформацииЗавершение(Результат, Параметры) Экспорт
	Если ТипЗнч(Результат) = Тип("Структура") Тогда 
		УведомлениеОСпецрежимахНалогообложенияКлиент.ОбновитьАдресВТабличномДокументе(ЭтотОбъект, Результат, Параметры, Истина);
		
		Если Параметры.Свойство("ТекСтраницаДанные") И Параметры.ТекСтраницаДанные <> Неопределено Тогда 
			Если Не Параметры.ТекСтраницаДанные.Свойство(Параметры.Префикс + "АдресJSON") Тогда 
				Параметры.ТекСтраницаДанные.Вставить(Параметры.Префикс + "АдресJSON", Результат.Значение);
			Иначе
				Параметры.ТекСтраницаДанные[Параметры.Префикс + "АдресJSON"] = Результат.Значение;
			КонецЕсли;
			Если Не Параметры.ТекСтраницаДанные.Свойство(Параметры.Префикс + "АдресXML") Тогда 
				Параметры.ТекСтраницаДанные.Вставить(Параметры.Префикс + "АдресXML", Результат.КонтактнаяИнформация);
			Иначе
				Параметры.ТекСтраницаДанные[Параметры.Префикс + "АдресXML"] = Результат.КонтактнаяИнформация;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСтроку()
	МногострочнаяЧасть1.Добавить();
	ВывестиМногострочнуюЧасть("МногострочнаяЧасть1");
КонецПроцедуры

&НаКлиенте
Процедура УдалитьСтроку(Область)
	ОбластьИмя = Область.Имя;
	Номер = Число(Сред(ОбластьИмя, СтрНайти(ОбластьИмя, "_") + 1)) - 1;
	МногострочнаяЧасть1.Удалить(Номер);
	Если МногострочнаяЧасть1.Количество() = 0 Тогда 
		МногострочнаяЧасть1.Добавить();
	КонецЕсли;
	ВывестиМногострочнуюЧасть("МногострочнаяЧасть1");
КонецПроцедуры

&НаСервере
Процедура ВывестиМногострочнуюЧасть(МногострочнаяЧасть)
	Обл = ПредставлениеУведомления.Область(МногострочнаяЧасть);
	ПредставлениеУведомления.УдалитьОбласть(ПредставлениеУведомления.Область(Обл.Верх, , Обл.Верх + 10 * ЭтотОбъект[МногострочнаяЧасть].Количество()), ТипСмещенияТабличногоДокумента.ПоВертикали);
	
	Колонки = РеквизитФормыВЗначение(МногострочнаяЧасть).Колонки;
	Макет = УведомлениеОСпецрежимахНалогообложения.ПолучитьМакетТабличногоДокумента(ЭтотОбъект, "Форма2014_1_СтраницаИ");
	ОбластьМнг = Макет.ПолучитьОбласть(МногострочнаяЧасть);
	ОбластьДоб = Макет.ПолучитьОбласть("ДобавлениеСтроки");
	
	Инд = 1;
	Для Каждого Стр Из ЭтотОбъект[МногострочнаяЧасть] Цикл 
		Если Инд > 1 Тогда 
			Для Каждого Колонка Из Колонки Цикл 
				ОбластьМнг.Области[Колонка.Имя + "_" + (Инд - 1)].Имя = Колонка.Имя + "_" + Инд;
			КонецЦикла;
			ОбластьМнг.Области["УдалитьСтроку_" + (Инд - 1)].Имя = "УдалитьСтроку_" + Инд;
			Если Инд = 2 Тогда 
				ОбластьМнг.Области[МногострочнаяЧасть].Имя = "";
			КонецЕсли;
		КонецЕсли;
		ПредставлениеУведомления.Вывести(ОбластьМнг);
		
		Для Каждого Колонка Из Колонки Цикл 
			ПредставлениеУведомления.Области[Колонка.Имя + "_" + Инд].Значение = Стр[Колонка.Имя];
		КонецЦикла;
		Инд = Инд + 1;
	КонецЦикла;
	
	ПредставлениеУведомления.Вывести(ОбластьДоб);
КонецПроцедуры

&НаКлиенте
Функция ОпределитьПринадлежностьОбластиКМногострочномуРазделу(ОбластьИмя) Экспорт 
	Если ("А01020000" = Лев(ОбластьИмя, СтрНайти(ОбластьИмя, "_") - 1)) Тогда 
		Возврат "МногострочнаяЧасть1";
	КонецЕсли;
КонецФункции

&НаСервере
Функция СформироватьXMLНаСервере(УникальныйИдентификатор)
	СохранитьДанные();
	Документ = РеквизитФормыВЗначение("Объект");
	Возврат Документ.ВыгрузитьДокумент(УникальныйИдентификатор);
КонецФункции

&НаКлиенте
Процедура СформироватьXML(Команда)
	
	ВыгружаемыеДанные = СформироватьXMLНаСервере(УникальныйИдентификатор);
	Если ВыгружаемыеДанные <> Неопределено Тогда 
		РегламентированнаяОтчетностьКлиент.ВыгрузитьФайлы(ВыгружаемыеДанные);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Запись_УведомлениеОСпецрежимахНалогообложения", ПараметрыЗаписи, Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСДвухмернымШтрихкодомPDF417(Команда)
	РегламентированнаяОтчетностьКлиент.ВывестиМашиночитаемуюФормуУведомленияОСпецрежимахПоСсылке(ЭтотОбъект, Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьНаКлиенте(Автосохранение = Ложь,ВыполняемоеОповещение = Неопределено) Экспорт 
	
	СохранитьДанные();
	Если ВыполняемоеОповещение <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(ВыполняемоеОповещение);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	СохранитьДанные();
	Оповестить("Запись_УведомлениеОСпецрежимахНалогообложения",,Объект.Ссылка);
	Закрыть(Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьВКонтролирующийОрган(Команда)
	
	РегламентированнаяОтчетностьКлиент.ПриНажатииНаКнопкуОтправкиВКонтролирующийОрган(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВИнтернете(Команда)
	
	РегламентированнаяОтчетностьКлиент.ПроверитьВИнтернете(ЭтотОбъект);
	
КонецПроцедуры

#Область ПанельОтправкиВКонтролирующиеОрганы

&НаКлиенте
Процедура ОбновитьОтправку(Команда)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОбновитьОтправкуИзПанелиОтправки(ЭтотОбъект, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаПротоколНажатие(Элемент)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьПротоколИзПанелиОтправки(ЭтотОбъект, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьНеотправленноеИзвещение(Команда)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОтправитьНеотправленноеИзвещениеИзПанелиОтправки(ЭтотОбъект, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ЭтапыОтправкиНажатие(Элемент)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьСостояниеОтправкиИзПанелиОтправки(ЭтотОбъект, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура КритическиеОшибкиОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьКритическиеОшибкиИзПанелиОтправки(ЭтотОбъект, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаНаименованиеЭтапаНажатие(Элемент)
	
	ПараметрыИзменения = Новый Структура;
	ПараметрыИзменения.Вставить("Форма", ЭтотОбъект);
	ПараметрыИзменения.Вставить("Организация", Объект.Организация);
	ПараметрыИзменения.Вставить("КонтролирующийОрган",
		ПредопределенноеЗначение("Перечисление.ТипыКонтролирующихОрганов.ФНС"));
	ПараметрыИзменения.Вставить("ТекстВопроса", НСтр("ru='Вы уверены, что уведомление уже сдано?'"));
	
	РегламентированнаяОтчетностьКлиент.ИзменитьСтатусОтправки(ПараметрыИзменения);
	
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ПроверитьВыгрузкуНаСервере()
	СохранитьДанные();
	Документ = РеквизитФормыВЗначение("Объект");
	Документ.ПроверитьДокумент(УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВыгрузку(Команда)
	ПроверитьВыгрузкуНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОткрытьПрисоединенныеФайлы(Команда)
	
	РегламентированнаяОтчетностьКлиент.СохранитьУведомлениеИОткрытьФормуПрисоединенныеФайлы(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПечатьБРО(Команда)
	ЕстьВыходЗаГраницы = Ложь;
	ПечатьБРОНаСервере(ЕстьВыходЗаГраницы);
	РегламентированнаяОтчетностьКлиент.ОткрытьФормуПредварительногоПросмотра(ЭтотОбъект, "Открыть", Ложь, 
		ЭтотОбъект["СтруктураРеквизитовУведомления"].СписокПечатаемыхЛистов, Новый Структура("ЕстьВыходЗаГраницы", ЕстьВыходЗаГраницы));
КонецПроцедуры

&НаСервере
Процедура ПечатьБРОНаСервере(ЕстьВыходЗаГраницы)
	ЕстьВыходЗаГраницы = Ложь;
	СохранитьДанные();
	ЭтотОбъект["СтруктураРеквизитовУведомления"] = Новый Структура("СписокПечатаемыхЛистов", 
		ОбщегоНазначения.ОбщийМодуль("Отчеты." + Объект.ИмяОтчета).СформироватьСписокЛистов(Объект, ЕстьВыходЗаГраницы));
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьКодОКСМ(Команда)
	ПредставлениеУведомления.ТекущаяОбласть.Значение = "";
	УведомлениеОСпецрежимахНалогообложенияКлиент.ПриИзмененииСодержимогоОбласти(ЭтотОбъект, ПредставлениеУведомления.ТекущаяОбласть, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеУведомленияПриАктивизации(Элемент)
	Элементы.ПредставлениеУведомленияКонтекстноеМенюОчиститьКодОКСМ.Доступность = ЭтоОбластьОКСМ(Элемент.ТекущаяОбласть);
КонецПроцедуры

&НаКлиенте
Процедура РучнойВвод(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ОбработкаРучнойВвод(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура КомментарийПриИзменении(Элемент)
	Модифицированность = Истина;
КонецПроцедуры
