
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Отбор.Свойство("ФизическоеЛицо", ФизическоеЛицоСсылка);
	
	СотрудникиФормы.ПрочитатьНаборЗаписей(ЭтаФорма, "ЗнаниеЯзыковФизическихЛиц");
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ПредставлениеЗнаниеЯзыковТекст = 
		РегистрыСведений.ЗнаниеЯзыковФизическихЛиц.ПредставлениеВладениеЯзыкамиПоКоллекцииЗаписей(ЗнаниеЯзыковФизическихЛиц);
		
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

	Оповестить("ИзмененоЗнаниеЯзыковФизическихЛиц", ПредставлениеЗнаниеЯзыковТекст, ВладелецФормы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыЗнаниеЯзыковФизическихЛиц

&НаКлиенте
Процедура ЗнаниеЯзыковФизическихЛицПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		Элемент.ТекущиеДанные.ФизическоеЛицо = ФизическоеЛицоСсылка;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
