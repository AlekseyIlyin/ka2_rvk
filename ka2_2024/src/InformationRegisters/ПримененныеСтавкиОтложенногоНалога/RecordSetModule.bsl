#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого Запись Из ЭтотОбъект Цикл
		
		РегистрыСведений.РасчетОтложенногоНалога.ПривестиПериодРасчета(Запись.ОтчетнаяДата);
		РегистрыСведений.РасчетОтложенногоНалога.ПривестиПериодРасчета(Запись.ПериодРасчета);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
