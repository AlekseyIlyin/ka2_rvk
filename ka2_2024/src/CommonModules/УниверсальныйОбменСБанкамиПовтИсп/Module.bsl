Функция ЭтоОблачныйСертификатПользователя(ОтпечатокИлиСерийныйНомер, Издатель = "", ПоискПоСерийномуНомеру = Ложь) Экспорт
	
	Если НЕ УниверсальныйОбменСБанками.ДоступнаОблачнаяКриптография() Тогда
		// При отсутствии сервиса криптографии все сертификаты считаются локальными.
		Возврат Ложь;
	КонецЕсли;
	
	Сертификат = УниверсальныйОбменСБанками.НайтиОблачныйСертификатВХранилище(ОтпечатокИлиСерийныйНомер, Издатель, ПоискПоСерийномуНомеру);
	Возврат Сертификат <> Неопределено;
	
КонецФункции

// Извлекает данные сервиса из макета и формирует
// структуру с информацией о сервисе.
Функция ИзвлечьОписаниеДокументооборотовСервиса(Сервис) Экспорт
	
	Макет = УниверсальныйОбменСБанками.МакетСервиса(Сервис);
	
	ДеревоОписания = Новый ДеревоЗначений;
	
	Результат = Новый Структура;
	Результат.Вставить("ДеревоОписания",          ДеревоОписания);
	Результат.Вставить("ТранзакцияВСтроку",       Новый Соответствие);
	Результат.Вставить("ТранзакцияИзСтроки",      Новый Соответствие);
	Результат.Вставить("ДокументооборотВСтроку",  Новый Соответствие);
	Результат.Вставить("ДокументооборотИзСтроки", Новый Соответствие);
	Результат.Вставить("ДокументВСтроку",         Новый Соответствие);
	Результат.Вставить("ДокументИзСтроки",        Новый Соответствие);
	Результат.Вставить("ТранзакцияВКод",          Новый Соответствие);
	Результат.Вставить("ДокументооборотВКод",     Новый Соответствие);
	Результат.Вставить("ДокументВКод",            Новый Соответствие);
	Результат.Вставить("ТранзакцияИзКода",        Новый Соответствие);
	Результат.Вставить("ДокументооборотИзКода",   Новый Соответствие);
	Результат.Вставить("ДокументИзКода",          Новый Соответствие);
	
	ДеревоОписания.Колонки.Добавить("Тип");
	ДеревоОписания.Колонки.Добавить("НеИспользуется");
	ДеревоОписания.Колонки.Добавить("ЗначениеПеречисления");
	
	ВысотаТаблицы = Макет.ВысотаТаблицы;
	
	УчтенныеГруппы = Новый Соответствие;
	КолонкаТип = 1;
	КолонкаКод = 2;
	КолонкаНеИспользуется = 3;
	КолонкаЗначениеПеречисления = 4;
	Для Уровень = 0 По Макет.КоличествоУровнейГруппировокСтрок() - 1 Цикл
		Макет.ПоказатьУровеньГруппировокСтрок(Уровень);
		Для НомерСтроки = 2 По ВысотаТаблицы Цикл
			НомерСтрокиДанных = ВысотаТаблицы - НомерСтроки + 2;
			Если Макет.Область(НомерСтрокиДанных, 0, НомерСтрокиДанных, 0).Видимость И УчтенныеГруппы.Получить(НомерСтрокиДанных) = Неопределено Тогда
				
				РодительскийУзел = ДеревоОписания;
				Если Уровень <> 0 Тогда
					Для Инд = 1 По НомерСтрокиДанных - 2 Цикл
						Узел = УчтенныеГруппы.Получить(НомерСтрокиДанных - Инд);
						Если Узел <> Неопределено Тогда
							РодительскийУзел = Узел;
							Прервать;
						КонецЕсли;
					КонецЦикла;
				КонецЕсли;
				
				НоваяСтрока = РодительскийУзел.Строки.Вставить(0);
				Тип = СокрЛП(Макет.Область(НомерСтрокиДанных, КолонкаТип, НомерСтрокиДанных, КолонкаТип).Текст);
				НоваяСтрока.Тип = Тип;
				НеИспользуется = СокрЛП(Макет.Область(НомерСтрокиДанных, КолонкаНеИспользуется, НомерСтрокиДанных, КолонкаНеИспользуется).Текст) = "+";
				НоваяСтрока.НеИспользуется = НеИспользуется;
				ТипЗначениеПеречисления = СокрЛП(
					Макет.Область(НомерСтрокиДанных, КолонкаЗначениеПеречисления, НомерСтрокиДанных, КолонкаЗначениеПеречисления).Текст);
				ЗначениеПеречисления = ПредопределенноеЗначение("Перечисление." + ТипЗначениеПеречисления);
				НоваяСтрока.ЗначениеПеречисления = ЗначениеПеречисления;
				Код = СокрЛП(Макет.Область(НомерСтрокиДанных, КолонкаКод, НомерСтрокиДанных, КолонкаКод).Текст);
				
				Если НЕ НеИспользуется Тогда
					Если Уровень = 0 Тогда
						СоответствиеВСтроку = Результат.ДокументооборотВСтроку;
						СоответствиеИзСтроки = Результат.ДокументооборотИзСтроки;
						СоответствиеВКод = Результат.ДокументооборотВКод;
						СоответствиеИзКода = Результат.ДокументооборотИзКода;
					ИначеЕсли Уровень = 1 Тогда
						СоответствиеВСтроку = Результат.ТранзакцияВСтроку;
						СоответствиеИзСтроки = Результат.ТранзакцияИзСтроки;
						СоответствиеВКод = Результат.ТранзакцияВКод;
						СоответствиеИзКода = Результат.ТранзакцияИзКода;
					ИначеЕсли Уровень = 2 Тогда
						СоответствиеВСтроку = Результат.ДокументВСтроку;
						СоответствиеИзСтроки = Результат.ДокументИзСтроки;
						СоответствиеВКод = Результат.ДокументВКод;
						СоответствиеИзКода = Результат.ДокументИзКода;
					КонецЕсли;
					
					СоответствиеИзСтроки.Вставить(Тип, ЗначениеПеречисления);
					СоответствиеВСтроку.Вставить(ЗначениеПеречисления, Тип);
					СоответствиеВКод.Вставить(ЗначениеПеречисления, Код);
					СоответствиеИзКода.Вставить(Код, ЗначениеПеречисления);
				КонецЕсли;
				УчтенныеГруппы.Вставить(НомерСтрокиДанных, НоваяСтрока);
				
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Возвращает адреса серверов меток времени в порядке, требуемом банками. 
// И добавляет в него отсутствующие адреса из ЭлектроннаяПодпись.ОбщиеНастройки().АдресаСерверовМетокВремени
Функция АдресаСерверовМетокВремени() Экспорт
	
	Возврат ЭлектроннаяПодпись.ОбщиеНастройки().АдресаСерверовМетокВремени;
	
КонецФункции
