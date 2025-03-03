#Область СлужебныйПрограммныйИнтерфейс

// Заполняет параметры работы клиента на сервере
// При использовании БСП процедуру требуется вызвать из процедуры 
// ОбщегоНазначенияПереопределяемый.ПриДобавленииПараметровРаботыКлиента()
//
// Параметры:
//   Параметры - Структура:
//    * ИдентификаторКлиента - Строка - (входящий) идентификатор рабочего места клиента
//    * ОборудованиеДляПереустановки - Массив из Структура - имена макетов для переустановки внешних компонент
//    * ИдентификаторОбсужденияРаспределеннойФискализации - ИдентификаторОбсужденияСистемыВзаимодействия -
Процедура ПриДобавленииПараметровРаботыКлиентаПриЗапуске(Параметры) Экспорт
	
	ИнтеграцияПодсистемБПО.ПриДобавленииПараметровРаботыКлиентаПриЗапуске(Параметры);
	
КонецПроцедуры

#КонецОбласти
