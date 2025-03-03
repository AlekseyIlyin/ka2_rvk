#Область ПрограммныйИнтерфейс

Функция ПараметрыРежимаОбмена() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Режим", РежимОбмен());
	Результат.Вставить("ЭтоОбменИзФормыПредмета", Ложь);
	Результат.Вставить("ЭтоОбменИзФормыСпискаПредметов", Ложь);
	Результат.Вставить("ЭтоОбменИзЭтаповОтправки", Ложь);
	
	Возврат Результат;
	
КонецФункции

Функция ПараметрыРежимаОтправки() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Режим", РежимОтправка());
	Результат.Вставить("ЭтоОтправкаИзФормыСпискаПредметов", Ложь);
	Результат.Вставить("ЭтоОтправкаИзФормыПредмета", Ложь);
	// Сюда можно передавать массив структур, полученных методом НовыеПараметрыДобавленияЭтапаОбмена()
	Результат.Вставить("ЭтапыОбмена", Неопределено);
	
	Возврат Результат;
	
КонецФункции

Функция ПараметрыРежимаУниверсальногоОжидания() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Режим", РежимУниверсальноеОжидание());
	Результат.Вставить("Заголовок", НСтр("ru='Ожидайте'"));
	Результат.Вставить("Надпись", НСтр("ru='Ожидайте...'"));
	
	Возврат Результат;
	
КонецФункции

Функция ПараметрыРежимаРасшифровки() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Режим", РежимРасшифровка());
	Результат.Вставить("Авторасшифровка", Ложь);
	
	Возврат Результат;
	
КонецФункции

Функция РежимОбмен() Экспорт
	
	Возврат "Обмен";
	
КонецФункции

Функция РежимУниверсальноеОжидание() Экспорт
	
	Возврат "УниверсальноеОжидание";
	
КонецФункции

Функция РежимОтправка() Экспорт
	
	Возврат "Отправка";
	
КонецФункции

Функция РежимРасшифровка() Экспорт
	
	Возврат "Расшифровка";
	
КонецФункции

Функция ДобавитьОшибку(Знач Ошибки, Знач НоваяОшибка) Экспорт
	
	// Не добавляем дублирующуюся ошибку.
	Если ТакаяОшибкаУжеЕсть(Ошибки, НоваяОшибка) Тогда
		Возврат Ошибки;
	Иначе
		// Ошибки - это фиксированный массив,
		// его можно менять только преобразовав в обычный массив.
		ОшибкиПослеДобавления = Новый Массив(Ошибки);
		ОшибкиПослеДобавления.Добавить(НоваяОшибка);
		
		Возврат Новый ФиксированныйМассив(ОшибкиПослеДобавления);
	
	КонецЕсли;
	
КонецФункции

Функция ТакаяОшибкаУжеЕсть(Знач Ошибки, Знач НоваяОшибка) Экспорт
	
	Для каждого Ошибка Из Ошибки Цикл
		Если Ошибка["ОписаниеОшибки"] = НоваяОшибка["ОписаниеОшибки"]
			И Ошибка["Организация"] = НоваяОшибка["Организация"] Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

// Запоминаем параметры бублика в ПараметрыПриложения
// Список ключей - в процедуре ЗначенияПараметровПоУмолчанию.
Процедура ИзменитьПараметрыДлительнойОтправки(КлючПараметра, НовоеЗначение) Экспорт
		
	ТекущееЗначениеПараметров = ЗначенияПараметровДлительнойОперации();
	ТекущееЗначениеПараметров = Новый Соответствие(ТекущееЗначениеПараметров);
	
	Если КлючПараметра = "Ошибки" Тогда
		ТекущееЗначениеПараметров["Ошибки"] = ДобавитьОшибку(ТекущееЗначениеПараметров["Ошибки"], НовоеЗначение);
	Иначе
		ТекущееЗначениеПараметров[КлючПараметра] = НовоеЗначение;
	КонецЕсли; 
	
	НовоеЗначениеПараметров = Новый ФиксированноеСоответствие(ТекущееЗначениеПараметров);
	
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		УстановитьПривилегированныйРежим(Истина);
		ПараметрыСеанса[КлючПараметровДлительнойОтправкиСервер()] = НовоеЗначениеПараметров;
		УстановитьПривилегированныйРежим(Ложь);
	#Иначе
		ПараметрыПриложения[КлючПараметровДлительнойОтправкиКлиент()] = НовоеЗначениеПараметров;
	#КонецЕсли
	
КонецПроцедуры

Функция ЗначенияПараметровДлительнойОперацииПоУмолчанию() Экспорт
	
	СостояниеДлительнойОперации = Новый Соответствие;
	// Идентификатор формы, в которую будут выводиться сообщения, чтобы они 
	// не наезжали на бублик и не загораживали его.
	СостояниеДлительнойОперации.Вставить("ИдентификаторФормыПолучателя",
		Новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000000"));
	СостояниеДлительнойОперации.Вставить("Ошибки", 				Новый ФиксированныйМассив(Новый Массив));
	СостояниеДлительнойОперации.Вставить("Организация", 		Неопределено);
	СостояниеДлительнойОперации.Вставить("Банк", 				Неопределено);
	СостояниеДлительнойОперации.Вставить("Сервис", 				Неопределено);
	
	Возврат СостояниеДлительнойОперации;
	
КонецФункции

Функция КлючПараметровДлительнойОтправкиСервер() Экспорт
	
	Возврат "СостояниеДлительнойОперацииОбменаСБанками";
	
КонецФункции

Функция КлючПараметровДлительнойОтправкиКлиент() Экспорт
	
	Возврат "БанкКоннект." + КлючПараметровДлительнойОтправкиСервер();
	
КонецФункции

Функция ЗначенияПараметровДлительнойОперации() Экспорт
	
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		ПараметрыДлительнойОтправки = ПараметрыСеанса[КлючПараметровДлительнойОтправкиСервер()];
		УстановитьПривилегированныйРежим(Ложь);
		// Здесь никогда не может оказаться пустого параметра сеанса, потому что 
		// он обязательно инициализируется при запуске программы процедурами БСП. 
		
	#Иначе
		
		ИмяПараметровКлиент = КлючПараметровДлительнойОтправкиКлиент();
		ПараметрыДлительнойОтправки = ПараметрыПриложения[ИмяПараметровКлиент];
		
		Если ПараметрыДлительнойОтправки = Неопределено Тогда
			ЗначенияПоУмолчанию = ЗначенияПараметровДлительнойОперацииПоУмолчанию();
			ПараметрыПриложения.Вставить(ИмяПараметровКлиент, Новый ФиксированноеСоответствие(ЗначенияПоУмолчанию));
			ПараметрыДлительнойОтправки = ПараметрыПриложения[ИмяПараметровКлиент];
		КонецЕсли;
		
	#КонецЕсли
	
	Возврат ПараметрыДлительнойОтправки;
	
КонецФункции

Функция ЗначениеПараметраДлительнойОперации(КлючПараметра) Экспорт
	
	ТекущееЗначениеПараметров = ЗначенияПараметровДлительнойОперации();
	ЗначениеПараметра = ТекущееЗначениеПараметров.Получить(КлючПараметра);
	
	Возврат ЗначениеПараметра;
	
КонецФункции

Функция НовыеПараметрыСохранения(ЭтоАвтозапрос) Экспорт

	Результат = Новый Структура();
	Результат.Вставить("Ошибки",								Новый ФиксированныйМассив(Новый Массив));
	Результат.Вставить("Предмет",								Неопределено);
	Результат.Вставить("ЕстьОшибки",							Ложь);
	Результат.Вставить("ПараметрыРежима",						Неопределено);
	Результат.Вставить("ЭтоАвтозапрос",							ЭтоАвтозапрос);
	Результат.Вставить("Банк",									"");
	Результат.Вставить("НаименованиеБанка",						"");
	Результат.Вставить("Заголовок", 							"");
	Результат.Вставить("ЗакрытьБезДальнейшихДействий", 			Ложь);
	Результат.Вставить("ТекстРезультатаОбменаПоОрганизации", 	"");
	Результат.Вставить("КартинкаРезультатаОбменаПоОрганизации", Неопределено);
	Результат.Вставить("ЭтоОбменИзОтчета",						Ложь);
	Результат.Вставить("ЭтоОбменИзЭтаповОтправки",				Ложь);
	
	Если ЭтоАвтозапрос Тогда
		
		Результат.Вставить("Документооборот",					Неопределено);
		Результат.Вставить("ПротоколЗаполнен",					Ложь);
		
	Иначе
		
		// Для отправок.
		Результат.Вставить("ВыполняемоеОповещение", 			Неопределено);
		Результат.Вставить("РезультатОтправки", 				Неопределено);
		
		// Для обменов.
		Результат.Вставить("АдресДереваНовых", 					"");
		Результат.Вставить("ЕстьНовые",  		 				Ложь);
		Результат.Вставить("ПротоколОтрицательногоРезультата",	Неопределено);
		
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

Функция КоличествоОшибокОтменыДействия(Ошибки) Экспорт
	
	ОшибкиОтменыДействия = Новый Массив;
	// КриптоПро
	ОшибкиОтменыДействия.Добавить("The operation was canceled by the user");
	ОшибкиОтменыДействия.Добавить("Действие было отменено пользователем");
	// VipNet
	ОшибкиОтменыДействия.Добавить("Операция была отменена пользователем");
	// ЭП в облаке
	ОшибкиОтменыДействия.Добавить("Пользователь отказался от ввода пароля");
	
	КоличествоОшибокОтменыДействия = 0;
	
	Для каждого ОшибкаИзФиксированногоМассива Из Ошибки Цикл
		
		Для каждого ОшибкаОтменыДействия Из ОшибкиОтменыДействия Цикл
			Если Найти(ОшибкаИзФиксированногоМассива.ОписаниеОшибки, ОшибкаОтменыДействия) > 0 Тогда
				КоличествоОшибокОтменыДействия = КоличествоОшибокОтменыДействия + 1;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат КоличествоОшибокОтменыДействия;
	
КонецФункции

Процедура ОчиститьПараметрыДлительнойОтправки() Экспорт
	
	СоздатьПараметрыДлительнойОперацииПриНеобходимости();
	ТекущееЗначениеПараметров 	= ЗначенияПараметровДлительнойОперацииПоУмолчанию(); 
	НовоеЗначениеПараметров 	= Новый ФиксированноеСоответствие(ТекущееЗначениеПараметров);
	
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		УстановитьПривилегированныйРежим(Истина);
		ПараметрыСеанса[КлючПараметровДлительнойОтправкиСервер()] = НовоеЗначениеПараметров;
		УстановитьПривилегированныйРежим(Ложь);
	#Иначе
		ПараметрыПриложения[КлючПараметровДлительнойОтправкиКлиент()] = НовоеЗначениеПараметров;
	#КонецЕсли
	
КонецПроцедуры

Функция ФормаДлительнойОперацииОткрыта() Экспорт
	
	ПараметрыДлительнойОтправки = ЗначенияПараметровДлительнойОперации();
	ИдентификаторПолучателя 	= ПараметрыДлительнойОтправки["ИдентификаторФормыПолучателя"];
	
	ФормаОткрыта = ЗначениеЗаполнено(ИдентификаторПолучателя);
	
	Возврат ФормаОткрыта;
	
КонецФункции

Функция НоваяОшибка(Знач ОписаниеОшибки, Знач Организация = Неопределено) Экспорт
	
	// Текст ошибки.
	НоваяОшибка = Новый Структура;
	НоваяОшибка.Вставить("ОписаниеОшибки", ОписаниеОшибки);
	
	// Организация.
	Если НЕ ЗначениеЗаполнено(Организация) Тогда
		ТекущаяОрганизация = ЗначениеПараметраДлительнойОперации("ТекущаяОрганизация");
		Если ЗначениеЗаполнено(ТекущаяОрганизация) Тогда
			Организация = ТекущаяОрганизация;
		КонецЕсли;
	КонецЕсли;
	НоваяОшибка.Вставить("Организация", Организация);
	
	НоваяОшибка = Новый ФиксированнаяСтруктура(НоваяОшибка);
	
	Возврат НоваяОшибка;
	
КонецФункции

// Вывод ошибок. Если открыта форма длительной операции - все ошибки будут в ней накапливаться и затем показаны в отдельном окне ошибок.
// Если форма не открыта, но указан идентификатор формы-получателя сообщений, то сообщения выводятся в эту форму.
// В противном случае текст выводится обычным способом в нижнюю часть активной формы.
//
// Параметры:
//  ТекстСообщения	 - Строка - Текст выводимого сообщения.
//
Процедура ВывестиОшибку(
	Знач ТекстСообщения,
	Знач КлючДанных = Неопределено,
	Знач Поле = "",
	Знач ПутьКДанным = "",
	Отказ = Ложь,
	ВыводитьВКонсоль = Ложь,
	Организация = Неопределено
	) Экспорт
	
	// Добавляем сообщение к уже имеющимся.
	НоваяОшибка = НоваяОшибка(ТекстСообщения, Организация);
	ИзменитьПараметрыДлительнойОтправки("Ошибки", НоваяОшибка);
	
	Если НЕ ФормаДлительнойОперацииОткрыта() Тогда
		
		Если ВыводитьВКонсоль Тогда
			Если ЗначениеЗаполнено(КлючДанных)
				ИЛИ ЗначениеЗаполнено(Поле) 
				ИЛИ ЗначениеЗаполнено(ПутьКДанным)
				ИЛИ Отказ <> Ложь Тогда
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, КлючДанных, Поле, ПутьКДанным, Отказ);
			Иначе
				УниверсальныйОбменСБанкамиКлиентСервер.СообщитьПользователю(ТекстСообщения);
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Функция ИнтервалЧтенияСообщенийФоновыхЗаданий() Экспорт
	
	Возврат 0.5;
	
КонецФункции

#Область ПараметрыЭтапов

Функция ВесЭтапаПоУмолчанию() Экспорт
	
	Возврат 10;
	
КонецФункции

Функция НовыеПараметрыЗавершенияРасшифровки() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("КоличествоНеРасшифрованных", 	0);
	Параметры.Вставить("КоличествоРасшифрованных", 		0);
	Параметры.Вставить("Всего", 						0);
	
	Возврат Параметры;
	
КонецФункции

Функция НовыеПараметрыЭтаповРасшифровки() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("КоличествоПройденныхЭтапов", 	0);
	Параметры.Вставить("ОбщееКоличествоЭтапов", 		0);
	Параметры.Вставить("ТекущаяОрганизация", 			Неопределено);
	
	Возврат Параметры;
	
КонецФункции

Функция НовыеПараметрыДобавленияЭтапаОбмена() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("ИмяСобытия", 			"");
	Параметры.Вставить("Банк", 					Неопределено);
	Параметры.Вставить("Организация", 			Неопределено);
	Параметры.Вставить("Документооборот", 		Неопределено);
	Параметры.Вставить("ПроизвольнаяАналитика", Неопределено);
	Параметры.Вставить("ВесЭтапа", 				ВесЭтапаПоУмолчанию());
	// Индекс этапа в таблице этапов.
	Параметры.Вставить("ИндексЭтапа", 			Неопределено);
	
	Возврат Параметры;
	
КонецФункции

Функция НовыеПараметрыУточненииЭтаповСобытияОбмена() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("ИмяСобытия", 			"");
	// Массив структур результата фукции НовыеПараметрыДобавленияЭтапаОбмена()
	Параметры.Вставить("ЭтапыСобытия",			Новый Массив);
	
	Возврат Параметры;
	
КонецФункции

Функция НовыеПараметрыСменыИдентификатораФоновогоЗадания() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("Идентификатор",		Неопределено);
	
	Возврат Параметры;
	
	
КонецФункции

Функция НовыеПараметрыИзмененияПризнакаЧтенияСообщенийФоновогоЗадания(Признак = Ложь) Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("ПризнакЧтенияСообщенийФоновогоЗадания", Признак);
	Возврат Параметры;
	
КонецФункции

Функция НовыеПараметрыСменыЭтапаОбмена() Экспорт
	
	Параметры = Новый Структура();
	// Имя события.
	Параметры.Вставить("Имя", 					"");
	// Представление этапа для отображения на форме.
	Параметры.Вставить("Представление", 		"");
	// Банк универсального обмена или строка.
	Параметры.Вставить("Банк", 					Неопределено);
	Параметры.Вставить("Организация", 			Неопределено);
	Параметры.Вставить("Документооборот", 		Неопределено);
	Параметры.Вставить("ПроизвольнаяАналитика", Неопределено);
	// Длительность паузы перед вызовом обработчкика смены этапа.
	Параметры.Вставить("ДлительностьПаузы", 0);
	
	Возврат Параметры;
	
КонецФункции

Функция ВызватьОбработчикБезПаузы() Экспорт
	
	Возврат -1;
	
КонецФункции

#КонецОбласти

#Область ИменаЭтаповОбмена

Функция ИмяЭтапаОбменаСжатиеДанных() Экспорт
	
	Возврат "СжатиеДанных";
	
КонецФункции

Функция ИмяЭтапаОбменаПодготовкаДанных() Экспорт
	
	Возврат "ПодготовкаДанных";
	
КонецФункции

Функция ИмяЭтапаОбменаПолучениеВходящих() Экспорт
	
	Возврат "ПолучениеВходящих";
	
КонецФункции

Функция ИмяЭтапаОбменаРасшифровкаСообщений() Экспорт
	
	Возврат "РасшифроватьСообщения";
	
КонецФункции

Функция ИмяЭтапаОбменаПодписаниеШифрованиеСообщений() Экспорт
	
	Возврат "ПодписатьЗашифроватьСообщения";
	
КонецФункции

Функция ИмяЭтапаОбменаОтправкаСообщений() Экспорт
	
	Возврат "ОтправитьСообщения";
	
КонецФункции

#КонецОбласти

Функция ПрефиксСообщенийУточненияЭтаповСобытия() Экспорт
	
	Префикс = СтрШаблон("{%1}", "БанкКоннект.СообщениеУточненияЭтаповСобытия");
	Возврат Префикс;
	
КонецФункции

Функция ПрефиксСообщенийЭтаповОбмена() Экспорт
	
	Префикс = СтрШаблон("{%1}", "БанкКоннект.СообщениеЭтаповОбмена");
	Возврат Префикс;
	
КонецФункции

Функция ПрефиксСообщенийОшибок() Экспорт
	
	Префикс = СтрШаблон("{%1}", "БанкКоннект.Ошибка");
	Возврат Префикс;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СоздатьПараметрыДлительнойОперацииПриНеобходимости()

	 ЗначенияПараметровДлительнойОперации();

КонецПроцедуры

#КонецОбласти