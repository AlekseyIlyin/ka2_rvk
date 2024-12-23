#Область СлужебныеПроцедурыИФункции

// Выводит соответствующее оповещение.
//
Процедура ОповеститьКурсыУспешноОбновлены() Экспорт
	
	ПоказатьОповещениеПользователя(
		НСтр("ru = 'Курсы валют успешно обновлены'"),
		,
		НСтр("ru = 'Курсы валют обновлены'"),
		БиблиотекаКартинок.Информация32);
	
КонецПроцедуры

// Выводит соответствующее оповещение.
//
Процедура ОповеститьКурсыАктуальны() Экспорт
	
	ПоказатьПредупреждение(,НСтр("ru = 'Курсы валют актуальны.'"));
	
КонецПроцедуры

#КонецОбласти