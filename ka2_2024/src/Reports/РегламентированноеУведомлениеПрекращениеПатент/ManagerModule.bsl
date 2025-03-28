#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Функция ПолучитьТаблицуПримененияФорматов() Экспорт 
	Результат = Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюТаблицуПримененияФорматов();
	
	Стр = Результат.Добавить();
	Стр.ИмяФормы = "Форма2020_1";
	Стр.КНД = "1150026";
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
	Стр.ИмяФормы = "Форма2020_1";
	Стр.ОписаниеФормы = "Прекращение деятельности по патентной системе(26.5-4)/приказ ФНС от 04.12.2020 N КЧ-7-3/882@";

	Возврат Результат;
КонецФункции

Функция СформироватьМакет(Объект, ИмяФормы) Экспорт
	Если ИмяФормы = "Форма2014_1" Тогда
		Возврат СформироватьМакетПолучениеПатентаРекомендованнаяФорма_Форма2014_1(Объект);
	КонецЕсли;
КонецФункции

Функция СформироватьВыгрузкуИПолучитьДанные(ДокОбъект) Экспорт 
	Выгрузка = ДокОбъект.ВыгрузитьДокумент();
	Если Выгрузка = Неопределено Тогда 
		Возврат Неопределено;
	КонецЕсли;
	СтруктураВыгрузки = Новый Структура("ТестВыгрузки,КодировкаВыгрузки", Выгрузка[0].ТестВыгрузки, Выгрузка[0].КодировкаВыгрузки);
	
	Если ДокОбъект.ИмяФормы = "Форма2020_1" Тогда 
		СтруктураВыгрузки.Вставить("Данные", УведомлениеОСпецрежимахНалогообложения.ПолучитьМакетДвоичныхДанных(ДокОбъект.ИмяОтчета, "TIFF_2020_1"));
		СтруктураВыгрузки.Вставить("ИмяФайла", "1150026_5.02000_02.tif");
		Возврат СтруктураВыгрузки;
	КонецЕсли;
КонецФункции

Функция ЭлектронноеПредставление(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
	Если ИмяФормы = "Форма2020_1" Тогда
		Возврат ЭлектронноеПредставление_Форма2020_1(Объект, УникальныйИдентификатор);
	КонецЕсли;
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт 
	Если ИмяФормы = "Форма2020_1" Тогда
		Возврат ПроверитьДокументСВыводомВТаблицу_Форма2020_1(
			Объект, УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект), УникальныйИдентификатор);
	КонецЕсли;
КонецФункции

Функция СформироватьМакетПолучениеПатентаРекомендованнаяФорма_Форма2014_1(Объект)
	
	ПечатнаяФорма = Новый ТабличныйДокумент;
	МакетУведомления = Отчеты[Объект.ИмяОтчета].ПолучитьМакет("Печать_MXL_Форма2014_1");
	ПараметрыМакета = МакетУведомления.Параметры;
	СтруктураПараметров = Объект.ДанныеУведомления.Получить();
	
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(СтруктураПараметров.П_ИНН, "ИНН_", ПараметрыМакета, 12);
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(СтруктураПараметров.КОД_НО, "КОД_НО_", ПараметрыМакета, 4);
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(СтруктураПараметров.ФАМИЛИЯ_ИП, "Фамилия_", ПараметрыМакета, 37);
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(СтруктураПараметров.ИМЯ_ИП, "Имя_", ПараметрыМакета, 37);
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(СтруктураПараметров.ОТЧЕСТВО_ИП, "Отчество_", ПараметрыМакета, 37);
	Документы.УведомлениеОСпецрежимахНалогообложения.ДатаВПараметрыМакета(СтруктураПараметров.ДАТА_ПРЕКРАЩЕНИЯ, "ДатаПрекращения_", ПараметрыМакета);
	Документы.УведомлениеОСпецрежимахНалогообложения.ДатаВПараметрыМакета(СтруктураПараметров.ДАТА_ВЫДАЧИ, "ДатаВыдачи_", ПараметрыМакета);
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(СтруктураПараметров.НОМЕР_ПАТЕНТА, "НомерПатента_", ПараметрыМакета, 13);
	Документы.УведомлениеОСпецрежимахНалогообложения.ЧислоВПараметрыМакета(СтруктураПараметров.ПРИЛОЖЕНО_ЛИСТОВ, "ПриложеноЛистов_", ПараметрыМакета, 3);
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(СтруктураПараметров.ТЕЛЕФОН, "Телефон_", ПараметрыМакета, 20);
	Документы.УведомлениеОСпецрежимахНалогообложения.ДатаВПараметрыМакета(Объект.ДатаПодписи, "ДатаПодписи_", ПараметрыМакета);
	ПараметрыМакета.ПризнакПредставителя = Объект.ПодписантПризнак;
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(Объект.ПодписантФамилия, "ОргПодписантФамилия_", ПараметрыМакета, 20);
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(Объект.ПодписантИмя, "ОргПодписантИмя_", ПараметрыМакета, 20);
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(Объект.ПодписантОтчество, "ОргПодписантОтчество_", ПараметрыМакета, 20);
	Документы.УведомлениеОСпецрежимахНалогообложения.СтрокаВПараметрыМакета(СтруктураПараметров.ДОКУМЕНТ_ПРЕДСТАВИТЕЛЯ, "ДокументПредставителя_", ПараметрыМакета, 40);
	
	ПечатнаяФорма.Вывести(МакетУведомления);
	Возврат ПечатнаяФорма;
КонецФункции

Функция ИдентификаторФайлаЭлектронногоПредставления(СведенияОтправки)
	Префикс = "SR_ZPRPSN";
	Возврат Документы.УведомлениеОСпецрежимахНалогообложения.ИдентификаторФайлаЭлектронногоПредставления(Префикс, СведенияОтправки);
КонецФункции

Функция ЭлектронноеПредставление_Форма2020_1(Объект, УникальныйИдентификатор)
	СведенияЭлектронногоПредставления = УведомлениеОСпецрежимахНалогообложения.СведенияЭлектронногоПредставления();
	ДанныеУведомления = УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект);
	Ошибки = ПроверитьДокументСВыводомВТаблицу_Форма2020_1(Объект, ДанныеУведомления, УникальныйИдентификатор);
	УведомлениеОСпецрежимахНалогообложения.СообщитьОшибкиПриПроверкеВыгрузки(Объект, Ошибки, ДанныеУведомления);
	
	ОсновныеСведения = ОсновныеСведенияЭлектронногоПредставления_Форма2020_1(Объект, УникальныйИдентификатор);
	СтруктураВыгрузки = Документы.УведомлениеОСпецрежимахНалогообложения.ИзвлечьСтруктуруXMLУведомления(Объект.ИмяОтчета, "СхемаВыгрузкиФорма2020_1");
	УведомлениеОСпецрежимахНалогообложения.ТиповоеЗаполнениеДанными(ДанныеУведомления, ОсновныеСведения, СтруктураВыгрузки);
	УведомлениеОСпецрежимахНалогообложения.ВыгрузитьДеревоВТаблицу(СтруктураВыгрузки, ОсновныеСведения, СведенияЭлектронногоПредставления);
	Возврат СведенияЭлектронногоПредставления;
КонецФункции

Функция СформироватьСписокЛистов(Объект) Экспорт
	Если Объект.ИмяФормы = "Форма2020_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2020_1(Объект);
	КонецЕсли;
КонецФункции

Функция СформироватьСписокЛистовФорма2020_1(Объект) Экспорт
	Листы = Новый СписокЗначений;
	
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	СтруктураПараметров = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ДанныеУведомления").Получить();
	ИННКПП = УведомлениеОСпецрежимахНалогообложения.ТиповаяСтруктураИННКППДляПечати(Объект, СтруктураПараметров.ДанныеУведомления.Титульная);
	
	НомСтр = 0;
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета, СтруктураПараметров.ДанныеУведомления["Титульная"],
		НомСтр, "Печать_Форма2020_1_Титульная", ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр, Ложь);
	Возврат Листы;
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу_Форма2020_1(Объект, Данные, УникальныйИдентификатор)
	ТаблицаОшибок = Новый СписокЗначений;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаАктуальностиФормыПриВыгрузке(
		Данные.Объект.ИмяФормы, ТаблицаОшибок, ПолучитьТаблицуФорм());
	
	Титульная = Данные.ДанныеУведомления.Титульная;
	Если Не ЗначениеЗаполнено(Титульная.ПрПодп) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан признак подписанта", "Титульная", "ПрПодп"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.НаимДок) И Титульная.ПрПодп = "2" Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан документ (обязателен при подаче представителем)", "Титульная", "НаимДок"));
	КонецЕсли;
	Если Титульная.ПрПодп = "2" Тогда 
		УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаПодписантаНалоговойОтчетности(Данные, ТаблицаОшибок, "Титульная", Истина);
	Иначе
		УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаПодписантаНалоговойОтчетности(Данные, ТаблицаОшибок, "Титульная", Ложь);
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаКодаНО(Титульная.КодНО, ТаблицаОшибок, "Титульная");
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаИННКПП(Ложь, Титульная, ТаблицаОшибок);
	Если Не ЗначениеЗаполнено(Титульная.Фамилия) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана фамилия", "Титульная", "Фамилия"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.Имя) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указано имя", "Титульная", "Имя"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.ДатаПрекрПСН) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана дата прекращения деятельности", "Титульная", "ДатаПрекрПСН"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.НомПатент) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан номер патента", "Титульная", "НомПатент"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.ДатаВыд) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана дата выдачи патента", "Титульная", "ДатаВыд"));
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаДатВУведомлении(Данные, ТаблицаОшибок);
	Возврат ТаблицаОшибок;
КонецФункции

Функция ОсновныеСведенияЭлектронногоПредставления_Форма2020_1(Объект, УникальныйИдентификатор)
	ОсновныеСведения = Документы.УведомлениеОСпецрежимахНалогообложения.НачальнаяИнициализацияОбщихРеквизитовВыгрузки(Объект);
	ИдентификаторФайла = ИдентификаторФайлаЭлектронногоПредставления(ОсновныеСведения);
	ОсновныеСведения.Вставить("ИдФайл", ИдентификаторФайла);
	Возврат ОсновныеСведения;
КонецФункции

#КонецОбласти
#КонецЕсли