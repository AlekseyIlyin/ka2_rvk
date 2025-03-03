

#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СертификатДействителенПоМестноеВремя = Параметры.СертификатДействителенПоМестноеВремя;
	СвойстваСертификата = Параметры.СвойстваСертификата;
	
	МожетВыпастьНаНерабочиеДни = ОбработкаЗаявленийАбонентаВызовСервера.ОтправкаРаспискиМожетВыпастьНаНерабочиеДни();
	Элементы.ПредупреждениеПроНерабочиеДни.Видимость = МожетВыпастьНаНерабочиеДни;
		
	ИзменитьОформлениеПредупрежденияПроСрок();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПредупреждениеПроСрокОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	КриптографияЭДКОКлиент.ПоказатьСертификат(СвойстваСертификата, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы


&НаКлиенте
Процедура ПродолжитьОтправку(Команда)
	Закрыть("Продолжить");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИзменитьОформлениеПредупрежденияПроСрок()
	
	Истекает = ОбработкаЗаявленийАбонентаВызовСервера.СертификатСкороИстекает(СертификатДействителенПоМестноеВремя);
	Элементы.ПредупреждениеПроСрок.Видимость = Истекает;
	
	Если Истекает Тогда
		
		СсылкаНаСертификат = Новый ФорматированнаяСтрока(НСтр("ru = 'сертификат'"),,,, НСтр("ru = 'сертификат'"));
		
		Дельта = (НачалоДня(СертификатДействителенПоМестноеВремя) - НачалоДня(ТекущаяДатаСеанса())) / (60 * 60 * 24);
		Шаблон = НСтр("ru=';%1 день;;%1 дня;%1 дней;%1 дней'");
		ДельтаСтрокой = ДокументооборотСКОКлиентСервер.СтрокаСЧисломДляЛюбогоЯзыка(Шаблон, Дельта);
		
		Элементы.ПредупреждениеПроСрок.Заголовок = Новый ФорматированнаяСтрока(
			НСтр("ru = 'Ваш текущий '"),
			СсылкаНаСертификат,
			НСтр("ru = ' истекает '"),
			ДокументооборотСКОКлиентСервер.Жирным(Строка(СертификатДействителенПоМестноеВремя)),
			НСтр("ru = ' (через '"),
			ДельтаСтрокой,
			НСтр("ru = '), после чего подписание расписки будет невозможно.'"));
		
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти





