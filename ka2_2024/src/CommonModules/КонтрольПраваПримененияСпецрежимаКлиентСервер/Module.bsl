#Область ПрограммныйИнтерфейс

// Возвращает лимит доходов налогоплательщика для применения УСН, с учетом возможного перехода на повышенную ставку
//
// Параметры:
// Дата - дата - дата, на которую получаем лимит
//
// Возвращаемое значение:
//  Число
//
Функция ГраницаДоходовДляПримененияПовышеннойСтавкиУСН(Дата) Экспорт
	
	БазовыйЛимитДоходов = БазовыйЛимитДоходовДляПримененияПовышеннойСтавкиУСН(Дата);
	
	// Размер лимитов применения УСН индексируется на коэффициент-дефлятор ежегодно до 31 декабря текущего года.
	// Положения НК РФ, вводящие в действие прогрессивную шкалу УСН начинают действовать с 1 января 2021 года,
	// когда индексация лимитов применения УСН уже завершена.
	// Первая индексация новой границы применения УСН произойдет только к концу 2021 года на коэффициент-дефлятор, 
	// установленный на 2022 год.
	Если Год(Дата) = Год(УчетУСНКлиентСервер.ДатаНачалаПрогрессивнойШкалы()) Тогда
		Возврат БазовыйЛимитДоходов;
	Иначе
		КоэффициентДефлятор = УчетУСНКлиентСервер.КоэффициентДефлятор(Дата);
		Возврат БазовыйЛимитДоходов * КоэффициентДефлятор;
	КонецЕсли;
	
КонецФункции

// Возвращает лимит доходов налогоплательщика, ограничивающий его право на применение основной ставки налога УСН
// с учетом коэффициента дефлятора для указанной даты
// 
// Параметры:
//  Дата - Дата - Дата, на которую получаем границу.
//
// Возвращаемое значение:
//  Число 
//
Функция ГраницаДоходовДляПримененияОсновнойСтавкиУСН(Дата) Экспорт

	БазовыйЛимитДоходов = БазовыйЛимитДоходовДляПримененияОсновнойСтавкиУСН(Дата);
	
	// Коэффициент ежегодной индексации
	КоэффициентДефлятор = УчетУСНКлиентСервер.КоэффициентДефлятор(Дата);
	
	Возврат БазовыйЛимитДоходов * КоэффициентДефлятор;
	
КонецФункции

// Возвращает базовый лимит доходов налогоплательщика для применения основной ставки УСН,
// действующий на указанную дату, без учета коэффициента-дефлятора
//
// Параметры:
//  Дата - Дата - Дата, на которую получаем базовый лимит.
//
// Возвращаемое значение:
//  Число
//
Функция БазовыйЛимитДоходовДляПримененияОсновнойСтавкиУСН(Дата) Экспорт

	// Лимит доходов налогоплательщика, ограничивающий его право на применение УСН
	// п. 4 ст. 346.13 НК РФ
	БазовыйЛимит = 60000000; // в редакции Федерального закона от 25.06.2012 N 94-ФЗ
	
	Если Год(Дата) >= 2025 Тогда
		БазовыйЛимит = 450000000; // в редакции Федерального закона от 12.07.2024 № 176-ФЗ
	ИначеЕсли Год(Дата) >= 2017 Тогда
		БазовыйЛимит = 150000000; // в редакции Федерального закона от 30.11.2016 № 401-ФЗ
	КонецЕсли;
	
	Возврат БазовыйЛимит;

КонецФункции

// Возвращает базовый лимит доходов налогоплательщика для применения повышенной ставки УСН,
// действующий на указанную дату, без учета коэффициента-дефлятора
//
// Параметры:
//  Дата - Дата - Дата, на которую получаем базовый лимит.
//
// Возвращаемое значение:
//  Число
//
Функция БазовыйЛимитДоходовДляПримененияПовышеннойСтавкиУСН(Дата) Экспорт

	Если Дата >= УчетУСНКлиентСервер.ДатаНачалаПрогрессивнойШкалы() Тогда
		БазовыйЛимит = 200000000; // п. 4.1 ст. 346.13 НК РФ
	Иначе
		БазовыйЛимит = БазовыйЛимитДоходовДляПримененияОсновнойСтавкиУСН(Дата);
	КонецЕсли;
	
	Возврат БазовыйЛимит;

КонецФункции

// Возвращает лимит средней численности работников для применения УСН, с учетом возможного перехода на 
// повышенную ставку
//
// Параметры:
//  Дата - дата - дата на которую получаем лимит
//
// Возвращаемое значение:
//  Число
Функция ГраницаЧисленностиРаботниковДляПримененияПовышеннойСтавкиУСН(Дата) Экспорт
	
	Если Дата >= УчетУСНКлиентСервер.ДатаНачалаПрогрессивнойШкалы() Тогда
		// п. 4 ст. 346.13 НК РФ
		СредняяЧисленность = 130;
	Иначе
		СредняяЧисленность = ГраницаЧисленностиРаботниковДляПримененияОсновнойСтавкиУСН(Дата);
	КонецЕсли;
	
	Возврат СредняяЧисленность;
	
КонецФункции

// Возвращает лимит средней численности работников
// 
// Параметры:
//  Дата - Дата - Дата, на которую необходимо получить Границу среднесписочной численности работников
// 
// Возвращаемое значение:
//  Число - Граница среднесписочной численности работников, ограничивающая право применения УСН
Функция ГраницаЧисленностиРаботниковДляПримененияОсновнойСтавкиУСН(Дата) Экспорт
	
	// Лимит средней численности работников за налоговый период.
	// см пп. 15 п. 3 ст. 346.12 НК РФ.
	Если Год(Дата) >= 2025 Тогда
		Возврат 130;
	Иначе
		Возврат 100; 
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает признак того, что показатель приближается к границе, за которой следует повышение ставки УСН,
// а не переход с УСН на другую систему налогообложения
//
// Параметры:
//  Показатель - число - значение числового показателя
//  НижняяГраница - число - значение границы, после которой следует повышение ставки УСН
//  ВерхняяГраница - число - значение границы, после которой следует переход с УСН на другую систему налогообложения.
//                   Если значения нижней и верхней границ равны между собой, то повышение ставки не применяется
//
// Возвращаемое значение:
//  Булево - истина, если после пересечения границы последует повышение ставки УСН
//           ложь, если после пересечения границы последует переход с УСН на другую систему налогообложения
//
Функция ПредупреждатьОВозможномПримененииПовышеннойСтавки(Показатель, НижняяГраница, ВерхняяГраница) Экспорт
	
	Если ВерхняяГраница > НижняяГраница Тогда
		Возврат Показатель <= НижняяГраница;
	Иначе
		Возврат Ложь;
	КонецЕсли
	
КонецФункции

#КонецОбласти