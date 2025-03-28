#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция ВерсияФорматаВыгрузки(Знач НаДату = Неопределено, ВыбраннаяФорма = Неопределено) Экспорт
	
	Возврат Перечисления.ВерсииФорматовВыгрузки.Версия500;
	
КонецФункции

Функция ТаблицаФормОтчета() Экспорт
	
	ОписаниеТиповСтрока = Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(254));
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Дата"));
	ОписаниеТиповДата = Новый ОписаниеТипов(МассивТипов, , Новый КвалификаторыДаты(ЧастиДаты.Дата));
	
	ТаблицаФормОтчета = Новый ТаблицаЗначений;
	ТаблицаФормОтчета.Колонки.Добавить("ФормаОтчета",        ОписаниеТиповСтрока);
	ТаблицаФормОтчета.Колонки.Добавить("ОписаниеОтчета",     ОписаниеТиповСтрока, "Утверждена",  20);
	ТаблицаФормОтчета.Колонки.Добавить("ДатаНачалоДействия", ОписаниеТиповДата,   "Действует с", 5);
	ТаблицаФормОтчета.Колонки.Добавить("ДатаКонецДействия",  ОписаниеТиповДата,   "         по", 5);
	ТаблицаФормОтчета.Колонки.Добавить("РедакцияФормы",      ОписаниеТиповСтрока, "Редакция формы", 20);
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "ФормаОтчета2019Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расшифровки бухгалтерской отчетности";
	НоваяФорма.РедакцияФормы      = "версия 1.01";
	НоваяФорма.ДатаНачалоДействия = '2000-01-01';
	НоваяФорма.ДатаКонецДействия  = РегламентированнаяОтчетностьКлиентСервер.ПустоеЗначениеТипа(Тип("Дата"));
	
	Возврат ТаблицаФормОтчета;
	
КонецФункции

Функция ДанныеРеглОтчета(ЭкземплярРеглОтчета) Экспорт
	
КонецФункции

Функция ДеревоФормИФорматов() Экспорт
	
	ФормыИФорматы = Новый ДеревоЗначений;
	ФормыИФорматы.Колонки.Добавить("Код");
	ФормыИФорматы.Колонки.Добавить("ДатаПриказа");
	ФормыИФорматы.Колонки.Добавить("НомерПриказа");
	ФормыИФорматы.Колонки.Добавить("ДатаНачалаДействия");
	ФормыИФорматы.Колонки.Добавить("ДатаОкончанияДействия");
	ФормыИФорматы.Колонки.Добавить("ИмяОбъекта");
	ФормыИФорматы.Колонки.Добавить("Описание");
	
	Форма20000101 = ОпределитьФормуВДеревеФормИФорматов(ФормыИФорматы, "710099", '2000-01-01', "", "ФормаОтчета2019Кв1");
	ОпределитьФорматВДеревеФормИФорматов(Форма20000101, "1.01");
	
	Возврат ФормыИФорматы;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОпределитьФормуВДеревеФормИФорматов(ДеревоФормИФорматов, Код, ДатаПриказа = '00010101', НомерПриказа = "", ИмяОбъекта = "",
			ДатаНачалаДействия = '00010101', ДатаОкончанияДействия = '00010101', Описание = "")
	
	НовСтр = ДеревоФормИФорматов.Строки.Добавить();
	НовСтр.Код = СокрЛП(Код);
	НовСтр.ДатаПриказа = ДатаПриказа;
	НовСтр.НомерПриказа = СокрЛП(НомерПриказа);
	НовСтр.ДатаНачалаДействия = ДатаНачалаДействия;
	НовСтр.ДатаОкончанияДействия = ДатаОкончанияДействия;
	НовСтр.ИмяОбъекта = СокрЛП(ИмяОбъекта);
	НовСтр.Описание = СокрЛП(Описание);
	
	Возврат НовСтр;
	
КонецФункции

Функция ОпределитьФорматВДеревеФормИФорматов(Форма, Версия, ДатаПриказа = '00010101', НомерПриказа = "",
			ДатаНачалаДействия = Неопределено, ДатаОкончанияДействия = Неопределено, ИмяОбъекта = "", Описание = "")
	
	НовСтр = Форма.Строки.Добавить();
	НовСтр.Код = СокрЛП(Версия);
	НовСтр.ДатаПриказа = ДатаПриказа;
	НовСтр.НомерПриказа = СокрЛП(НомерПриказа);
	НовСтр.ДатаНачалаДействия = ?(ДатаНачалаДействия = Неопределено, Форма.ДатаНачалаДействия, ДатаНачалаДействия);
	НовСтр.ДатаОкончанияДействия = ?(ДатаОкончанияДействия = Неопределено, Форма.ДатаОкончанияДействия, ДатаОкончанияДействия);
	НовСтр.ИмяОбъекта = СокрЛП(ИмяОбъекта);
	НовСтр.Описание = СокрЛП(Описание);
	
	Возврат НовСтр;
	
КонецФункции

#Область ПредставленияОтчетов

Процедура СформироватьСтраницуПеречняБанковскихОпераций(КонтекстФормирования) Экспорт
	
	РегламентированныйОтчет = КонтекстФормирования.РегламентированныйОтчет;
	ПолеДокументаОтчета = КонтекстФормирования.ПолеДокументаОтчета;
	ИмяМакетаОтчета = КонтекстФормирования.ИмяМакетаОтчета;
	НомерСекции = КонтекстФормирования.НомерСекции;
	ПрефиксИдентификатораДанных = КонтекстФормирования.ПрефиксИдентификатораДанных;
	
	МакетОтчета = Отчеты.РасшифровкиБухгалтерскойОтчетности.ПолучитьМакет(ИмяМакетаОтчета);
	
	ДокументОтчета = Новый ТабличныйДокумент;
	
	Секция_Шапка = МакетОтчета.ПолучитьОбласть("Шапка");
	ДокументОтчета.Вывести(Секция_Шапка);
	
	Если КонтекстФормирования.Вариант = "ДляПечати" Тогда
		Область_ПечатьЗаголовок = МакетОтчета.ПолучитьОбласть("ПечатьЗаголовок");
		Область_ПечатьЗаголовок.Параметры.Заголовок = КонтекстФормирования.Заголовок;
		ДокументОтчета.Вывести(Область_ПечатьЗаголовок);
	КонецЕсли;
	
	ВыборкаСегментов = ВыборкаСегментовОтчета(РегламентированныйОтчет, ПрефиксИдентификатораДанных);
	
	Если ВыборкаСегментов.Количество() > 1 Тогда
		НомерСтраницы = "Стр. " + СтрокаЧГ0(НомерСекции) + " из " + СтрокаЧГ0(ВыборкаСегментов.Количество());
		Если КонтекстФормирования.Вариант = "ДляПечати" Тогда
			Область_ПечатьЗаголовокНомерСтраницы = МакетОтчета.ПолучитьОбласть("ПечатьЗаголовокНомерСтраницы");
			Область_ПечатьЗаголовокНомерСтраницы.Параметры.НомерСтраницы = НомерСтраницы;
			ДокументОтчета.Вывести(Область_ПечатьЗаголовокНомерСтраницы);
			
		Иначе
			Область_Навигация = МакетОтчета.ПолучитьОбласть("Навигация");
			Область_Навигация.Параметры.НомерСтраницы = НомерСтраницы;
			ДокументОтчета.Вывести(Область_Навигация);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Секция_ШапкаТаблицы = МакетОтчета.ПолучитьОбласть("ШапкаТаблицы");
	ДокументОтчета.Вывести(Секция_ШапкаТаблицы);
	
	ВысотаШапки = ДокументОтчета.ВысотаТаблицы;
	
	ВидДополнительногоФайла = ПрефиксИдентификатораДанных + "." + СтрокаЧГ0(НомерСекции);
	СтрокиСекции = ДанныеРегистраДополнительныхФайлов(РегламентированныйОтчет, ВидДополнительногоФайла);
	
	Если СтрокиСекции <> Неопределено Тогда
		Для Каждого СтрокаСекции Из СтрокиСекции Цикл
			Область_СтрокаТаблицы = МакетОтчета.ПолучитьОбласть("СтрокаТаблицы");
			Область_СтрокаТаблицы.Параметры.Заполнить(СтрокаСекции);
			ДокументОтчета.Вывести(Область_СтрокаТаблицы);
		КонецЦикла;
	КонецЕсли;
	
	ПолеДокументаОтчета.Очистить();
	ПолеДокументаОтчета.Вывести(ДокументОтчета);
	ПолеДокументаОтчета.ФиксацияСверху = ВысотаШапки;
	
КонецПроцедуры

Функция НовыйКонтекстФормирования() Экспорт
	
	КонтекстФормирования = Новый Структура;
	КонтекстФормирования.Вставить("РегламентированныйОтчет");
	КонтекстФормирования.Вставить("ПрефиксИдентификатораДанных");
	КонтекстФормирования.Вставить("НомерСекции", 1);
	КонтекстФормирования.Вставить("ИмяМакетаОтчета");
	КонтекстФормирования.Вставить("ПолеДокументаОтчета");
	КонтекстФормирования.Вставить("Вариант", "ДляЭкрана"); // Для формирования печатной формы используется "ДляПечати"
	КонтекстФормирования.Вставить("Заголовок", "");
	
	Возврат КонтекстФормирования;
	
КонецФункции

Функция ВыборкаСегментовОтчета(РегламентированныйОтчет, ПрефиксИдентификатораДанных) Экспорт
	
	ШаблонОтбора = ПрефиксИдентификатораДанных + ".%";
	
	Возврат ВыборкаСегментовОтчетаПоШаблону(РегламентированныйОтчет, ШаблонОтбора);
	
КонецФункции

Функция ТекущееИмяРаздела(ИмяРаздела) Экспорт
	
	Если ИмяРаздела = "ОперацииПоБанковскимСчетам" Тогда
		Возврат "КарточкаСчета";
	Иначе
		Возврат ИмяРаздела;
	КонецЕсли;
	
КонецФункции

Функция ВыборкаСегментовОтчетаПоШаблону(РегламентированныйОтчет, ШаблонОтбора)
	
	ЗапросПоДанным = Новый Запрос;
	ЗапросПоДанным.Текст = "ВЫБРАТЬ
	                       |	ДополнительныеФайлыРегламентированныхОтчетов.ВидДополнительногоФайла КАК ВидДополнительногоФайла
	                       |ИЗ
	                       |	РегистрСведений.ДополнительныеФайлыРегламентированныхОтчетов КАК ДополнительныеФайлыРегламентированныхОтчетов
	                       |ГДЕ
	                       |	ДополнительныеФайлыРегламентированныхОтчетов.РегламентированныйОтчет = &РегламентированныйОтчет
	                       |	И ДополнительныеФайлыРегламентированныхОтчетов.ВидДополнительногоФайла ПОДОБНО &ШаблонОтбора
	                       |
	                       |УПОРЯДОЧИТЬ ПО
	                       |	ВидДополнительногоФайла";
	
	ЗапросПоДанным.УстановитьПараметр("ШаблонОтбора", ШаблонОтбора);
	ЗапросПоДанным.УстановитьПараметр("РегламентированныйОтчет", РегламентированныйОтчет);
	
	ВыборкаСегментов = ЗапросПоДанным.Выполнить().Выбрать();
	
	Возврат ВыборкаСегментов;
	
КонецФункции

Функция ДанныеРегистраДополнительныхФайлов(РегламентированныйОтчет, ВидДополнительногоФайла)
	
	ЗаписьРегистраСведений = РегистрыСведений.ДополнительныеФайлыРегламентированныхОтчетов.СоздатьМенеджерЗаписи();
	
	ЗаписьРегистраСведений.РегламентированныйОтчет = РегламентированныйОтчет;
	ЗаписьРегистраСведений.ВидДополнительногоФайла = ВидДополнительногоФайла;
	
	ЗаписьРегистраСведений.Прочитать();
	
	Если ЗаписьРегистраСведений.Выбран() Тогда
		Данные = ЗаписьРегистраСведений.СодержимоеФайла.Получить();
	Иначе
		Данные = Неопределено;
	КонецЕсли;
	
	Возврат Данные;
	
КонецФункции

Функция СтрокаЧГ0(ФорматируемоеЧисло)
	
	Возврат Формат(ФорматируемоеЧисло, "ЧН=; ЧГ=0");
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли
