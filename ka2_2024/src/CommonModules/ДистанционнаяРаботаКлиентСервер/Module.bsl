////////////////////////////////////////////////////////////////////////////////
// Подсистема "Дистанционная работа".
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Устанавливает доступность.
//
// Параметры:
//   Форма - Форма - имя форма кадрового перевода".
//
Процедура КадровыйПереводУстановитьДоступностьЭлементов(Форма) Экспорт
	
	Объект = Форма.Объект;
	
	ИзменитьДистанционнуюРаботу = Объект.ИзменитьДистанционнуюРаботу И ЗначениеЗаполнено(Объект.Сотрудник);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"РаботаетДистанционно",
		"Доступность",
		ИзменитьДистанционнуюРаботу);
	
КонецПроцедуры

#КонецОбласти