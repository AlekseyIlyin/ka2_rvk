#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция СформироватьНовоеУведомление(Данные) Экспорт
	
	Если Данные.Свойство("СсылкаНаУведомление")
		И ТипЗнч(Данные.СсылкаНаУведомление) = Тип("ДокументСсылка.УведомлениеОСпецрежимахНалогообложения") Тогда
		
		УведомлениеОбъект = Данные.СсылкаНаУведомление.ПолучитьОбъект();
		
	Иначе
		
		УведомлениеОбъект = Документы.УведомлениеОСпецрежимахНалогообложения.СоздатьДокумент();
		
		УведомлениеОбъект.Дата = ТекущаяДатаСеанса();
		УведомлениеОбъект.УстановитьВремя();
		УведомлениеОбъект.УстановитьНовыйНомер();
		УведомлениеОбъект.ДатаПодписи = ТекущаяДатаСеанса();
		
		УведомлениеОбъект.ВидУведомления = Перечисления.ВидыУведомленийОСпецрежимахНалогообложения.УменьшениеНалогаНаСтраховыеВзносы;
		
	КонецЕсли;
	
	УведомлениеОбъект.ИмяОтчета = "РегламентированноеУведомлениеУменьшениеНалогаНаСтраховыеВзносы";
	УведомлениеОбъект.ИмяФормы = "Форма2021_1";
	
	ДокументОснование = Неопределено;
	Если Данные.Свойство("ДокументОснование") Тогда
		ДокументОснование = Данные.ДокументОснование;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ДокументОснование) Тогда
		УведомлениеОбъект.Дата        = Данные.ДатаОснования;
		УведомлениеОбъект.ДатаПодписи = Данные.ДатаОснования;
		УведомлениеОбъект.Комментарий = Данные.КомментарийОснования;
	КонецЕсли;
	
	Данные.Свойство("Организация",          УведомлениеОбъект.Организация);
	Данные.Свойство("РегистрацияВИФНС",     УведомлениеОбъект.РегистрацияВИФНС);
	
	Руководитель = РегламентированнаяОтчетностьВызовСервера.ПолучитьСведенияОбОрганизации(УведомлениеОбъект.Организация,
		УведомлениеОбъект.Дата, "ФамилияИП, ИмяИП, ОтчествоИП, ИННФЛ, ТелДом");
	Реквизиты = РегистрацияВНОСервер.ДанныеРегистрации(УведомлениеОбъект.РегистрацияВИФНС);
	Если ЗначениеЗаполнено(Реквизиты.Представитель) Тогда
		ПРИЗНАК_НП_ПОДВАЛ = "2";
		НаимДок = Реквизиты.ДокументПредставителя;
		СведенияОПредставителе = РегламентированнаяОтчетностьВызовСервера.ПолучитьПоКодамСведенияОПредставителе(
			УведомлениеОбъект.Организация, Реквизиты.Код, "");
		Если ЗначениеЗаполнено(СведенияОПредставителе.НаименованиеОрганизацииПредставителя) Тогда
			ПодписантСтр = СведенияОПредставителе.ФИОПредставителя;
			ФИО = РегламентированнаяОтчетность.РазложитьФИО(СведенияОПредставителе.ФИОПредставителя);
			УведомлениеОбъект.ПодписантФамилия = СокрЛП(ФИО.Фамилия);
			УведомлениеОбъект.ПодписантИмя = СокрЛП(ФИО.Имя);
			УведомлениеОбъект.ПодписантОтчество = СокрЛП(ФИО.Отчество);
		Иначе
			ДанныеПредставителя = РегламентированнаяОтчетностьПереопределяемый.ПолучитьСведенияОФизЛице(Реквизиты.Представитель, , ТекущаяДатаСеанса());
			УведомлениеОбъект.ПодписантФамилия = СокрЛП(ДанныеПредставителя.Фамилия);
			УведомлениеОбъект.ПодписантИмя = СокрЛП(ДанныеПредставителя.Имя);
			УведомлениеОбъект.ПодписантОтчество = СокрЛП(ДанныеПредставителя.Отчество);
		КонецЕсли;
	Иначе
		ПРИЗНАК_НП_ПОДВАЛ = "1";
		НаимДок = "";
		УведомлениеОбъект.ПодписантФамилия = Руководитель.ФамилияИП;
		УведомлениеОбъект.ПодписантИмя = Руководитель.ИмяИП;
		УведомлениеОбъект.ПодписантОтчество = Руководитель.ОтчествоИП;
	КонецЕсли;
	
	ИдентификаторыОбычныхСтраниц = Новый Структура("ЛистБ, Титульная",
		Новый УникальныйИдентификатор, Новый УникальныйИдентификатор, Новый УникальныйИдентификатор);
		
	ДанныеДопСтрокБД = Новый Структура;
	
	ДанныеУведомления = Новый Структура("ЛистБ, Титульная",
		Новый Структура, Новый Структура);
	ДанныеМногостраничныхРазделов = Новый Структура("ЛистА",
		Новый СписокЗначений);
		
	ПрототипЛистА = Новый Структура("УИД", Новый УникальныйИдентификатор);
	Для Каждого Обл Из Отчеты.РегламентированноеУведомлениеУменьшениеНалогаНаСтраховыеВзносы.ПолучитьМакет("ЛистА_2021").Области Цикл
		Если Обл.ТипОбласти = ТипОбластиЯчеекТабличногоДокумента.Прямоугольник
			И Обл.СодержитЗначение = Истина Тогда 
			
			ПрототипЛистА.Вставить(Обл.Имя);
		КонецЕсли;
	КонецЦикла;
		
	Макет = Отчеты.РегламентированноеУведомлениеУменьшениеНалогаНаСтраховыеВзносы.ПолучитьМакет("Титульная_2021");
	Для Каждого Обл Из Макет.Области Цикл 
		Если Обл.ТипОбласти = ТипОбластиЯчеекТабличногоДокумента.Прямоугольник
			И Обл.СодержитЗначение = Истина Тогда 
			
			ДанныеУведомления.Титульная.Вставить(Обл.Имя);
		КонецЕсли;
	КонецЦикла;
	Макет = Отчеты.РегламентированноеУведомлениеУменьшениеНалогаНаСтраховыеВзносы.ПолучитьМакет("ЛистБ_2021");
	Для Каждого Обл Из Макет.Области Цикл 
		Если Обл.ТипОбласти = ТипОбластиЯчеекТабличногоДокумента.Прямоугольник
			И Обл.СодержитЗначение = Истина Тогда 
			
			ДанныеУведомления.ЛистБ.Вставить(Обл.Имя);
		КонецЕсли;
	КонецЦикла;
	
	ДанныеЗаполнения = Данные.ДанныеЗаполнения;
	ДанныеЛистаА = ПолучитьИзВременногоХранилища(ДанныеЗаполнения.ЛистА);
	
	Если ЗначениеЗаполнено(ДанныеЛистаА) Тогда
		Для Каждого Стр Из ДанныеЛистаА Цикл
			ЛистА = ОбщегоНазначения.СкопироватьРекурсивно(ПрототипЛистА);
			ЗаполнитьЗначенияСвойств(ЛистА, Стр);
			ЛистА.УИД = Новый УникальныйИдентификатор;
			ДанныеМногостраничныхРазделов.ЛистА.Добавить(ЛистА);
		КонецЦикла;
	КонецЕсли;
	
	Если ДанныеМногостраничныхРазделов.ЛистА.Количество() = 0 Тогда
		ДанныеМногостраничныхРазделов.ЛистА.Добавить(ПрототипЛистА);
	КонецЕсли;
	
	ДанныеУведомления.Титульная.ДАТА_ПОДПИСИ = УведомлениеОбъект.ДатаПодписи;
	ДанныеУведомления.Титульная.ИНН = Руководитель.ИННФЛ;
	ДанныеУведомления.Титульная.Имя = Руководитель.ИмяИП;
	ДанныеУведомления.Титульная.КодНО = Реквизиты.Код;
	ДанныеУведомления.Титульная.НаимДок = НаимДок;
	ДанныеУведомления.Титульная.Отчество = Руководитель.ОтчествоИП;
	ДанныеУведомления.Титульная.ПРИЗНАК_НП_ПОДВАЛ = ПРИЗНАК_НП_ПОДВАЛ;
	ДанныеУведомления.Титульная.Тлф = Руководитель.ТелДом;
	ДанныеУведомления.Титульная.ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ = СокрЛП(УведомлениеОбъект.ПодписантФамилия 
		+ " " + УведомлениеОбъект.ПодписантИмя + " " + УведомлениеОбъект.ПодписантОтчество);
	ДанныеУведомления.Титульная.Фамилия = Руководитель.ФамилияИП;
	
	ЗаполнитьЗначенияСвойств(ДанныеУведомления.ЛистБ, ДанныеЗаполнения.ЛистБ);
	ЗаполнитьЗначенияСвойств(ДанныеУведомления.Титульная, ДанныеЗаполнения.Титульная);
	
	ДеревоСтраниц = Новый ДеревоЗначений;
	ДеревоСтраниц.Колонки.Добавить("ИДНаименования");
	ДеревоСтраниц.Колонки.Добавить("ИмяМакета");
	ДеревоСтраниц.Колонки.Добавить("ИндексКартинки");
	ДеревоСтраниц.Колонки.Добавить("МакетыПФ");
	ДеревоСтраниц.Колонки.Добавить("Многостраничность");
	ДеревоСтраниц.Колонки.Добавить("Многострочность");
	ДеревоСтраниц.Колонки.Добавить("МногострочныеЧасти");
	ДеревоСтраниц.Колонки.Добавить("Наименование");
	ДеревоСтраниц.Колонки.Добавить("УИД");
	
	Титульная = ДеревоСтраниц.Строки.Добавить();
	Титульная.ИДНаименования = "Титульная";
	Титульная.ИмяМакета = "Титульная_2021";
	Титульная.ИндексКартинки = 1;
	Титульная.МакетыПФ = "Печать_Форма2021_1_Титульная";
	Титульная.Многостраничность = Ложь;
	Титульная.Многострочность = Ложь;
	Титульная.МногострочныеЧасти = Новый СписокЗначений;
	Титульная.Наименование = "Титульная страница";
	Титульная.УИД = ИдентификаторыОбычныхСтраниц.Титульная;
	
	Стр001 = ДеревоСтраниц.Строки.Добавить();
	Стр001.Наименование = "Сведения о патентах";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Истина;
	
	Инд = 0;
	Для Каждого Элт Из ДанныеМногостраничныхРазделов.ЛистА Цикл 
		ЛистА = Элт.Значение;
		Инд = Инд + 1;
		ЛистА = Стр001.Строки.Добавить();
		ЛистА.Наименование = "Стр. " + Формат(Инд, "ЧГ=");
		ЛистА.ИндексКартинки = 1;
		ЛистА.ИмяМакета = "ЛистА_2021";
		ЛистА.Многостраничность = Истина;
		ЛистА.Многострочность = Ложь;
		ЛистА.УИД = Элт.Значение.УИД;
		ЛистА.ИДНаименования = "ЛистА";
	КонецЦикла;

	ЛистБ = ДеревоСтраниц.Строки.Добавить();
	ЛистБ.ИДНаименования = "ЛистБ";
	ЛистБ.ИмяМакета = "ЛистБ_2021";
	ЛистБ.ИндексКартинки = 1;
	ЛистБ.МакетыПФ = "Печать_Форма2021_1_ЛистБ";
	ЛистБ.Многостраничность = Ложь;
	ЛистБ.Многострочность = Ложь;
	ЛистБ.МногострочныеЧасти = Новый СписокЗначений;
	ЛистБ.Наименование = "Лист Б";
	ЛистБ.УИД = ИдентификаторыОбычныхСтраниц.ЛистБ;
	
	Если Данные.Свойство("ЗаполненоПоДаннымПомощника") Тогда
		ДанныеУведомления.Вставить("ДанныеПомощника", ДанныеЗаполнения);
	КонецЕсли;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ИдентификаторыОбычныхСтраниц", ИдентификаторыОбычныхСтраниц);
	СтруктураПараметров.Вставить("ДанныеДопСтрокБД", ДанныеДопСтрокБД);
	СтруктураПараметров.Вставить("ДеревоСтраниц", ДеревоСтраниц);
	СтруктураПараметров.Вставить("ДанныеМногостраничныхРазделов", ДанныеМногостраничныхРазделов);
	СтруктураПараметров.Вставить("ДанныеУведомления", ДанныеУведомления);
	СтруктураПараметров.Вставить("РазрешитьВыгружатьСОшибками", Ложь);
	СтруктураПараметров.Вставить("ДокументОснование", ДокументОснование);
	
	УведомлениеОбъект.ДанныеУведомления = Новый ХранилищеЗначения(СтруктураПараметров);
	УведомлениеОбъект.Основание = ДокументОснование;
	УведомлениеОбъект.Записать();
	
	Возврат УведомлениеОбъект.Ссылка;
	
КонецФункции

Функция СформироватьНовоеУведомлениеПоДаннымЗаполнения(Организация, Регистрация, ДанныеЗаполнения, СсылкаНаСохрУведомление = Неопределено ) Экспорт 
	ВызватьИсключение "Формат 5.01 устарел";
КонецФункции

Функция СформироватьНовоеУведомлениеПоДаннымЗаполнения_2021(Организация, Регистрация, ДанныеЗаполнения, СсылкаНаСохрУведомление = Неопределено ) Экспорт 
	Если ЗначениеЗаполнено(СсылкаНаСохрУведомление) Тогда
		УведомлениеОбъект = СсылкаНаСохрУведомление.ПолучитьОбъект();
	Иначе
		УведомлениеОбъект = Документы.УведомлениеОСпецрежимахНалогообложения.СоздатьДокумент();
		УведомлениеОбъект.Дата = ТекущаяДатаСеанса();
		УведомлениеОбъект.УстановитьВремя();
		УведомлениеОбъект.УстановитьНовыйНомер();
		УведомлениеОбъект.ДатаПодписи = ТекущаяДатаСеанса();
		УведомлениеОбъект.ВидУведомления = Перечисления.ВидыУведомленийОСпецрежимахНалогообложения.УменьшениеНалогаНаСтраховыеВзносы;
	КонецЕсли;
	
	УведомлениеОбъект.ИмяОтчета = "РегламентированноеУведомлениеУменьшениеНалогаНаСтраховыеВзносы";
	УведомлениеОбъект.ИмяФормы = "Форма2021_1";
	УведомлениеОбъект.Организация = Организация;
	УведомлениеОбъект.РегистрацияВИФНС = Регистрация;
	
	Руководитель = РегламентированнаяОтчетностьВызовСервера.ПолучитьСведенияОбОрганизации(Организация,
		УведомлениеОбъект.Дата, "ФамилияИП,ИмяИП,ОтчествоИП,ИННФЛ,ТелДом");
	Реквизиты = РегистрацияВНОСервер.ДанныеРегистрации(Регистрация);
	Если ЗначениеЗаполнено(Реквизиты.Представитель) Тогда
		ПРИЗНАК_НП_ПОДВАЛ = "2";
		НаимДок = Реквизиты.ДокументПредставителя;
		СведенияОПредставителе = РегламентированнаяОтчетностьВызовСервера.ПолучитьПоКодамСведенияОПредставителе(
			Организация, Реквизиты.Код, "");
		Если ЗначениеЗаполнено(СведенияОПредставителе.НаименованиеОрганизацииПредставителя) Тогда
			ПодписантСтр = СведенияОПредставителе.ФИОПредставителя;
			ФИО = РегламентированнаяОтчетность.РазложитьФИО(СведенияОПредставителе.ФИОПредставителя);
			УведомлениеОбъект.ПодписантФамилия = СокрЛП(ФИО.Фамилия);
			УведомлениеОбъект.ПодписантИмя = СокрЛП(ФИО.Имя);
			УведомлениеОбъект.ПодписантОтчество = СокрЛП(ФИО.Отчество);
		Иначе
			ДанныеПредставителя = РегламентированнаяОтчетностьПереопределяемый.ПолучитьСведенияОФизЛице(Реквизиты.Представитель, , ТекущаяДатаСеанса());
			УведомлениеОбъект.ПодписантФамилия = СокрЛП(ДанныеПредставителя.Фамилия);
			УведомлениеОбъект.ПодписантИмя = СокрЛП(ДанныеПредставителя.Имя);
			УведомлениеОбъект.ПодписантОтчество = СокрЛП(ДанныеПредставителя.Отчество);
		КонецЕсли;
	Иначе
		ПРИЗНАК_НП_ПОДВАЛ = "1";
		НаимДок = "";
		УведомлениеОбъект.ПодписантФамилия = Руководитель.ФамилияИП;
		УведомлениеОбъект.ПодписантИмя = Руководитель.ИмяИП;
		УведомлениеОбъект.ПодписантОтчество = Руководитель.ОтчествоИП;
	КонецЕсли;
	
	ИдентификаторыОбычныхСтраниц = Новый Структура("ЛистБ, Титульная",
		Новый УникальныйИдентификатор, Новый УникальныйИдентификатор, Новый УникальныйИдентификатор);
		
	ДанныеДопСтрокБД = Новый Структура;
	
	ДанныеУведомления = Новый Структура("ЛистБ, Титульная",
		Новый Структура, Новый Структура);
	ДанныеМногостраничныхРазделов = Новый Структура("ЛистА",
		Новый СписокЗначений);
		
	ПрототипЛистА = Новый Структура("УИД", Новый УникальныйИдентификатор);
	Для Каждого Обл Из Отчеты.РегламентированноеУведомлениеУменьшениеНалогаНаСтраховыеВзносы.ПолучитьМакет("ЛистА_2021").Области Цикл 
		Если Обл.ТипОбласти = ТипОбластиЯчеекТабличногоДокумента.Прямоугольник
			И Обл.СодержитЗначение = Истина Тогда 
			
			ПрототипЛистА.Вставить(Обл.Имя);
		КонецЕсли;
	КонецЦикла;
		
	Макет = Отчеты.РегламентированноеУведомлениеУменьшениеНалогаНаСтраховыеВзносы.ПолучитьМакет("Титульная_2021");
	Для Каждого Обл Из Макет.Области Цикл 
		Если Обл.ТипОбласти = ТипОбластиЯчеекТабличногоДокумента.Прямоугольник
			И Обл.СодержитЗначение = Истина Тогда 
			
			ДанныеУведомления.Титульная.Вставить(Обл.Имя);
		КонецЕсли;
	КонецЦикла;
	Макет = Отчеты.РегламентированноеУведомлениеУменьшениеНалогаНаСтраховыеВзносы.ПолучитьМакет("ЛистБ_2021");
	Для Каждого Обл Из Макет.Области Цикл 
		Если Обл.ТипОбласти = ТипОбластиЯчеекТабличногоДокумента.Прямоугольник
			И Обл.СодержитЗначение = Истина Тогда 
			
			ДанныеУведомления.ЛистБ.Вставить(Обл.Имя);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Стр Из ДанныеЗаполнения.ЛистА Цикл 
		ЛистА = ОбщегоНазначения.СкопироватьРекурсивно(ПрототипЛистА);
		ЗаполнитьЗначенияСвойств(ЛистА, Стр);
		ЛистА.УИД = Новый УникальныйИдентификатор;
		ДанныеМногостраничныхРазделов.ЛистА.Добавить(ЛистА);
	КонецЦикла;
	Если ДанныеМногостраничныхРазделов.ЛистА.Количество() = 0 Тогда 
		ДанныеМногостраничныхРазделов.ЛистА.Добавить(ПрототипЛистА);
	КонецЕсли;
	
	ДанныеУведомления.Титульная.ДАТА_ПОДПИСИ = УведомлениеОбъект.ДатаПодписи;
	ДанныеУведомления.Титульная.ИНН = Руководитель.ИННФЛ;
	ДанныеУведомления.Титульная.Имя = Руководитель.ИмяИП;
	ДанныеУведомления.Титульная.КодНО = Реквизиты.Код;
	ДанныеУведомления.Титульная.НаимДок = НаимДок;
	ДанныеУведомления.Титульная.Отчество = Руководитель.ОтчествоИП;
	ДанныеУведомления.Титульная.ПРИЗНАК_НП_ПОДВАЛ = ПРИЗНАК_НП_ПОДВАЛ;
	ДанныеУведомления.Титульная.Тлф = Руководитель.ТелДом;
	ДанныеУведомления.Титульная.ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ = СокрЛП(УведомлениеОбъект.ПодписантФамилия 
		+ " " + УведомлениеОбъект.ПодписантИмя + " " + УведомлениеОбъект.ПодписантОтчество);
	ДанныеУведомления.Титульная.Фамилия = Руководитель.ФамилияИП;
	
	ЗаполнитьЗначенияСвойств(ДанныеУведомления.ЛистБ, ДанныеЗаполнения.ЛистБ);
	ЗаполнитьЗначенияСвойств(ДанныеУведомления.Титульная, ДанныеЗаполнения.Титульная);
	
	ДеревоСтраниц = Новый ДеревоЗначений;
	ДеревоСтраниц.Колонки.Добавить("ИДНаименования");
	ДеревоСтраниц.Колонки.Добавить("ИмяМакета");
	ДеревоСтраниц.Колонки.Добавить("ИндексКартинки");
	ДеревоСтраниц.Колонки.Добавить("МакетыПФ");
	ДеревоСтраниц.Колонки.Добавить("Многостраничность");
	ДеревоСтраниц.Колонки.Добавить("Многострочность");
	ДеревоСтраниц.Колонки.Добавить("МногострочныеЧасти");
	ДеревоСтраниц.Колонки.Добавить("Наименование");
	ДеревоСтраниц.Колонки.Добавить("УИД");
	
	Титульная = ДеревоСтраниц.Строки.Добавить();
	Титульная.ИДНаименования = "Титульная";
	Титульная.ИмяМакета = "Титульная_2021";
	Титульная.ИндексКартинки = 1;
	Титульная.МакетыПФ = "Печать_Форма2021_1_Титульная";
	Титульная.Многостраничность = Ложь;
	Титульная.Многострочность = Ложь;
	Титульная.МногострочныеЧасти = Новый СписокЗначений;
	Титульная.Наименование = "Титульная страница";
	Титульная.УИД = ИдентификаторыОбычныхСтраниц.Титульная;
	
	Стр001 = ДеревоСтраниц.Строки.Добавить();
	Стр001.Наименование = "Сведения о патентах";
	Стр001.ИндексКартинки = 1;
	Стр001.Многостраничность = Истина;
	Стр001.Многострочность = Истина;
	
	Инд = 0;
	Для Каждого Элт Из ДанныеМногостраничныхРазделов.ЛистА Цикл 
		ЛистА = Элт.Значение;
		Инд = Инд + 1;
		ЛистА = Стр001.Строки.Добавить();
		ЛистА.Наименование = "Стр. " + Формат(Инд, "ЧГ=");
		ЛистА.ИндексКартинки = 1;
		ЛистА.ИмяМакета = "ЛистА_2021";
		ЛистА.Многостраничность = Истина;
		ЛистА.Многострочность = Ложь;
		ЛистА.УИД = Элт.Значение.УИД;
		ЛистА.ИДНаименования = "ЛистА";
	КонецЦикла;

	ЛистБ = ДеревоСтраниц.Строки.Добавить();
	ЛистБ.ИДНаименования = "ЛистБ";
	ЛистБ.ИмяМакета = "ЛистБ_2021";
	ЛистБ.ИндексКартинки = 1;
	ЛистБ.МакетыПФ = "Печать_Форма2021_1_ЛистБ";
	ЛистБ.Многостраничность = Ложь;
	ЛистБ.Многострочность = Ложь;
	ЛистБ.МногострочныеЧасти = Новый СписокЗначений;
	ЛистБ.Наименование = "Лист Б";
	ЛистБ.УИД = ИдентификаторыОбычныхСтраниц.ЛистБ;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ИдентификаторыОбычныхСтраниц", ИдентификаторыОбычныхСтраниц);
	СтруктураПараметров.Вставить("ДанныеДопСтрокБД", ДанныеДопСтрокБД);
	СтруктураПараметров.Вставить("ДеревоСтраниц", ДеревоСтраниц);
	СтруктураПараметров.Вставить("ДанныеМногостраничныхРазделов", ДанныеМногостраничныхРазделов);
	СтруктураПараметров.Вставить("ДанныеУведомления", ДанныеУведомления);
	СтруктураПараметров.Вставить("РазрешитьВыгружатьСОшибками", Ложь);
	
	УведомлениеОбъект.ДанныеУведомления = Новый ХранилищеЗначения(СтруктураПараметров);
	УведомлениеОбъект.Записать();
	
	Возврат УведомлениеОбъект.Ссылка;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Функция ПолучитьТаблицуПримененияФорматов() Экспорт 
	Результат = Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюТаблицуПримененияФорматов();
	
	Стр = Результат.Добавить();
	Стр.ИмяФормы = "Форма2021_1";
	Стр.КНД = "1112021";
	Стр.ВерсияФормата = "5.02";
	
	Возврат Результат;
КонецФункции

Функция ДанноеУведомлениеДоступноДляОрганизации() Экспорт 
	Возврат Ложь;
КонецФункции

Функция ДанноеУведомлениеДоступноДляИП() Экспорт 
	Возврат Истина;
КонецФункции

Функция ПолучитьОсновнуюФорму() Экспорт 
	Возврат "";
КонецФункции

Функция ПолучитьФормуПоУмолчанию() Экспорт 
	Возврат "";
КонецФункции

Функция ПолучитьТаблицуФорм() Экспорт 
	Результат = Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюТаблицуФормУведомления();
	
	Стр = Результат.Добавить();
	Стр.ИмяФормы = "Форма2021_1";
	Стр.ОписаниеФормы = "В соответствии с письмом ФНС России от 26.03.2021 № ЕД-7-3/218@";
	Стр.ДатаНачала = '20210711';
	Стр.ДатаКонца = '20991231';
	
	Возврат Результат;
КонецФункции

Функция СформироватьВыгрузкуИПолучитьДанные(ДокОбъект) Экспорт 
	Выгрузка = ДокОбъект.ВыгрузитьДокумент();
	Если Выгрузка = Неопределено Тогда 
		Возврат Неопределено;
	КонецЕсли;
	СтруктураВыгрузки = Новый Структура("ТестВыгрузки,КодировкаВыгрузки", Выгрузка[0].ТестВыгрузки, Выгрузка[0].КодировкаВыгрузки);
	
	Если ДокОбъект.ИмяФормы = "Форма2021_1" Тогда 
		СтруктураВыгрузки.Вставить("Данные", УведомлениеОСпецрежимахНалогообложения.ПолучитьМакетДвоичныхДанных(ДокОбъект.ИмяОтчета, "TIFF_2021_1"));
		СтруктураВыгрузки.Вставить("ИмяФайла", "1112021_5.02000_02.tif");
		Возврат СтруктураВыгрузки;
	КонецЕсли;
КонецФункции

Функция ЭлектронноеПредставление(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
	Если ИмяФормы = "Форма2021_1" Тогда
		Возврат ЭлектронноеПредставление_Форма2021_1(Объект, УникальныйИдентификатор);
	КонецЕсли;
КонецФункции

Функция СформироватьСписокЛистов(Объект) Экспорт
	Если Объект.ИмяФормы = "Форма2020_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2020_1(Объект);
	ИначеЕсли Объект.ИмяФормы = "Форма2021_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2021_1(Объект);
	КонецЕсли;
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт 
	Если ИмяФормы = "Форма2021_1" Тогда 
		Возврат ПроверитьДокументСВыводомВТаблицу_Форма2021_1(
			Объект, УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект), УникальныйИдентификатор);
	КонецЕсли;
КонецФункции

Функция ИдентификаторФайлаЭлектронногоПредставления(СведенияОтправки)
	Префикс = "UT_UVUMNALPNS";
	Возврат Документы.УведомлениеОСпецрежимахНалогообложения.ИдентификаторФайлаЭлектронногоПредставления(Префикс, СведенияОтправки);
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу_Форма2021_1(Объект, Данные, УникальныйИдентификатор)
	ТаблицаОшибок = Новый СписокЗначений;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаАктуальностиФормыПриВыгрузке(
		Данные.Объект.ИмяФормы, ТаблицаОшибок, ПолучитьТаблицуФорм());
	
	Титульная = Данные.ДанныеУведомления.Титульная;
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаКодаНО(Титульная.КодНО, ТаблицаОшибок, "Титульная");
	Если Не ЗначениеЗаполнено(Титульная.ГодДействПат)
		Или СтрДлина(Титульная.ГодДействПат) <> 4 
		Или Не СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(Титульная.ГодДействПат) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан / неправильно указан год периода действия патентов", "Титульная", "ГодДействПат"));
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Титульная.Фамилия) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана фамилия", "Титульная", "Фамилия"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.Имя) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указано имя", "Титульная", "Имя"));
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаИННКПП(Ложь, Титульная, ТаблицаОшибок);
	Если Не ЗначениеЗаполнено(Титульная.ПРИЗНАК_НП_ПОДВАЛ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан признак подписанта", "Титульная", "ПРИЗНАК_НП_ПОДВАЛ"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.ДАТА_ПОДПИСИ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана дата подписи", "Титульная", "ДАТА_ПОДПИСИ"));
	КонецЕсли;
	
	Если Титульная.ПРИЗНАК_НП_ПОДВАЛ = "2" Тогда 
		Если Не ЗначениеЗаполнено(Титульная.НаимДок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан документ представителя", "Титульная", "НаимДок"));
		КонецЕсли;
		УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаПодписантаНалоговойОтчетности(Данные, ТаблицаОшибок, "Титульная", Истина);
	КонецЕсли;
	
	Для Каждого Элт Из Данные.ДанныеМногостраничныхРазделов.ЛистА Цикл 
		ЛистА = Элт.Значение;
		
		Если Не ЗначениеЗаполнено(ЛистА.НомерПат) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан номер патента", "ЛистА", "НомерПат", ЛистА.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(ЛистА.ДатаНачПат) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана дата начала патента", "ЛистА", "ДатаНачПат", ЛистА.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(ЛистА.ДатаКонПат) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана дата окончания патента", "ЛистА", "ДатаКонПат", ЛистА.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(ЛистА.ПрНП) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан признак", "ЛистА", "ПрНП", ЛистА.УИД));
		КонецЕсли;
		Если ЛистА.ПрНП = "1" Тогда
			Если Данные.ОТЧ.ПривестиЗначение(ЛистА.СумСВУмНал) >
				Данные.ОТЧ.ПривестиЗначение(ЛистА.СумНалПатУм) / 2 - Данные.ОТЧ.ПривестиЗначение(ЛистА.СумСВУменУчт) Тогда 
				
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"для стр. 030 = ""1"": стр. 050 <= стр. 040 / 2 - стр. 060", "ЛистА", "СумСВУмНал", ЛистА.УИД));
			КонецЕсли;
		ИначеЕсли ЛистА.ПрНП = "2" Тогда 
			Если Данные.ОТЧ.ПривестиЗначение(ЛистА.СумСВУмНал) >
				Данные.ОТЧ.ПривестиЗначение(ЛистА.СумНалПатУм) - Данные.ОТЧ.ПривестиЗначение(ЛистА.СумСВУменУчт) Тогда 
				
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"для стр. 030 = ""2"": стр. 050 <= стр. 040 - стр. 060", "ЛистА", "СумСВУмНал", ЛистА.УИД));
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	ЛистБ = Данные.ДанныеУведомления.ЛистБ;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаДатВУведомлении(Данные, ТаблицаОшибок);
	УведомлениеОСпецрежимахНалогообложения.ПолнаяПроверкаЗаполненныхПоказателейНаСоотвествиеСписку(
		"СпискиВыбора2021_1", "СхемаВыгрузкиФорма2021_1", Данные.Объект.ИмяОтчета, ТаблицаОшибок, Данные);
	Возврат ТаблицаОшибок;
КонецФункции

Функция ОсновныеСведенияЭлектронногоПредставления_Форма2021_1(Объект, УникальныйИдентификатор)
	ОсновныеСведения = Документы.УведомлениеОСпецрежимахНалогообложения.НачальнаяИнициализацияОбщихРеквизитовВыгрузки(Объект);
	ИдентификаторФайла = ИдентификаторФайлаЭлектронногоПредставления(ОсновныеСведения);
	ОсновныеСведения.Вставить("ИдФайл", ИдентификаторФайла);
	Возврат ОсновныеСведения;
КонецФункции

Функция ЭлектронноеПредставление_Форма2021_1(Объект, УникальныйИдентификатор)
	СведенияЭлектронногоПредставления = УведомлениеОСпецрежимахНалогообложения.СведенияЭлектронногоПредставления();
	
	ДанныеУведомления = УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект);
	Ошибки = ПроверитьДокументСВыводомВТаблицу_Форма2021_1(Объект, ДанныеУведомления, УникальныйИдентификатор);
	УведомлениеОСпецрежимахНалогообложения.СообщитьОшибкиПриПроверкеВыгрузки(Объект, Ошибки, ДанныеУведомления);
	
	ОсновныеСведения = ОсновныеСведенияЭлектронногоПредставления_Форма2021_1(Объект, УникальныйИдентификатор);
	СтруктураВыгрузки = Документы.УведомлениеОСпецрежимахНалогообложения.ИзвлечьСтруктуруXMLУведомления(Объект.ИмяОтчета, "СхемаВыгрузкиФорма2021_1");
	УведомлениеОСпецрежимахНалогообложения.ТиповоеЗаполнениеДанными(ДанныеУведомления, ОсновныеСведения, СтруктураВыгрузки);
	УведомлениеОСпецрежимахНалогообложения.ВыгрузитьДеревоВТаблицу(СтруктураВыгрузки, ОсновныеСведения, СведенияЭлектронногоПредставления);
	Возврат СведенияЭлектронногоПредставления;
КонецФункции

Функция СформироватьСписокЛистовФорма2020_1(Объект) Экспорт
	СписокИспользуемыхМакетов = УведомлениеОСпецрежимахНалогообложения.ЗагрузитьМакетыИзАрхива(Объект, "БланкиПечати_");
	Листы = Новый СписокЗначений;
	
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	СтруктураПараметров = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ДанныеУведомления").Получить();
	ИННКПП = УведомлениеОСпецрежимахНалогообложения.ТиповаяСтруктураИННКППДляПечати(Объект, СтруктураПараметров.ДанныеУведомления.Титульная);
	
	НомСтр = 0;
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета, СтруктураПараметров.ДанныеУведомления["Титульная"], НомСтр, 
		УведомлениеОСпецрежимахНалогообложения.ПустойМакетИзСписка(Объект, СписокИспользуемыхМакетов, "Печать_Форма2020_1_Титульная"), ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
	
	Инд = 0;
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета, СтруктураПараметров.ДанныеУведомления["ЛистА"], НомСтр, 
		УведомлениеОСпецрежимахНалогообложения.ПустойМакетИзСписка(Объект, СписокИспользуемыхМакетов, "Печать_Форма2020_1_ЛистА"), ПечатнаяФорма, ИННКПП);
	Для Каждого Стр Из СтруктураПараметров.ДанныеДопСтрокБД.МнгСтр Цикл
		Если ЗначениеЗаполнено(Стр.НомерПат) 
			Или ЗначениеЗаполнено(Стр.ДатаВыдПат)
			Или ЗначениеЗаполнено(Стр.СумНалПатУм) Тогда 
			
			Инд = Инд + 1;
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СокрЛП(Стр.НомерПат), "НомерПат_" + Инд, ПечатнаяФорма.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(СокрЛП(Стр.ДатаВыдПат), "ДатаВыдПат_" + Инд, ПечатнаяФорма.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиЧислоСПрочеркамиНаПечать(СокрЛП(Стр.СумНалПатУм), "СумНалПатУм_" + Инд, ПечатнаяФорма.Области);
		КонецЕсли;
		
		Если Инд = 7 Тогда
			УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
			УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета, СтруктураПараметров.ДанныеУведомления["ЛистА"], НомСтр, 
				УведомлениеОСпецрежимахНалогообложения.ПустойМакетИзСписка(Объект, СписокИспользуемыхМакетов, "Печать_Форма2020_1_ЛистА"), ПечатнаяФорма, ИННКПП);
			Инд = 0;
		КонецЕсли;
	КонецЦикла;
	
	Если Инд > 0 Тогда 
		Пока Инд < 8 Цикл 
			Инд = Инд + 1;
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать("", "НомерПат_" + Инд, ПечатнаяФорма.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать("", "ДатаВыдПат_" + Инд, ПечатнаяФорма.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать("", "СумНалПатУм_" + Инд, ПечатнаяФорма.Области, "-");
		КонецЦикла;
		УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
	КонецЕсли;
	
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета, СтруктураПараметров.ДанныеУведомления["ЛистБ"], НомСтр, 
		УведомлениеОСпецрежимахНалогообложения.ПустойМакетИзСписка(Объект, СписокИспользуемыхМакетов, "Печать_Форма2020_1_ЛистБ"), ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
	
	Возврат Листы;
КонецФункции

Функция СформироватьСписокЛистовФорма2021_1(Объект) Экспорт
	СписокИспользуемыхМакетов = УведомлениеОСпецрежимахНалогообложения.ЗагрузитьМакетыИзАрхива(Объект, "БланкиПечати_");
	Листы = Новый СписокЗначений;
	
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	СтруктураПараметров = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ДанныеУведомления").Получить();
	ИННКПП = УведомлениеОСпецрежимахНалогообложения.ТиповаяСтруктураИННКППДляПечати(Объект, СтруктураПараметров.ДанныеУведомления.Титульная);
	
	НомСтр = 0;
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета, СтруктураПараметров.ДанныеУведомления["Титульная"], НомСтр, 
		УведомлениеОСпецрежимахНалогообложения.ПустойМакетИзСписка(Объект, СписокИспользуемыхМакетов, "Печать_Форма2021_1_Титульная"), ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
	
	Инд = 0;
	НомСтр = 2;
	МакетПФ = УведомлениеОСпецрежимахНалогообложения.ПустойМакетИзСписка(Объект, СписокИспользуемыхМакетов, "Печать_Форма2021_1_ЛистА");
	Для Каждого Стр Из СтруктураПараметров.ДанныеМногостраничныхРазделов.ЛистА Цикл 
		ЛистА = Стр.Значение;
		Инд = Инд + 1;
		Постфикс = "_" + Инд;
		
		Для Каждого КЗ Из ЛистА Цикл
			Если ТипЗнч(КЗ.Значение) = Тип("Строка") Тогда 
				УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(ВРег(КЗ.Значение), КЗ.Ключ + Постфикс, МакетПФ.Области, "-");
			ИначеЕсли ТипЗнч(КЗ.Значение) = Тип("Дата") Тогда 
				УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(КЗ.Значение, КЗ.Ключ + Постфикс, МакетПФ.Области);
			ИначеЕсли ТипЗнч(КЗ.Значение) = Тип("Число") Тогда 
				УведомлениеОСпецрежимахНалогообложения.ВывестиЧислоСПрочеркамиНаПечать(КЗ.Значение, КЗ.Ключ + Постфикс, МакетПФ.Области);
			ИначеЕсли КЗ.Значение = Неопределено Тогда 
				УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать("", КЗ.Ключ + Постфикс, МакетПФ.Области, "-");
			КонецЕсли;
		КонецЦикла;
		
		Если Инд = 2 Тогда
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(ИННКПП.ИНН, "ИННШапка", МакетПФ.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(Формат(НомСтр, "ЧЦ=3; ЧВН="), "НомСтр", МакетПФ.Области, "-");
			ПечатнаяФорма.Вывести(МакетПФ);
			УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
			МакетПФ = УведомлениеОСпецрежимахНалогообложения.ПустойМакетИзСписка(Объект, СписокИспользуемыхМакетов, "Печать_Форма2021_1_ЛистА");
			Инд = 0;
			НомСтр = НомСтр + 1;
		КонецЕсли;
	КонецЦикла;
	
	Если Инд = 1 Тогда
		Для Каждого КЗ Из ЛистА Цикл
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать("", КЗ.Ключ + "_2", МакетПФ.Области, "-");
		КонецЦикла;
		УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(ИННКПП.ИНН, "ИННШапка", МакетПФ.Области, "-");
		УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(Формат(НомСтр, "ЧЦ=3; ЧВН="), "НомСтр", МакетПФ.Области, "-");
		ПечатнаяФорма.Вывести(МакетПФ);
		УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
		НомСтр = НомСтр + 1;
	КонецЕсли;
	
	НомСтр = НомСтр - 1;
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета, СтруктураПараметров.ДанныеУведомления["ЛистБ"], НомСтр, 
		УведомлениеОСпецрежимахНалогообложения.ПустойМакетИзСписка(Объект, СписокИспользуемыхМакетов, "Печать_Форма2021_1_ЛистБ"), ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
	
	Возврат Листы;
КонецФункции

#КонецОбласти
#КонецЕсли
