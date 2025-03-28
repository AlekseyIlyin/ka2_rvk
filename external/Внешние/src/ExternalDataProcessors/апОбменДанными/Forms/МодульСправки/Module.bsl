#Область ОписаниеПеременных

&НаКлиенте
Перем ГМодульК; // общий клиентский модуль

// ОписаниеПеременных
#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	//@skip-check structure-consructor-too-many-keys
	СтррКонтекст = Новый Структура("Страницы,ПутьКСправке,ПутьКНовойСправке,СтраницыНовойСправки");
	ТекОбъект = РеквизитФормыВЗначение("Объект");		
	ТекОбъект.КонтекстФормыИнициализировать(СтррКонтекст, Параметры);
	
	ИнициализироватьСвязиРазделовСправки();
	
	СтррКонтекст.ПутьКСправке 	   = "https://help.agentplus.online/mtbase/ut11/v1/";
	СтррКонтекст.ПутьКНовойСправке = "https://agentplus.tech/pages/viewpage.action?pageId=";
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Отказ = Истина;
КонецПроцедуры

// ОбработчикиСобытийФормы
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИнициализироватьСвязиРазделовСправки()
	
	СтвСтраницы = Новый Соответствие;
	                                                    	
	// Главная страница
	СтвСтраницы.Вставить("ГлавнаяФорма", 									"24675632");
	СтвСтраницы.Вставить("ГлавнаяФорма_Главная", 							"domashnyaya_stranitsa");
	СтвСтраницы.Вставить("ГлавнаяФорма_ОбменДанными", 						"obmen_dannymi_1");
	СтвСтраницы.Вставить("ГлавнаяФорма_Справочники", 						"spravochniki_1");
	СтвСтраницы.Вставить("ГлавнаяФорма_Документы", 							"dokumenty_1");
	СтвСтраницы.Вставить("ГлавнаяФорма_ПланированиеИКонтроль", 				"planirovanie_i_kontrol_2");
	СтвСтраницы.Вставить("ГлавнаяФорма_Сервис", 							"servis");
	СтвСтраницы.Вставить("ГлавнаяФорма_Помощь", 							"pomoshch");
	
	СтвСтраницы.Вставить("ЛичныйКабинет", 									"nastrojka_dostupa_v_lichnyj_kabinet");
	
	// Справочники
	СтвСтраницы.Вставить("НастройкиАгентов",								"torgovye_agenty");
	СтвСтраницы.Вставить("МобильныеУстройства",								"mobilnye_ustrojstva");
	СтвСтраницы.Вставить("СпискиТорговыхТочек",								"spiski_torgovykh_tochek");
	
	СтвСтраницы.Вставить("СписокТорговыхТочек",								"vkladka__spisok_");
	СтвСтраницы.Вставить("СписокТорговыхТочек_ГруппаСписок",				"vkladka__spisok_");
	СтвСтраницы.Вставить("СписокТорговыхТочек_ГруппаПланПосещений",			"vkladka__plan_poseshchenij_");
	СтвСтраницы.Вставить("СписокТорговыхТочек_ГруппаДополнительно",			"vkladka__dopolnitelno__3");
	
	СтвСтраницы.Вставить("СправочникДополнительныеОтчетыДляМУ", 			"28476042");
	
	// Документы
	СтвСтраницы.Вставить("Документы_Посещение",								"poseshcheniya");
	
	
	// Общие настройки
	СтвСтраницы.Вставить("НастройкиМодуля", 								"obshchie_nastrojki");
	СтвСтраницы.Вставить("НастройкиМодуля_ГруппаОсновные", 					"vkladka__osnovnye_");
	СтвСтраницы.Вставить("НастройкиМодуля_ГруппаДополнительно", 			"vkladka__dopolnitelno__2");
	СтвСтраницы.Вставить("НастройкиМодуля_ГруппаКаталоги", 					"vkladka__katalogi_");
	
	// Настройка мобильного приложения
	СтвСтраницы.Вставить("НастройкиМобильногоПриложения", 					"nastrojka_mobilnogo_prilozheniya_na_ustrojstve");
	
	СтвСтраницы.Вставить("НастройкиМодуля_КаталогДанныхДляСервера_Windows", "katalog_dannykh_na_servere_windows");
	СтвСтраницы.Вставить("НастройкиМодуля_КаталогДанныхДляСервера_Linux", 	"katalog_dannykh_na_servere_linux");	
	
	// Планирование и контроль
	СтвСтраницы.Вставить("ОтчетВыполнениеПланаПосещений", 					"vypolnenie_plana_poseshchenij");
	СтвСтраницы.Вставить("ОтчетКонтрольПередвиженийАгентов", 				"kontrol_peredvizhenij_torgovykh_agentov");
	СтвСтраницы.Вставить("РедакторМеток", 									"zapolnit_koordinaty_partnerov");
	СтвСтраницы.Вставить("ОтчетВыполнениеПлановПродаж", 					"8585363");

	
	СтррКонтекст.Страницы = СтвСтраницы;
	
	МСтраницыНовойСправки = Новый Массив; // Страницы новой справки
	
	МСтраницыНовойСправки.Добавить("ГлавнаяФорма");
	МСтраницыНовойСправки.Добавить("СправочникДополнительныеОтчетыДляМУ");
	МСтраницыНовойСправки.Добавить("ОтчетВыполнениеПлановПродаж");
	
	СтррКонтекст.СтраницыНовойСправки = МСтраницыНовойСправки;
	
КонецПроцедуры

&НаКлиенте
Процедура ВнешнийВызовОткрытьСправку(Знач ПутьКСтранице) Экспорт
	
	Страница = МодульК().ПоследнийЭлементСтроки(ПутьКСтранице);
	ФлНоваяСправка = ЭтоНоваяСправка(Страница);
	СтрИдентификаторРаздела = СтррКонтекст.Страницы.Получить(Страница);
	Если СтрИдентификаторРаздела = Неопределено Тогда
		Если ФлНоваяСправка Тогда
			СтрИдентификаторРаздела = СтррКонтекст.Страницы.Получить("ГлавнаяФорма");
		Иначе
			СтрИдентификаторРаздела = "index";
		КонецЕсли;
	КонецЕсли;
		
	Если ФлНоваяСправка Тогда
		СтрПуть = СтррКонтекст.ПутьКНовойСправке + СтрИдентификаторРаздела;
	Иначе
		СтрПуть = СтррКонтекст.ПутьКСправке + СтрИдентификаторРаздела + ".htm";
	КонецЕсли;
	
	ЗапуститьПриложение(СтрПуть);
	
КонецПроцедуры

&НаКлиенте
Функция МодульК()

	Если ГМодульК = Неопределено Тогда
	    //@skip-check use-non-recommended-method
	    ГМодульК = ПолучитьФорму(СтррКонтекст.ПутьКФорме + "МодульОбщий", СтррКонтекст);
	КонецЕсли; 
	
	Возврат ГМодульК;

КонецФункции

// Возвращает признак наличия страницы в новой справке
//
// Параметры:
//	Страница - Строка - наименование страницы
//
// Возвращаемое значиение:
//	Булево - признак новой
//
&НаКлиенте
Функция ЭтоНоваяСправка(Страница)
	
	Если Не СтррКонтекст.СтраницыНовойСправки.Найти(Страница) = Неопределено Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции // ЭтоНоваяСправка()

// СлужебныеПроцедурыИФункции
#КонецОбласти
