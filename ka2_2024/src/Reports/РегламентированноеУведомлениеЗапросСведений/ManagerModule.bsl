#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Функция ДанноеУведомлениеДоступноДляОрганизации() Экспорт 
	Возврат Истина;
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
	Стр.ИмяФормы = "Форма2022_1";
	Стр.ОписаниеФормы = "В соответствии с письмом ФНС России от 29.08.2022 № АБ-4-19/11332@";
	
	Возврат Результат;
КонецФункции

Функция ПолучитьТаблицуПримененияФорматов() Экспорт 
	Результат = Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюТаблицуПримененияФорматов();
	
	Стр = Результат.Добавить();
	Стр.ИмяФормы = "Форма2022_1";
	Стр.КНД = "1110070";
	Стр.ВерсияФормата = "5.02";
	
	Возврат Результат;
КонецФункции

Функция ЭлектронноеПредставление(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
	Если ИмяФормы = "Форма2019_1" Тогда
		Возврат ЭлектронноеПредставление_Форма2019_1(Объект, УникальныйИдентификатор);
	ИначеЕсли ИмяФормы = "Форма2022_1" Тогда
		Возврат ЭлектронноеПредставление_Форма2022_1(Объект, УникальныйИдентификатор);
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

Функция ПроверитьДокумент(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
КонецФункции

Функция СформироватьСписокЛистов(Объект) Экспорт
	Если Объект.ИмяФормы = "Форма2019_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2019_1(Объект);
	ИначеЕсли Объект.ИмяФормы = "Форма2022_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2022_1(Объект);
	КонецЕсли;
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт 
	Если ИмяФормы = "Форма2019_1" Тогда 
		Возврат ПроверитьДокументСВыводомВТаблицу_Форма2019_1(
			Объект, УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект), УникальныйИдентификатор);
	ИначеЕсли ИмяФормы = "Форма2022_1" Тогда 
		Возврат ПроверитьДокументСВыводомВТаблицу_Форма2022_1(
			Объект, УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект), УникальныйИдентификатор);
	КонецЕсли;
КонецФункции

Функция ИдентификаторФайлаЭлектронногоПредставления_Форма2019_1(СведенияОтправки)
	Префикс = "IU_ZAPPRNT";
	Возврат Документы.УведомлениеОСпецрежимахНалогообложения.ИдентификаторФайлаЭлектронногоПредставления(Префикс, СведенияОтправки);
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу_Форма2019_1(Объект, Данные, УникальныйИдентификатор)
	ТаблицаОшибок = Новый СписокЗначений;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаАктуальностиФормыПриВыгрузке(
		Данные.Объект.ИмяФормы, ТаблицаОшибок, ПолучитьТаблицуФорм());
	
	Титульная = Данные.ДанныеУведомления.Титульная;
	Если РегламентированнаяОтчетностьПереопределяемый.ЭтоЮридическоеЛицо(Данные.Организация) Тогда 
		УведомлениеОСпецрежимахНалогообложения.ПроверкаИННКПП(Истина, Титульная, ТаблицаОшибок);
		Если Не ЗначениеЗаполнено(Титульная.НаимОрг) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указано название организации", "Титульная", "НаимОрг"));
		КонецЕсли;
	Иначе
		Если Титульная.ПрОбъекта = "индивидуальный предприниматель" Тогда 
			УведомлениеОСпецрежимахНалогообложения.ПроверкаИННКПП(Ложь, Титульная, ТаблицаОшибок);
		Иначе
			Если ЗначениеЗаполнено(Титульная.ИНН) Тогда 
				УведомлениеОСпецрежимахНалогообложения.ПроверкаИНН(Титульная, ТаблицаОшибок, "Титульная", "ИНН", Ложь, Ложь);
			Иначе
				Если Не ЗначениеЗаполнено(Титульная.КодВидДок) Тогда 
					ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
						"Не указан код документа", "Титульная", "КодВидДок"));
				КонецЕсли;
				Если Не ЗначениеЗаполнено(Титульная.СерНомДок) Тогда 
					ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
						"Не указана серия/номер документа", "Титульная", "СерНомДок"));
				КонецЕсли;
				Если Не ЗначениеЗаполнено(Титульная.ДатаДок) Тогда 
					ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
						"Не указана дата выдачи документа", "Титульная", "ДатаДок"));
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Титульная.Фамилия) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана фамилия", "Титульная", "Фамилия"));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Титульная.Имя) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указано имя", "Титульная", "Имя"));
		КонецЕсли;
	КонецЕсли;
	
	УведомлениеОСпецрежимахНалогообложения.ПроверкаКодаНО(Титульная.КодНО, ТаблицаОшибок, "Титульная");
	Если Не ЗначениеЗаполнено(Титульная.ПРИЗНАК_НП_ПОДВАЛ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан признак подписанта", "Титульная", "ПРИЗНАК_НП_ПОДВАЛ"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.ДАТА_ПОДПИСИ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана дата подписи", "Титульная", "ДАТА_ПОДПИСИ"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.ДатаНачПер) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана дата начала периода", "Титульная", "ДатаНачПер"));
	КонецЕсли;
	Если Титульная.ПРИЗНАК_НП_ПОДВАЛ = "2" Тогда 
		УведомлениеОСпецрежимахНалогообложения.ПроверкаПодписантаНалоговойОтчетности(Данные, ТаблицаОшибок, "Титульная", Истина);
	Иначе
		УведомлениеОСпецрежимахНалогообложения.ПроверкаПодписантаНалоговойОтчетности(Данные, ТаблицаОшибок, "Титульная", Ложь);
	КонецЕсли;
	УказаныПризнаки = Ложь;
	Для Инд = 1 По 14 Цикл 
		Если ЗначениеЗаполнено(Титульная["Код" + Формат(Инд, "ЧЦ=2; ЧВН=") + "00"]) Тогда 
			УказаныПризнаки = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Если Не УказаныПризнаки Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указаны признаки", "Титульная", "Код0100"));
	КонецЕсли;
	
	Лист002 = Данные.ДанныеУведомления.Лист002;
	Если Лист002.ПрОбъекта = "организация" Тогда
		УведомлениеОСпецрежимахНалогообложения.ПроверкаИННКПП(Истина, Лист002, ТаблицаОшибок, "Лист002");
		Если Не ЗначениеЗаполнено(Лист002.НаимОрг) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указано название организации", "Лист002", "НаимОрг"));
		КонецЕсли;
	ИначеЕсли Лист002.ПрОбъекта = "индивидуальный предприниматель" Тогда
		УведомлениеОСпецрежимахНалогообложения.ПроверкаИННКПП(Ложь, Лист002, ТаблицаОшибок, "Лист002");
		Если Не ЗначениеЗаполнено(Лист002.Фамилия) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана фамилия", "Лист002", "Фамилия"));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Лист002.Имя) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указано имя", "Лист002", "Имя"));
		КонецЕсли;
	ИначеЕсли Лист002.ПрОбъекта = "физическое лицо" Тогда
		Если Не ЗначениеЗаполнено(Лист002.Фамилия) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана фамилия", "Лист002", "Фамилия"));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Лист002.Имя) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указано имя", "Лист002", "Имя"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.ИНН) Тогда 
			УведомлениеОСпецрежимахНалогообложения.ПроверкаИНН(Лист002, ТаблицаОшибок, "Лист002", "ИНН", Ложь, Ложь);
		Иначе
			Если Не ЗначениеЗаполнено(Лист002.КодВидДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не указан код документа", "Лист002", "КодВидДок"));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Лист002.СерНомДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не указана серия/номер документа", "Лист002", "СерНомДок"));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Лист002.ДатаДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не указана дата выдачи документа", "Лист002", "ДатаДок"));
			КонецЕсли;
		КонецЕсли;
	Иначе
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан тип объекта", "Лист002", "ПрОбъекта"));
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаДатВУведомлении(Данные, ТаблицаОшибок);
	Возврат ТаблицаОшибок;
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу_Форма2022_1(Объект, Данные, УникальныйИдентификатор)
	ТаблицаОшибок = Новый СписокЗначений;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаАктуальностиФормыПриВыгрузке(
		Данные.Объект.ИмяФормы, ТаблицаОшибок, ПолучитьТаблицуФорм());
	
	Титульная = Данные.ДанныеУведомления.Титульная;
	Лист001 = Данные.ДанныеУведомления.Лист001;
	Лист002 = Данные.ДанныеУведомления.Лист002;
	
	Если РегламентированнаяОтчетностьПереопределяемый.ЭтоЮридическоеЛицо(Данные.Организация) Тогда 
		УведомлениеОСпецрежимахНалогообложения.ПроверкаИННКПП(Истина, Титульная, ТаблицаОшибок);
	ИначеЕсли Титульная.ПризНП = "1" Тогда 
		УведомлениеОСпецрежимахНалогообложения.ПроверкаИННКПП(Ложь, Титульная, ТаблицаОшибок);
	ИначеЕсли Титульная.ПризНП = "2" Тогда
		Если Не ЗначениеЗаполнено(Титульная.КодВидДок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указан код документа", "Титульная", "КодВидДок"));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Титульная.СерНомДок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана серия и номер документа", "Титульная", "СерНомДок"));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Титульная.ДатаДок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не указана дата выдачи документа", "Титульная", "ДатаДок"));
		КонецЕсли;
		УведомлениеОСпецрежимахНалогообложения.ПроверкаИНН(Титульная, ТаблицаОшибок, "Титульная", "ИНН", Ложь, Ложь);
	Иначе
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан / неправильно указан признак", "Титульная", "ПризНП"));
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаКодаНО(Титульная.КодНО, ТаблицаОшибок, "Титульная");
	Если Не ЗначениеЗаполнено(Титульная.ПРИЗНАК_НП_ПОДВАЛ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан признак подписанта", "Титульная", "ПРИЗНАК_НП_ПОДВАЛ"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.ДАТА_ПОДПИСИ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана дата подписи", "Титульная", "ДАТА_ПОДПИСИ"));
	КонецЕсли;
	Если Данные.ОТЧ.ПривестиЗначение(Титульная.ДатаНачПер) < 1900 Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан / неправильно указан год начала периода", "Титульная", "ДатаНачПер"));
	КонецЕсли;
	Если Данные.ОТЧ.ПривестиЗначение(Титульная.ДатаКонПер) < 1900 Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Неправильно указан год окончания периода", "Титульная", "ДатаКонПер"));
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаПодписантаНалоговойОтчетности(
		Данные, ТаблицаОшибок, "Титульная", 
		Титульная.ПРИЗНАК_НП_ПОДВАЛ = "2" Или РегламентированнаяОтчетностьПереопределяемый.ЭтоЮридическоеЛицо(Объект.Организация));
	Если Титульная.ПРИЗНАК_НП_ПОДВАЛ = "2" И Не ЗначениеЗаполнено(Титульная.НаимДок) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан документ представителя", "Титульная", "НаимДок"));
	КонецЕсли;
	
	Заполненность = ЗначениеЗаполнено(Лист001.КодКомпл);
	Если ЗначениеЗаполнено(Лист001.КодКомпл) 
		И (СтрДлина(СокрЛП(Лист001.КодКомпл)) <> 5 Или Лев(Лист001.КодКомпл, 1) <> "2") Тогда 
		
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Неправильно указан код комплекта сведений", "Лист001", "КодКомпл"));
	КонецЕсли;
	
	Инд = 0;
	Для Каждого Стр Из Данные.ДанныеДопСтрокБД.МнгСтр1 Цикл 
		Инд = Инд + 1;
		Заполненность = Заполненность Или ЗначениеЗаполнено(Стр.КодСвед);
		
		Если ЗначениеЗаполнено(Стр.КодСвед) 
			И (СтрДлина(СокрЛП(Стр.КодСвед)) <> 5 Или Лев(Стр.КодСвед, 1) <> "1") Тогда 
			
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Неправильно указан код сведений", "Лист001", "КодСвед___" + Инд));
		КонецЕсли;
	КонецЦикла;
	
	Если Не Заполненность Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не заполнен лист с кодами", "Лист001", "КодКомпл"));
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Лист002.ИННЮЛ) Или ЗначениеЗаполнено(Лист002.КПП) Или ЗначениеЗаполнено(Лист002.НаимОрг) Тогда
		УведомлениеОСпецрежимахНалогообложения.ПроверкаИНН(Лист002, ТаблицаОшибок, "Лист002", "ИННЮЛ", Истина, Истина);
		УведомлениеОСпецрежимахНалогообложения.ПроверкаКПП(Лист002, ТаблицаОшибок, "Лист002", "КПП", Истина);
		Если Не ЗначениеЗаполнено(Лист002.НаимОрг) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не заполнено наименование организации", "Лист002", "НаимОрг"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.ПризНП) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"При заполненной организации признак не заполняется", "Лист002", "ПризНП"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.ИННФЛ) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"При заполненной организации ИНН не заполняется", "Лист002", "ИННФЛ"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.Фамилия) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"При заполненной организации фамилия не заполняется", "Лист002", "Фамилия"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.Имя) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"При заполненной организации имя не заполняется", "Лист002", "Имя"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.Отчество) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"При заполненной организации отчество не заполняется", "Лист002", "Отчество"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.КодВидДок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"При заполненной организации код документа не заполняется", "Лист002", "КодВидДок"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.СерНомДок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"При заполненной организации серия и номер документа не заполняется", "Лист002", "СерНомДок"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.ДатаДок) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"При заполненной организации дата выдачи документа не заполняется", "Лист002", "ДатаДок"));
		КонецЕсли;
	ИначеЕсли ЗначениеЗаполнено(Лист002.ПризНП) 
		Или ЗначениеЗаполнено(Лист002.ИННФЛ)
		Или ЗначениеЗаполнено(Лист002.Фамилия)
		Или ЗначениеЗаполнено(Лист002.Имя)
		Или ЗначениеЗаполнено(Лист002.Отчество)
		Или ЗначениеЗаполнено(Лист002.КодВидДок)
		Или ЗначениеЗаполнено(Лист002.СерНомДок)
		Или ЗначениеЗаполнено(Лист002.ДатаДок)Тогда
		
		Если Не ЗначениеЗаполнено(Лист002.ПризНП) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не заполнен признак", "Лист002", "ПризНП"));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Лист002.Фамилия) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не заполнена фамилия", "Лист002", "Фамилия"));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Лист002.Имя) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не заполнено имя", "Лист002", "Имя"));
		КонецЕсли;
		Если ЗначениеЗаполнено(Лист002.ИННФЛ) 
			И Не РегламентированныеДанныеКлиентСервер.ИННСоответствуетТребованиям(Лист002.ИННФЛ, Ложь, "") Тогда 
			
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не заполнен / неправильно заполнен ИНН", "Лист002", "ИННФЛ"));
		ИначеЕсли Не ЗначениеЗаполнено(Лист002.ИННФЛ) И Лист002.ПризНП = "1" Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не заполнен ИНН", "Лист002", "ИННФЛ"));
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Лист002.ИННФЛ) И Лист002.ПризНП = "2" Тогда 
			Если Не ЗначениеЗаполнено(Лист002.КодВидДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнен код документа", "Лист002", "КодВидДок"));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Лист002.СерНомДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнены серия и номер документа", "Лист002", "СерНомДок"));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Лист002.ДатаДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнена дата выдачи документа", "Лист002", "ДатаДок"));
			КонецЕсли;
		ИначеЕсли ЗначениеЗаполнено(Лист002.ИННФЛ) И Лист002.ПризНП = "2" Тогда
			Если ЗначениеЗаполнено(Лист002.КодВидДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"При заполненном ИНН код документа не заполняется", "Лист002", "КодВидДок"));
			КонецЕсли;
			Если ЗначениеЗаполнено(Лист002.СерНомДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"При заполненном ИНН серия/номер документа не заполняется", "Лист002", "СерНомДок"));
			КонецЕсли;
			Если ЗначениеЗаполнено(Лист002.ДатаДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"При заполненном ИНН дата выдачи документа не заполняется", "Лист002", "ДатаДок"));
			КонецЕсли;
		КонецЕсли;
	Иначе
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не заполнены сведения, кому предоставляется доступ", "Лист002", "ИННЮЛ"));
	КонецЕсли;
	
	УведомлениеОСпецрежимахНалогообложения.ПроверкаДатВУведомлении(Данные, ТаблицаОшибок);
	УведомлениеОСпецрежимахНалогообложения.ПолнаяПроверкаЗаполненныхПоказателейНаСоотвествиеСписку(
		"СпискиВыбора2022_1", "СхемаВыгрузкиФорма2022_1", Данные.Объект.ИмяОтчета, ТаблицаОшибок, Данные);
	Возврат ТаблицаОшибок;
КонецФункции

Функция ОсновныеСведенияЭлектронногоПредставления_Форма2019_1(Объект, УникальныйИдентификатор)
	ОсновныеСведения = Документы.УведомлениеОСпецрежимахНалогообложения.НачальнаяИнициализацияОбщихРеквизитовВыгрузки(Объект);
	Данные = Объект.ДанныеУведомления.Получить();
	Титульная = Данные.ДанныеУведомления.Титульная;
	Лист002 = Данные.ДанныеУведомления.Лист002;
	ОсновныеСведения.Вставить("ИНН_Лист002", Лист002.ИНН);
	
	Если ОсновныеСведения.ЭтоПБОЮЛ Тогда
		Если Титульная.ПрОбъекта = "индивидуальный предприниматель" Тогда 
			ОсновныеСведения.Вставить("ПрЗаявителя", "2");
		Иначе
			ОсновныеСведения.Вставить("ПрЗаявителя", "3");
		КонецЕсли;
	Иначе 
		ОсновныеСведения.Вставить("ПрЗаявителя", "1");
	КонецЕсли;
	
	Если Лист002.ПрОбъекта = "индивидуальный предприниматель" Тогда 
		ОсновныеСведения.Вставить("ПрОбъекта", "2");
	ИначеЕсли Лист002.ПрОбъекта = "организация" Тогда  
		ОсновныеСведения.Вставить("ПрОбъекта", "1");
	ИначеЕсли Лист002.ПрОбъекта = "физическое лицо" Тогда  
		ОсновныеСведения.Вставить("ПрОбъекта", "3");
	Иначе
		ОсновныеСведения.Вставить("ПрОбъекта", "0");
	КонецЕсли;
	
	ИдентификаторФайла = ИдентификаторФайлаЭлектронногоПредставления_Форма2019_1(ОсновныеСведения);
	ОсновныеСведения.Вставить("ИдФайл", ИдентификаторФайла);
	
	Возврат ОсновныеСведения;
КонецФункции

Функция ОсновныеСведенияЭлектронногоПредставления_Форма2022_1(Объект, УникальныйИдентификатор)
	ОсновныеСведения = Документы.УведомлениеОСпецрежимахНалогообложения.НачальнаяИнициализацияОбщихРеквизитовВыгрузки(Объект);
	Данные = Объект.ДанныеУведомления.Получить();
	ОсновныеСведения.Вставить("ПризНП", Данные.ДанныеУведомления.Титульная.ПризНП);
	ОсновныеСведения.Вставить("ПризНП_Лист002", Данные.ДанныеУведомления.Лист002.ПризНП);
	
	ИдентификаторФайла = ИдентификаторФайлаЭлектронногоПредставления_Форма2019_1(ОсновныеСведения);
	ОсновныеСведения.Вставить("ИдФайл", ИдентификаторФайла);
	Возврат ОсновныеСведения;
КонецФункции

Функция ЭлектронноеПредставление_Форма2019_1(Объект, УникальныйИдентификатор)
	СведенияЭлектронногоПредставления = УведомлениеОСпецрежимахНалогообложения.СведенияЭлектронногоПредставления();
	ДанныеУведомления = УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект);
	Ошибки = ПроверитьДокументСВыводомВТаблицу_Форма2019_1(Объект, ДанныеУведомления, УникальныйИдентификатор);
	УведомлениеОСпецрежимахНалогообложения.СообщитьОшибкиПриПроверкеВыгрузки(Объект, Ошибки, ДанныеУведомления);
	
	ОсновныеСведения = ОсновныеСведенияЭлектронногоПредставления_Форма2019_1(Объект, УникальныйИдентификатор);
	СтруктураВыгрузки = Документы.УведомлениеОСпецрежимахНалогообложения.ИзвлечьСтруктуруXMLУведомления(Объект.ИмяОтчета, "СхемаВыгрузкиФорма2019_1");
	ДополнитьПараметры(ДанныеУведомления);
	УведомлениеОСпецрежимахНалогообложения.ТиповоеЗаполнениеДанными(ДанныеУведомления, ОсновныеСведения, СтруктураВыгрузки);
	УведомлениеОСпецрежимахНалогообложения.ВыгрузитьДеревоВТаблицу(СтруктураВыгрузки, ОсновныеСведения, СведенияЭлектронногоПредставления);
	Возврат СведенияЭлектронногоПредставления;
КонецФункции

Функция ЭлектронноеПредставление_Форма2022_1(Объект, УникальныйИдентификатор)
	СведенияЭлектронногоПредставления = УведомлениеОСпецрежимахНалогообложения.СведенияЭлектронногоПредставления();
	ДанныеУведомления = УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект);
	Ошибки = ПроверитьДокументСВыводомВТаблицу_Форма2022_1(Объект, ДанныеУведомления, УникальныйИдентификатор);
	УведомлениеОСпецрежимахНалогообложения.СообщитьОшибкиПриПроверкеВыгрузки(Объект, Ошибки, ДанныеУведомления);
	
	ОсновныеСведения = ОсновныеСведенияЭлектронногоПредставления_Форма2022_1(Объект, УникальныйИдентификатор);
	СтруктураВыгрузки = Документы.УведомлениеОСпецрежимахНалогообложения.ИзвлечьСтруктуруXMLУведомления(Объект.ИмяОтчета, "СхемаВыгрузкиФорма2022_1");
	УведомлениеОСпецрежимахНалогообложения.ТиповоеЗаполнениеДанными(ДанныеУведомления, ОсновныеСведения, СтруктураВыгрузки);
	УведомлениеОСпецрежимахНалогообложения.ВыгрузитьДеревоВТаблицу(СтруктураВыгрузки, ОсновныеСведения, СведенияЭлектронногоПредставления);
	Возврат СведенияЭлектронногоПредставления;
КонецФункции

Процедура ДополнитьПараметры(Параметры)
	МнгСтр = Новый ТаблицаЗначений;
	МнгСтр.Колонки.Добавить("КодСвед");
	Для Инд = 1 По 14 Цикл 
		ОкСтр = Формат(Инд, "ЧЦ=2; ЧВН=") + "00";
		Если ЗначениеЗаполнено(Параметры.ДанныеУведомления.Титульная["Код" + ОкСтр]) Тогда 
			НовСтр = МнгСтр.Добавить();
			НовСтр.КодСвед = ОкСтр;
		КонецЕсли;
	КонецЦикла;
	Параметры.Вставить("ДанныеДопСтрокБД", Новый Структура("МнгСтр", МнгСтр));
КонецПроцедуры

Функция СформироватьСписокЛистовФорма2019_1(Объект) Экспорт
	Листы = Новый СписокЗначений;
	
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	СтруктураПараметров = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ДанныеУведомления").Получить();
	ИННКПП = УведомлениеОСпецрежимахНалогообложения.ТиповаяСтруктураИННКППДляПечати(Объект, СтруктураПараметров.ДанныеУведомления.Титульная);
	
	ДУТ = СтруктураПараметров.ДанныеУведомления["Титульная"];
	Для Инд = 1 По 14 Цикл 
		ДУТ.Вставить("КодСвед_" + Инд, "");
	КонецЦикла;
	Сч = 0;
	Для Инд = 1 По 14 Цикл 
		СтрКод = Формат(Инд, "ЧЦ=2; ЧВН=") + "00";
		Если ЗначениеЗаполнено(ДУТ["Код" + Формат(Инд, "ЧЦ=2; ЧВН=") + "00"]) Тогда 
			Сч = Сч + 1;
			ДУТ["КодСвед_" + Сч] = СтрКод;
		КонецЕсли;
	КонецЦикла;
	
	Если РегламентированнаяОтчетностьПереопределяемый.ЭтоЮридическоеЛицо(Объект.Организация) Тогда 
		ДУТ.Вставить("Наименование", ДУТ.НаимОрг);
	Иначе 
		ДУТ.Вставить("Наименование", СокрЛП("" + Строка(ДУТ.Фамилия) + " " + Строка(ДУТ.Имя) + " " + Строка(ДУТ.Отчество)));
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета,
		ДУТ, 0, "Печать_Форма2019_1_Титульная", ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, 1, Ложь);
	
	ДУТ = СтруктураПараметров.ДанныеУведомления["Лист002"];
	Если ДУТ.ПрОбъекта = "организация" Тогда 
		ДУТ.Вставить("Наименование", ДУТ.НаимОрг);
	Иначе 
		ДУТ.Вставить("Наименование", СокрЛП("" + Строка(ДУТ.Фамилия) + " " + Строка(ДУТ.Имя) + " " + Строка(ДУТ.Отчество)));
	КонецЕсли;
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета,
		ДУТ, 1, "Печать_Форма2019_1_Лист002", ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(ИННКПП.ИНН, "ИННШапка", ПечатнаяФорма.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ВывестиСтрокуНаПечать(ИННКПП.КПП, "КППШапка", ПечатнаяФорма.Области, "-");
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, 2, Ложь);
	
	Возврат Листы;
КонецФункции

Функция СформироватьСписокЛистовФорма2022_1(Объект) Экспорт
	Возврат УведомлениеОСпецрежимахНалогообложения.ПечатьВСледующихВерсиях(Объект);
КонецФункции
#КонецОбласти
#КонецЕсли
