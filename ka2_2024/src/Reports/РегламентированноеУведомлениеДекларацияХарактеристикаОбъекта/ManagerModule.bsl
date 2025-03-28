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
	Стр.ИмяФормы = "Форма2015_1";
	Стр.ОписаниеФормы = "Утверждено Постановлением Правительства РФ от 26.11.2015 № 1268";
	
	Возврат Результат;
КонецФункции

Функция ЭлектронноеПредставление(Объект, ИмяФормы, УникальныйИдентификатор) Экспорт
	РегламентированнаяОтчетность.СообщитьПользователюОбОшибкеВУведомлении("Для данной декларации выгрузка не предусмотрена", УникальныйИдентификатор);
	ВызватьИсключение "";
КонецФункции

Функция СформироватьСписокЛистов(Объект) Экспорт
	Если Объект.ИмяФормы = "Форма2015_1" Тогда 
		Возврат СформироватьСписокЛистовФорма2015_1(Объект);
	КонецЕсли;
КонецФункции

Функция СформироватьСписокЛистовФорма2015_1(Объект) Экспорт
	Листы = Новый СписокЗначений;
	ПечатнаяФорма = УведомлениеОСпецрежимахНалогообложения.НовыйПустойЛист();
	СтруктураПараметров = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ДанныеУведомления").Получить();
	ДанныеФормы = СтруктураПараметров.ДанныеУведомления.Форма2015_1;
	
	МакетПФ = Отчеты[Объект.ИмяОтчета].ПолучитьМакет("Печать_MXL_Форма2015_1");
	НомСтр = 1;
	Для Инд = 1 По 32 Цикл
		ОблЧасть = МакетПФ.ПолучитьОбласть("Часть" + Инд);
		Для Каждого Область Из ОблЧасть.Области Цикл 
			Если Область.ТипОбласти = ТипОбластиЯчеекТабличногоДокумента.Прямоугольник И Область.СодержитЗначение Тогда 
				ДанныеФормы.Свойство(Область.Имя, Область.Значение);
			КонецЕсли;
		КонецЦикла;
		
		Если ПечатнаяФорма.ПроверитьВывод(ОблЧасть) Тогда 
			ПечатнаяФорма.Вывести(ОблЧасть);
		Иначе
			УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр, Ложь);
			ПечатнаяФорма.Вывести(ОблЧасть);
		КонецЕсли;
	КонецЦикла;
	УведомлениеОСпецрежимахНалогообложения.ПоложитьПФВСписокЛистов(Объект, Листы, ПечатнаяФорма, НомСтр, Ложь);
	
	Возврат Листы;
КонецФункции

#КонецОбласти
#КонецЕсли