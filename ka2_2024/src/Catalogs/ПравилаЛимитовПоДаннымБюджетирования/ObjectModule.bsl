#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда 
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если Не ЭтоГруппа Тогда
		Если НЕ ИерархияАналитикПерезаписана Тогда
			ТабличнаяЧасть = ИерархияАналитик.Выгрузить();
			ТабличнаяЧасть.ЗаполнитьЗначения(Истина, "Используется");
			НоваяИерархия = Справочники.ПравилаЛимитовПоДаннымБюджетирования.ИерархияАналитик(
				Владелец,
				СтатьяБюджета,
				ТабличнаяЧасть);
			ИерархияАналитик.Загрузить(НоваяИерархия);
			ИерархияАналитикПерезаписана = Истина;
		КонецЕсли;
		ПредставлениеАналитик = Справочники.ПравилаЛимитовПоДаннымБюджетирования.ПредставлениеАналитик(ЭтотОбъект);
		Если ЛимитыПоДаннымБюджетированияСервер.СтатьяБюджетовИспользуетсяВНастройкахЛимитов(СтатьяБюджета, Ложь) Тогда
			Если ЭтоНовый() Тогда
				ОчищатьКэшНастроекЛимитов = Истина;
			Иначе
				РеквизитыСравнения = "СтатьяБюджета,Периодичность,ПредставлениеАналитик,ПометкаУдаления";
				ИсходныеРеквизиты = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, РеквизитыСравнения);
				ТекущиеРеквизиты = Новый Структура(РеквизитыСравнения);
				ЗаполнитьЗначенияСвойств(ТекущиеРеквизиты, ЭтотОбъект, РеквизитыСравнения);
				ОчищатьКэшНастроекЛимитов = Не ОбщегоНазначенияУТКлиентСервер.СтруктурыРавны(ИсходныеРеквизиты, ТекущиеРеквизиты, РеквизитыСравнения);
			КонецЕсли;
			Если ОчищатьКэшНастроекЛимитов Тогда
				НаборКэшНастроекЛимитов = РегистрыСведений.КэшНастроекЛимитовПоДаннымБюджетирования.СоздатьНаборЗаписей();
				УстановитьПривилегированныйРежим(Истина);
				НаборКэшНастроекЛимитов.Записать();
				УстановитьПривилегированныйРежим(Ложь);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли