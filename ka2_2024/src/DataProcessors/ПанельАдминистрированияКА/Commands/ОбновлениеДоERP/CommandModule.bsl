
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ДополнительныеПараметры = Новый Структура("ЗаголовокОкна,ЗаголовокНетОбновления");
	ДополнительныеПараметры.ЗаголовокОкна = НСтр("ru = 'Переход на программу: 1С:ERP Управление предприятием 2'");
	ДополнительныеПараметры.ЗаголовокНетОбновления = НСтр("ru = 'Обновления отсутствуют.'");
	
	ПолучениеОбновленийПрограммыКлиент.ПерейтиНаДругуюПрограмму("Enterprise20",,ДополнительныеПараметры);
	
КонецПроцедуры

#КонецОбласти



