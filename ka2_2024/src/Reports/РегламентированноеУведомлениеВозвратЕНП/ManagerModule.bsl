#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции
Функция ПолучитьФормуПоУмолчанию() Экспорт
	Возврат "";
КонецФункции

Функция СформироватьСписокЛистов(Объект) Экспорт
	Если Объект.ИмяФормы = "Форма2022_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2022_1(Объект);
	КонецЕсли;
КонецФункции

Функция ПолучитьТаблицуПримененияФорматов() Экспорт 
	Результат = Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюТаблицуПримененияФорматов();
	
	Стр = Результат.Добавить();
	Стр.ИмяФормы = "Форма2022_1";
	Стр.КНД = "1110357";
	Стр.ВерсияФормата = "5.01";
	
	Возврат Результат;
КонецФункции

Функция ДанноеУведомлениеДоступноДляОрганизации() Экспорт 
	Возврат Истина;
КонецФункции

Функция ДанноеУведомлениеДоступноДляИП() Экспорт 
	Возврат Истина;
КонецФункции

Функция ПолучитьОсновнуюФорму() Экспорт 
	Возврат "";
КонецФункции

Функция ПолучитьТаблицуФорм() Экспорт 
	Результат = Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюТаблицуФормУведомления();
	
	Стр = Результат.Добавить();
	Стр.ИмяФормы = "Форма2022_1";
	Стр.ВидУведомления = Перечисления.ВидыУведомленийОСпецрежимахНалогообложения.ВозвратЕдиногоНалоговогоПлатежа;
	Стр.ОписаниеФормы = "В соответствии с приказом ФНС России от 11.05.2022 № ЕД-7-8/389@";
	
	Возврат Результат;
КонецФункции

Функция СформироватьМакет(Объект, ИмяФормы) Экспорт
	ВызватьИсключение НСтр("ru = 'Печатная форма не реализована'");
	Возврат Неопределено;
КонецФункции

Функция ЭлектронноеПредставление(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
	Если ИмяФормы = "Форма2022_1" Тогда
		Возврат ЭлектронноеПредставление_Форма2022_1(Объект, УникальныйИдентификатор);
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

Функция ПроверитьДокумент(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт 
	Если ИмяФормы = "Форма2022_1" Тогда 
		Возврат ПроверитьДокументСВыводомВТаблицу_Форма2022_1(
			УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект), УникальныйИдентификатор);
	КонецЕсли;
КонецФункции

Функция ИдентификаторФайлаЭлектронногоПредставления_Форма2022_1(СведенияОтправки)
	Префикс = "UT_ZVOZVRDENSR";
	Возврат Документы.УведомлениеОСпецрежимахНалогообложения.ИдентификаторФайлаЭлектронногоПредставления(Префикс, СведенияОтправки);
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу_Форма2022_1(Данные, УникальныйИдентификатор)
	ТаблицаОшибок = Новый СписокЗначений;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаАктуальностиФормыПриВыгрузке(
		Данные.Объект.ИмяФормы, ТаблицаОшибок, ПолучитьТаблицуФорм());
		
	УведомлениеОСпецрежимахНалогообложения.ПроверкаДатВУведомлении(Данные, ТаблицаОшибок);
	УведомлениеОСпецрежимахНалогообложения.ПолнаяПроверкаЗаполненныхПоказателейНаСоотвествиеСписку(
		"СпискиВыбора2022_1", "СхемаВыгрузкиФорма2022_1", Данные.Объект.ИмяОтчета, ТаблицаОшибок, Данные);
	
	Титульная = Данные.ДанныеУведомления.Титульная;
	ЭтоЮЛ = РегламентированнаяОтчетностьПереопределяемый.ЭтоЮридическоеЛицо(Данные.Организация);
	УведомлениеОСпецрежимахНалогообложения.ПроверкаИННКПП(ЭтоЮЛ, Титульная, ТаблицаОшибок);
	
	Если Не ЗначениеЗаполнено(Титульная.ПРИЗНАК_НП_ПОДВАЛ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан признак подписанта", "Титульная", "ПРИЗНАК_НП_ПОДВАЛ"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.ДАТА_ПОДПИСИ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана дата подписи", "Титульная", "ДАТА_ПОДПИСИ"));
	КонецЕсли;
	Если (Титульная.ПРИЗНАК_НП_ПОДВАЛ = "1" И ЭтоЮЛ) Или Титульная.ПРИЗНАК_НП_ПОДВАЛ = "2" Тогда 
		УведомлениеОСпецрежимахНалогообложения.ПроверкаПодписантаНалоговойОтчетности(Данные, ТаблицаОшибок, "Титульная", Истина);
	Иначе
		УведомлениеОСпецрежимахНалогообложения.ПроверкаПодписантаНалоговойОтчетности(Данные, ТаблицаОшибок, "Титульная", Ложь);
	КонецЕсли;
	Если Титульная.ПРИЗНАК_НП_ПОДВАЛ = "2" И Не ЗначениеЗаполнено(Титульная.НаимДок) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан документ представителя", "Титульная", "НаимДок"));
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаКодаНО(Титульная.КодНО, ТаблицаОшибок, "Титульная");
	Если Не ЗначениеЗаполнено(Титульная.НаимОрг) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указано наименование организации/ФИО физлица", "Титульная", "НаимОрг"));
	КонецЕсли;
	
	ЗаявВозврДенСр = Данные.ДанныеУведомления.ЗаявВозврДенСр;
	Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.НаимБанк) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указано наименование банка", "ЗаявВозврДенСр", "НаимБанк"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.ВидСч) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан вид счета", "ЗаявВозврДенСр", "ВидСч"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.ПрНомСч) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан признак номера счета", "ЗаявВозврДенСр", "ПрНомСч"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.БИК)
		Или СтрДлина(ЗаявВозврДенСр.БИК) <> 9
		Или Не СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(ЗаявВозврДенСр.БИК) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан / неправильно указан БИК", "ЗаявВозврДенСр", "БИК"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.НомСч)
		Или СтрДлина(ЗаявВозврДенСр.НомСч) <> 20
		Или Не СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(ЗаявВозврДенСр.НомСч) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан / неправильно указан номер счета", "ЗаявВозврДенСр", "НомСч"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.ПрПолуч) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан признак получателя", "ЗаявВозврДенСр", "ПрПолуч"));
	КонецЕсли;
	
	Если ЗаявВозврДенСр.ПрПолуч = "1" Тогда 
		Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.НаимОрг) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указано наименование организации", "ЗаявВозврДенСр", "НаимОрг"));
		КонецЕсли;
	ИначеЕсли ЗаявВозврДенСр.ПрПолуч = "2" Тогда 
		Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.Фамилия) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан фамилия", "ЗаявВозврДенСр", "Фамилия"));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.Имя) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указано имя", "ЗаявВозврДенСр", "Имя"));
		КонецЕсли;
	ИначеЕсли ЗаявВозврДенСр.ПрПолуч = "3" Тогда 
		Если Не ЗначениеЗаполнено(ЗаявВозврДенСр.НаимОргЛицСч) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указано наименование органа, осуществляющего открытие и ведение лицевых счетов", "ЗаявВозврДенСр", "НаимОргЛицСч"));
		КонецЕсли;
		Если ЗначениеЗаполнено(ЗаявВозврДенСр.КБКПолуч)
			И (СтрДлина(ЗаявВозврДенСр.КБКПолуч) <> 20 Или Не СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(ЗаявВозврДенСр.КБКПолуч)) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Неправильно указан КБК получателя", "ЗаявВозврДенСр", "КБКПолуч"));
		КонецЕсли;
		Если ЗначениеЗаполнено(ЗаявВозврДенСр.НомЛицСчПолуч)
			И (СтрДлина(ЗаявВозврДенСр.НомЛицСчПолуч) <> 11 Или Не СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(ЗаявВозврДенСр.НомЛицСчПолуч)) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Неправильно указан номер лицевого счета получателя", "ЗаявВозврДенСр", "НомЛицСчПолуч"));
		КонецЕсли;
	КонецЕсли;
	
	Возврат ТаблицаОшибок;
КонецФункции

Функция ОсновныеСведенияЭлектронногоПредставления_Форма2022_1(Объект, УникальныйИдентификатор)
	ОсновныеСведения = Документы.УведомлениеОСпецрежимахНалогообложения.НачальнаяИнициализацияОбщихРеквизитовВыгрузки(Объект);
	
	Данные = Объект.ДанныеУведомления.Получить();
	ИдентификаторФайла = ИдентификаторФайлаЭлектронногоПредставления_Форма2022_1(ОсновныеСведения);
	ОсновныеСведения.Вставить("ИдФайл", ИдентификаторФайла);
	
	Возврат ОсновныеСведения;
КонецФункции

Функция ЭлектронноеПредставление_Форма2022_1(Объект, УникальныйИдентификатор)
	СведенияЭлектронногоПредставления = УведомлениеОСпецрежимахНалогообложения.СведенияЭлектронногоПредставления();
	ДанныеУведомления = УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект);
	Ошибки = ПроверитьДокументСВыводомВТаблицу_Форма2022_1(ДанныеУведомления, УникальныйИдентификатор);
	УведомлениеОСпецрежимахНалогообложения.СообщитьОшибкиПриПроверкеВыгрузки(Объект, Ошибки, ДанныеУведомления);
	
	ОсновныеСведения = ОсновныеСведенияЭлектронногоПредставления_Форма2022_1(Объект, УникальныйИдентификатор);
	СтруктураВыгрузки = Документы.УведомлениеОСпецрежимахНалогообложения.ИзвлечьСтруктуруXMLУведомления(Объект.ИмяОтчета, "СхемаВыгрузкиФорма2022_1");
	УведомлениеОСпецрежимахНалогообложения.ТиповоеЗаполнениеДанными(ДанныеУведомления, ОсновныеСведения, СтруктураВыгрузки);
	УведомлениеОСпецрежимахНалогообложения.ВыгрузитьДеревоВТаблицу(СтруктураВыгрузки, ОсновныеСведения, СведенияЭлектронногоПредставления);
	Возврат СведенияЭлектронногоПредставления;
КонецФункции

Функция СформироватьСписокЛистовФорма2022_1(Объект) Экспорт
	Листы = Новый СписокЗначений;
	
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	СтруктураПараметров = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ДанныеУведомления").Получить();
	ИННКПП = УведомлениеОСпецрежимахНалогообложения.ТиповаяСтруктураИННКППДляПечати(Объект, СтруктураПараметров.ДанныеУведомления.Титульная);
	
	НомСтр = 0;
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета,
		СтруктураПараметров.ДанныеУведомления["Титульная"], НомСтр, "Печать_Форма2020_1_Титульная", ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
	
	ЗаявВозврДенСр = СтруктураПараметров.ДанныеУведомления["ЗаявВозврДенСр"];
	Если ЗаявВозврДенСр.ПрПолуч = "1" Тогда
		ЗаявВозврДенСр.Вставить("НаимПолуч", ЗаявВозврДенСр.НаимОрг);
	ИначеЕсли ЗаявВозврДенСр.ПрПолуч = "2" Тогда
		ЗаявВозврДенСр.Вставить("НаимПолуч", СокрЛП(ЗаявВозврДенСр.Фамилия + " " + ЗаявВозврДенСр.Имя + " " + ЗаявВозврДенСр.Отчество));
	ИначеЕсли ЗаявВозврДенСр.ПрПолуч = "3" Тогда
		ЗаявВозврДенСр.Вставить("НаимПолуч", ЗаявВозврДенСр.НаимОргЛицСч);
	КонецЕсли;
	
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета,
		ЗаявВозврДенСр, НомСтр, "Печать_Форма2020_1_ЗаявВозврДенСр", ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
	Возврат Листы;
КонецФункции

#КонецОбласти
#КонецЕсли
