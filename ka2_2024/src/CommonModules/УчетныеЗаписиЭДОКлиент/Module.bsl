
#Область СлужебныйПрограммныйИнтерфейс

// Открывает форму создания учетной записи электронного документооборота.
// 
// Параметры:
// 	ПараметрыСоздания - см. НовыеПараметрыСозданияУчетнойЗаписи
Процедура СоздатьУчетнуюЗапись(ПараметрыСоздания = Неопределено) Экспорт
	
	Если ПараметрыСоздания = Неопределено Тогда
		ПараметрыСоздания = НовыеПараметрыСозданияУчетнойЗаписи();
	КонецЕсли;
	
	УчетныеЗаписиЭДОСлужебныйКлиент.СоздатьУчетнуюЗапись(ПараметрыСоздания);
	
КонецПроцедуры

// Возвращает параметры для создания учетной записи электронного документооборота.
// 
// Возвращаемое значение:
// 	Структура:
// * Организация - ОпределяемыйТип.Организация - организация, для которой создается учетная запись
// * КнопкаНазадДоступна - Булево - если Истина, на первой странице мастера создания учетной записи будет
//                                  отображаться кнопка "Назад".
// * ВладелецФормы - Неопределено
// * ОповещениеОЗавершении - ОписаниеОповещения - описание процедуры, которая будет выполнена после создания
//                           учетной записи со следующими параметрами:
//                             * ИдентификаторУчетнойЗаписи - Строка
//                             * ДополнительныеПараметры - Произвольный - значение, которое было указано при
//                                                          создании объекта ОписаниеОповещения.
// * РежимОткрытия - РежимОткрытияОкнаФормы - режим открытия окна.
// * Контрагент - Неопределено,ОпределяемыйТип.УчастникЭДО
// * СпособыОбмена - Массив из ПеречислениеСсылка.СпособыОбменаЭД
// * ОперацияЭДО - Неопределено
//               - см. УчетныеЗаписиЭДОКлиентСервер.НоваяОперацияПодключенияЭДО
// * ДополнительныеПараметры - Неопределено,Произвольный
// * НастройкаОперацииЭДО - Булево
// * ЧерезОблачныйЭДО - Булево
Функция НовыеПараметрыСозданияУчетнойЗаписи() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Организация", Неопределено);
	Параметры.Вставить("ВладелецФормы", Неопределено);
	Параметры.Вставить("КнопкаНазадДоступна", Ложь);
	Параметры.Вставить("ОповещениеОЗавершении", Неопределено);
	Параметры.Вставить("РежимОткрытия", Неопределено);
	Параметры.Вставить("Контрагент", Неопределено);
	Параметры.Вставить("СпособыОбмена", Новый Массив);
	Параметры.Вставить("ОперацияЭДО", Неопределено);
	Параметры.Вставить("ДополнительныеПараметры", Неопределено);
	Параметры.Вставить("НастройкаОперацииЭДО", Ложь);
	Параметры.Вставить("ЧерезОблачныйЭДО", Ложь);
	
	Возврат Параметры;
	
КонецФункции

// Открывает учетную запись электронного документооборота.
// 
// Параметры:
// 	ИдентификаторУчетнойЗаписи - Строка
// 	ВладелецФормы - ФормаКлиентскогоПриложения
// 	Оповещение - ОписаниеОповещения
Процедура ОткрытьУчетнуюЗапись(ИдентификаторУчетнойЗаписи, ВладелецФормы = Неопределено,
	Оповещение = Неопределено) Экспорт
	
	УчетныеЗаписиЭДОСлужебныйКлиент.ОткрытьУчетнуюЗапись(ИдентификаторУчетнойЗаписи, ВладелецФормы, Оповещение);
	
КонецПроцедуры

// Открывает учетную запись электронного документооборота прямого обмена.
// 
// Параметры:
// 	Организация - ОпределяемыйТип.Организация
// 	ВладелецФормы - ФормаКлиентскогоПриложения
// 	Оповещение - ОписаниеОповещения
Процедура ОткрытьУчетнуюЗаписьПрямогоОбмена(Организация, ВладелецФормы = Неопределено, Оповещение = Неопределено) Экспорт
	
	УчетныеЗаписиЭДОСлужебныйКлиент.СоздатьУчетнуюЗаписьПрямогоОбмена(Организация, ВладелецФормы, Оповещение);
	
КонецПроцедуры

// Открывает форму списка учетных записей организации.
//
// Параметры:
//  Организация - ОпределяемыйТип.ОрганизацияБЭД - Организация
Процедура ОткрытьСписокУчетныхЗаписей(Организация = Неопределено) Экспорт
	
	НастройкиОтбора   = Новый Структура;
	Если Организация <> Неопределено Тогда
		НастройкиОтбора.Вставить("Организация", Организация);
	КонецЕсли;
	ПараметрыОткрытия = Новый Структура("Отбор", НастройкиОтбора);
	
	ОткрытьФорму("РегистрСведений.УчетныеЗаписиЭДО.ФормаСписка", ПараметрыОткрытия,, Организация);
	
КонецПроцедуры

// Возвращает ключ записи регистра сведений УчетныеЗаписиЭДО.
// 
// Параметры:
// 	ИдентификаторУчетнойЗаписи - Строка
// Возвращаемое значение:
// 	РегистрСведенийКлючЗаписи.УчетныеЗаписиЭДО
Функция КлючУчетнойЗаписи(ИдентификаторУчетнойЗаписи) Экспорт
	
	ЗначенияКлюча = Новый Структура("ИдентификаторЭДО", ИдентификаторУчетнойЗаписи);
	Тип = Тип("РегистрСведенийКлючЗаписи.УчетныеЗаписиЭДО");
	Возврат ОбщегоНазначенияБЭДКлиент.КлючЗаписиРегистраСведений(Тип, ЗначенияКлюча);
	
КонецФункции

// Открывает помощник регистрации сертификатов во время выполнении операции подписания или отправки
// электронного документа если для продолжения операции нет валидного сертификата.
//
// Параметры:
//  ПараметрыРегистрации - см. УчетныеЗаписиЭДОКлиентСервер.НовыеПараметрыРегистрацииСертификатов
//  ВладелецФормы - ФормаКлиентскогоПриложения - форма-владелец.
//  ОповещениеОЗакрытии - ОписаниеОповещения - содержит описание процедуры, которая будет вызвана при закрытии
//                                             помощника регистрации сертификатов со следующими параметрами: 
//                        * РезультатЗакрытия - Неопределено.
//                        * ДополнительныеПараметры - Произвольный - значение, которое было указано при создании
//                                                    объекта ОписаниеОповещения.
//
Процедура ОткрытьПомощникРегистрацииСертификатов(ПараметрыРегистрации, ВладелецФормы = Неопределено,
	ОповещениеОЗакрытии = Неопределено) Экспорт
	
	Если ВладелецФормы <> Неопределено Тогда
		ОткрытьФорму("РегистрСведений.СертификатыУчетныхЗаписейЭДО.Форма.ПомощникРегистрацииСертификатов", ПараметрыРегистрации,
			ВладелецФормы, ВладелецФормы.УникальныйИдентификатор,,, ОповещениеОЗакрытии, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	Иначе
		ОткрытьФорму("РегистрСведений.СертификатыУчетныхЗаписейЭДО.Форма.ПомощникРегистрацииСертификатов", ПараметрыРегистрации,,,,,
			ОповещениеОЗакрытии);
	КонецЕсли;
	
КонецПроцедуры

// Инициализирует получение уникального идентификатора Абонента в сервис 1С-ЭДО
// 
// Параметры:
//	ОписаниеОповещения - ОписаниеОповещения - обработчик, в который
//		передается результат получения идентификатора.
//		Передаваемое значение:
//			Строка - полученный идентификатор абонента;
//			Неопределено - если, идентификатор абонента не был получен.
// 	ОбработчикСтатусаЗаявки - ОписаниеОповещения - содержит описание процедуры обработки статуса заявки на получение 
// 							  идентификатора со следующими параметрами:
//			* Результат - Структура:
//				** СтатусЗаявки - Строка - статус текущей заявки:
//				** НомерЗаявки - Строка - номер заявки;
//				** КодОшибки - Строка - код ошибки в сервисе Такском;
//				** ОписаниеОшибки - Строка - описание ошибки обработки последней заявки. <Пустая строка>, если ошибки нет;
//				** ДанныеЗаявки - Структура, Неопределено - данные текущей заявки:
//					*** ИдентификаторАбонента - Строка - идентификатор абонента Такском;
//					*** ОтпечатокСертификата - Строка - отпечаток  сертификата в виде base64-строки,
//						указанного при регистрации заявки;
//					*** Индекс - Строка - почтовый индекс организации;
//					*** КодРегиона - Строка - код региона в адресе организации;
//					*** Район - Строка - Район;
//					*** Город - Строка - Город;
//					*** НаселенныйПункт - Строка - населенный пункт расположения организации;
//					*** Улица - Строка - Улица;
//					*** Дом - Строка - Дом;
//					*** Корпус - Строка - Корпус;
//					*** Квартира - Строка - Квартира;
//					*** Телефон - Строка - телефон организации;
//					*** НаименованиеОрганизации - Строка - наименование организации;
//					*** ИНН - Строка - ИНН организации;
//					*** КПП - Строка - КПП организации;
//					*** ОГРН - Строка - ОГРН организации;
//					*** КодНалоговогоОргана - Строка - код ИМНС организации;
//					*** ЮрФизЛицо - Строка - вид лица, возможные значения: "ЮрЛицо" или "ФизЛицо";
//					*** Фамилия - Строка - фамилия руководителя;
//					*** Имя - Строка - имя руководителя;
//					*** Отчество - Строка - отчество руководителя;
//				** ОбработчикРезультата - ОписаниеОповещения - обработчик, который должен быть вызван при
//					завершении выполнения метода. В обработчик передается результат выполнения метода.
//					Результат - Структура:
//					*** Действие - Строка - описание действия, которое необходимо выполнить для продолжения бизнес-процесса.
//			* ДополнительныеПараметры - Произвольный - значение, которое было указано при
//						создании объекта ОписаниеОповещения.
//	СертификатКриптографии - СправочникСсылка.СертификатыКлючейЭлектроннойПодписиИШифрования - сертификат
//		электронной подписи;
//	Организация - Произвольный - организация, с которой связан сертификат,
//		используется для заполнения данных организации в заявке на получение
//		идентификатора абонента (см. Подключение1СТакскомПереопределяемый.ЗаполнитьРегистрационныеДанныеОрганизации);
// 	ДополнительныеПараметры - см. УчетныеЗаписиЭДОКлиентСервер.НовыеПараметрыПодключенияЭДО
//
Процедура НачатьПолучениеНовогоИдентификатораТакском(ОписаниеОповещения, ОбработчикСтатусаЗаявки,
	СертификатКриптографии, Организация, ДополнительныеПараметры) Экспорт
	
	ОбработчикСозданияЗаявки = Новый ОписаниеОповещения(
		"ОбработатьСозданиеЗаявкиПриПолученииНовогоИдентификатораТакском",
		УчетныеЗаписиЭДОСлужебныйКлиент, ДополнительныеПараметры);
		
	ПараметрыОбработки = Новый Структура;
	ПараметрыОбработки.Вставить("ОбработчикСтатусаЗаявки", ОбработчикСтатусаЗаявки);
	ПараметрыОбработки.Вставить("ОбработчикСозданияЗаявки", ОбработчикСозданияЗаявки);
	
	Подключение1СТакскомКлиент.ПолучитьУникальныйИдентификаторАбонента(СертификатКриптографии, Организация,
			ОписаниеОповещения, ПараметрыОбработки);
	
КонецПроцедуры

// Параметры:
//  Контекст - Структура:
//  * ДанныеПакета - Структура
//  * КонтекстДиагностики - см. ОбработкаНеисправностейБЭДКлиент.НовыйКонтекстДиагностики
//  * ПаролиСертификатов - см. КриптографияБЭД.ПаролиСертификатов
// 
// Возвращаемое значение:
//  Структура - Результат операции в сервисе1 СЭДО:
//  * Успех - Булево
//  * УникальныйИдентификаторЗаявки1СЭДО - Строка
//  * КонтекстДиагностики - см. ОбработкаНеисправностейБЭДКлиент.НовыйКонтекстДиагностики
//  * ПаролиСертификатов - см. КриптографияБЭД.ПаролиСертификатов
Функция РезультатОперацииВСервисе1СЭДО(Контекст) Экспорт
	
	Возврат УчетныеЗаписиЭДОСлужебныйКлиент.РезультатОперацииВСервисе1СЭДО(Контекст);
	
КонецФункции

// Подписывает и отправляет регистрационный пакет в сервис 1С-ЭДО.
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения
// 	Оповещение - ОписаниеОповещения - содержит описание процедуры, которая будет выполнена после регистрации
// 	             сертификата со следующими параметрами:
// 	                * Результат - см. РезультатОперацииВСервисе1СЭДО
// 	                * ДополнительныеПараметры - Произвольный - значение, которое было указано при
// 	                  создании объекта ОписаниеОповещения.
// 	ПараметрыРегистрации - см. СервисЭДОКлиент.НовыеПараметрыРегистрацииВСервисе1СЭДО
// 	КонтекстДиагностики - см. ОбработкаНеисправностейБЭДКлиент.НовыйКонтекстДиагностики
//
Процедура ЗарегистрироватьСертификатВСервисе1СЭДО(Форма, Оповещение, ПараметрыРегистрации,
	КонтекстДиагностики) Экспорт
	
	ДанныеПакета = СервисЭДОВызовСервера.ДанныеДляРегистрационногоПакета1СЭДО(ПараметрыРегистрации);

	Контекст = УчетныеЗаписиЭДОСлужебныйКлиент.НовыйКонтекстРегистрацииСертификатаВСервисе1СЭДО();
	Контекст.ДанныеПакета = ДанныеПакета;
	Контекст.Оповещение = Оповещение;
	Контекст.Форма = Форма;
	Контекст.КонтекстДиагностики = КонтекстДиагностики;
	Контекст.ПаролиСертификатов = Неопределено;
	Контекст.Доверенности = ПараметрыРегистрации.Доверенности;
	
	Если ЗначениеЗаполнено(ДанныеПакета.ТекстОшибки) Тогда  
		ОбщегоНазначенияКлиент.СообщитьПользователю(ДанныеПакета.ТекстОшибки);
		РезультатОперации = УчетныеЗаписиЭДОСлужебныйКлиент.РезультатОперацииВСервисе1СЭДО(Контекст);
		РезультатОперации.Успех = Ложь;
		ВыполнитьОбработкуОповещения(Контекст.Оповещение, РезультатОперации);
		Возврат;
	КонецЕсли;
	
	ОписаниеПодписатьЭД = Новый ОписаниеОповещения("СформироватьИОтправитьРегистрационныйПакет1СЭДОПослеПодписания",
		УчетныеЗаписиЭДОСлужебныйКлиент, Контекст);
	
	ОтборСертификатов = ?(ПараметрыРегистрации.ОтборСертификатов.Количество() > 0,
		ПараметрыРегистрации.ОтборСертификатов,
		ПараметрыРегистрации.СертификатыПодписейОрганизации);
	
	УчетныеЗаписиЭДОСлужебныйКлиент.НачатьПодписаниеРегистрационногоПакета1СЭДО(ОписаниеПодписатьЭД, 
		ДанныеПакета, ОтборСертификатов, ПараметрыРегистрации);
	
КонецПроцедуры

#КонецОбласти