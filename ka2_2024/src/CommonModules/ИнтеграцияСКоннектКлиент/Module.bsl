///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "ИнтернетПоддержкаПользователей.ИнтеграцияСКоннект".
// ОбщийМодуль.ИнтеграцияСКоннектКлиент.
//
// Клиентские процедуры интеграции с сервисом 1С-Коннект:
//  - запуск приложения 1С-Коннект;
//  - обработка событий БСП;
//  - настройки интеграции с 1С-Коннект.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Открывает форму настройки интеграции с сервисом 1С-Коннект.
//
// Параметры:
//  Владелец - ФормаКлиентскогоПриложения, Неопределено - форма, которая будет установлена в качестве владельца.
//  ОписаниеОповещения - ОписаниеОповещения - оповещение, которое необходимо выполнить после завершения
//                      настройки интеграции.
//
Процедура НастройкаИнтеграции(
		Владелец = Неопределено,
		ОписаниеОповещения = Неопределено) Экспорт
	
	ОткрытьФорму(
		"ОбщаяФорма.НастройкаПодключенияКоннект",
		,
		Владелец,
		,
		,
		,
		ОписаниеОповещения);
	
КонецПроцедуры

// Запускает приложение 1С-Коннект. Если приложение не установлено
// на клиентский персональный компьютер, открывается форма настройки
// подключения.
//
Процедура СвязатьсяСоСпециалистом() Экспорт
	
	Если Не ДоступнаИнтеграцияСКоннект() Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"СвязатьсяСоСпециалистомПослеУстановкиРасширения",
		ЭтотОбъект);
	
	ФайловаяСистемаКлиент.ПодключитьРасширениеДляРаботыСФайлами(
		ОписаниеОповещения,
		НСтр("ru = 'Для запуска приложения необходимо установить расширение для работы с 1С:Предприятием.'"),
		Ложь);
	
КонецПроцедуры

// Определяет имя события, которое будет содержать оповещение
// о завершении настройки интеграции для пользователя.
//
// Возвращаемое значение:
//  Строка - Имя события. Может быть использовано для идентификации
//           сообщений принимающими их формами.
//
Функция ИмяСобытияОбновленияНастроек() Экспорт
	
	Возврат "ИзменениеНастроекИнтеграцииСКоннект";
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ВызовПриложенияКоннект

// Запускает приложение 1С-Коннект. Если приложение не установлено
// на клиентский персональный компьютер, открывается форма настройки
// подключения.
//
// Параметры:
//  РасширениеПодключено - Булево - Истина, если расширение работы с файлами установлено успешно;
//  ДополнительныеПараметры - Структура - параметры запуска приложения.
//
Процедура СвязатьсяСоСпециалистомПослеУстановкиРасширения(
		РасширениеПодключено,
		ДополнительныеПараметры) Экспорт
	
	Если НЕ РасширениеПодключено Тогда
		Возврат;
	КонецЕсли;
	
	// Определение параметров запуска.
	РасположениеИзРеестра   = РасположениеИзРеестраWindows();
	РасположениеИзХранилища = ИнтеграцияСКоннектВызовСервера.НастройкиИнтеграции().РасположениеФайла;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("РасположениеИзРеестра",     "");
	ДополнительныеПараметры.Вставить("РасположениеИзХранилища",   РасположениеИзХранилища);
	ДополнительныеПараметры.Вставить("ФайлИзРеестраСуществует",   Ложь);
	ДополнительныеПараметры.Вставить("ФайлИзХранилищаСуществует", Ложь);
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"СвязатьсяСоСпециалистомЗапускПриложения",
		ЭтотОбъект,
		ДополнительныеПараметры);
	
	ПроверитьСуществованиеПриложенияИзРеестра(
		ОписаниеОповещения,
		РасположениеИзРеестра);
	
КонецПроцедуры

// Производит проверку существования файла приложения на основании данных найденных в реестре Windows.
// Поскольку в реестре может быть несколько расположений исполняемого файла (например, старая и новая программы), будет
// использоваться первый существующий.
//
// Параметры:
//  ОповещениеЗавершениеПроверки - ОписаниеОповещения - оповещение которое необходимо вызвать
//                                 после завершения проверки путей к файлам приложений.
//  РасположениеИзРеестра - Массив из Строка - найденные в реестре пути к приложению.
//
Процедура ПроверитьСуществованиеПриложенияИзРеестра(ОповещениеЗавершениеПроверки, РасположениеИзРеестра)
	
	ДополнительныеПараметры = НовыйДополнительныеПараметрыПроверкиСуществованияВРеестре();
	ДополнительныеПараметры.ОповещениеЗавершениеПроверки = ОповещениеЗавершениеПроверки;
	ДополнительныеПараметры.РасположениеИзРеестра = РасположениеИзРеестра;
	ДополнительныеПараметры.ПродолжитьПроверку = Ложь;
	ДополнительныеПараметры.ПутьКФайлу = "";
	
	Если РасположениеИзРеестра.Количество() = 0 Тогда
		ПослеПроверкиСуществованиеПриложенияИзРеестра(Ложь, ДополнительныеПараметры);
		Возврат;
	КонецЕсли;
	
	НомерПервого = -1;
	ПутьКФайлу = "";
	Для ном = 0 По РасположениеИзРеестра.ВГраница() Цикл
		ПутьКФайлу = РасположениеИзРеестра[ном];
		ПроверяемыйФайл = Новый Файл(ПутьКФайлу);
		Если НРег(ПроверяемыйФайл.Расширение) = ".exe" Тогда
			НомерПервого = ном;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если НомерПервого = -1 Тогда
		ПослеПроверкиСуществованиеПриложенияИзРеестра(Ложь, ДополнительныеПараметры);
		Возврат;
	КонецЕсли;
	
	Пока НомерПервого > -1 Цикл
		РасположениеИзРеестра.Удалить(0);
		НомерПервого = НомерПервого - 1;
	КонецЦикла;
	
	ДополнительныеПараметры.ПутьКФайлу            = ПутьКФайлу;
	ДополнительныеПараметры.РасположениеИзРеестра = РасположениеИзРеестра;
	ДополнительныеПараметры.ПродолжитьПроверку    = РасположениеИзРеестра.Количество() > 0;
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ПослеПроверкиСуществованиеПриложенияИзРеестра",
		ЭтотОбъект,
		ДополнительныеПараметры);

	ПроверяемыйФайл.НачатьПроверкуСуществования(ОписаниеОповещения);
	
КонецПроцедуры

// Производит проверку существования файла приложения на основании данных настроек.
//
// Параметры:
//  Существует - Булево - признак существования файла по пути реестра Windows.
//  ДополнительныеПараметры - см. НовыйДополнительныеПараметрыПроверкиСуществованияВРеестре.
//
Процедура ПослеПроверкиСуществованиеПриложенияИзРеестра(
		Существует,
		ДополнительныеПараметры) Экспорт

	ПравильныеПараметры = НовыйДополнительныеПараметрыПроверкиСуществованияВРеестре();
	ЗаполнитьЗначенияСвойств(ПравильныеПараметры, ДополнительныеПараметры);
	
	Если Не Существует И ПравильныеПараметры.ПродолжитьПроверку Тогда
		ПроверитьСуществованиеПриложенияИзРеестра(
			ПравильныеПараметры.ОповещениеЗавершениеПроверки,
			ПравильныеПараметры.РасположениеИзРеестра);
		Возврат;
	КонецЕсли;
	
	ОповещениеЗавершениеПроверки = ПравильныеПараметры.ОповещениеЗавершениеПроверки;
	
	ОповещениеЗавершениеПроверки.ДополнительныеПараметры.ФайлИзРеестраСуществует = Существует;
	Если Существует Тогда
		ОповещениеЗавершениеПроверки.ДополнительныеПараметры.РасположениеИзРеестра = ПравильныеПараметры.ПутьКФайлу;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ПослеПроверкиСуществованиеПриложенияИзХранилища",
		ЭтотОбъект,
		ОповещениеЗавершениеПроверки);
	
	ПроверяемыйФайл = Новый Файл(
		ОповещениеЗавершениеПроверки.ДополнительныеПараметры.РасположениеИзХранилища);
	
	Если ОбщегоНазначенияКлиент.ЭтоWindowsКлиент() Тогда
		Если НРег(ПроверяемыйФайл.Расширение) <> ".exe" Тогда
			ПослеПроверкиСуществованиеПриложенияИзХранилища(Ложь, ОповещениеЗавершениеПроверки);
		Иначе
			ПроверяемыйФайл.НачатьПроверкуСуществования(ОписаниеОповещения);
		КонецЕсли;
	Иначе
		ПроверяемыйФайл.НачатьПроверкуСуществования(ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

// Анализирует результат проверки существования файла приложения на основании данных настроек.
//
// Параметры:
//  Существует - Булево - признак существования файла по пути из настроек.
//  ОповещениеЗавершениеПроверки - ОписаниеОповещения - оповещение которое необходимо вызвать
//                                 после завершения проверки путей к файлам приложений.
//
Процедура ПослеПроверкиСуществованиеПриложенияИзХранилища(
		Существует,
		ОповещениеЗавершениеПроверки) Экспорт
	
	ОповещениеЗавершениеПроверки.ДополнительныеПараметры.ФайлИзХранилищаСуществует = Существует;
	ВыполнитьОбработкуОповещения(ОповещениеЗавершениеПроверки);
	
КонецПроцедуры

// Запускает приложение 1С-Коннект. Если приложение не установлено
// на клиентский персональный компьютер, открывается форма настройки
// подключения.
//
// Параметры:
//  Результат - Произвольный - результат проверки файлов приложения;
//  ДополнительныеПараметры - Структура - результат проверки файлов приложения.
//
Процедура СвязатьсяСоСпециалистомЗапускПриложения(Результат, ДополнительныеПараметры) Экспорт
	
	ПараметрыЗапуска = Новый Массив;
	ПараметрыЗапуска.Добавить("/StartedFrom1CConf");
	
	ПараметрыЗапускаПрограммы = ФайловаяСистемаКлиент.ПараметрыЗапускаПрограммы();
	ПараметрыЗапускаПрограммы.ДождатьсяЗавершения = Ложь;
	
	Если ДополнительныеПараметры.ФайлИзХранилищаСуществует Тогда
		
		КомандаЗапуска = Новый Массив;
		КомандаЗапуска.Добавить(ДополнительныеПараметры.РасположениеИзХранилища);
		
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(
			КомандаЗапуска,
			ПараметрыЗапуска);
		
		Если ОбщегоНазначенияКлиент.ЭтоLinuxКлиент() Тогда
			ЗапускаемыйФайл = Новый Файл(ДополнительныеПараметры.РасположениеИзХранилища);
			ПараметрыЗапускаПрограммы.ТекущийКаталог = ЗапускаемыйФайл.Путь;
		КонецЕсли;
		
		ФайловаяСистемаКлиент.ЗапуститьПрограмму(
			КомандаЗапуска,
			ПараметрыЗапускаПрограммы);
		
		ПоказатьОповещениеПользователя(
			НСтр("ru = 'Запущено приложение 1С-Коннект'"),
			,
			НСтр("ru = 'Команда на запуск приложения отправлена,
				|дождитесь открытия стартовой страницы.'"),
			БиблиотекаКартинок.Информация32,
			СтатусОповещенияПользователя.Информация);
		
		Возврат;
		
	КонецЕсли;
	
	Если ДополнительныеПараметры.ФайлИзРеестраСуществует Тогда
		
		КомандаЗапуска = Новый Массив;
		КомандаЗапуска.Добавить(ДополнительныеПараметры.РасположениеИзРеестра);
		
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(
			КомандаЗапуска,
			ПараметрыЗапуска);
		
		ФайловаяСистемаКлиент.ЗапуститьПрограмму(
			КомандаЗапуска,
			ПараметрыЗапускаПрограммы);
		
		ПоказатьОповещениеПользователя(
			НСтр("ru = 'Запущено приложение 1С-Коннект'"),
			,
			НСтр("ru = 'Команда на запуск приложения отправлена,
				|дождитесь открытия стартовой страницы.'"),
			БиблиотекаКартинок.Информация32,
			СтатусОповещенияПользователя.Информация);
		
		Возврат;
		
	КонецЕсли;
	
	НастройкаИнтеграции();
	
КонецПроцедуры

// Определяет расположение приложения на основании данных реестра Windows.
// Информация в реестре может храниться в разных местах в зависимости от версии программы, способа ее установки,
// первого запуска и того, какая версия программы была запущена последней.
// На текущий момент, из-за особенностей работы установщика при удалении программы, в реестре могут остаться записи
// даже после удаления программы. Кроме того, у старой версии вообще нет программы удаления, поэтому записи из реестра
// не удаляются.
// В связи с этим, наличие программ проверяется в следующем порядке (используется первый существующий файл):
//   1. Последняя запущенная версия программы.
//   2. Новая версия программы (5.Х), установленная для всех пользователей.
//   3. Новая версия программы (5.Х), установленная для текущего пользователя.
//   4. Старая версия программы (4.Х).
// В ветке "SOFTWARE\Classes\connect" указывается путь к файлу, который был запущен последним. Может быть как старая,
// так и новая. Если новая запущена, висит в трее, и после этого запускают старую, то она перезапишет информацию
// в этой ветке и открываться будет старая, до тех пор, пока новая не будет закрыта (совсем, чтобы не отображалась
// в трее) и повторно запущена. И наоборот.
// Если установлена новая версия и программа ни разу не запускалась, то она будет найдена на основе информации об
// удалении программы.
// Если установили только старую версию и она еще ни разу не запускалась, то она не будет найдена, поскольку в реестре
// отсутствует информация по удалению программы.
//
// Возвращаемое значение:
//  Массив из Строка - возможные расположения исполняемых файлов найденные в реестре Windows.
//
Функция РасположениеИзРеестраWindows()
	
	#Если ВебКлиент Тогда
		Возврат Новый Массив;
	#КонецЕсли
	
	Если Не ОбщегоНазначенияКлиент.ЭтоWindowsКлиент() Тогда
		Возврат Новый Массив;
	КонецЕсли;

	Результат = Новый Массив;
	
	КомпонентаОбъект = ПолучитьCOMОбъект("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv");
	Значение = "";
	
	// Если запускалась хотя бы раз, то путь к файлу должен быть в ветке
	//   HKEY_CURRENT_USER\SOFTWARE\Classes\connect\shell\open\command
	//   в значении - путь к файлу с параметрами
	//  Первый параметр метода - числовое представление первого уровня реестра. Можно посмотреть в описании
	//  параметров конкретного метода на сайте
	//  https://learn.microsoft.com/en-us/previous-versions/windows/desktop/regprov/stdregprov
	// "2147483649" - HKEY_CURRENT_USER
	КомпонентаОбъект.GetStringValue("2147483649", "SOFTWARE\Classes\connect\shell\open\command", "", Значение);
	
	УбратьПараметрыИзСтрокиЗапуска(Значение);
	ДобавитьПутьИзРеестраВМассив(Результат, Значение);
	
	// Новая версия программы (проверено на версии 5.2.2)
	// Если еще ни разу не запускалась, то может быть в информации по удалению программ
	
	// Вариант установки для всех пользователей.
	// "2147483650" - HKEY_LOCAL_MACHINE
	Значение = ПутьВУдаленииПрограмм(
		КомпонентаОбъект,
		"2147483650",
		"SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall");
	ДобавитьПутьИзРеестраВМассив(Результат, Значение);

	// Вариант установки только для текущего пользователя.
	// "2147483649" - HKEY_CURRENT_USER
	Значение = ПутьВУдаленииПрограмм(
		КомпонентаОбъект,
		"2147483649",
		"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall");
	ДобавитьПутьИзРеестраВМассив(Результат, Значение);
	
	// Старая версия программы
	// Записи в реестре появляются только после первого запуска программы. До этого есть только в специфичных ветках,
	// без указания нормального пути к исполняемому файлу.
	КомпонентаОбъект.GetStringValue("2147483649", "Software\Buhphone", "ProgramPath", Значение);
	ДобавитьПутьИзРеестраВМассив(Результат, Значение);
	
	Возврат Результат;
	
КонецФункции

// Выполняет поиск пути к исполняемому файлу в ветках, хранящих информацию для удаления программы.
// Поскольку в ветке храниться путь к файлу удаления программы, а не к самой программе, то для поиска пути запуска
// программы используется путь к файлу иконки. В настоящий момент, он совпадает с файлом запуска программы, но это может
// поменяться при выпуске новых версий.
// Поиск выполняется по имени программы, выводимому в панель "Установка/удаление программ" windows. Должно содержать
// подстроку "1С-Коннект".
// Если путь к фалу найден, то проверяется, что последнее, что в нем указано - это "\connect.exe", чтобы не запустить
// удаление программы.
// 
// Параметры:
//   КомпонентаОбъект - Произвольный - COM-объект, используемые для доступа к реестру windows.
//   Корень - Строка - исходный корень реестра, в котором выполняется поиск. Указывается в виде числа. см, например,
//     https://learn.microsoft.com/en-us/previous-versions/windows/desktop/regprov/enumkey-method-in-class-stdregprov.
//   НачальнаяВетка - Строка - ветка реестра, в которой необходимо выполнить поиск.
//
// Возвращаемое значение:
//   Строка - результат поиска пути к исполняемому файлу.
//
Функция ПутьВУдаленииПрограмм(КомпонентаОбъект, Корень, НачальнаяВетка)
	
	Результат = "";
	
#Если Не ВебКлиент И Не МобильныйКлиент Тогда
	
	ПодчиненныеКлючи = "";
	
	КомпонентаОбъект.EnumKey(Корень, НачальнаяВетка, ПодчиненныеКлючи);
	
	Если ТипЗнч(ПодчиненныеКлючи) = Тип("COMSafeArray") Тогда
		
		Для Каждого ИмяКлюча Из ПодчиненныеКлючи Цикл
			
			СписокСвойств = Неопределено;
			Ветка = НачальнаяВетка + "\" + ИмяКлюча;
			КомпонентаОбъект.EnumValues(Корень, Ветка, СписокСвойств);
			
			Если ТипЗнч(СписокСвойств) <> Тип("COMSafeArray") Тогда
				Продолжить;
			КонецЕсли;
			
			ДанныеРеестра = Новый Структура("Имя, ПутьКИконке", "", "");
			
			Для Каждого Свойство Из СписокСвойств Цикл
				Если Свойство = "DisplayName" Тогда
					КомпонентаОбъект.GetStringValue(
						Корень,
						Ветка,
						Свойство,
						ДанныеРеестра.Имя);
				ИначеЕсли Свойство = "DisplayIcon" Тогда
					КомпонентаОбъект.GetStringValue(
						Корень,
						Ветка,
						Свойство,
						ДанныеРеестра.ПутьКИконке);
				КонецЕсли;
			КонецЦикла;
			
			Если Не СтрНайти(ДанныеРеестра.Имя, "1С-Коннект") Тогда
				Продолжить;
			КонецЕсли;
			
			Если Прав(ДанныеРеестра.ПутьКИконке, 12) = "\connect.exe" Тогда
				Результат = ДанныеРеестра.ПутьКИконке;
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
#КонецЕсли
	
	Возврат Результат;
	
КонецФункции

// Убирает из найденного пути к исполняемому файлу дополнительные параметры запуска.
// Путь должен содержать "\connect.exe" или "\1C-Connect.exe". В противном случае, значение очищается.
//
// Параметры:
//  Значение - Строка - найденный путь, который может содержать дополнительные параметры.
//
Процедура УбратьПараметрыИзСтрокиЗапуска(Значение)
	
	Если ТипЗнч(Значение) <> Тип("Строка") 
		Или ПустаяСтрока(Значение) Тогда
		Значение = "";
		Возврат;
	КонецЕсли;
	
	Позиция = СтрНайти(Значение, "\connect.exe");
	Если Позиция <> 0 Тогда
		Значение = Лев(Значение, Позиция + 11);
		Значение = СтрЗаменить(Значение, """", "");
		Возврат;
	КонецЕсли;
	
	Позиция = СтрНайти(Значение, "\1C-Connect.exe");
	Если Позиция <> 0 Тогда
		Значение = Лев(Значение, Позиция + 15);
		Значение = СтрЗаменить(Значение, """", "");
		Возврат;
	КонецЕсли;
	
	// Если в строке нет допустимого имени файла, то очищаем строку, чтобы исключить запуск некорректного приложения.
	Значение = "";
	
КонецПроцедуры

// Проверяет, что найденное значение заполнено и добавляет его в массив. Информация в массиве не дублируется.
//
// Параметры:
//  Результат - Массив Из Строка - массив найденных путей к исполняемым файлам.
//  Значение - Строка, Неопределено, Null - результат поиска информации в реестре.
//
Процедура ДобавитьПутьИзРеестраВМассив(Результат, Значение)
	
	Если ЗначениеЗаполнено(Значение)
		И Результат.Найти(Значение) = Неопределено Тогда
		Результат.Добавить(Значение);
	КонецЕсли;
	
КонецПроцедуры

// Формирует структуру, содержащую необходимые свойства для параметра ДополнительныеПараметры метода
// ПослеПроверкиСуществованиеПриложенияИзРеестра.
//
// Возвращаемое значение:
//  Структура - дополнительные параметры:
//    * ОповещениеЗавершениеПроверки - Неопределено - оповещение которое необходимо вызвать
//                                     после завершения проверки путей к файлам приложений.
//    * РасположениеИзРеестра - Массив из Строка - пути к приложению, которые еще не были проверены.
//    * ПродолжитьПроверку - Булево - Истина, если нужно выполнить проверку существование следующего файла в массиве.
//                           Используется только если ранее найденный проверяемый не существует.
//    * ПутьКФайлу - Строка - путь к текущему проверяемому файлу.
//
Функция НовыйДополнительныеПараметрыПроверкиСуществованияВРеестре()

	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ОповещениеЗавершениеПроверки", Неопределено);
	ДополнительныеПараметры.Вставить("РасположениеИзРеестра", Новый Массив);
	ДополнительныеПараметры.Вставить("ПродолжитьПроверку", Ложь);
	ДополнительныеПараметры.Вставить("ПутьКФайлу", "");

	Возврат ДополнительныеПараметры;
	
КонецФункции

#КонецОбласти

#Область ПрочиеСлужебныеПроцедурыФункции

// Определяет доступность интеграции с 1С-Коннект.
// Если интеграция не доступна, показывает предупреждение.
//
// Возвращаемое значение:
//  Булево - если Истина, интеграция с 1С-Коннект доступна.
//
Функция ДоступнаИнтеграцияСКоннект()
	
	Если Не (ОбщегоНазначенияКлиент.ЭтоWindowsКлиент()
		Или ОбщегоНазначенияКлиент.ЭтоLinuxКлиент()) Тогда
		ПоказатьПредупреждение(
			,
			НСтр("ru = 'Для работы с приложением необходима операционная система Microsoft Windows или Linux.'"));
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецОбласти
