#Область ОписаниеПеременных

&НаКлиенте
Перем UID_Пустой;

#КонецОбласти

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

	ЗначениеКопирования = Неопределено;
	ПараметрыЗаполнения = Неопределено;
	Параметры.Свойство("ЗначениеКопирования", ЗначениеКопирования);
	Параметры.Свойство("ПараметрыЗаполнения", ПараметрыЗаполнения);
	
	Если НЕ (Параметры.Свойство("Ключ") И ЗначениеЗаполнено(Объект.Ссылка)) Тогда 
		Параметры.Свойство("Организация", Объект.Организация);
		Если Параметры.Свойство("НалоговыйОрган") И ЗначениеЗаполнено(Параметры.НалоговыйОрган) Тогда 
			Объект.РегистрацияВИФНС = Параметры.НалоговыйОрган;
		Иначе
			Объект.РегистрацияВИФНС = Документы.УведомлениеОСпецрежимахНалогообложения.РегистрацияВФНСОрганизации(Объект.Организация);
		КонецЕсли;
	КонецЕсли;
	
	Если РегламентированнаяОтчетностьПереопределяемый.ЭтоЮридическоеЛицо(Объект.Организация) Тогда 
		ОбщегоНазначения.СообщитьПользователю("Сообщение по форме ЕНВД-2 можно создавать только для индивидуальных предпринимателей");
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Объект.ДатаПодписи = ТекущаяДатаСеанса();
		Заголовок = Заголовок + " (создание)";
	КонецЕсли;
	
	Разложение = СтрРазделить(ИмяФормы, ".");
	Объект.ИмяФормы = Разложение[3];
	Объект.ИмяОтчета = Разложение[1];
	
	Документы.УведомлениеОСпецрежимахНалогообложения.ЗагрузитьДанныеЕНВД(ЭтотОбъект, ЗначениеКопирования);
	Документы.УведомлениеОСпецрежимахНалогообложения.ЗагрузитьМакетыУведомления(ЭтотОбъект, Объект.ИмяОтчета, "ПараметрыФорма2014_1");
	Документы.УведомлениеОСпецрежимахНалогообложения.СформироватьДеревоЛистовЕНВДУведомления(ЭтотОбъект);
	РегламентированнаяОтчетностьКлиентСервер.ПриИнициализацииФормыРегламентированногоОтчета(ЭтотОбъект);
	
	СтруктураРеквизитов = РегламентированнаяОтчетность.СформироватьСтруктуруОбязательныхРеквизитовУведомления();
	мСтруктураВариантыЗаполнения = Новый Структура;
	РегламентированнаяОтчетность.СформироватьСоставПоказателей(ЭтотОбъект, "СоставПоказателей2014_1");
	РегламентированнаяОтчетность.ДобавитьКнопкуПрисоединенныеФайлы(ЭтотОбъект);
	РегламентированнаяОтчетностьКлиентСервер.ПриИнициализацииФормыРегламентированногоОтчета(ЭтотОбъект);
	ЭлектронныйДокументооборотСКонтролирующимиОрганами.ОтметитьКакПрочтенное(Объект.Ссылка);
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда 
		ЗаблокироватьДанныеДляРедактирования(Объект.Ссылка, , УникальныйИдентификатор);
	КонецЕсли;
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
	Элементы.Разделы.НачальноеОтображениеДерева = НачальноеОтображениеДерева.РаскрыватьВсеУровни;
	UID_Пустой = Новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000000");
	Элементы.ФормаРазрешитьВыгружатьСОшибками.Пометка = ЭтотОбъект["РазрешитьВыгружатьСОшибками"];
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Запись_УведомлениеОСпецрежимахНалогообложения", ПараметрыЗаписи, Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "УведомлениеОСпецрежимахНалогообложения_НавигацияПоОшибкам" Тогда 
		Если Параметр.ИмяСтраницы = "ТитульныйЛист" Тогда 
			ТекущийТипСтраницы = 1;
		ИначеЕсли Параметр.ИмяСтраницы = "Лист2" Тогда 
			ТекущийТипСтраницы = 2;
		КонецЕсли;
		
		ТекущийИдентификаторСтраницы = Параметр.УИДСтраницы;
		СформироватьМакетНаСервере();
		Элементы.ПредставлениеУведомления.ТекущаяОбласть = ПредставлениеУведомления.Области.Найти(Параметр.ИмяОбласти);
		УстановитьДоступностьКнопок();
		Активизировать();
		Если ТипЗнч(Источник) = Тип("ФормаКлиентскогоПриложения") И Источник.Открыта() Тогда 
			Источник.Закрыть( );
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПредставлениеУведомленияПриИзмененииСодержимогоОбласти(Элемент, Область)
	ИмяОбласти = ПолучитьИмяОбласти(ТекущийТипСтраницы);
	Если Не ЗначениеЗаполнено(ИмяОбласти) Тогда 
		Возврат;
	КонецЕсли;
	
	Если Область.Имя = "П_ИНН" Тогда
		НовИнн = Область.Значение;
		Для Каждого Стр Из СтраницыЛиста2 Цикл 
			Стр.П_ИНН1 = НовИнн;
		КонецЦикла;
	ИначеЕсли Область.Имя = "ДАТА_ПОДПИСИ" Тогда
		Объект.ДатаПодписи = Область.Значение;
		УстановитьДанныеПоРегистрацииВИФНС();
	КонецЕсли;
	
	ИмяТаблицы = ПолучитьИмяТаблицы(ТекущийТипСтраницы);
	ПараметрыОтбора = Новый Структура("UID", ТекущийИдентификаторСтраницы);
	Данные = ЭтотОбъект[ИмяТаблицы].НайтиСтроки(ПараметрыОтбора);
	СтруктураЗаписи = Новый Структура(Область.Имя, Область.Значение);
	Если Данные.Количество() > 0 Тогда
		ЗаполнитьЗначенияСвойств(Данные[0], СтруктураЗаписи);
	КонецЕсли;
	Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеУведомленияВыбор(Элемент, Область, СтандартнаяОбработка)
	Если СтрЧислоВхождений(Область.Имя, "ДобавитьСтраницу") > 0 Тогда
		ДобавитьСтраницу(Неопределено);
	ИначеЕсли СтрЧислоВхождений(Область.Имя, "УдалитьСтраницу") > 0 Тогда
		УведомлениеОСпецрежимахНалогообложенияКлиент.УдалитьСтраницу(ЭтотОбъект);
	КонецЕсли;
	
	ОтборПоИмениОбласти = Новый Структура("Имя", Область.Имя);
	Поля = ПоляСОсобымПорядкомЗаполнения.НайтиСтроки(ОтборПоИмениОбласти);
	
	//Для полей адреса
	ИмяЯчейки = Лев(Область.Имя, СтрДлина(Область.Имя) - 1);
	НомерБлока = Прав(Область.Имя, 1);
	ВРЕГ_ИмяЯчейки = ВРЕГ(ИмяЯчейки);
	
	Если Поля.Количество() > 0 Тогда
		СтандартнаяОбработка = Ложь;
		НестандартнаяОбработка(Поля[0]);
	КонецЕсли;
	
	Если Область.Имя = "ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ" Тогда 
		УведомлениеОСпецрежимахНалогообложенияКлиент.ОткрытьФормуВыбораФИО(ЭтотОбъект, СтандартнаяОбработка, "ПредставлениеУведомления", "ТитульныйЛист");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаПротоколНажатие(Элемент)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьПротоколИзПанелиОтправки(ЭтотОбъект, "ФНС");
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

&НаКлиенте
Процедура КомментарийПриИзменении(Элемент)
	Модифицированность = Истина;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРазделы

&НаКлиенте
Процедура РазделыЗаявленияПриАктивизацииСтроки(Элемент)
	
	Если ТекущийИдентификаторСтраницы = Элемент.ТекущиеДанные.UID И
		ТекущийТипСтраницы = Элемент.ТекущиеДанные.ТипСтраницы Тогда 
		
		Возврат;
	КонецЕсли;
	
	Если Элемент.ТекущиеДанные.ТипСтраницы = 0 Тогда
		ПодчиненныеЭлементыДерева = Элемент.ТекущиеДанные.ПолучитьЭлементы();
		ТекущийИдентификаторСтраницы = ПодчиненныеЭлементыДерева[0].UID;
		ТекущийТипСтраницы = ПодчиненныеЭлементыДерева[0].ТипСтраницы;
		СформироватьМакетНаСервере();
		УстановитьДоступностьКнопок();
		Возврат;
	КонецЕсли;
	
	ТекущийИдентификаторСтраницы = Элемент.ТекущиеДанные.UID;
	ТекущийТипСтраницы = Элемент.ТекущиеДанные.ТипСтраницы;
	СформироватьМакетНаСервере();
	УстановитьДоступностьКнопок();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Очистить(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ОчиститьУведомление(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьДанные();
	Оповестить("Запись_УведомлениеОСпецрежимахНалогообложения",,Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСтраницу(Команда)
	
	Если ТекущийТипСтраницы = 2 Тогда
		ДобавитьСтраницуНаСервере();
		ПеренумероватьСтраницы();
		Модифицированность = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьСтраницу() Экспорт
	НайденныйИД = РегламентированнаяОтчетностьКлиентСервер.НайтиИДВДереве(Разделы.ПолучитьЭлементы(), ТекущийИдентификаторСтраницы, UID_Пустой);
	Если ТекущийИдентификаторСтраницы = UID_Пустой Тогда 
		Возврат;
	КонецЕсли;
	ЭлементДерева = Разделы.НайтиПоИдентификатору(НайденныйИД);
	ТС = ЭлементДерева.ТипСтраницы;
	UID = ЭлементДерева.UID;
	ТекущиеДанныеРодитель = ЭлементДерева.ПолучитьРодителя();
	Если ТекущиеДанныеРодитель.ПолучитьЭлементы().Количество() <= 1 Тогда 
		Возврат;
	КонецЕсли;
	UID_новый = УдалитьСтраницуНаСервере(UID, ТС);
	Для Каждого Стр Из ТекущиеДанныеРодитель.ПолучитьЭлементы() Цикл 
		Если Стр.UID = UID Тогда
			ТекущиеДанныеРодитель.ПолучитьЭлементы().Удалить(Стр);
			Прервать;
		КонецЕсли;
	КонецЦикла;
	ПеренумероватьСтраницы();
	УстановитьДоступностьКнопок();
	
	РегламентированнаяОтчетностьКлиент.УстановитьТекущуюСтрокуВДеревеРазделов(ЭтотОбъект, UID_новый);
	Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура СформироватьXML(Команда)
	
	ВыгружаемыеДанные = СформироватьXMLНаСервере(УникальныйИдентификатор);
	Если ВыгружаемыеДанные <> Неопределено Тогда 
		РегламентированнаяОтчетностьКлиент.ВыгрузитьФайлы(ВыгружаемыеДанные);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПечатьУведомления(Команда)
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда 
		ПечатьУведомленияАсинх();
	Иначе
		Печать();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПредварительныйПросмотр(Команда)
	ПредварительныйПросмотрАсинх();
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	СохранитьДанные();
	Оповестить("Запись_УведомлениеОСпецрежимахНалогообложения",,Объект.Ссылка);
	Закрыть(Неопределено);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Отправка в ФНС

&НаКлиенте
Процедура ОтправитьВКонтролирующийОрган(Команда)
	
	РегламентированнаяОтчетностьКлиент.ПриНажатииНаКнопкуОтправкиВКонтролирующийОрган(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВИнтернете(Команда)
	
	РегламентированнаяОтчетностьКлиент.ПроверитьВИнтернете(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОтправку(Команда)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОбновитьОтправкуИзПанелиОтправки(ЭтотОбъект, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьНеотправленноеИзвещение(Команда)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОтправитьНеотправленноеИзвещениеИзПанелиОтправки(ЭтотОбъект, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВыгрузку(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ПроверитьВыгрузку(ЭтотОбъект, ПроверитьВыгрузкуНаСервере());
КонецПроцедуры

&НаКлиенте
Процедура РазрешитьВыгружатьСОшибками(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ОбработкаРазрешитьВыгружатьСОшибками(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОчисткаОтчета() Экспорт
	Объект.РегистрацияВИФНС = Документы.УведомлениеОСпецрежимахНалогообложения.РегистрацияВФНСОрганизации(Объект.Организация);
	ТитульныйЛист.Очистить();
	СтраницыЛиста2.Очистить();
	Документы.УведомлениеОСпецрежимахНалогообложения.СформироватьДеревоЛистовЕНВДУведомления(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТитульныйЛист(НовыйЛист) Экспорт 
	
	НовыйЛист.UID = Новый УникальныйИдентификатор;
	НовыйЛист.ДАТА_ПОДПИСИ = ТекущаяДатаСеанса(); 
	Объект.ДатаПодписи = НовыйЛист.ДАТА_ПОДПИСИ;
	
	СтрокаСведений = "ИННФЛ,ТелДом,ОГРН,ФИО,ФамилияИП,ИмяИП,ОтчествоИП";
	СведенияОбОрганизации = РегламентированнаяОтчетностьВызовСервера.ПолучитьСведенияОбОрганизации(Объект.Организация, Объект.ДатаПодписи, СтрокаСведений);
	
	НовыйЛист.Фамилия_ИП = СведенияОбОрганизации.ФамилияИП;
	НовыйЛист.Имя_ИП = СведенияОбОрганизации.ИмяИП;
	НовыйЛист.Отчество_ИП = СведенияОбОрганизации.ОтчествоИП;
	НовыйЛист.П_ОГРНИП = СведенияОбОрганизации.ОГРН;
	НовыйЛист.КОД_НО = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.РегистрацияВИФНС, "Код");
	НовыйЛист.П_ИНН = СведенияОбОрганизации.ИННФЛ;
	НовыйЛист.ТЕЛЕФОН = СведенияОбОрганизации.ТелДом;
	Фамилия = СокрЛП(СведенияОбОрганизации.ФамилияИП);
	Имя = СокрЛП(СведенияОбОрганизации.ИмяИП);
	Отчество = СокрЛП(СведенияОбОрганизации.ОтчествоИП);
	
	УстановитьДанныеПоРегистрацииВИФНС();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьЛист2(НовыйЛист) Экспорт 
	
	НовыйЛист.UID = Новый УникальныйИдентификатор;
	НовыйЛист.П_ИНН1 = ТитульныйЛист[0].П_ИНН;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДанныеПоРегистрацииВИФНС()
	
	Титульный = ТитульныйЛист[0];
	Организация = Объект.Организация;
	РегистрацияВИФНС = Объект.РегистрацияВИФНС;
	
	Титульный.КОД_НО = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(РегистрацияВИФНС, "Код");
	Представитель = РегистрацияВНОСервер.Представитель(РегистрацияВИФНС);
	Если ЗначениеЗаполнено(Представитель) Тогда
		Титульный.ПРИЗНАК_НП_ПОДВАЛ = "2";
		Титульный.ДОКУМЕНТ_ПРЕДСТАВИТЕЛЯ = РегистрацияВНОСервер.ДокументПредставителя(РегистрацияВИФНС);
	Иначе
		УстановитьПредставителяПоОрганизации(Титульный);
		Титульный.ПРИЗНАК_НП_ПОДВАЛ = "1";
		Титульный.ДОКУМЕНТ_ПРЕДСТАВИТЕЛЯ = "";
		Титульный.ИНН_ПРЕДСТАВИТЕЛЯ = "";
	КонецЕсли;
	
	Если ТекущийТипСтраницы = 1 Тогда
		ПредставлениеУведомления.Область("ПРИЗНАК_НП_ПОДВАЛ").Значение = Титульный.ПРИЗНАК_НП_ПОДВАЛ;
		ПредставлениеУведомления.Область("ТЕЛЕФОН").Значение = Титульный.ТЕЛЕФОН;
		ПредставлениеУведомления.Область("ДОКУМЕНТ_ПРЕДСТАВИТЕЛЯ").Значение = Титульный.ДОКУМЕНТ_ПРЕДСТАВИТЕЛЯ;
		ПредставлениеУведомления.Область("ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ").Значение = Титульный.ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ;
		ПредставлениеУведомления.Область("ИНН_ПРЕДСТАВИТЕЛЯ").Значение = Титульный.ИНН_ПРЕДСТАВИТЕЛЯ;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПредставителяПоОрганизации(Титульный)
	Документы.УведомлениеОСпецрежимахНалогообложения.УстановитьДанныеРуководителя(Объект);
	Титульный.ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ = СокрЛП(Объект.ПодписантФамилия + " " + Объект.ПодписантИмя + " " + Объект.ПодписантОтчество);
КонецПроцедуры

&НаСервере
Процедура СохранитьДанные() Экспорт
	Документы.УведомлениеОСпецрежимахНалогообложения.СохранитьДанныеЕНВД(ЭтотОбъект, Перечисления.ВидыУведомленийОСпецрежимахНалогообложения.ФормаЕНВД2);
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьКнопок()
	Если Элементы.Разделы.ТекущиеДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ТипСтраницы = Элементы.Разделы.ТекущиеДанные.ТипСтраницы;
	
	КМенюРО = Элементы.Разделы.КонтекстноеМеню;
	Если ТипСтраницы = 2 Тогда
		КМенюРО.Видимость = Истина;
		КМенюРО.ПодчиненныеЭлементы.РазделыЗаявленияКонтекстноеМенюДобавитьСтраницу.Видимость = Истина;
		КМенюРО.ПодчиненныеЭлементы.РазделыЗаявленияКонтекстноеМенюУдалитьСтраницу.Видимость = Истина;
		КМенюРО.ПодчиненныеЭлементы.РазделыЗаявленияКонтекстноеМенюДобавитьСтраницу.Доступность = Истина;
		КМенюРО.ПодчиненныеЭлементы.РазделыЗаявленияКонтекстноеМенюУдалитьСтраницу.Доступность = (СтраницыЛиста2.Количество() > 1);
	Иначе
		КМенюРО.Видимость = Ложь;
		КМенюРО.ПодчиненныеЭлементы.РазделыЗаявленияКонтекстноеМенюДобавитьСтраницу.Видимость = Ложь;
		КМенюРО.ПодчиненныеЭлементы.РазделыЗаявленияКонтекстноеМенюУдалитьСтраницу.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СформироватьМакетНаСервере()
	Документы.УведомлениеОСпецрежимахНалогообложения.СформироватьМакетОтчетаНаСервере(ЭтотОбъект, Объект.ИмяОтчета, "Форма2014_1", ПолучитьИмяОбласти(ТекущийТипСтраницы), ПолучитьИмяТаблицы(ТекущийТипСтраницы));
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьИмяОбласти(ТекущийТипСтраницы)
	
	Если ТекущийТипСтраницы = 1 Тогда
		Возврат "ТитульныйЛист";
	ИначеЕсли ТекущийТипСтраницы = 2 Тогда
		Возврат "Страница2";
	КонецЕсли;
	
	Возврат "";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьИмяТаблицы(ТекущийТипСтраницы)
	Если ТекущийТипСтраницы = 1 Тогда
		Возврат "ТитульныйЛист";
	ИначеЕсли ТекущийТипСтраницы = 2 Тогда
		Возврат "СтраницыЛиста2";
	КонецЕсли;
	
	Возврат "";
КонецФункции

&НаКлиенте
Процедура НестандартнаяОбработка(Инфо)
	Если Инфо.Обработчик = "ОбработкаСписка" Тогда
		ОбработкаСписка(Инфо);
	ИначеЕсли Инфо.Обработчик = "ОбработкаКодаНО" Тогда
		ОбработкаКодаНО(Инфо);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаСписка(Инфо)
	ИмяНестандартнойОбласти = Инфо.Имя;
	НазваниеСписка = Инфо.ИмяФормы;
	
	СтруктураОтбора = Новый Структура("ИмяСписка", Инфо.ИмяСписка);
	Строки = ТаблицаЗначенийПредопределенныхРеквизитов.НайтиСтроки(СтруктураОтбора);
	ЗагружаемыеКоды.Очистить();
	Для Каждого Строка Из Строки Цикл 
		НоваяСтрока = ЗагружаемыеКоды.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
	КонецЦикла;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Заголовок",          НазваниеСписка);
	ПараметрыФормы.Вставить("ТаблицаЗначений",    ЗагружаемыеКоды);
	ПараметрыФормы.Вставить("СтруктураДляПоиска", Новый Структура("Код", ПредставлениеУведомления.Области[ИмяНестандартнойОбласти].Значение));
	ДополнительныеПараметры = Новый Структура("ИмяНестандартнойОбласти", ИмяНестандартнойОбласти);
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработкаСпискаЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	ОткрытьФорму("Обработка.ОбщиеОбъектыРеглОтчетности.Форма.ФормаВыбораЗначенияИзТаблицы", ПараметрыФормы, ЭтотОбъект,,,, ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаСпискаЗавершение(РезультатВыбора, ДополнительныеПараметры) Экспорт
	
	ИмяНестандартнойОбласти = ДополнительныеПараметры.ИмяНестандартнойОбласти;
	
	Если РезультатВыбора = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИмяОбластиДоп = "";
	РезультатВыбораКод = СокрЛП(РезультатВыбора.Код);
	
	ПредставлениеУведомления.Области[ИмяНестандартнойОбласти].Значение = РезультатВыбораКод;
	ИмяОбласти = ПолучитьИмяОбласти(ТекущийТипСтраницы);
	ИмяТаблицы = ПолучитьИмяТаблицы(ТекущийТипСтраницы);
	ПараметрыОтбора = Новый Структура("UID", ТекущийИдентификаторСтраницы);
	Данные = ЭтотОбъект[ИмяТаблицы].НайтиСтроки(ПараметрыОтбора);
	СтруктураЗаписи = Новый Структура(ИмяНестандартнойОбласти, РезультатВыбораКод);
	Если Данные.Количество() > 0 Тогда
		ЗаполнитьЗначенияСвойств(Данные[0], СтруктураЗаписи);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИмяОбластиДоп) Тогда 
		СтруктураЗаписи = Новый Структура(ИмяОбластиДоп, "");
		Если Данные.Количество() > 0 Тогда
			ЗаполнитьЗначенияСвойств(Данные[0], СтруктураЗаписи);
		КонецЕсли;
	КонецЕсли;
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКодаНО(Инфо)
	РегламентированнаяОтчетностьКлиент.ОткрытьФормуВыбораРегистрацииВИФНС(ЭтотОбъект, Инфо);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКодаНОЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Если Результат <> Неопределено Тогда 
		Объект.РегистрацияВИФНС = Результат;
		ПредставлениеУведомления.Области[ДополнительныеПараметры.Инфо.Имя].Значение = КодНалоговогоОргана();
		Модифицированность = Истина;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция КодНалоговогоОргана()
	УстановитьДанныеПоРегистрацииВИФНС();
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.РегистрацияВИФНС, "Код");
КонецФункции

&НаСервере
Процедура ДобавитьСтраницуНаСервере()
	Если ТекущийТипСтраницы = 2 Тогда
		КорневойУровень = Разделы.ПолучитьЭлементы();
		СписокЛистов2 = КорневойУровень[1].ПолучитьЭлементы();
		НовыйЛист = СтраницыЛиста2.Добавить();
		ЗаполнитьЛист2(НовыйЛист);
		Лист2 = СписокЛистов2.Добавить();
		Лист2.ИндексКартинки = 1;
		Лист2.ТипСтраницы = 2;
		Лист2.Наименование = "Стр. 2";
		Лист2.UID = НовыйЛист.UID;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция УдалитьСтраницуНаСервере(UID, ТипСтраницы)
	ОтборСтрок = Новый Структура("UID", UID);
	Таблица = ЭтотОбъект[ПолучитьИмяТаблицы(ТипСтраницы)];
	Строки = Таблица.НайтиСтроки(ОтборСтрок);
	Таблица.Удалить(Строки[0]);
	Возврат Таблица[0].UID;
КонецФункции

&НаКлиенте
Процедура ПеренумероватьСтраницы()
	Листы = Разделы.ПолучитьЭлементы()[1].ПолучитьЭлементы();
	Номер = 1;
	Для Каждого Лист Из Листы Цикл 
		Лист.Наименование = "Стр. "+Номер;
		Номер = Номер + 1;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ПриЗакрытииНаСервере()
	СохранитьДанные();
КонецПроцедуры

&НаСервере
Функция СформироватьXMLНаСервере(УникальныйИдентификатор)
	СохранитьДанные();
	Документ = РеквизитФормыВЗначение("Объект");
	Возврат Документ.ВыгрузитьДокумент(УникальныйИдентификатор);
КонецФункции

&НаСервере
Функция СформироватьПечатнуюФорму()
	СохранитьДанные();
	Документ = РеквизитФормыВЗначение("Объект");
	Возврат Документ.ПечатьСразу();
КонецФункции

&НаКлиенте
Асинх Процедура ПечатьУведомленияАсинх()
	Если Ждать ВопросАсинх("Перед печатью необходимо сохранить изменения. Сохранить?", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Да Тогда 
		Печать();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Печать()
	ПФ = СформироватьПечатнуюФорму();
	Если ПФ <> Неопределено Тогда 
		ПФ.Напечатать(РежимИспользованияДиалогаПечати.НеИспользовать);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Асинх Процедура ПредварительныйПросмотрАсинх()
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Если Ждать ВопросАсинх("Перед печатью необходимо сохранить изменения. Сохранить?", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Да Тогда 
			СохранитьДанные();
		Иначе
			Возврат;
		КонецЕсли;
	ИначеЕсли Модифицированность Тогда 
		СохранитьДанные();
	КонецЕсли;
	
	МассивПечати = Новый Массив;
	МассивПечати.Добавить(Объект.Ссылка);
	УправлениеПечатьюКлиент.ВыполнитьКомандуПечати(
		"Документ.УведомлениеОСпецрежимахНалогообложения",
		"Уведомление", МассивПечати, Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьНаКлиенте(Автосохранение = Ложь,ВыполняемоеОповещение = Неопределено) Экспорт 
	
	СохранитьДанные();
	Если ВыполняемоеОповещение <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(ВыполняемоеОповещение);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПроверитьВыгрузкуНаСервере()
	СохранитьДанные();
	Документ = РеквизитФормыВЗначение("Объект");
	Возврат Документ.ПроверитьДокументСВыводомВТаблицу(УникальныйИдентификатор);
КонецФункции

&НаКлиенте
Процедура Подключаемый_ОткрытьПрисоединенныеФайлы(Команда)
	
	РегламентированнаяОтчетностьКлиент.СохранитьУведомлениеИОткрытьФормуПрисоединенныеФайлы(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти
