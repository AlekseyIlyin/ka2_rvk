#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ОбращениеСФРКСтрахователю") Тогда
		
		Основание	= ДанныеЗаполнения;
		РеквизитыОснования = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(
			ДанныеЗаполнения, "Ответственный, Организация, Заголовок");
		Ответственный = РеквизитыОснования.Ответственный;
		Организация = РеквизитыОснования.Организация;
		Заголовок = РеквизитыОснования.Заголовок;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли