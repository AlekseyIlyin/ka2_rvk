#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Запись, ЭтотОбъект);
	
	Если Параметры.Свойство("Показатель") И ЗначениеЗаполнено(Параметры.Показатель) Тогда
		
		СуществующаяЗапись = РегистрыСведений.ЗначенияПоказателейДляРаспределенияРасходовНаОВЗ.СоздатьМенеджерЗаписи();
		СуществующаяЗапись.Показатель = Параметры.Показатель;
		СуществующаяЗапись.ОВЗ = Параметры.ОВЗ;
		СуществующаяЗапись.Период = Параметры.Период;
		СуществующаяЗапись.Прочитать();
		
		Если ЗначениеЗаполнено(СуществующаяЗапись.Показатель) Тогда
			ЗначениеВДанныеФормы(СуществующаяЗапись, Запись);
		Иначе
			ЗаполнитьЗначенияСвойств(Запись, Параметры);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	Запись.Период = НачалоМесяца(Запись.Период);
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
КонецПроцедуры

#КонецОбласти
