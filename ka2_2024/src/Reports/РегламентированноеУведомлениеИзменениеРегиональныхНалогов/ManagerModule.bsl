#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДанноеУведомлениеДоступноДляОрганизации() Экспорт 
	Возврат Истина;
КонецФункции

Функция ДанноеУведомлениеДоступноДляИП() Экспорт 
	Возврат Ложь;
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
	Стр.ОписаниеФормы = "В соответствии с приказом ФНС России от 29.10.2024 № ЕД-7-21/899@";
	Стр.ДатаНачала = '20240101';
	Стр.ДатаКонца = '20991231';
	
	Возврат Результат;
КонецФункции

Функция ЭлектронноеПредставление(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
	Если ИмяФормы = "Форма2021_1" Тогда
		Возврат ЭлектронноеПредставление_Форма2021_1(Объект, УникальныйИдентификатор);
	КонецЕсли;
КонецФункции

Функция ПроверитьДокумент(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
КонецФункции

Функция СформироватьСписокЛистов(Объект) Экспорт
	Если Объект.ИмяФормы = "Форма2021_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2021_1(Объект);
	ИначеЕсли Объект.ИмяФормы = "Форма2017_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2017_1(Объект);
	КонецЕсли;
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт 
	Если ИмяФормы = "Форма2021_1" Тогда 
		Возврат ПроверитьДокументСВыводомВТаблицу_Форма2021_1(
			УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект), УникальныйИдентификатор);
	КонецЕсли;
КонецФункции

Функция ИдентификаторФайлаЭлектронногоПредставления(СведенияОтправки)
	Префикс = "VO_USTIZMPRNAL";
	Возврат Документы.УведомлениеОСпецрежимахНалогообложения.ИдентификаторФайлаЭлектронногоПредставления(Префикс, СведенияОтправки);
КонецФункции

Функция ОсновныеСведенияЭлектронногоПредставления_Форма2021_1(Объект, УникальныйИдентификатор)
	ОсновныеСведения = Документы.УведомлениеОСпецрежимахНалогообложения.НачальнаяИнициализацияОбщихРеквизитовВыгрузки(Объект);
	
	Данные = Объект.ДанныеУведомления.Получить();
	ОсновныеСведения.Вставить("КолДок", Данные.ДанныеМногостраничныхРазделов.Документ.Количество());
	ОсновныеСведения.Вставить("ИННЮЛ", Данные.ДанныеУведомления.Титульный.ИННЮЛ);
	ИдентификаторФайла = ИдентификаторФайлаЭлектронногоПредставления(ОсновныеСведения);
	ОсновныеСведения.Вставить("ИдФайл", ИдентификаторФайла);
	
	Возврат ОсновныеСведения;
КонецФункции

Функция ЭлектронноеПредставление_Форма2021_1(Объект, УникальныйИдентификатор)
	СведенияЭлектронногоПредставления = УведомлениеОСпецрежимахНалогообложения.СведенияЭлектронногоПредставления();
	ДанныеУведомления = УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект);
	ДополнитьПараметры(ДанныеУведомления);
	Ошибки = ПроверитьДокументСВыводомВТаблицу_Форма2021_1(ДанныеУведомления, УникальныйИдентификатор);
	УведомлениеОСпецрежимахНалогообложения.СообщитьОшибкиПриПроверкеВыгрузки(Объект, Ошибки, ДанныеУведомления);
	
	ОсновныеСведения = ОсновныеСведенияЭлектронногоПредставления_Форма2021_1(Объект, УникальныйИдентификатор);
	СтруктураВыгрузки = Документы.УведомлениеОСпецрежимахНалогообложения.ИзвлечьСтруктуруXMLУведомления(Объект.ИмяОтчета, "СхемаВыгрузкиФорма2021_1");
	УведомлениеОСпецрежимахНалогообложения.ТиповоеЗаполнениеДанными(ДанныеУведомления, ОсновныеСведения, СтруктураВыгрузки);
	УведомлениеОСпецрежимахНалогообложения.ВыгрузитьДеревоВТаблицу(СтруктураВыгрузки, ОсновныеСведения, СведенияЭлектронногоПредставления);
	Возврат СведенияЭлектронногоПредставления;
КонецФункции

Процедура ДополнитьПараметры(Параметры)
	Для Каждого Стр Из Параметры.ДанныеМногостраничныхРазделов.Документ Цикл
		ПарамСтр = Стр.Значение;
		Если УведомлениеОСпецрежимахНалогообложения.СтраницаЗаполнена(ПарамСтр) Тогда
			Если ПарамСтр.ВидНал = "2" Тогда 
				ПарамСтр.Вставить("НалПерМесГод", Формат(ПарамСтр.НалПер, "ДФ=MM.yyyy; ДП=00.0000"));
			Иначе
				ПарамСтр.Вставить("НалПерГод", Формат(ПарамСтр.НалПер, "ДФ=yyyy; ДП=000000"));
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

Функция СформироватьСписокЛистовФорма2017_1(Объект) Экспорт
	Листы = Новый СписокЗначений;
	
	СтруктураПараметров = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ДанныеУведомления").Получить();
	МакетУведомления = Отчеты[Объект.ИмяОтчета].ПолучитьМакет("ПечатныйБланк_2017");
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	Страница = МакетУведомления.ПолучитьОбласть("Страница1");
	Страница.Параметры.КодНО = СтруктураПараметров.ДанныеУведомления.Титульный.КодНО;
	Страница.Параметры.НаименованиеНО = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.РегистрацияВИФНС, "Наименование");
	Страница.Параметры.НаименованиеОргана = СтруктураПараметров.ДанныеУведомления.Титульный.НаимОрг;
	Страница.Параметры.Отправитель = СтруктураПараметров.ДанныеУведомления.Титульный.ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ;
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтруктураПараметров.ДанныеУведомления.Титульный.ОГРН, "ОГРН", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтруктураПараметров.ДанныеУведомления.Титульный.ИННЮЛ, "ИНН", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтруктураПараметров.ДанныеУведомления.Титульный.КПП, "КПП", Страница.Области, "-");
	СтрДокумент = СтруктураПараметров.ДанныеМногостраничныхРазделов.Документ[0].Значение;
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.ТипДок, "ТипДок", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.ВидНал, "ВидНал", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.ВидИнф, "ВидИнф", Страница.Области, "-");
	Страница.Параметры.ВидАкт = СтрДокумент.ВидАкт;
	Страница.Параметры.НаимОргАкт = СтрДокумент.НаимОргАкт;
	УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(СтрДокумент.ДатаПринАкт, "ДатаПринАкт", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(СтрДокумент.ДатаОпубАкт, "ДатаОпубАкт", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(СтрДокумент.ДатаВступАкт, "ДатаВступАкт", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(Объект.ДатаПодписи, "ДАТА_ПОДПИСИ", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.НомАкт, "НомАкт", Страница.Области, "-");
	НалПер = Формат(СтрДокумент.СвДатаНач, ?(СтрДокумент.ВидНал = "2", "ДФ=MMyyyy; ДП=------", "ДФ=--yyyy; ДП=------"));
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(НалПер, "НалПер", Страница.Области, "-");
	УИД = СтрДокумент.УИД;
	ОКТМО = "";
	Для Каждого Элт Из СтруктураПараметров.ДанныеДопСтрокБД.МнгСтр1.НайтиСтроки(Новый Структура("УИД", УИД)) Цикл 
		Если ЗначениеЗаполнено(Элт["ОКТМО"]) Тогда 
			ОКТМО = ОКТМО + ?(ЗначениеЗаполнено(ОКТМО), ",", "") + Элт["ОКТМО"];
		КонецЕсли;
		Если СтрДлина(ОКТМО) > 100 Тогда 
			Прервать;
		КонецЕсли;
	КонецЦикла;
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(ОКТМО, "ОКТМО", Страница.Области, "-");
	ПечатнаяФорма.Вывести(Страница);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, 1, Ложь);
	
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	Страница = МакетУведомления.ПолучитьОбласть("Страница2");
	Для Каждого СвНалСтав Из СтруктураПараметров.ДанныеМногостраничныхРазделов.СвНалСтав Цикл 
		Если СвНалСтав.Значение.УИДРодителя = УИД Тогда 
			СвНалСтав = СвНалСтав.Значение;
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СвНалСтав.СведНалСтав, "СвСтавка", Страница.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СвНалСтав.ЕдИзмер, "ЕдИзм", Страница.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиЧислоСПрочеркамиНаПечать(СвНалСтав.РазмНалСтав, "РазмерСтавки", Страница.Области);
			Страница.Параметры.ВидОбъектаНалогообложения = СвНалСтав.НаимОбъект;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Для Каждого СвНалЛьгот Из СтруктураПараметров.ДанныеМногостраничныхРазделов.СвНалЛьгот Цикл 
		Если СвНалЛьгот.Значение.УИДРодителя = УИД Тогда 
			СвНалЛьгот = СвНалЛьгот.Значение;
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СвНалЛьгот.СведНалСтав, "СвЛьгота", Страница.Области, "-");
			Страница.Параметры.КатегорияОбъектаНалогообложения = СвНалЛьгот.КатегНал;
			Страница.Параметры.СодержаниеЛьготы = СвНалЛьгот.СодНалЛьгот;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Для Каждого СвНалВыч Из СтруктураПараметров.ДанныеМногостраничныхРазделов.СвНалВыч Цикл 
		Если СвНалВыч.Значение.УИДРодителя = УИД Тогда 
			СвНалВыч = СвНалВыч.Значение;
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СвНалВыч.СведНалСтав, "СвВычет", Страница.Области, "-");
			Страница.Параметры.КатегорияНПЛ = СвНалВыч.КатегНал;
			Страница.Параметры.РазмерВычета = СвНалВыч.СодНалЛьгот;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(Формат(СтрДокумент.СвОсобОпр, "ДФ=yyyy; ДП=----"), "СвОсобОпр", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(Формат(СтрДокумент.СвДатаНач, "ДФ=yyyy; ДП=----"), "СвДатаНач", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(Формат(СтрДокумент.СвОтмУпл, "ДФ=yyyy; ДП=----"), "СвОтмУпл", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.КодУстСрок, "СвАванс", Страница.Области, "-");
	Страница.Параметры.УстСрок = СтрДокумент.УстСрок;
	ПечатнаяФорма.Вывести(Страница);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, 2, Ложь);
	
	Возврат Листы;
КонецФункции

Функция СформироватьСписокЛистовФорма2021_1(Объект) Экспорт
	Листы = Новый СписокЗначений;
	
	СтруктураПараметров = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ДанныеУведомления").Получить();
	МакетУведомления = Отчеты[Объект.ИмяОтчета].ПолучитьМакет("ПечатныйБланк_2021");
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	Страница = МакетУведомления.ПолучитьОбласть("Страница1");
	Страница.Параметры.КодНО = СтруктураПараметров.ДанныеУведомления.Титульный.КодНО;
	Страница.Параметры.НаименованиеНО = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.РегистрацияВИФНС, "Наименование");
	Страница.Параметры.НаименованиеОргана = СтруктураПараметров.ДанныеУведомления.Титульный.НаимОрг;
	Страница.Параметры.Отправитель = СтруктураПараметров.ДанныеУведомления.Титульный.ФИО_РУКОВОДИТЕЛЯ_ПРЕДСТАВИТЕЛЯ;
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтруктураПараметров.ДанныеУведомления.Титульный.ОГРН, "ОГРН", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтруктураПараметров.ДанныеУведомления.Титульный.ИННЮЛ, "ИНН", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтруктураПараметров.ДанныеУведомления.Титульный.КПП, "КПП", Страница.Области, "-");
	СтрДокумент = СтруктураПараметров.ДанныеМногостраничныхРазделов.Документ[0].Значение;
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.ТипДок, "ТипДок", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.ВидНал, "ВидНал", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.ВидИнф, "ВидИнф", Страница.Области, "-");
	Страница.Параметры.ВидАкт = СтрДокумент.ВидАкт;
	Страница.Параметры.НаимОргАкт = СтрДокумент.НаимОргАкт;
	УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(СтрДокумент.ДатаПринАкт, "ДатаПринАкт", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(СтрДокумент.ДатаОпубАкт, "ДатаОпубАкт", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(СтрДокумент.ДатаВступАкт, "ДатаВступАкт", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиДатуНаПечать(Объект.ДатаПодписи, "ДАТА_ПОДПИСИ", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.НомАкт, "НомАкт", Страница.Области, "-");
	НалПер = Формат(СтрДокумент.СвДатаНач, ?(СтрДокумент.ВидНал = "2", "ДФ=MMyyyy; ДП=------", "ДФ=--yyyy; ДП=------"));
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(НалПер, "НалПер", Страница.Области, "-");
	УИД = СтрДокумент.УИД;
	ОКТМО = "";
	Для Каждого Элт Из СтруктураПараметров.ДанныеДопСтрокБД.МнгСтр1.НайтиСтроки(Новый Структура("УИД", УИД)) Цикл 
		Если ЗначениеЗаполнено(Элт["ОКТМО"]) Тогда 
			ОКТМО = ОКТМО + ?(ЗначениеЗаполнено(ОКТМО), ",", "") + Элт["ОКТМО"];
		КонецЕсли;
		Если СтрДлина(ОКТМО) > 100 Тогда 
			Прервать;
		КонецЕсли;
	КонецЦикла;
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(ОКТМО, "ОКТМО", Страница.Области, "-");
	ПечатнаяФорма.Вывести(Страница);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, 1, Ложь);
	
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	Страница = МакетУведомления.ПолучитьОбласть("Страница2");
	Для Каждого СвНалСтав Из СтруктураПараметров.ДанныеМногостраничныхРазделов.СвНалСтав Цикл 
		Если СвНалСтав.Значение.УИДРодителя = УИД Тогда 
			СвНалСтав = СвНалСтав.Значение;
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СвНалСтав.СведНалСтав, "СвСтавка", Страница.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СвНалСтав.ЕдИзмер, "ЕдИзм", Страница.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(
				ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(СвНалСтав, "ПерНалСтав", ""), "ПерНалСтав", Страница.Области, "-");
			УведомлениеОСпецрежимахНалогообложения.ВывестиЧислоСПрочеркамиНаПечать(СвНалСтав.РазмНалСтав, "РазмерСтавки", Страница.Области);
			Страница.Параметры.ВидОбъектаНалогообложения = СвНалСтав.НаимОбъект;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Для Каждого СвНалЛьгот Из СтруктураПараметров.ДанныеМногостраничныхРазделов.СвНалЛьгот Цикл 
		Если СвНалЛьгот.Значение.УИДРодителя = УИД Тогда 
			СвНалЛьгот = СвНалЛьгот.Значение;
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СвНалЛьгот.СведНалСтав, "СвЛьгота", Страница.Области, "-");
			Страница.Параметры.КатегорияОбъектаНалогообложения = СвНалЛьгот.КатегНал;
			Страница.Параметры.СодержаниеЛьготы = СвНалЛьгот.СодНалЛьгот;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Для Каждого СвНалВыч Из СтруктураПараметров.ДанныеМногостраничныхРазделов.СвНалВыч Цикл 
		Если СвНалВыч.Значение.УИДРодителя = УИД Тогда 
			СвНалВыч = СвНалВыч.Значение;
			УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СвНалВыч.СведНалСтав, "СвВычет", Страница.Области, "-");
			Страница.Параметры.КатегорияНПЛ = СвНалВыч.КатегНал;
			Страница.Параметры.РазмерВычета = СвНалВыч.СодНалЛьгот;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(Формат(СтрДокумент.СвОсобОпр, "ДФ=yyyy; ДП=----"), "СвОсобОпр", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(Формат(СтрДокумент.СвДатаНач, "ДФ=yyyy; ДП=----"), "СвДатаНач", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(Формат(СтрДокумент.СвОтмУпл, "ДФ=yyyy; ДП=----"), "СвОтмУпл", Страница.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(СтрДокумент.КодУстСрок, "СвАванс", Страница.Области, "-");
	Страница.Параметры.УстСрок = СтрДокумент.УстСрок;
	Страница.Параметры.ИнаяИнформация = СтрДокумент.ИнаяИнф;
	ПечатнаяФорма.Вывести(Страница);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, 2, Ложь);
	
	Возврат Листы;
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу_Форма2021_1(Данные, УникальныйИдентификатор)
	ТаблицаОшибок = Новый СписокЗначений;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаАктуальностиФормыПриВыгрузке(
		Данные.Объект.ИмяФормы, ТаблицаОшибок, ПолучитьТаблицуФорм());
	
	Титульная = Данные.ДанныеУведомления.Титульный;
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаКодаНО(Титульная.КодНО, ТаблицаОшибок, "Титульный");
	Если Не ЗначениеЗаполнено(Титульная.НаимОрг) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указано наименование организации", "Титульный", "НаимОрг"));
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаИНН(Титульная, ТаблицаОшибок, "Титульный", "ИННЮЛ", Истина, Истина);
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаКПП(Титульная, ТаблицаОшибок, "Титульный", "КПП", Истина);
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаОГРН(Титульная, ТаблицаОшибок, "Титульный", "ОГРН", Истина, Истина);
	Если Не ЗначениеЗаполнено(Титульная.ДАТА_ПОДПИСИ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана дата составления", "Титульный", "ДАТА_ПОДПИСИ"));
	КонецЕсли;
	
	Для Каждого Элт Из СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок("СвНалСтав,СвНалЛьгот,СвНалВыч", ",") Цикл 
		Для Каждого Стр Из Данные.ДанныеМногостраничныхРазделов[Элт] Цикл 
			СтрЗнач = Стр.Значение;
			Если УведомлениеОСпецрежимахНалогообложения.СтраницаЗаполнена(СтрЗнач) И Не ЗначениеЗаполнено(СтрЗнач.СведНалСтав) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не указаны сведения о налоговом вычете", Элт, "СведНалСтав", СтрЗнач.УИД));
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаПодписантаНалоговойОтчетности(Данные, ТаблицаОшибок, "Титульная", Ложь);
	
	Для Каждого Стр Из Данные.ДанныеМногостраничныхРазделов.Документ Цикл
		СтрЗнач = Стр.Значение;
		
		Если Не ЗначениеЗаполнено(СтрЗнач.ТипДок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан тип документа", "Документ", "ТипДок", СтрЗнач.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрЗнач.ВидНал) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан вид налога", "Документ", "ВидНал", СтрЗнач.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрЗнач.ВидИнф) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан вид информации", "Документ", "ВидИнф", СтрЗнач.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрЗнач.ВидАкт) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан вид акта", "Документ", "ВидАкт", СтрЗнач.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрЗнач.НаимОргАкт) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана организация", "Документ", "НаимОргАкт", СтрЗнач.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрЗнач.ДатаПринАкт) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана дата подписания акта", "Документ", "ДатаПринАкт", СтрЗнач.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрЗнач.ДатаОпубАкт) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана дата опубликования акта", "Документ", "ДатаОпубАкт", СтрЗнач.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрЗнач.ДатаВступАкт) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана дата вступления акта в силу", "Документ", "ДатаВступАкт", СтрЗнач.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрЗнач.НалПер) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан налоговый период", "Документ", "НалПер", СтрЗнач.УИД));
		КонецЕсли;
		Если ЗначениеЗаполнено(СтрЗнач.УстСрок) И Не ЗначениеЗаполнено(СтрЗнач.КодУстСрок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан вид налога или платежа", "Документ", "КодУстСрок", СтрЗнач.УИД));
		КонецЕсли;
		Если ЗначениеЗаполнено(СтрЗнач.КодУстСрок) И Не ЗначениеЗаполнено(СтрЗнач.УстСрок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан установленный срок", "Документ", "УстСрок", СтрЗнач.УИД));
		КонецЕсли;
		
		Инд = 0;
		Для Каждого СтрМнг1 Из Данные.ДанныеДопСтрокБД.МнгСтр1.НайтиСтроки(Новый Структура("УИД", СтрЗнач.УИД)) Цикл 
			Инд = Инд + 1;
			УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаОКТМО(СтрМнг1, ТаблицаОшибок, "Документ", "ОКТМО", Истина, Инд);
		КонецЦикла;
	КонецЦикла;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаДатВУведомлении(Данные, ТаблицаОшибок);
	УведомлениеОСпецрежимахНалогообложения.ПолнаяПроверкаЗаполненныхПоказателейНаСоотвествиеСписку(
		"СпискиВыбора2021_1", "СхемаВыгрузкиФорма2021_1", Данные.Объект.ИмяОтчета, ТаблицаОшибок, Данные);
	
	Возврат ТаблицаОшибок;
КонецФункции

#КонецОбласти
#КонецЕсли
