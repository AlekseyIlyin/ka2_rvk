#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Сервисная экспортная функция. Вызывается в основной программе при регистрации обработки в информационной базе
// Возвращает структуру с параметрами регистрации
//
// Возвращаемое значение:
//		Структура:
//			* Вид - Строка - вид обработки, один из возможных: "ДополнительнаяОбработка", "ДополнительныйОтчет", 
//					"ЗаполнениеОбъекта", "Отчет", "ПечатнаяФорма", "СозданиеСвязанныхОбъектов"
//			* Назначение - Массив строк имен объектов метаданных в формате: 
//					<ИмяКлассаОбъектаМетаданного>.[ * | <ИмяОбъектаМетаданных>]. 
//					Например, "Документ.СчетЗаказ" или "Справочник.*". Параметр имеет смысл только для назначаемых обработок, для глобальных может не задаваться.
//			* Наименование - строка - Наименование обработки, которым будет заполнено наименование элемента справочника по умолчанию.
//			* Информация  - строка - Краткая информация или описание по обработке.
//			* Версия - строка - Версия обработки в формате “<старший номер>.<младший номер>” используется при загрузке обработок в информационную базу.
//			* БезопасныйРежим - булево - Принимает значение Истина или Ложь, в зависимости от того, требуется ли устанавливать или отключать безопасный режим 
//							исполнения обработок. Если истина, обработка будет запущена в безопасном режиме. 
//
Функция СведенияОВнешнейОбработке() Экспорт
 
	Версия = "1.0"; 
	
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке(СтандартныеПодсистемыСервер.ВерсияБиблиотеки()); 
	ПараметрыРегистрации.Наименование = НСтр("ru = 'ВосстановлениеПоследовательности'");
	ПараметрыРегистрации.Информация = НСтр("ru = 'Восстановление последовательности'");
	ПараметрыРегистрации.Вид = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
	ПараметрыРегистрации.Версия = Версия;
	ПараметрыРегистрации.БезопасныйРежим = Ложь;	
// 
// 	Команда = ПараметрыРегистрации.Команды.Добавить();
// 	Команда.Представление = "Открытие формы обработки...";
//	Команда.Идентификатор = "ВыполнитьДлительнуюОперацию";
//	Команда.Использование = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
//	Команда.ПоказыватьОповещение = Ложь; 	
 
    Возврат ПараметрыРегистрации;

КонецФункции

Функция ВыполнитьДлительнуюОперацию(ПараметрыОбработки, АдресРезультата) Экспорт
	
	Возврат усУправлениеПоследовательностью.ВосстановитьПоследовательность();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

#КонецЕсли