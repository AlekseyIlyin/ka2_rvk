#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ВариантыОтчетов

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ЗадолженностьПоЗарплате");
	НастройкиВарианта.Описание =
		НСтр("ru = 'Задолженность перед сотрудниками с историей формирования задолженности 
		|по месяцам периода.'");
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ЗадолженностьВРазрезеИсточниковФинансирования");
	НастройкиВарианта.Описание =
		НСтр("ru = 'Задолженность перед сотрудниками с историей формирования задолженности 
		|по месяцам периода в разрезе источников финансирования.'");
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ЗадолженностьВРазрезеВидовДоходовИсполнительногоПроизводства");
	НастройкиВарианта.Описание =
		НСтр("ru = 'Задолженность перед сотрудниками с историей формирования задолженности 
		|по месяцам периода в разрезе видов доходов исполнительного производства.'");
		
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВариантыОтчетов

#КонецОбласти

#КонецОбласти

#КонецЕсли