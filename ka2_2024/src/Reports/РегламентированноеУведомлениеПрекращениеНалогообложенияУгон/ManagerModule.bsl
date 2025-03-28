#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Функция ПолучитьТаблицуПримененияФорматов() Экспорт 
	Результат = Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюТаблицуПримененияФорматов();
	
	Стр = Результат.Добавить();
	Стр.ИмяФормы = "Форма2023_1";
	Стр.КНД = "1150136";
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

Функция ПолучитьФормуПоУмолчанию() Экспорт 
	Возврат "";
КонецФункции

Функция ПолучитьТаблицуФорм() Экспорт 
	Результат = Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюТаблицуФормУведомления();
	
	Стр = Результат.Добавить();
	Стр.ИмяФормы = "Форма2023_1";
	Стр.ОписаниеФормы = "В соответствии с приказом ФНС России от 11.08.2023 № СД-7-21/534@";
	Стр.ДатаНачала = '20240101';
	
	Возврат Результат;
КонецФункции

Функция СформироватьВыгрузкуИПолучитьДанные(ДокОбъект) Экспорт 
	Выгрузка = ДокОбъект.ВыгрузитьДокумент();
	Если Выгрузка = Неопределено Тогда 
		Возврат Неопределено;
	КонецЕсли;
	СтруктураВыгрузки = Новый Структура("ТестВыгрузки,КодировкаВыгрузки", Выгрузка[0].ТестВыгрузки, Выгрузка[0].КодировкаВыгрузки);
	
	Если ДокОбъект.ИмяФормы = "Форма2023_1" Тогда 
		СтруктураВыгрузки.Вставить("Данные", УведомлениеОСпецрежимахНалогообложения.ПолучитьМакетДвоичныхДанных(ДокОбъект.ИмяОтчета, "TIFF_2023_1"));
		СтруктураВыгрузки.Вставить("ИмяФайла", "1150136_5.01000_01.tif");
		Возврат СтруктураВыгрузки;
	КонецЕсли;
КонецФункции

Функция ЭлектронноеПредставление(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
	Если ИмяФормы = "Форма2023_1" Тогда
		Возврат ЭлектронноеПредставление_Форма2023_1(Объект, УникальныйИдентификатор);
	КонецЕсли;
	Возврат Неопределено;
КонецФункции

Функция ПроверитьДокумент(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
КонецФункции

Функция СформироватьСписокЛистов(Объект) Экспорт
	Если Объект.ИмяФормы = "Форма2023_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2023_1(Объект);
	КонецЕсли;
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт 
	Если ИмяФормы = "Форма2023_1" Тогда 
		Возврат ПроверитьДокументСВыводомВТаблицу_Форма2023_1(УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект), УникальныйИдентификатор);
	КонецЕсли;
КонецФункции

Функция ИдентификаторФайлаЭлектронногоПредставления_Форма2023_1(СведенияОтправки)
	Префикс = "IU_PREKRTNUGON";
	Возврат Документы.УведомлениеОСпецрежимахНалогообложения.ИдентификаторФайлаЭлектронногоПредставления(Префикс, СведенияОтправки);
КонецФункции

Функция ПроверитьДокументСВыводомВТаблицу_Форма2023_1(Данные, УникальныйИдентификатор)
	ТаблицаОшибок = Новый СписокЗначений;
	УведомлениеОСпецрежимахНалогообложения.ПроверкаАктуальностиФормыПриВыгрузке(
		Данные.Объект.ИмяФормы, ТаблицаОшибок, ПолучитьТаблицуФорм());
		
	ЭтоЮЛ = РегламентированнаяОтчетностьПереопределяемый.ЭтоЮридическоеЛицо(Данные.Организация);
	Титульная = Данные.ДанныеУведомления.Титульная;
	
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаКодаНО(Титульная.КодНО, ТаблицаОшибок, "Титульная");
	Если Не ЗначениеЗаполнено(Титульная.НаимОрг) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указано наименование организации / ФИО физлица", "Титульная", "НаимОрг"));
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Титульная.ПРИЗНАК_НП_ПОДВАЛ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан признак подписанта на титульной странице", "Титульная", "ПРИЗНАК_НП_ПОДВАЛ"));
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Титульная.ДАТА_ПОДПИСИ) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указана дата подписи", "Титульная", "ДАТА_ПОДПИСИ"));
	КонецЕсли;
	
	УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаПодписантаНалоговойОтчетности(Данные, ТаблицаОшибок, "Титульная", ЭтоЮЛ Или Титульная.ПРИЗНАК_НП_ПОДВАЛ = "2");
	Если Титульная.ПРИЗНАК_НП_ПОДВАЛ = "2" И Не ЗначениеЗаполнено(Титульная.НаимДок) Тогда 
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не указан документ представителя", "Титульная", "НаимДок"));
	КонецЕсли;
	
	Если ЭтоЮЛ Тогда 
		УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаИННКПП(Истина, Титульная, ТаблицаОшибок);
	Иначе
		Если ЗначениеЗаполнено(Титульная.ИНН) Тогда
			УведомлениеОСпецрежимахНалогообложенияСлужебный.ПроверкаИННКПП(Ложь, Титульная, ТаблицаОшибок);
		Иначе 
			Если Не ЗначениеЗаполнено(Титульная.ДатаРожд) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнена дата рождения", "Титульная", "ДатаРожд"));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Титульная.МестоРожд) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнено место рождения", "Титульная", "МестоРожд"));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Титульная.КодВидДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнен вид документа", "Титульная", "КодВидДок"));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Титульная.СерНомДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнены серия и номер документа", "Титульная", "СерНомДок"));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Титульная.ДатаДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнена дата выдачи документа", "Титульная", "ДатаДок"));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Титульная.ВыдДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнен орган, выдавший документ", "Титульная", "ВыдДок"));
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	ЕстьЗаполненныеЛисты = Ложь;
	Для Каждого Стр Из Данные.ДанныеМногостраничныхРазделов.ЗаявПрекрИсчТНУгон Цикл
		Лист0 = Стр.Значение;
		Если УведомлениеОСпецрежимахНалогообложения.СтраницаЗаполнена(Лист0) Тогда 
			ЕстьЗаполненныеЛисты = Истина;
		Иначе
			Продолжить;
		КонецЕсли;
		
		Если УведомлениеОСпецрежимахНалогообложения.БлокЗаполнен(Лист0, "НаимДок,ВыдДок,ДатаДок,НомерДок") Тогда
			Если Не ЗначениеЗаполнено(Лист0.НаимДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнен документ", "ЗаявПрекрИсчТНУгон", "НаимДок", Лист0.УИД));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Лист0.ВыдДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнен орган, выдавший документ", "ЗаявПрекрИсчТНУгон", "ВыдДок", Лист0.УИД));
			КонецЕсли;
			Если Не ЗначениеЗаполнено(Лист0.ДатаДок) Тогда 
				ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
					"Не заполнена дата выдачи документа", "ЗаявПрекрИсчТНУгон", "ДатаДок", Лист0.УИД));
			КонецЕсли;
		КонецЕсли;
	
		Если Не ЗначениеЗаполнено(Лист0.ВидТС) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не заполнен вид транспортного средства", "ЗаявПрекрИсчТНУгон", "ВидТС", Лист0.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Лист0.РегЗнакТС) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не заполнен регистрационный номер транспортного средства", "ЗаявПрекрИсчТНУгон", "РегЗнакТС", Лист0.УИД));
		КонецЕсли;
		Если Не ЗначениеЗаполнено(Лист0.МесНачРоз) Тогда 
			ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
				"Не заполнена дата начала розыска транспортного средства", "ЗаявПрекрИсчТНУгон", "МесНачРоз", Лист0.УИД));
		КонецЕсли;
	КонецЦикла;
	
	Если Не ЕстьЗаполненныеЛисты Тогда
		ТаблицаОшибок.Добавить(Документы.УведомлениеОСпецрежимахНалогообложения.ПолучитьПустуюСтруктуруНавигацииПоОшибкам(
			"Не заполнены сведения о транспорте", "ЗаявПрекрИсчТНУгон", "ВидТС", Данные.ДанныеМногостраничныхРазделов.ЗаявПрекрИсчТНУгон[0].Значение.УИД));
	КонецЕсли;
	
	УведомлениеОСпецрежимахНалогообложения.ПроверкаДатВУведомлении(Данные, ТаблицаОшибок);
	УведомлениеОСпецрежимахНалогообложения.ПолнаяПроверкаЗаполненныхПоказателейНаСоотвествиеСписку(
		"СпискиВыбора2023_1", "СхемаВыгрузкиФорма2023_1",
		Данные.Объект.ИмяОтчета, ТаблицаОшибок, Данные);
	Возврат ТаблицаОшибок;
КонецФункции

Функция ОсновныеСведенияЭлектронногоПредставления_Форма2023_1(Объект, УникальныйИдентификатор)
	ОсновныеСведения = Документы.УведомлениеОСпецрежимахНалогообложения.НачальнаяИнициализацияОбщихРеквизитовВыгрузки(Объект);
	ИдентификаторФайла = ИдентификаторФайлаЭлектронногоПредставления_Форма2023_1(ОсновныеСведения);
	ОсновныеСведения.Вставить("ИдФайл", ИдентификаторФайла);
	Возврат ОсновныеСведения;
КонецФункции

Функция ЭлектронноеПредставление_Форма2023_1(Объект, УникальныйИдентификатор)
	СведенияЭлектронногоПредставления = УведомлениеОСпецрежимахНалогообложения.СведенияЭлектронногоПредставления();
	ДанныеУведомления = УведомлениеОСпецрежимахНалогообложения.ДанныеУведомленияДляВыгрузки(Объект);
	Ошибки = ПроверитьДокументСВыводомВТаблицу_Форма2023_1(ДанныеУведомления, УникальныйИдентификатор);
	УведомлениеОСпецрежимахНалогообложения.СообщитьОшибкиПриПроверкеВыгрузки(Объект, Ошибки, ДанныеУведомления);
	
	ОсновныеСведения = ОсновныеСведенияЭлектронногоПредставления_Форма2023_1(Объект, УникальныйИдентификатор);
	СтруктураВыгрузки = Документы.УведомлениеОСпецрежимахНалогообложения.ИзвлечьСтруктуруXMLУведомления(Объект.ИмяОтчета, "СхемаВыгрузкиФорма2023_1");
	УведомлениеОСпецрежимахНалогообложения.ТиповоеЗаполнениеДанными(ДанныеУведомления, ОсновныеСведения, СтруктураВыгрузки);
	УведомлениеОСпецрежимахНалогообложения.ВыгрузитьДеревоВТаблицу(СтруктураВыгрузки, ОсновныеСведения, СведенияЭлектронногоПредставления);
	Возврат СведенияЭлектронногоПредставления;
КонецФункции

Функция СформироватьСписокЛистовФорма2023_1(Объект) Экспорт
	Листы = Новый СписокЗначений;
	
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	СтруктураПараметров = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ДанныеУведомления").Получить();
	ИННКПП = УведомлениеОСпецрежимахНалогообложения.ТиповаяСтруктураИННКППДляПечати(Объект, СтруктураПараметров.ДанныеУведомления.Титульная);
	
	НомСтр = 0;
	УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета,
		СтруктураПараметров.ДанныеУведомления["Титульная"], НомСтр, "Печать_Форма2023_1_Титульная", ПечатнаяФорма, ИННКПП);
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр);
	
	НомСтр = 1;
	НапечататьЛистыСвед(Объект, Листы, СтруктураПараметров, НомСтр, ИННКПП, "Печать_Форма2023_1_ЗаявПрекрИсчТНУгон");
	Возврат Листы;
КонецФункции

Процедура НапечататьЛистыСвед(Объект, Листы, СтруктураПараметров, НомСтр, ИННКПП, ИмяМакетаПФ)
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	ТекИнд = 1;
	Для Каждого Элт0 Из СтруктураПараметров.ДанныеМногостраничныхРазделов["ЗаявПрекрИсчТНУгон"] Цикл
		Свед0 = Элт0.Значение;
		Если Не УведомлениеОСпецрежимахНалогообложения.СтраницаЗаполнена(Свед0) Тогда
			Продолжить;
		КонецЕсли;
		
		Свед0.Вставить("МесНачРозМес", Формат(Свед0.МесНачРоз, "ДФ=MMyyyy; ДП=' '"));
		Свед0.Вставить("МесПрекрРозМес", Формат(Свед0.МесПрекрРоз, "ДФ=MMyyyy; ДП=' '"));
		
		УведомлениеОСпецрежимахНалогообложения.НапечататьСтруктуру(Объект.ИмяОтчета,
			Свед0, НомСтр, ИмяМакетаПФ, ПечатнаяФорма, ИННКПП);
		УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр, Ложь);
	КонецЦикла;
КонецПроцедуры
#КонецОбласти
#КонецЕсли
