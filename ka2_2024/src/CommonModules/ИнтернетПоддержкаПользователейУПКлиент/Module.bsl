#Область ПрограммныйИнтерфейс

// Открывает веб страницу ИТС для отправки сообщения в тех поддержку
//
// Параметры:
//  ТекстОбращение - Строка - 
//  ТемаОбращения - Строка -
//
Процедура ОтправитьСообщениеСПомощьюВебСтраницыИТС(ТекстОбращение = "<Текст сообщения>", ТемаОбращения = "<Тема>") Экспорт
	
	ДанныеСообщения = СообщенияВСлужбуТехническойПоддержкиКлиентСервер.ДанныеСообщения();
	
	ДанныеСообщения.Получатель = "v8";
	ДанныеСообщения.Тема = ТемаОбращения;
	ДанныеСообщения.Сообщение = ТекстОбращение;
	
	СообщенияВСлужбуТехническойПоддержкиКлиент.ОтправитьСообщение(ДанныеСообщения);
	
КонецПроцедуры

#КонецОбласти