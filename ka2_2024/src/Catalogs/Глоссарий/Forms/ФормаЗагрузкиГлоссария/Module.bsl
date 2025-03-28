
#Область ОБработчикиКомандФормы

&НаКлиенте
Процедура ЗагрузитьГлоссарий(Команда)
	
	ОчиститьСообщения();
	
	РезультатЗагрузки = РезультатЗагрузкиНаСервере();
	
	ТекстОповещения = НСтр("ru = 'Загрузка глоссариев'"); 
	
	Если РезультатЗагрузки.Загружено = 0 Тогда
		
		ТекстПояснения = НСтр("ru = 'Ни один глоссарий не загружен'");
		
	Иначе
		
		ТекстПояснения = СтрШаблон(НСтр("ru = 'Загружено глоссариев %1 из %2'"), РезультатЗагрузки.Загружено, РезультатЗагрузки.ВсегоКЗагрузке);
		
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(ТекстОповещения, , ТекстПояснения, БиблиотекаКартинок.Информация32);
	
	Для Каждого ТекстОшибки Из РезультатЗагрузки.Ошибки Цикл
		
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстОшибки);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция РезультатЗагрузкиНаСервере()
	
	Результат = Новый Структура;
	Результат.Вставить("Успешно",       Истина);
	Результат.Вставить("Ошибки",         Новый Массив);
	Результат.Вставить("Загружено",      0);
	Результат.Вставить("ВсегоКЗагрузке", 0);
	
	РезультатФормирования = РезультатФормированияТаблицыЗначенийИзТабличногоДокумента(ТабличныйДокумент);
	Если РезультатФормирования.ТаблицаЗначений = Неопределено Тогда 
		
		Результат.Ошибки.Добавить(РезультатФормирования.ТекстОшибки);
		Результат.Успешно = Ложь; 
		
		Возврат Результат;
	КонецЕсли;
	
	ТаблицаДанных = РезультатФормирования.ТаблицаЗначений; 
	
	Если ТаблицаДанных.Колонки.Найти("Наименование") = Неопределено Тогда
		
		ТекстОшибки = НСтр("ru = 'В таблице данных не найдена колонка ""Наименование""'");
		Результат.Ошибки.Добавить(ТекстОшибки);
		Результат.Успешно = Ложь;
		
	ИначеЕсли Не ЗначениеЗаполнено(ТаблицаДанных.Колонки.Наименование.ТипЗначения) Тогда
		
		ТекстОшибки = НСтр("ru = 'Не указано ни одно значение в колонке ""Наименование""'");
		Результат.Ошибки.Добавить(ТекстОшибки);
		Результат.Успешно = Ложь; 
		
		Возврат Результат;
			
	КонецЕсли;
	
	Если ТаблицаДанных.Колонки.Найти("Описание") = Неопределено Тогда
		
		ТекстОшибки = НСтр("ru = 'В таблице данных не найдена колонка ""Описание""'");
		Результат.Ошибки.Добавить(ТекстОшибки);
		Результат.Успешно = Ложь;
		
	ИначеЕсли Не ЗначениеЗаполнено(ТаблицаДанных.Колонки.Описание.ТипЗначения) Тогда
		
		ТекстОшибки = НСтр("ru = 'Не указано ни одно значение в колонке ""Описание""'");
		Результат.Ошибки.Добавить(ТекстОшибки);
		Результат.Успешно = Ложь; 
		
		Возврат Результат;
		
	КонецЕсли;
	
	Если Не Результат.Успешно Тогда
		Возврат Результат;
	КонецЕсли;
	
	КодТекущегоЯзыка =  ТекущийЯзык().КодЯзыка;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТаблицаДанных.Наименование КАК Наименование,
		|	ТаблицаДанных.Описание     КАК Описание
		|ПОМЕСТИТЬ ТаблицаДанных
		|ИЗ
		|	&ТаблицаДанных КАК ТаблицаДанных
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТаблицаДанных.Наименование                           КАК Наименование,
		|	ТаблицаДанных.Описание                               КАК Описание,
		|	Глоссарий.Ссылка КАК Ссылка
		|ИЗ
		|	ТаблицаДанных КАК ТаблицаДанных
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Глоссарий КАК Глоссарий
		|		ПО ТаблицаДанных.Наименование = Глоссарий.Наименование";
	
	Запрос.УстановитьПараметр("ТаблицаДанных", ТаблицаДанных);
	
	ВыборкаДетальныеЗаписи = Запрос.Выполнить().Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		Результат.ВсегоКЗагрузке = Результат.ВсегоКЗагрузке + 1;
		
		НачатьТранзакцию();
		
		Попытка
		
			Если ЗначениеЗаполнено(ВыборкаДетальныеЗаписи.Ссылка) Тогда
				
				Если ПерезаполнятьСуществующие Тогда
					
						Блокировка = Новый БлокировкаДанных;
						ЭлементБлокировки = Блокировка.Добавить(ВыборкаДетальныеЗаписи.Ссылка.Метаданные().ПолноеИмя());
						ЭлементБлокировки.УстановитьЗначение("Ссылка", ВыборкаДетальныеЗаписи.Ссылка);
						Блокировка.Заблокировать();
						
						ГлоссарийОбъект = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
						
				Иначе
					Продолжить;
				КонецЕсли;
				
			Иначе
				ГлоссарийОбъект = Справочники.Глоссарий.СоздатьЭлемент();
			КонецЕсли;
				
			ГлоссарийОбъект.Наименование = ВыборкаДетальныеЗаписи.Наименование;
			ДокументОписания = Новый ФорматированныйДокумент;
			ДокументОписания.Добавить(ВыборкаДетальныеЗаписи.Описание);
			
			НоваяСтрока = ГлоссарийОбъект.ОписанияГлоссария.Добавить();
			НоваяСтрока.КодЯзыка = КодТекущегоЯзыка;
			НоваяСтрока.Описание = Новый ХранилищеЗначения(ДокументОписания);
			
			ГлоссарийОбъект.Записать();
			Результат.Загружено = Результат.Загружено + 1;
			
			ЗафиксироватьТранзакцию();
		
		Исключение
			
			ОтменитьТранзакцию();
			
			ТекстОшибки = СтрШаблон(НСтр("ru = 'Не удалось записать глоссарий с наименованием ""%1"" по причине -  %2'"),
			                        ВыборкаДетальныеЗаписи.Ссылка, ОбработкаОшибок.КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
			Результат.Ошибки.Добавить(ТекстОшибки);
		
		КонецПопытки;
		
	КонецЦикла; 
	
	Возврат Результат;
		
КонецФункции

// Генерирует таблицу значений из табличного документа
// 
// Параметры:
//  ТабличныйДокумент - ТабличныйДокумент - из которого получается таблица значений
// 
// Возвращаемое значение:
//  Структура - Результат формирования таблицы значений из табличного документа:
// * ТаблицаЗначений - Неопределено, ТаблицаЗначений - сформированная таблица значений.
// * ТекстОшибки     - Строка - текст ошибки, если операция завершилась неудачно.
//
&НаСервере
Функция РезультатФормированияТаблицыЗначенийИзТабличногоДокумента(ТабличныйДокумент) 
	
	Результат = Новый Структура;
	Результат.Вставить("ТаблицаЗначений", Неопределено);
	Результат.Вставить("ТекстОшибки",     "");
	
	ПоследняяСтрока = ТабличныйДокумент.ВысотаТаблицы;
	ПоследняяКолонка = ТабличныйДокумент.ШиринаТаблицы;
	
	Если ПоследняяКолонка = 0 
		Или ПоследняяСтрока = 0 Тогда
		
		Результат.ТекстОшибки = НСтр("ru = 'В таблице не введены загружаемые данные'");
		Возврат Результат;
		
	КонецЕсли;
	ОбластьЯчеек = ТабличныйДокумент.Область(1, 1, ПоследняяСтрока, ПоследняяКолонка);
	
	Попытка
	
		ИсточникДанных = Новый ОписаниеИсточникаДанных(ОбластьЯчеек);
		// Создаем объект для интеллектуального построения отчетов,
		// указываем источник данных и выполняем построение отчета.
		ПостроительОтчета = Новый ПостроительОтчета;
		ПостроительОтчета.ИсточникДанных = ИсточникДанных;
		ПостроительОтчета.Выполнить();
		// Результат выгружаем в таблицу значений.
		Результат.ТаблицаЗначений = ПостроительОтчета.Результат.Выгрузить();
	
	Исключение
		
		Результат.ТекстОшибки = НСтр("ru = 'Данные в таблице указаны неверно. В первой строке, начиная с первой колонки, должны быть указаны имена колонок таблицы.
		                                   |Далее, со второй строки, загружаемые данные.'");
		Возврат Результат;
		
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти



