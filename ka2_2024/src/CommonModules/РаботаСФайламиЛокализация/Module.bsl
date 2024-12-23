
#Область ПрограммныйИнтерфейс

// Переопределение настроек присоединенных файлов.
//
// см. РаботаСФайламиПереопределяемый.ПриОпределенииНастроек
//
Процедура ПриОпределенииНастроек(Настройки) Экспорт
	
	//++ Локализация
	
	// ЭлектронноеВзаимодействие
	ЭлектронноеВзаимодействие.ПриОпределенииНастроек(Настройки);
	// Конец ЭлектронноеВзаимодействие
	
	ИнтеграцияЕГАИС.ПриОпределенииНастроекРаботыСФайлами(Настройки);
	ИнтеграцияВЕТИС.ПриОпределенииНастроекРаботыСФайлами(Настройки);
	ИнтеграцияИСМП.ПриОпределенииНастроекРаботыСФайлами(Настройки);
	ИнтеграцияЗЕРНО.ПриОпределенииНастроекРаботыСФайлами(Настройки);
	ИнтеграцияСАТУРН.ПриОпределенииНастроекРаботыСФайлами(Настройки);
	
	//-- Локализация
		
КонецПроцедуры

// Позволяет переопределить справочники хранения файлов по типам владельцев.
// 
// см. РаботаСФайламиПереопределяемый.ПриОпределенииСправочниковХраненияФайлов
//
Процедура ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников) Экспорт
	
	//++ Локализация

	//++ НЕ УТ
	ЭлектронныйДокументооборотСКонтролирующимиОрганами.ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников);
	//-- НЕ УТ
	
	//++ НЕ ГОСИС
	ИнтеграцияГИСМ.ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников);
	ИнтеграцияИСМП.ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников);
	ИнтеграцияЕГАИС.ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников);
	ИнтеграцияВЕТИС.ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников);
	ИнтеграцияЗЕРНО.ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников);
	ИнтеграцияСАТУРН.ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников);
	//-- НЕ ГОСИС
	
	//++ НЕ УТ

	// Универсальный обмен с банками
	УниверсальныйОбменСБанками.ПриОпределенииСправочниковХраненияФайлов(ТипВладелецФайла, ИменаСправочников);
	// Конец универсальный обмен с банками

	//-- НЕ УТ

	//-- Локализация
	
КонецПроцедуры

#КонецОбласти