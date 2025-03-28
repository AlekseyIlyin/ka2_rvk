#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	КадровыйУчетРасширенныйВызовСервера.ОбработкаПолученияДанныхВыбораПеречисленияВидыДоговоровССотрудниками(ДанныеВыбора, Параметры, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Для методов служебного API использование не контролируем          
// АПК:581-выкл 
// АПК:299-выкл

Функция ДоступныеВидыДоговоров(ГруппаДоговоров) Экспорт
	
	Если ГруппаДоговоров = Неопределено Тогда
		ГруппаДоговоров = "Все";
	КонецЕсли;
	
	// Формируем массив групп операций, по которым осуществляется отбор.
	ГруппыДоговоров = Новый Массив;
	Если ТипЗнч(ГруппаДоговоров) = Тип("ФиксированныйМассив") Тогда
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ГруппыДоговоров, ГруппаДоговоров);
	Иначе
		ГруппыДоговоров.Добавить(ГруппаДоговоров);
	КонецЕсли;
	
	ДоступныеВидыДоговоров = Новый Массив;
	
	Если ГруппыДоговоров.Найти("Все") <> Неопределено Или ГруппыДоговоров.Найти("РаботникиИСлужащие") <> Неопределено Тогда
		
		ДоступныеВидыДоговоров.Добавить(Метаданные.Перечисления.ВидыДоговоровССотрудниками.ЗначенияПеречисления.ТрудовойДоговор);
		
		Если ПолучитьФункциональнуюОпцию("ИспользоватьГосударственнуюСлужбу") Тогда
			ДоступныеВидыДоговоров.Добавить(Метаданные.Перечисления.ВидыДоговоровССотрудниками.ЗначенияПеречисления.КонтрактГосслужащего);
		КонецЕсли;
		
		Если ПолучитьФункциональнуюОпцию("ИспользоватьМуниципальнуюСлужбу") Тогда
			ДоступныеВидыДоговоров.Добавить(Метаданные.Перечисления.ВидыДоговоровССотрудниками.ЗначенияПеречисления.ДоговорМуниципальногоСлужащего);
		КонецЕсли;
		
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("ГосударственнаяСлужба");
		Модуль.ДобавитьДоступныеВидыДоговоровССотрудникамиПоНастройкам(ДоступныеВидыДоговоров, ГруппыДоговоров);
	КонецЕсли;
	
	Возврат ДоступныеВидыДоговоров;
	
КонецФункции

Функция ВидыДоговоровВоеннойСлужбы() Экспорт
	
	МассивДоговоров = Новый Массив;
	МассивДоговоров.Добавить(Перечисления.ВидыДоговоровССотрудниками.ВоеннослужащийПоПризыву);
	МассивДоговоров.Добавить(Перечисления.ВидыДоговоровССотрудниками.КонтрактВоеннослужащего);
	
	Возврат МассивДоговоров;
	
КонецФункции

Функция ВидыДоговоровКромеВоеннойСлужбы() Экспорт
	
	ВидыДоговоровВоеннойСлужбы = ВидыДоговоровВоеннойСлужбы();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВидыДоговоровССотрудниками.Ссылка
	|ИЗ
	|	Перечисление.ВидыДоговоровССотрудниками КАК ВидыДоговоровССотрудниками
	|ГДЕ
	|	НЕ ВидыДоговоровССотрудниками.Ссылка В (&МассивВидовДоговоров)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(Перечисление.ВидыДоговоровССотрудниками.ПустаяСсылка)";
	
	Запрос.УстановитьПараметр("МассивВидовДоговоров", ВидыДоговоровВоеннойСлужбы);
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
		
КонецФункции

Функция ВидыДоговоровГражданскойИВедомственнойСлужбы() Экспорт
	
	ВидыДоговоров = ВидыДоговоровКромеВоеннойСлужбы();
	ВидыДоговоров.Добавить(Перечисления.ВидыДоговоровССотрудниками.КонтрактВоеннослужащего);	
	
	Возврат ВидыДоговоров;
		
КонецФункции

Функция ЭтоДоговорСлужащего(ВидДоговора) Экспорт
	Возврат ВидДоговора = КонтрактГосслужащего Или ВидДоговора = ДоговорМуниципальногоСлужащего;
КонецФункции

// АПК:299-вкл
// АПК:581-вкл

#КонецОбласти

#КонецЕсли