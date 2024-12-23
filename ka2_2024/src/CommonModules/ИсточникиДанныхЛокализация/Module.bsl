#Область СлужебныйПрограммныйИнтерфейс

// Добавляет аналитику бюджетирования по типу данных учета.
// 
// Параметры:
//  ТипДанныхУчета - ПеречислениеСсылка.ТипыДанныхУчета
//  СтруктураАналитики - Структура
//  ШаблонПараметровПоляАналитики - Структура
// 
Процедура ДобавитьАналитикуПоТипуДанныхУчета(ТипДанныхУчета, СтруктураАналитики, ШаблонПараметровПоляАналитики) Экспорт
	
	//++ Локализация
	
	// ДенежныеСредства
	Если ТипДанныхУчета = Перечисления.ТипыДанныхУчета.ДенежныеСредства Тогда
		
		ПараметрыПоляАналитики = ОбщегоНазначения.СкопироватьРекурсивно(ШаблонПараметровПоляАналитики);
		ПараметрыПоляАналитики.ПутьКДанным = "";
		ПараметрыПоляАналитики.Тип = Новый ОписаниеТипов("СправочникСсылка.БанковскиеСчетаОрганизаций,СправочникСсылка.Кассы,СправочникСсылка.КассыККМ,СправочникСсылка.Контрагенты,СправочникСсылка.ФизическиеЛица,СправочникСсылка.ДоговорыКредитовИДепозитов,СправочникСсылка.ЭквайринговыеТерминалы,СправочникСсылка.ДенежныеДокументы");
		ПараметрыПоляАналитики.Заголовок = НСтр("ru='Денежные средства'");
		ПараметрыПоляАналитики.ИмяКор = "КорДенежныеСредства";
		ПараметрыПоляАналитики.ЗаголовокКор = НСтр("ru='Кор. денежные средства'");
		СтруктураАналитики.Вставить("ДенежныеСредства", ПараметрыПоляАналитики);
		
		ПараметрыПоляАналитики = ОбщегоНазначения.СкопироватьРекурсивно(ШаблонПараметровПоляАналитики);
		ПараметрыПоляАналитики.ПутьКДанным = "ТипПлатежаФЗ275";
		ПараметрыПоляАналитики.Тип = Новый ОписаниеТипов("СправочникСсылка.ТипыПлатежейФЗ275");
		ПараметрыПоляАналитики.Заголовок = НСтр("ru='Тип платежа 275-ФЗ'");
		ПараметрыПоляАналитики.ИмяКор = "КорТипПлатежаФЗ275";
		ПараметрыПоляАналитики.ЗаголовокКор = НСтр("ru='Кор. тип платежа 275-ФЗ'");
		СтруктураАналитики.Вставить("ТипПлатежаФЗ275", ПараметрыПоляАналитики);
		
		ПараметрыПоляАналитики = ОбщегоНазначения.СкопироватьРекурсивно(ШаблонПараметровПоляАналитики);
		ПараметрыПоляАналитики.ПутьКДанным = "СтатьяЦелевыхСредств";
		ПараметрыПоляАналитики.Тип = Новый ОписаниеТипов("СправочникСсылка.НаправленияРасходованияЦелевыхСредств,СправочникСсылка.ИсточникиПоступленияЦелевыхСредств");
		ПараметрыПоляАналитики.Заголовок = НСтр("ru='Статья целевых средств'");
		ПараметрыПоляАналитики.ИмяКор = "КорСтатьяЦелевыхСредств";
		ПараметрыПоляАналитики.ЗаголовокКор = НСтр("ru='Кор. статья целевых средств'");
		СтруктураАналитики.Вставить("СтатьяЦелевыхСредств", ПараметрыПоляАналитики);
	
	КонецЕсли;
	
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти