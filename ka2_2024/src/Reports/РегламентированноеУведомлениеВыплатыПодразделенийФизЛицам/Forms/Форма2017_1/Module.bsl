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
	Параметры.Свойство("Данные", Данные);
	
	Объект.ВидУведомления = Перечисления.ВидыУведомленийОСпецрежимахНалогообложения.СообщениеОНаделенииОППолномочиямиПоВыплатам;
	УведомлениеОСпецрежимахНалогообложения.НачальныеОперацииПриСозданииНаСервере(ЭтотОбъект);
	УведомлениеОСпецрежимахНалогообложения.СформироватьСпискиВыбора(ЭтотОбъект, "СпискиВыбора2017_1");
	
	Если ТипЗнч(Данные) = Тип("Структура") Тогда
		СформироватьДеревоСтраниц();
		УведомлениеОСпецрежимахНалогообложения.СформироватьСтруктуруДанныхУведомленияНовогоОбразца(ЭтотОбъект);
		УведомлениеОСпецрежимахНалогообложения.ЗагрузитьДанныеПростогоУведомления(ЭтотОбъект, Данные, ПредставлениеУведомления)
	ИначеЕсли Параметры.Свойство("Ключ") И ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Объект.Организация = Параметры.Ключ.Организация;
		ЗагрузитьДанные(Параметры.Ключ);
	ИначеЕсли Параметры.Свойство("ЗначениеКопирования") И ЗначениеЗаполнено(Параметры.ЗначениеКопирования) Тогда
		Объект.Организация = Параметры.ЗначениеКопирования.Организация;
		ЗагрузитьДанные(Параметры.ЗначениеКопирования);
	ИначеЕсли Параметры.Свойство("ПредставлениеXML") Тогда 
		Параметры.Свойство("РегистрацияВНалоговомОргане", Объект.РегистрацияВИФНС);
		Параметры.Свойство("Организация", Объект.Организация);
		ЗагрузитьИзXMLНаСервере(Новый Структура("Организация, РегистрацияВНалоговомОргане, ПредставлениеXML", 
								Объект.Организация, Объект.РегистрацияВИФНС, Параметры.ПредставлениеXML));
	Иначе
		Параметры.Свойство("Организация", Объект.Организация);
		Объект.РегистрацияВИФНС = Документы.УведомлениеОСпецрежимахНалогообложения.РегистрацияВФНСОрганизации(Объект.Организация);
		СформироватьДеревоСтраниц();
		УведомлениеОСпецрежимахНалогообложения.СформироватьСтруктуруДанныхУведомленияНовогоОбразца(ЭтотОбъект);
		ЗаполнитьНачальныеДанные();
	КонецЕсли;
	
	ИдДляСвор = УведомлениеОСпецрежимахНалогообложения.ПолучитьИдентификаторыДляСворачивания(ЭтотОбъект);
	ЭтотОбъект["СворачиваемыеЭлементы"] = ПоместитьВоВременноеХранилище(ИдДляСвор);
	РегламентированнаяОтчетностьКлиентСервер.ПриИнициализацииФормыРегламентированногоОтчета(ЭтотОбъект);
	Заголовок = УведомлениеОСпецрежимахНалогообложения.ДополнитьЗаголовокУведомления(Заголовок, Объект.Организация);
	УведомлениеОСпецрежимахНалогообложения.СпрятатьКнопкиВыгрузкиОтправкиУНеактуальныхФорм(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	ПриЗакрытииНаСервере();
	Оповестить("Запись_УведомлениеОСпецрежимахНалогообложения",,Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ПриОткрытии(ЭтотОбъект, Отказ);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	РегламентированнаяОтчетностьКлиент.ПередЗакрытиемРегламентированногоОтчета(ЭтотОбъект, Отказ, СтандартнаяОбработка, ЗавершениеРаботы, ТекстПредупреждения);
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура Очистить(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ОчиститьУведомление(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ОчисткаОтчета() Экспорт
	Объект.РегистрацияВИФНС = Документы.УведомлениеОСпецрежимахНалогообложения.РегистрацияВФНСОрганизации(Объект.Организация);
	СформироватьДеревоСтраниц();
	УведомлениеОСпецрежимахНалогообложения.СформироватьСтруктуруДанныхУведомленияНовогоОбразца(ЭтотОбъект);
	ЗаполнитьНачальныеДанные();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНачальныеДанные() Экспорт
	ДанныеУведомленияТитульный = ЭтотОбъект["ДанныеУведомления"]["Титульный"];
	ДанныеУведомленияТитульный.Вставить("КодНО", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.РегистрацияВИФНС, "Код"));
	Объект.ДатаПодписи = ТекущаяДатаСеанса();
	ДанныеУведомленияТитульный.Вставить("ДАТА_ПОДПИСИ", Объект.ДатаПодписи);
	
	СтрокаСведений = "ИННЮЛ,НаимЮЛПол,КППЮЛ,ТелОрганизации";
	СведенияОбОрганизации = РегламентированнаяОтчетностьВызовСервера.ПолучитьСведенияОбОрганизации(Объект.Организация, Объект.ДатаПодписи, СтрокаСведений);
	ДанныеУведомленияТитульный.Вставить("ИНН", СведенияОбОрганизации.ИННЮЛ);
	ДанныеУведомленияТитульный.Вставить("Наименование", СведенияОбОрганизации.НаимЮЛПол);
	ДанныеУведомленияТитульный.Вставить("КПП", СведенияОбОрганизации.КППЮЛ);
	ДанныеУведомленияТитульный.Вставить("Тлф", СведенияОбОрганизации.ТелОрганизации);
	
	Реквизиты = РегистрацияВНОСервер.ДанныеРегистрации(Объект.РегистрацияВИФНС);
	ДанныеУведомленияТитульный.Вставить("КодНО", Реквизиты.Код);
	ДанныеУведомленияТитульный.Вставить("КПП", Реквизиты.КПП);
	
	Если ЗначениеЗаполнено(Реквизиты.Представитель) Тогда
		УведомлениеОСпецрежимахНалогообложения.УстановитьПредставителяПоФизЛицу(ЭтотОбъект);
	Иначе
		УведомлениеОСпецрежимахНалогообложения.УстановитьПредставителяПоОрганизации(ЭтотОбъект);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СформироватьДеревоСтраниц() Экспорт
	ДеревоСтраниц.ПолучитьЭлементы().Очистить();
	КорневойУровень = ДеревоСтраниц.ПолучитьЭлементы();
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Титульная страница";
	Стр001.ИндексКартинки = 1;
	Стр001.ИмяМакета = "Титульный";
	Стр001.Многостраничность = Ложь;
	Стр001.Многострочность = Ложь;
	Стр001.УИД = Новый УникальныйИдентификатор;
	Стр001.ИДНаименования = "Титульный";
	Стр001.МакетыПФ = "Печать_Форма2017_Титульный";
	
	Стр001 = КорневойУровень.Добавить();
	Стр001.Наименование = "Сведения о подразделениях";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	
	Стр001 = Стр001.ПолучитьЭлементы().Добавить();
	Стр001.Наименование = "Стр. 1";
	Стр001.ИндексКартинки = 1;
	Стр001.ИмяМакета = "Подразделение";
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Ложь;
	Стр001.УИД = Новый УникальныйИдентификатор;
	Стр001.ИДНаименования = "Подразделение";
	Стр001.МакетыПФ = "Печать_Форма2017_Подразделение";
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
		ПоказатьТекущуюМногостраничнуюСтраницу(ИмяМакета, ПредУИД);
	Иначе 
		ПоказатьТекущуюСтраницу(Элемент.ТекущиеДанные.ИмяМакета, Элемент.ТекущиеДанные.МногострочныеЧасти, ПредУИД);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПоказатьТекущуюСтраницу(ИмяМакета, МногострочныеЧасти, ПредУИД)
	УведомлениеОСпецрежимахНалогообложения.ПоказатьТекущуюСтраницу(ЭтотОбъект, ИмяМакета, ПредУИД);
КонецПроцедуры

&НаСервере
Процедура ПоказатьТекущуюМногостраничнуюСтраницу(ИмяМакета, ПредУИД)
	УведомлениеОСпецрежимахНалогообложения.ПоказатьТекущуюМногостраничнуюСтраницу(ЭтотОбъект, ИмяМакета);
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеУведомленияПриИзмененииСодержимогоОбласти(Элемент, Область)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ПриИзмененииСодержимогоОбласти(ЭтотОбъект, Область, Истина);
	
	Если Область.Имя = "ДАТА_ПОДПИСИ" Тогда
		Объект.ДатаПодписи = Область.Значение;
		УстановитьДанныеПоРегистрацииВИФНС();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура УстановитьДанныеПоРегистрацииВИФНС()
	Реквизиты = РегистрацияВНОСервер.ДанныеРегистрации(Объект.РегистрацияВИФНС);
	ПредставлениеУведомления.Области["КодНО"].Значение = Реквизиты.Код;
	ПредставлениеУведомления.Области["КПП"].Значение = Реквизиты.КПП;
	Если ЗначениеЗаполнено(Реквизиты.Представитель) Тогда
		УведомлениеОСпецрежимахНалогообложения.УстановитьПредставителяПоФизЛицу(ЭтотОбъект);
	Иначе
		УведомлениеОСпецрежимахНалогообложения.УстановитьПредставителяПоОрганизации(ЭтотОбъект);
	КонецЕсли;
	
	ДанныеУведомленияТитульный = ЭтотОбъект["ДанныеУведомления"]["Титульный"];
	ДанныеУведомленияТитульный.Вставить("ПРИЗНАК_НП_ПОДВАЛ", ПредставлениеУведомления.Области["ПРИЗНАК_НП_ПОДВАЛ"].Значение);
	ДанныеУведомленияТитульный.Вставить("НаимДок", ПредставлениеУведомления.Области["НаимДок"].Значение);
	ДанныеУведомленияТитульный.Вставить("ДАТА_ПОДПИСИ", ПредставлениеУведомления.Области["ДАТА_ПОДПИСИ"].Значение);
	ДанныеУведомленияТитульный.Вставить("ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ", ПредставлениеУведомления.Области["ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ"].Значение);
	ДанныеУведомленияТитульный.Вставить("КодНО", ПредставлениеУведомления.Области["КодНО"].Значение);
	ДанныеУведомленияТитульный.Вставить("КПП", ПредставлениеУведомления.Области["КПП"].Значение);
КонецПроцедуры

&НаСервере
Процедура СохранитьДанные() Экспорт
	Если ЗначениеЗаполнено(Объект.Ссылка) И Не Модифицированность Тогда 
		Возврат;
	КонецЕсли;
	
	СтруктураПараметров = УведомлениеОСпецрежимахНалогообложения.СтруктураПараметровДляСохранения(ЭтотОбъект);
	УведомлениеОСпецрежимахНалогообложения.СохранитьДанные(ЭтотОбъект, СтруктураПараметров);
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьДанные();
	Оповестить("Запись_УведомлениеОСпецрежимахНалогообложения",,Объект.Ссылка);
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьДанные(СсылкаНаДанные)
	УведомлениеОСпецрежимахНалогообложения.ЗагрузкаДанныхУведомления(ЭтотОбъект, СсылкаНаДанные);
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеУведомленияВыбор(Элемент, Область, СтандартнаяОбработка)
	Если УведомлениеОСпецрежимахНалогообложенияКлиент.ТиповойВыбор(ЭтотОбъект, Область, СтандартнаяОбработка) Или ЭтотОбъект["РучнойВвод"] Тогда 
		Возврат;
	КонецЕсли;
	
	Если СтандартнаяОбработка Тогда 
		УведомлениеОСпецрежимахНалогообложенияКлиент.ПредставлениеУведомленияВыбор(ЭтотОбъект, Область, СтандартнаяОбработка, Истина, Истина);
	КонецЕсли;
	
	Если СтандартнаяОбработка Тогда 
		УведомлениеОСпецрежимахНалогообложенияКлиент.ПредставлениеУведомленияВыборКодЗнач(ЭтотОбъект, Область, СтандартнаяОбработка, Истина);
	КонецЕсли;
	
	Если Область.Имя = "КодНО" Тогда 
		СтандартнаяОбработка = Ложь;
		РегламентированнаяОтчетностьКлиент.ОткрытьФормуВыбораРегистрацииВИФНС(ЭтотОбъект, Область.Имя);
	КонецЕсли;
	
	Если СтандартнаяОбработка И ЭтоОбластьОКСМ(Область) Тогда 
		УведомлениеОСпецрежимахНалогообложенияКлиент.ВыборКодаСтраныИзСправочника(ЭтотОбъект, Область, СтандартнаяОбработка);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКодаНОЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Если Результат <> Неопределено Тогда 
		Объект.РегистрацияВИФНС = Результат;
		УстановитьДанныеПоРегистрацииВИФНС();
		Модифицированность = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция ЭтоОбластьОКСМ(Область)
	Если (Область.Имя = "СтрРег" И (ЭтотОбъект["ТекущееИДНаименования"] = "ЛистА" Или ЭтотОбъект["ТекущееИДНаименования"] = "ЛистБ"
				Или ЭтотОбъект["ТекущееИДНаименования"] = "ЛистСведФЛ" Или ЭтотОбъект["ТекущееИДНаименования"] = "ЛистГ2"))
		Или (Область.Имя = "ОКСМ" И ЭтотОбъект["ТекущееИДНаименования"] = "ЛистСведФЛ") Тогда
		
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
КонецФункции

&НаКлиенте
Процедура ДобавитьСтраницу(Команда) Экспорт 
	ДобавитьСтраницуНаСервере();
КонецПроцедуры

&НаСервере
Процедура ДобавитьСтраницуНаСервере()
	УведомлениеОСпецрежимахНалогообложения.ДобавитьСтраницуУведомления(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура УдалитьСтраницу() Экспорт
	ЭтотОбъект["УдалениеСтраницы"] = Истина;
	УдалитьСтраницуНаСервере();
	ЭтотОбъект["УдалениеСтраницы"] = Ложь;
КонецПроцедуры

&НаСервере
Процедура УдалитьСтраницуНаСервере()
	УведомлениеОСпецрежимахНалогообложения.УдалитьСтраницуНаСервере(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ПриЗакрытииНаСервере()
	Если Модифицированность Тогда 
		СохранитьДанные();
	КонецЕсли;
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		УведомлениеОбъект = Объект.Ссылка.ПолучитьОбъект();
		Если УведомлениеОбъект.Заблокирован() Тогда 
			УведомлениеОбъект.Разблокировать();
		КонецЕсли;
		РазблокироватьДанныеДляРедактирования(Объект.Ссылка, УникальныйИдентификатор);
	КонецЕсли;
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
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("РоссийскийАдрес", РоссийскийАдрес);
	ДополнительныеПараметры.Вставить("Префикс", ?(СтрНачинаетсяС(Область.Имя, "АДДР"), Лев(Область.Имя, 6), ""));
	
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
	УведомлениеОСпецрежимахНалогообложенияКлиент.ОбновитьАдресВТабличномДокументе(ЭтотОбъект, Результат, Параметры, Истина);
КонецПроцедуры

&НаКлиенте
Функция ОпределитьПринадлежностьОбластиКМногострочномуРазделу(ОбластьИмя) Экспорт 
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
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОбновитьОтправкуИзПанелиОтправки(ЭтотОбъект, "РПН");
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаПротоколНажатие(Элемент)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьПротоколИзПанелиОтправки(ЭтотОбъект, "РПН");
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьНеотправленноеИзвещение(Команда)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОтправитьНеотправленноеИзвещениеИзПанелиОтправки(ЭтотОбъект, "РПН");
КонецПроцедуры

&НаКлиенте
Процедура ЭтапыОтправкиНажатие(Элемент)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьСостояниеОтправкиИзПанелиОтправки(ЭтотОбъект, "РПН");
КонецПроцедуры

&НаКлиенте
Процедура КритическиеОшибкиОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьКритическиеОшибкиИзПанелиОтправки(ЭтотОбъект, "РПН");
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
Функция ПроверитьВыгрузкуНаСервере()
	СохранитьДанные();
	Документ = РеквизитФормыВЗначение("Объект");
	Возврат Документ.ПроверитьДокументСВыводомВТаблицу(УникальныйИдентификатор);
КонецФункции

&НаКлиенте
Процедура ПроверитьВыгрузку(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ПроверитьВыгрузку(ЭтотОбъект, ПроверитьВыгрузкуНаСервере());
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОткрытьПрисоединенныеФайлы(Команда)
	
	РегламентированнаяОтчетностьКлиент.СохранитьУведомлениеИОткрытьФормуПрисоединенныеФайлы(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПечатьБРО(Команда)
	ПечатьБРОНаСервере();
	РегламентированнаяОтчетностьКлиент.ОткрытьФормуПредварительногоПросмотра(
		ЭтотОбъект, "Открыть", Ложь, ЭтотОбъект["СтруктураРеквизитовУведомления"].СписокПечатаемыхЛистов);
КонецПроцедуры

&НаСервере
Процедура ПечатьБРОНаСервере()
	УведомлениеОСпецрежимахНалогообложения.ПечатьУведомленияБРО(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура РучнойВвод(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ОбработкаРучнойВвод(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура РазрешитьВыгружатьСОшибками(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ОбработкаРазрешитьВыгружатьСОшибками(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "УведомлениеОСпецрежимахНалогообложения_НавигацияПоОшибкам" Тогда 
		УведомлениеОСпецрежимахНалогообложенияКлиент.ОбработкаОповещенияНавигацииПоОшибкам(ЭтотОбъект, Параметр, Источник);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КомментарийПриИзменении(Элемент)
	Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзXML(ПараметрыЗагрузкиXML) Экспорт
	ЗагрузитьИзXMLНаСервере(ПараметрыЗагрузкиXML);
	Элементы.ДеревоСтраниц.ТекущаяСтрока = ДеревоСтраниц.ПолучитьЭлементы()[0].ПолучитьИдентификатор();
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьИзXMLНаСервере(ПараметрыЗагрузкиXML)
	ДеревоЗагрузки = УведомлениеОСпецрежимахНалогообложения.СформироватьДеревоЗагрузки(ПараметрыЗагрузкиXML.ПредставлениеXML);
	СхемаВыгрузки = Документы.УведомлениеОСпецрежимахНалогообложения.ИзвлечьСтруктуруXMLУведомления(Объект.ИмяОтчета, "СхемаВыгрузкиФорма2017_1");
	УведомлениеОСпецрежимахНалогообложения.УстановитьОрганизациюПоПараметрамЗагрузки(ЭтотОбъект, ПараметрыЗагрузкиXML);
	ДеревоСтраниц.ПолучитьЭлементы().Очистить();
	СформироватьДеревоСтраниц();
	УведомлениеОСпецрежимахНалогообложения.СформироватьСтруктуруДанныхУведомленияНовогоОбразца(ЭтотОбъект);
	
	ДополнительныеПараметры = Новый Структура;
	УведомлениеОСпецрежимахНалогообложения.ЗагрузитьОбычныеСтраницы(ЭтотОбъект, ДеревоЗагрузки, СхемаВыгрузки, ДополнительныеПараметры);
	УведомлениеОСпецрежимахНалогообложения.ЗагрузитьМногостраничныеСтраницы(ЭтотОбъект, ДеревоЗагрузки, СхемаВыгрузки, ДополнительныеПараметры);
КонецПроцедуры

&НаСервере
Процедура ОсобаяОбработкаЭлементов(Путь, СтрЗагружаемоеЗначение, Страница) Экспорт 
	Если Путь = "Файл/Документ/ЗЗИУН/НомерСтНК" Тогда 
		ИндексТочки = СтрНайти(СтрЗагружаемоеЗначение.ЗначениеЭлемента, ".");
		Если ИндексТочки = 0 Тогда
			Страница.Пункт = СтрЗагружаемоеЗначение.ЗначениеЭлемента;
		Иначе
			Страница.Пункт = Лев(СтрЗагружаемоеЗначение.ЗначениеЭлемента, ИндексТочки - 1);
			Страница.Подпункт = Сред(СтрЗагружаемоеЗначение.ЗначениеЭлемента, ИндексТочки + 1);
		КонецЕсли;
	ИначеЕсли Путь = "Файл/Документ/ЗЗИУН/НалПериод" Тогда
		Если СтрДлина(СтрЗагружаемоеЗначение.ЗначениеЭлемента) = 10 Тогда
			Страница.КодПериода = Лев(СтрЗагружаемоеЗначение.ЗначениеЭлемента, 2);
			Страница.Месяц = Сред(СтрЗагружаемоеЗначение.ЗначениеЭлемента, 4, 2);
			Страница.Год = Прав(СтрЗагружаемоеЗначение.ЗначениеЭлемента, 4);
		КонецЕсли;
	ИначеЕсли Путь = "Файл/Документ/ЗЗИУН/СвНОПрПост/НалПериод" Тогда 
		Если СтрДлина(СтрЗагружаемоеЗначение.ЗначениеЭлемента) = 10 Тогда
			Страница.КодПериода = Лев(СтрЗагружаемоеЗначение.ЗначениеЭлемента, 2);
			Страница.Месяц = Сред(СтрЗагружаемоеЗначение.ЗначениеЭлемента, 4, 2);
			Страница.Год = Прав(СтрЗагружаемоеЗначение.ЗначениеЭлемента, 4);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзФайлаВФормуУведомление(Команда)
	УведомлениеОСпецрежимахНалогообложенияКлиент.ЗагрузитьИзФайлаУведомление(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	РегламентированнаяОтчетностьКлиент.РазрешитьРедактированиеРеквизитовОтчета(ЭтотОбъект);
КонецПроцедуры
