#Область СлужебныйПрограммныйИнтерфейс

// Добавляет в переданный массив имена неиспользуемых документов
// 
// Параметры:
// 	ИменаДокументов - Массив из Строка - имена неиспользуемых документов
//
Процедура ДополнитьИменаНеиспользуемыхДокументов(ИменаДокументов) Экспорт
	
	//++ Локализация
	
	МетаданныеДокументы = Метаданные.Документы;
	
	//++ НЕ УТ
	
	ИменаДокументов.Добавить(МетаданныеДокументы.ВозвратМатериаловИзПроизводства.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ВыпускПродукции.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПередачаМатериаловВПроизводство.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПеремещениеМатериаловВПроизводстве.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.СписаниеЗатратНаВыпуск.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.АмортизацияНМА.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.АмортизацияОС.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ВводОстатковВнеоборотныхАктивов.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ВозвратОСИзАренды.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ИзменениеПараметровНМА.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ИзменениеПараметровОС.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ИзменениеСостоянияОС.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.МодернизацияОС.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПередачаОСВАренду.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПеремещениеОС.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПереоценкаНМА.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПереоценкаОС.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПодготовкаКПередачеНМА.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПодготовкаКПередачеОС.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПринятиеКУчетуНМА.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.ПринятиеКУчетуОС.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.СписаниеНМА.Имя);
	ИменаДокументов.Добавить(МетаданныеДокументы.СписаниеОС.Имя);
	
	//-- НЕ УТ
	
	//-- Локализация
	
КонецПроцедуры

// Добавляет в переданный массив типы документов ввода начальных остатков
// 
// Параметры:
// 	ТипыДокументов - Массив из Тип - типы документов ввода начальных остатков
//
Процедура ДополнитьТипыДокументовВводаОстатков(ТипыДокументов) Экспорт
	
	//++ Локализация
	
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ВводОстатковНДСПредъявленного"));
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ВводОстатковТМЦВЭксплуатации"));
	
	//++ НЕ УТ
	
	ТипыДокументов.Добавить(Тип("ДокументСсылка.ВводОстатковРасходовПриУСН"));
	
	//-- НЕ УТ
	
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти