#Область СлужебныйПрограммныйИнтерфейс

// Устарело. Позволяет переопределить форму узла плана обмена "Обмен с сайтом".
//
// Параметры:
//  ВыбраннаяФорма - Форма - форма узла.
//
Процедура ПереопределитьФормуУзла(ВыбраннаяФорма) Экспорт
	
	ОбменССайтомПереопределяемый.ПереопределитьФормуУзла(ВыбраннаяФорма);
	
КонецПроцедуры

// Устарело. Позволяет переопределить действия обработчика обновления.
//
// Параметры:
//  ПредставлениеОбработчика - Строка - представление обработчика обновления, вызвавшего процедуру.
//
Процедура ПереопределитьОбработчикОбновления(ПредставлениеОбработчика) Экспорт
	
	ОбменССайтомПереопределяемый.ОбработчикОбновленияПереопределяемый(ПредставлениеОбработчика);
	
КонецПроцедуры

#КонецОбласти