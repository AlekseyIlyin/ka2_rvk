#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Функция ЗарегистрироватьФайлы(Заявка, ФайлыЗаявки, АдресEmail) Экспорт
	
	Для каждого ФайлЗаявки Из ФайлыЗаявки Цикл
		Запись = РегистрыСведений.ФайлыДляОтправкиНаПочтуКабинетСотрудника.СоздатьМенеджерЗаписи();
		Запись.Заявка 		= Заявка;
		Запись.Файл 		= ФайлЗаявки;
		Запись.АдресEmail 	= АдресEmail;
		Запись.Записать();
	КонецЦикла;

КонецФункции

#КонецОбласти

#КонецЕсли