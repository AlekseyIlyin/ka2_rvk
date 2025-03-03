#Область ПрограммныйИнтерфейс

// Возвращает текущую настройку использования передачи на портале Работа в России.
//
// Возвращаемое значение:
//  Булево - если Истина, передача доступна.
//
Функция ДоступнаПередачаДокументовНаРаботаВРоссии() Экспорт
	
	// Не всем потребителям требуются базовые роли БЗК.
	Если ПравоДоступа("Чтение", Метаданные.Константы.ИспользоватьИнтеграциюСРаботаВРоссии) Тогда
		Возврат Константы.ИспользоватьИнтеграциюСРаботаВРоссии.Получить();
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

// Производит передачу на портал присоединенного файла
//
// Параметры:
//   ПрисоединенныйФайл - Справочник, ссылка на присоединенный файл.
//
Процедура ПередатьНаПортал(ПрисоединенныйФайл) Экспорт
	
	ИдентификаторДокумента = РегистрыСведений.ИдентификаторыДокументовНаРаботаВРоссии.ИдентификаторДокумента(ПрисоединенныйФайл);
	Если ИдентификаторДокумента <> Неопределено Тогда
		
		УстановленныеПодписи = ЭлектроннаяПодпись.УстановленныеПодписи(ПрисоединенныйФайл);
		ПередатьПодписи(ИдентификаторДокумента, Строка(ПрисоединенныйФайл), УстановленныеПодписи);
		
		УдалитьФайлИзОбработки(ПрисоединенныйФайл);
		Возврат;
		
	КонецЕсли;
	
	ДополнительныеПараметры = РаботаСФайламиКлиентСервер.ПараметрыДанныхФайла();
	ДополнительныеПараметры.ИдентификаторФормы = Новый УникальныйИдентификатор;
	
	ДанныеФайла = РаботаСФайлами.ДанныеФайла(ПрисоединенныйФайл, ДополнительныеПараметры);
	Если ВРег(ДанныеФайла.Расширение) <> "PDF" Тогда
		УдалитьФайлИзОбработки(ПрисоединенныйФайл);
		ВызватьИсключение НСтр("ru = 'Допускается передача только документов в формате Adobe Acrobat (с расширением - .pdf).'");
	КонецЕсли;
	
	Если ДанныеФайла.Размер > МаксимальныйРазмерДокумента() Тогда
		УдалитьФайлИзОбработки(ПрисоединенныйФайл);
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Не допускается передача документов размером более %Мб.'"),
			Формат(МаксимальныйРазмерДокумента() / 1024 / 1024, "ЧДЦ=1; ЧГ="));
	КонецЕсли;
	
	Если ПередатьПрисоединенныйФайл(ДанныеФайла) Тогда
		УдалитьФайлИзОбработки(ПрисоединенныйФайл);
	КонецЕсли;
	
КонецПроцедуры

// Возвращает настройки авторизации на портале, сохраненные в безопасном хранилище
//
// Возвращаемое значение:
//  Структура - с ключами:
//   * Пароль        - Строка
//   * Логин         - Строка
//   * Идентификатор - Строка
//
Функция НастройкиАвторизации() Экспорт
	
	КлючиНастроек = "Пароль,Логин,Идентификатор";
	
	Настройки = Новый Структура(КлючиНастроек);
	
	Владелец = ОбщегоНазначения.ИдентификаторОбъектаМетаданных("Константа.ИспользоватьИнтеграциюСРаботаВРоссии");
	СохраненныеНастройки = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Владелец, КлючиНастроек);
	
	ЗаполнитьЗначенияСвойств(Настройки, СохраненныеНастройки);
	
	Возврат Настройки;
	
КонецФункции

// Сохраняет настройки авторизации на портале в безопасном хранилище.
//
// Параметры:
//  Пароль        - Строка
//  Логин         - Строка
//  Идентификатор - Строка
//
Процедура ЗапомнитьНастройкиАвторизации(Логин, Пароль, Идентификатор) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Владелец = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Метаданные.Константы.ИспользоватьИнтеграциюСРаботаВРоссии.ПолноеИмя());
	ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Владелец, Логин, "Логин");
	ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Владелец, Пароль, "Пароль");
	ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(Владелец, Идентификатор, "Идентификатор");
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

// Выполняет в фоновом режиме передачу готовых для этого печатных форм.
//
Процедура ВыполнитьПередачуПечатныхФорм() Экспорт
	
	Если Не ДоступнаПередачаДокументовНаРаботаВРоссии() Тогда
		Возврат;
	КонецЕсли;
	
	Если Не НастройкиАвторизацииЗаданы() Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	ЗаданияКИсполнению = РегистрыСведений.ЗапланированныеДействияСФайламиДокументовКЭДО.ФайлыКОбработке(
		Ложь, Перечисления.ДействияСФайламиДокументовКЭДО.ПередатьНаРаботаВРоссии);
	
	СписокЗаданий = ЗаданияКИсполнению.Получить(Перечисления.ДействияСФайламиДокументовКЭДО.ПередатьНаРаботаВРоссии);
	Если СписокЗаданий <> Неопределено Тогда
		
		Для Каждого ЭлементСписка Из СписокЗаданий Цикл
			ПередатьНаПортал(ЭлементСписка.Значение);
		КонецЦикла;
		
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция КомандаПодписатьФормыПечатьДокументов(Форма) Экспорт
	Возврат Форма.Команды.Найти(ИмяКомандыПодписатьФормыПечатьДокументов());
КонецФункции

// См. УправлениеПечатьюПереопределяемый.ПечатьДокументовПриСозданииНаСервере.
Процедура ПечатьДокументовПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	Если ДоступнаПередачаДокументовНаРаботаВРоссии() Тогда
		
		Если Не Форма.Параметры.Свойство("ПодписаниеПечатныхФорм") Тогда
			
			КомандаФормы = КомандаПодписатьФормыПечатьДокументов(Форма);
			Если КомандаФормы = Неопределено Тогда
				
				СвойстваКоманды = СвойстваКомандыПередачиНаПорталРаботаВРоссии();
				
				КомандаФормы = Форма.Команды.Добавить(ИмяКомандыПодписатьФормыПечатьДокументов());
				КомандаФормы.Действие = "Подключаемый_ВыполнитьКоманду";
				КомандаФормы.Заголовок = СвойстваКоманды.Заголовок;
				КомандаФормы.Подсказка = СвойстваКоманды.Подсказка;
				КомандаФормы.Отображение = ОтображениеКнопки.КартинкаИТекст;
				КомандаФормы.Картинка = СвойстваКоманды.Картинка;
				
				КнопкаФормы = КадровыйЭДО.РазместитьКомандуНаФормеПечатьДокументов(Форма, КомандаФормы);
				Если КнопкаФормы <> Неопределено Тогда
					КнопкаФормы.Вид = ВидКнопкиФормы.КнопкаКоманднойПанели;
					КнопкаФормы.ИмяКоманды = КомандаФормы.Имя;
					КнопкаФормы.ТолькоВоВсехДействиях = Ложь;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаСФайламиПереопределяемый.ПриСозданииФормыСпискаФайлов
//
Процедура ПриСозданииФормыСпискаФайлов(Форма) Экспорт
	
	Если ЗарплатаКадры.ЭтоОбъектЗарплатноКадровойБиблиотеки("Справочник." + Форма.ИмяСправочникаХранилищаФайлов) Тогда
		
		Если ДоступнаПередачаДокументовНаРаботаВРоссии() Тогда
			
			КнопкаПередатьНаРаботаВРоссии = Форма.Элементы.Найти("ПередатьНаРаботаВРоссии");
			Если КнопкаПередатьНаРаботаВРоссии <> Неопределено Тогда
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередатьНаПорталДокументыПоОписаниямПечатныхФорм(ОписанияПечатныхФорм) Экспорт
	
	Для Каждого ОписаниеПечатнойФормы Из ОписанияПечатныхФорм Цикл
		
		ПередатьДокумент(ОписаниеПечатнойФормы.Название, ОписаниеПечатнойФормы.ИмяФайла,
			ПолучитьИзВременногоХранилища(ОписаниеПечатнойФормы.АдресВХранилище),
			ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ОписаниеПечатнойФормы.СвойстваПодписи), , Истина);
		
	КонецЦикла;
	
КонецПроцедуры

Функция СвойстваКомандыПередачиНаПорталРаботаВРоссии() Экспорт
	Возврат Новый Структура("Заголовок,Подсказка,Картинка",
		НСтр("ru = 'Передать на ""Работа в России""'"),
		НСтр("ru = 'Подписать и передать на портал ""Работа в России""'"),
		БиблиотекаКартинок.ПередатьНаРаботаВРоссии);
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПередатьПрисоединенныйФайл(ДанныеФайла)
	
	УстановленныеПодписи = ЭлектроннаяПодпись.УстановленныеПодписи(ДанныеФайла.Ссылка);
	
	Возврат ПередатьДокумент(ДанныеФайла.Наименование, ДанныеФайла.ИмяФайла,
		ПолучитьИзВременногоХранилища(ДанныеФайла.СсылкаНаДвоичныеДанныеФайла),
		УстановленныеПодписи, ДанныеФайла.Ссылка)
	
КонецФункции

Функция ПередатьДокумент(Наименование, ИмяФайла, ДвоичныеДанныеФайла, УстановленныеПодписи, ПрисоединенныйФайл = Неопределено, ВызыватьИсключение = Ложь)
	
	Результат = Истина;
	
	Если ЗначениеЗаполнено(ПрисоединенныйФайл) Тогда
		ДанныеПечатнойФормы = РегистрыСведений.ПодписанныеПечатныеФормы.ДанныеФайлаПечатнойФормы(ПрисоединенныйФайл);
	Иначе
		ДанныеПечатнойФормы = Неопределено;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	Настройки = НастройкиАвторизации();
	УстановитьПривилегированныйРежим(Ложь);
	
	Если Не НастройкиАвторизацииЗаданы(Настройки, ВызыватьИсключение) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ЗаписьДанных = Новый ЗаписьJSON;
	ЗаписьДанных.УстановитьСтроку();
	
	ЗаписьДанных.ЗаписатьНачалоОбъекта();
	
	ЗаписьДанных.ЗаписатьИмяСвойства("userId");
	ЗаписьДанных.ЗаписатьЗначение(Настройки.Идентификатор);
	
	ЗаписьДанных.ЗаписатьИмяСвойства("name");
	ЗаписьДанных.ЗаписатьЗначение(Наименование);
	
	ЗаписьДанных.ЗаписатьИмяСвойства("fileName");
	ЗаписьДанных.ЗаписатьЗначение(ИмяФайла);
	
	ЗаписьДанных.ЗаписатьИмяСвойства("file");
	ЗаписьДанных.ЗаписатьЗначение(ДанныеВBase64(ДвоичныеДанныеФайла));
	
	Если ДанныеПечатнойФормы <> Неопределено Тогда
		
		Если ЗначениеЗаполнено(ДанныеПечатнойФормы.Дата) Тогда
			ЗаписьДанных.ЗаписатьИмяСвойства("docEffectiveDate");
			ЗаписьДанных.ЗаписатьЗначение(УниверсальноеВремя(ДанныеПечатнойФормы.Дата) - '19700101');
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ДанныеПечатнойФормы.Номер) Тогда
			ЗаписьДанных.ЗаписатьИмяСвойства("docNumber");
			ЗаписьДанных.ЗаписатьЗначение(ДанныеПечатнойФормы.Номер);
		КонецЕсли;
	КонецЕсли;
	
	ЗаписьДанных.ЗаписатьИмяСвойства("comment");
	ЗаписьДанных.ЗаписатьЗначение("");
	
	ЗаписьДанных.ЗаписатьИмяСвойства("groupId");
	ЗаписьДанных.ЗаписатьЗначение("");
	
	ЗаписьДанных.ЗаписатьИмяСвойства("docKindId");
	ЗаписьДанных.ЗаписатьЗначение("");
	
	ЗаписьДанных.ЗаписатьКонецОбъекта();
	
	Попытка
		
		ОтветСервиса = СоединениеСПорталом().ОтправитьДляОбработки(
			ЗапросHttp(Настройки, "/docs", ЗаписьДанных.Закрыть()));
		
		Если ОтветСервиса.КодСостояния = 200 Тогда
			
			ТелоОтвета = ОтветСервиса.ПолучитьТелоКакСтроку();
			
			ЗаписьДанных = Новый ЧтениеJSON;
			ЗаписьДанных.УстановитьСтроку(ТелоОтвета);
			КлючиРезультата = ПрочитатьJSON(ЗаписьДанных);
			
			ИдентификаторДокумента = Неопределено;
			Если Не КлючиРезультата.Свойство("documentId", ИдентификаторДокумента)
				Или Не ЗначениеЗаполнено(ИдентификаторДокумента) Тогда
				
				ВызватьИсключение
					НСтр("ru = 'Ошибка передачи документа на портал ""Работа в России"": В ответе портала отсутствует идентификатор документа.'");
				
			КонецЕсли;
			
			Если ЗначениеЗаполнено(ПрисоединенныйФайл) Тогда
				РегистрыСведений.ИдентификаторыДокументовНаРаботаВРоссии.ЗапомнитьИдентификатор(ПрисоединенныйФайл, ИдентификаторДокумента);
			КонецЕсли;
			
			Если ЗначениеЗаполнено(УстановленныеПодписи) Тогда
				Попытка
					ПередатьПодписи(ИдентификаторДокумента, ИмяФайла, УстановленныеПодписи, Настройки);
				Исключение
					Результат = Ложь;
				КонецПопытки;
			Иначе
				Результат = Ложь;
			КонецЕсли;
			
		Иначе
			ВызватьИсключение СтрШаблон(
				НСтр("ru = 'Ошибка передачи документа на портал ""Работа в России"" (Код: %1)'"),
				ОтветСервиса.КодСостояния);
		КонецЕсли;
		
	Исключение
		
		Ошибка = ИнформацияОбОшибке();
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Ошибка передачи документа на портал ""Работа в России"": %1'"),
			ПодробноеПредставлениеОшибки(Ошибка));
		
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

Процедура УдалитьФайлИзОбработки(ПрисоединенныйФайл)
	
	РегистрыСведений.ЗапланированныеДействияСФайламиДокументовКЭДО.УдалитьФайлыИзОбработки(
		ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ПрисоединенныйФайл),
		Перечисления.ДействияСФайламиДокументовКЭДО.ПередатьНаРаботаВРоссии);
	
КонецПроцедуры

Процедура ПередатьПодписи(ИдентификаторДокумента, ИмяФайла, УстановленныеПодписи, Настройки = Неопределено)
	
	Попытка
		
		Если Настройки = Неопределено Тогда
			УстановитьПривилегированныйРежим(Истина);
			Настройки = НастройкиАвторизации();
			УстановитьПривилегированныйРежим(Ложь);
		КонецЕсли;
		
		Если Не НастройкиАвторизацииЗаданы(Настройки) Тогда
			Возврат;
		КонецЕсли;
		
		Для Каждого ОписаниеПодписи Из УстановленныеПодписи Цикл
			
			ЗаписьДанных = Новый ЗаписьJSON;
			ЗаписьДанных.УстановитьСтроку();
			
			ЗаписьДанных.ЗаписатьНачалоОбъекта();
			
			ЗаписьДанных.ЗаписатьИмяСвойства("userId");
			ЗаписьДанных.ЗаписатьЗначение(Настройки.Идентификатор);
			
			ЗаписьДанных.ЗаписатьИмяСвойства("signatureFormat");
			ЗаписьДанных.ЗаписатьЗначение("CADESBES");
			
			ЗаписьДанных.ЗаписатьИмяСвойства("signature");
			ЗаписьДанных.ЗаписатьЗначение(ДанныеВBase64(ОписаниеПодписи.Подпись));
			
			Если ЗначениеЗаполнено(ОписаниеПодписи.ИмяФайлаПодписи) Тогда
				ИмяФайлаПодписи = ОписаниеПодписи.ИмяФайлаПодписи;
			Иначе
				ИмяФайлаПодписи = ЭлектроннаяПодписьСлужебныйКлиентСервер.ИмяФайлаПодписи(ИмяФайла,
					"", ЭлектроннаяПодпись.ПерсональныеНастройки().РасширениеДляФайловПодписи, Ложь);
			КонецЕсли;
			
			ЗаписьДанных.ЗаписатьИмяСвойства("signatureFileName");
			ЗаписьДанных.ЗаписатьЗначение(ИмяФайлаПодписи);
			
			ЗаписьДанных.ЗаписатьИмяСвойства("noVerify");
			ЗаписьДанных.ЗаписатьЗначение(Ложь);
			
			ЗаписьДанных.ЗаписатьКонецОбъекта();
			
			ОтветСервиса = СоединениеСПорталом().ОтправитьДляОбработки(
				ЗапросHttp(
					Настройки,
					СтрШаблон("/docs/%1/storeSign", ИдентификаторДокумента),
					ЗаписьДанных.Закрыть()));
			
			Если ОтветСервиса.КодСостояния <> 200 Тогда
				ВызватьИсключение СтрШаблон(
					НСтр("ru = 'Ошибка передачи ЭЦП документа на портал ""Работа в России"" (Код: %1)'"),
					ОтветСервиса.КодСостояния);
			КонецЕсли;
			
		КонецЦикла;
		
	Исключение
		
		Ошибка = ИнформацияОбОшибке();
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Ошибка передачи ЭЦП документа на портал ""Работа в России"": %1'"),
			ПодробноеПредставлениеОшибки(Ошибка));
		
	КонецПопытки;
	
КонецПроцедуры

Функция СоединениеСПорталом()
	
	ИнтернетПрокси = Неопределено;
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолучениеФайловИзИнтернета") Тогда
		МодульПолучениеФайловИзИнтернета = ОбщегоНазначения.ОбщийМодуль("ПолучениеФайловИзИнтернета");
		ИнтернетПрокси = МодульПолучениеФайловИзИнтернета.ПолучитьПрокси("https");
	КонецЕсли;
	
	ЗащищенноеСоединение = ОбщегоНазначенияКлиентСервер.НовоеЗащищенноеСоединение();
	Возврат Новый HTTPСоединение("ekd-api-integration.trudvsem.ru", , , , ИнтернетПрокси, 120, ЗащищенноеСоединение);
	
КонецФункции

Функция ЗапросHttp(Настройки, ПутьКМетоду, ТелоЗапроса)
	
	Запрос = Новый HTTPЗапрос(ПутьКМетоду, ЗаголовкиЗапроса(Настройки));
	Запрос.УстановитьТелоИзСтроки(ТелоЗапроса, КодировкаТекста.UTF8);
	
	Возврат Запрос;
	
КонецФункции

Функция ЗаголовкиЗапроса(Настройки)
	
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Accept", "application/json, */*; q=0.01");
	Заголовки.Вставить("Content-Type", "application/json; charset=utf-8");
	Заголовки.Вставить("Authorization", СтрШаблон("Basic %1", Токен(Настройки)));
	
	Возврат Заголовки;
	
КонецФункции

Функция Токен(Настройки)
	
	Возврат ДанныеВBase64(СтрШаблон(
		"%1:%2",
		СокрЛП(Настройки.Логин),
		СокрЛП(Настройки.Пароль)));
	
КонецФункции

Функция ДанныеВBase64(Данные, УдалятьПереводыСтрок = Истина)
	
	Если ТипЗнч(Данные) = Тип("Строка") Тогда
		КодируемыеДанные = ПолучитьДвоичныеДанныеИзСтроки(Данные);
	Иначе
		КодируемыеДанные = Данные;
	КонецЕсли;
	
	СтрокаBase64 = Base64Строка(КодируемыеДанные);
	
	Если УдалятьПереводыСтрок Тогда
		СтрокаBase64 = СтрЗаменить(СтрокаBase64, Символы.ПС, "");
		СтрокаBase64 = СтрЗаменить(СтрокаBase64, Символы.ВК, "");
	КонецЕсли;
	
	Возврат СтрокаBase64;
	
КонецФункции

Функция МаксимальныйРазмерДокумента()
	Возврат 15 * 1024 * 1024;
КонецФункции

Функция НастройкиАвторизацииЗаданы(Настройки = Неопределено, ВызыватьИсключение = Ложь)
	
	Если Настройки = Неопределено Тогда
		Настройки = НастройкиАвторизации();
	КонецЕсли;
	
	НастройкиЗаданы = ЗначениеЗаполнено(Настройки.Пароль)
		И ЗначениеЗаполнено(Настройки.Логин)
		И ЗначениеЗаполнено(Настройки.Идентификатор);
	
	Если Не НастройкиЗаданы Тогда
		
		ТекстЗаписи = НСтр("ru = 'Интеграция с Работа в России.Не заданы параметры авторизации'", ОбщегоНазначения.КодОсновногоЯзыка());
		ЗаписьЖурналаРегистрации(ТекстЗаписи, УровеньЖурналаРегистрации.Предупреждение);
		
		Если ВызыватьИсключение Тогда
			ВызватьИсключение ТекстЗаписи;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат НастройкиЗаданы;
	
КонецФункции

Функция ИмяКомандыПодписатьФормыПечатьДокументов()
	Возврат "ПередатьПодписанныеPDFНаРаботаВРоссии";
КонецФункции

#КонецОбласти