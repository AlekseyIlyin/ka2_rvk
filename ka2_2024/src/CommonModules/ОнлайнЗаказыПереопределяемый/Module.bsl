///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "ИнтернетПоддержкаПользователей.ОнлайнЗаказы".
// ОбщийМодуль.ОнлайнЗаказыПереопределяемый.
//
//
// Переопределяемые серверные процедуры работы с Системой быстрых платежей:
//  - определение параметров онлайн-заказа на основании первичного документа;
//  - обработка статусов выполнения онлайн-заказа;
//  - формирование шаблонов сообщений и подготовка параметров отправки URL онлайн-заказа.
//
///////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область СозданиеСсылки

// Определяет объекты, которые могут выступать в качестве оснований для онлайн-заказа.
//
// Параметры:
//  ИменаОснованийЗаказа - Массив Из Строка - имена объектов метаданных оснований для онлайн-заказов.
//
Процедура ПриОпределенииОснованияЗаказа(ИменаОснованийЗаказа) Экспорт
	
	
КонецПроцедуры

// Определяет доступность функциональности создания заказа на основании документа оплаты.
//
// Параметры:
//  ДокументЗаказа - ОпределяемыйТип.ДокументОнлайнЗаказаБИП - документ, по данным которого
//    будет создан новый заказ.
//  Результат - Структура - результат проверки:
//    * СозданиеЗаказаДоступно - Булево - признак доступности создания заказа по данным документа оплаты.
//    * СообщениеОбОшибке - Строка - сообщение для пользователя. Отображается в случае, если в параметр
//    СозданиеЗаказаДоступно установлено значение Ложь.
//    * Организация - ОпределяемыйТип.Организация - организация, по которой будет выполнен поиск
//      настроек платежных страниц.
//
Процедура ПриОпределенииПараметровСозданияЗаказа(
		ДокументЗаказа,
		Результат) Экспорт
	
	
КонецПроцедуры

// Определяет состав печатных форм доступных для использования в качестве вложений в онлайн-заказ.
// Параметры:
//  ДокументЗаказа - ОпределяемыйТип.ДокументОнлайнЗаказаБИП - документ, по данным которого
//    будет создан новый заказ.
//  ПечатныеФормы - ТаблицаЗначений - содержит описание печатных форм
//    * Идентификатор - Строка - Идентификатор печатной формы
//    * Представление - Строка - Представление печатной формы пользователю.
//    * ФорматСохранения - ТипФайлаТабличногоДокумента - значение типа ТипФайлаТабличногоДокумента,
//      В который будет выполнено сохранение печатной формы. По умолчанию сохранение выполняется в формате MXL.
//    * ИмяФайлаВТранслите - Булево - если Истина, то имя файла будет на латинице.
//    * ПодписьИПечать - Булево - если установить Истина
//      и сохраняемый табличный документ поддерживает размещение подписей и печатей,
//      то во вложении будут размещены подписи и печати.
//
Процедура ПриОпределенииПечатныхФормЗаказа(
		ДокументЗаказа,
		ПечатныеФормы) Экспорт
	
	
КонецПроцедуры

// Определяет состав табличной части товары и ее представление пользователю.
// Поля "ИдентификаторТовара", "Наименование", "Количество", "СуммаСоСкидкой", "Скидка", "СуммаНДС", обязательны.
// Параметры:
//  ДокументЗаказа - ОпределяемыйТип.ДокументОнлайнЗаказаБИП - документ, по данным которого
//    будет создан новый заказ.
//  ОписаниеПредставленияТоваров - Массив Из Структура - содержит описание колонок табличной части Товары онлайн-заказа.
//  Для добавления нового свойства рекомендуется использовать метод ОнлайнЗаказы.НоваяКолонкаТовары:
//    * Идентификатор - Строка - уникальный идентификатор колонки.
//    * Представление - Строка - представление колонки пользователю (шапка табличной части).
//    * ПорядокОтображения - Число - Порядок отображения колонок пользователю, упорядочивание по возрастанию.
//    * Видимость - Булево - признак видимости колонки пользователю.
//
Процедура ПриНастройкеТаблицыТоваров(
		ДокументЗаказа,
		ОписаниеПредставленияТоваров) Экспорт
	
	
КонецПроцедуры

// Определяются данные для формирования запроса на создание/обновление онлайн-заказа.
// Все поля переменной ЗаказНаОплату (за исключением свойства ДополнительнаяИнформация) обязательны для заполнения.
//
// Параметры:
//  ДокументЗаказа - ОпределяемыйТип.ДокументОнлайнЗаказаБИП - документ, по данным которого
//    будет создан новый заказ.
//  ЗаказНаОплату - Структура - содержит описание онлайн-заказа:
//    * ОбщиеПараметрыЗаказа - Структура - описывает общие параметры заказа:
//      ** СрокЖизни - Дата - содержит значение срока жизни заказа,
//         по наступлению указанного времени заказ будет аннулирован.
//         В случае передачи значения меньше текущей даты возвращается ошибка "НеверныйФорматЗапроса".
///    * ВизуализацияЗаказа - Структура - содержит описание шапки заказа на платежной странице.
//       ** Представление - Строка - представление заказа на платежной странице.
//       ** ДополнительнаяИнформация - Строка - дополнительная информация о заказе платежной страницы.
//       ** ПоставщикПредставление - Строка - содержит данные поставщика отображаемые на странице заказа.
//       ** ПоставщикЗаголовок - Строка - представление поставщика (пример: Поставщик, Исполнитель, Продавец).
//       ** ПокупательПредставление - Строка - содержит данные покупателя отображаемые на странице заказа.
//       ** ПокупательЗаголовок - Строка - представление покупателя (пример: Покупатель, Клиент).
//    * Товары - ТаблицаЗначений - Содержит данные товарного наполнения заказа.
//      Состав колонок определяется в методе ОнлайнЗаказыПереопределяемый.ПриНастройкеТаблицыТоваров
//    * ПараметрыОплат - Структура - Содержит описание видов оплат с их параметрами:
//      ** СБП - Структура - Содержит описание параметров оплаты СБП по вариантам сценария,
//         Неопределено, если подсистема не внедрена:
//        *** c2b - Структура, Неопределено - Содержит описание параметров оплаты СБП сценарию c2b,
//            Неопределено, если подсистема не внедрена или сценарий не используется:
//          **** НазначениеПлатежа - Строка - информация о платеже, которая будет отображена пользователю
//               в момент сканирования QR-кода в мобильном приложении. Рекомендуется
//               делать строку не длинной и включать информацию об организации, которая
//               является получателем денежных средств, например: Оплата СБП 524,00 RUB ООО Ромашка
//               Если строка не заполнена, будет передано стандартное представление
//               назначения: Оплата СБП {ЗаказНаОплату.ВизуализацияЗаказа.Представление}.
//               Длина строки не должна превышать 140 символов, в противном случае будет
//               обрезана принудительно. Система быстрых платежей имеет дополнительные требования
//               к символам и их кодировке. Возможна передача следующих значений:
//                 - символы латинского алфавита (A-Z и a-z) с десятичными кодами из диапазонов
//                 [065-090] и [097-122] в кодировке UTF-8;
//                 - символы русского алфавита (А-Я и а-я) с десятичными кодами из диапазона
//                 [1040-1103] в кодировке UTF-8;
//                 - цифры 0-9 с десятичными кодами из диапазона [048-057] в кодировке UTF-8;
//                 - специальные символы с десятичными кодами из диапазонов [032-047], [058-064],
//                 [091-096], [123-126] в кодировке UTF-8;
//                 - символ "№" под номером 8470 в кодировке UTF-8.
//          **** ШаблоныНазначения - ТаблицаЗначений - настройки заполнения шаблонов платежей:
//            ***** ОбъектМетаданных - Строка - имя объекта метаданных операции.
//            ***** Идентификатор - Строка - идентификатор шаблона.
//            ***** Наименование - Строка - наименование шаблона для пользователя.
//            ***** Параметры -Массив Из Структура - параметры заполнения шаблона:
//              ****** Наименование - Строка - наименование параметра для пользователя.
//              ****** Идентификатор - Строка - идентификатор параметра для заполнения.
//
Процедура ПриФормированииЗаказаНаОплату(ДокументЗаказа, ЗаказНаОплату) Экспорт
	
	
КонецПроцедуры

// Определяет алгоритм обработки операций онлайн-заказов.
//
// Параметры:
//  ДокументЗаказа - ОпределяемыйТип.ДокументОнлайнЗаказаБИП - документ основание заказа;
//  СтатусЗаказа - Строка - Статус заказа, может принимать следующие значения: "Оплачен", "ИстекСрокЖизни";
//  ПараметрыОплаты - Соответствие - содержит данные оплаты заказа:
//    * Ключ - Идентификатор типа оплаты может принимать следующие значения:
//        - "СБПc2b" - оплата через систему быстрых платежей (c2b).
//    * Значение - Структура - содержит данные оплаты, может принимать следующие значения:
//        - Для случая когда ключ имеет значение равное "СБПc2b":
//          ** НастройкаПодключения - СправочникСсылка.НастройкиПодключенияКСистемеБыстрыхПлатежей - настройка выполнения операции.
//          ** РезультатОбработки - Структура - результат загрузки статуса операции:
//            *** СообщениеОбОшибке - Строка - сообщение пользователю. Заполняется в случае ошибки.
//            *** СтатусОперации - Строка - текущее состояние операции. Возможные значения:
//                "Отменена" - по ранее сформированная операция отменена НСПК.
//                "Выполнена" - участник СБП подтвердил выполнение операции.
//            *** ПараметрыОперации - Структура - дополнительные данные по оплате:
//              **** ДатаОперации - Дата - фактическая дата оплаты в UTC;
//              **** СуммаОперации - Число - фактическая суммы операции по документу;
//              **** ИдентификаторОперации - Строка - идентификатор сформированной операции;
//              **** ДокументЧастичнойОплаты - Документ.ПлатежнаяСсылкаСБПc2b - документ частичной оплаты;
//              **** ИдентификаторОплаты- Строка - идентификатор оплаты.
//  Обработан - Булево - признак обработки операции. Необходимо установить Истина,после завершения обработки.
//
Процедура ПриЗагрузкеСтатусаЗаказа(
		ДокументЗаказа,
		СтатусЗаказа,
		ПараметрыОплаты,
		Обработан) Экспорт
	
	
КонецПроцедуры

// Определяет представление основания заказа для отображения пользователю на форме отправки ссылки
// и на странице онлайн-заказа
//
// Параметры:
//  ДокументЗаказа - ОпределяемыйТип.ДокументОнлайнЗаказаБИП - документ основание заказа,
//  для которого необходимо определить представление.
//  ПредставлениеОснования - Структура - Содержит описание представлений основания заказа:
//    * РезультатСклонения - Структура - Содержит данные склонения представления по падежам:
//      * ИменительныйПадеж - Строка - Представления основания в именительном падеже;
//      * РодительныйПадеж - Строка - Представление Основания в родительном падеже;
//      * ДательныйПадеж - Строка - Представление Основания в дательном падеже;
//      * ВинительныйПадеж - Строка - Представление Основания в винительном падеже;
//      * ТворительныйПадеж - Строка - Представление Основания в творительном падеже;
//      * ПредложныйПадеж - Строка - Представление Основания в винительном падеже.
// ДанныеОснования - Структура - Содержит описание данных заказа:
//   * НомерЗаказа - Строка - номер заказа.
//
Процедура ПриОпределенииПредставленияОснованияЗаказа(
	ДокументЗаказа,
	ПредставлениеОснования,
	ДанныеОснования) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область ШаблоныСообщений

// Возвращает признак использования шаблонов сообщений для работы с онлайн-заказами.
//
// Параметры:
//  Используется - Булево - признак использования шаблонов сообщений.
//
//@skip-warning
Процедура ПриПроверкеИспользованияШаблоновСообщенийОнлайнЗаказов(Используется) Экспорт
	
	
КонецПроцедуры

// Описывает предопределенные шаблоны писем по типу,
// с помощью которых можно будет выставлять онлайн-заказы для оплаты.
// Эти шаблоны будут доступны для создания из основной формы настроек и использоваться
// в форме формирования платежной ссылки онлайн-заказов.
//
// Параметры:
//  Шаблоны - Массив - Массив структур данных, описывающих предопределенные шаблоны сообщения.
//    * ПолноеИмяТипаНазначения - Строка - Полное имя объекта метаданных, на основании которого по данному шаблону
//        будут создаваться письма.
//    * Текст - Строка - Текст, который будет использоваться в качестве шаблона письма в формате HTML.
//    * Тема - Строка - Текст, который будет использоваться в качестве шаблона темы письма.
//    * Наименование - Строка - Текст, наименование шаблона письма.
//    * ТипШаблона - Строка - Тип шаблона. Возможные значения:"Почта" или "SMS".
//
//@skip-warning
Процедура ПриОпределенииПредопределенныхШаблоновСообщенийОнлайнЗаказовПоТипам(Шаблоны) Экспорт
	
	
КонецПроцедуры

// Определяет параметры отправки сообщений с использованием шаблонов онлайн-заказов.
//
// Параметры:
//  ПараметрыОтправкиСообщений - Структура - описание параметров отправки сообщений:
//    * ПараметрыОтправкиПисем - Структура - описание параметров отправки электронных писем:
//       ** ОтправлятьПисьмаВФорматеHTML - Булево, Неопределено - признак отправки электронных писем в формате HTML.
//          Если свойство не задано, в дальнейшем при наличии подсистемы "Взаимодействия" будет получено значение
//          функциональной опции "ОтправлятьПисьмаВФорматеHTML", либо Ложь при ее отсутствии.
//
//@skip-warning
Процедура ПриОпределенииПараметровОтправкиСообщений(
		ПараметрыОтправкиСообщений) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область ОтправкаСообщений

// Заполняет список получателей сообщения с URL онлайн-заказа.
//
// Параметры:
//  ДокументЗаказа - Произвольный - документ основание онлайн-заказа.
//  ВариантОтправки - Строка - способ отправки ссылки. "ЭлектроннаяПочта" - по электронной почте, "Телефон" - по SMS.
//  Получатели - СписокЗначений - адреса электронной почты или номера телефонов получателей (строка).
//
//@skip-warning
Процедура ПриФормированииСпискаПолучателейСообщенияОнлайнЗаказов(
		Знач ДокументЗаказа,
		Знач ВариантОтправки,
		Получатели) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

