////////////////////////////////////////////////////////////////////////////////
// Подсистема "Переработка на стороне".
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс


#Область СозданиеНаОсновании

// Создает Документ.ПередачаТоваровХранителю на основании Документ.ЗаказаПереработчику2_5
//
// Параметры:
//  МассивСсылок - Массив -
//  ПараметрыВыполнения - Структура - содержит:
//                         * ОписаниеКоманды - Структура - содержит:
//                            ** ДополнительныеПараметры - Структура - 
//
Процедура ПередачаТоваровХранителюСоздатьНаОснованииЗаказаПереработчику(МассивСсылок, ПараметрыВыполнения) Экспорт
	
	// &ЗамерПроизводительности
	ОценкаПроизводительностиКлиент.ЗамерВремени(
		"ОбщийМодуль.ПереработкаНаСторонеКлиент.ПередачаТоваровХранителюСоздатьНаОснованииЗаказаПереработчику");
	
	ПараметрыВыполненияКоманды = Новый Структура("Источник, Уникальность, Окно, НавигационнаяСсылка");
	ЗаполнитьЗначенияСвойств(ПараметрыВыполненияКоманды, ПараметрыВыполнения.ОписаниеКоманды.ДополнительныеПараметры);
	
	ПараметрыОткрытия =
		ПереработкаНаСторонеВызовСервера.ПередачаТоваровХранителюПараметрыОткрытияФормы(МассивСсылок);
	
	Если Не ПараметрыОткрытия = Неопределено Тогда
		
		ОткрытьФорму("Документ.ПередачаТоваровХранителю.Форма.ФормаДокумента",
					ПараметрыОткрытия,
					ПараметрыВыполненияКоманды.Источник,
					ПараметрыВыполненияКоманды.Уникальность,
					ПараметрыВыполненияКоманды.Окно,
					ПараметрыВыполненияКоманды.НавигационнаяСсылка);
		
	КонецЕсли;
	
КонецПроцедуры

// Создает Документ.ПоступлениеТоваровОтХранителя на основании Документ.ПередачаТоваровХранителю
//
// Параметры:
//  МассивСсылок - Массив -
//  ПараметрыВыполнения - Структура - содержит:
//                         * ОписаниеКоманды - Структура - содержит:
//                            ** ДополнительныеПараметры - Структура - 
//
Процедура ПоступлениеТоваровОтХранителяОперацияВозвратОтПереработчикаСоздатьНаОсновании(
			МассивСсылок, ПараметрыВыполнения) Экспорт
	
	// &ЗамерПроизводительности
	ОценкаПроизводительностиКлиент.ЗамерВремени(
		"ОбщийМодуль.ПереработкаНаСторонеКлиент.ПоступлениеТоваровОтХранителяОперацияВозвратОтПереработчикаСоздатьНаОсновании");
	
	ПараметрыВыполненияКоманды = Новый Структура("Источник, Уникальность, Окно, НавигационнаяСсылка");
	ЗаполнитьЗначенияСвойств(ПараметрыВыполненияКоманды, ПараметрыВыполнения.ОписаниеКоманды.ДополнительныеПараметры);

	ИмяНакладной		  = "ПоступлениеТоваровОтХранителя";
	ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВозвратОтПереработчика2_5");
	
	ПараметрыОткрытия = СозданиеНаОснованииУТВызовСервера.ПараметрыОткрытияФормыНакладнойНаОснованииЗаказа(
							МассивСсылок, ИмяНакладной, ХозяйственнаяОперация);
	
	ОткрытьФорму(
		ПараметрыОткрытия.ИмяФормы,
		ПараметрыОткрытия.ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность,
		ПараметрыВыполненияКоманды.Окно,
		ПараметрыВыполненияКоманды.НавигационнаяСсылка,,
		ПараметрыОткрытия.РежимОткрытияОкнаФормы);
	
КонецПроцедуры

// Создает Документ.ПоступлениеТоваровОтХранителя на основании Документ.ЗаказПереработчику2_5
//
// Параметры:
//  МассивСсылок - Массив -
//  ПараметрыВыполнения - Структура - содержит:
//                         * ОписаниеКоманды - Структура - содержит:
//                            ** ДополнительныеПараметры - Структура - 
//
Процедура ПоступлениеТоваровОтХранителяОперацияПоступлениеОтПереработчикаСоздатьНаОсновании(
			МассивСсылок, ПараметрыВыполнения) Экспорт
	
	// &ЗамерПроизводительности
	ОценкаПроизводительностиКлиент.ЗамерВремени(
		"ОбщийМодуль.ПереработкаНаСторонеКлиент.ПоступлениеТоваровОтХранителяОперацияПоступлениеОтПереработчикаСоздатьНаОсновании");
	
	ПараметрыВыполненияКоманды = Новый Структура("Источник, Уникальность, Окно, НавигационнаяСсылка");
	ЗаполнитьЗначенияСвойств(ПараметрыВыполненияКоманды, ПараметрыВыполнения.ОписаниеКоманды.ДополнительныеПараметры);

	ИмяНакладной		  = "ПоступлениеТоваровОтХранителя";
	ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ПоступлениеОтПереработчика2_5");
	
	ПараметрыОткрытия = СозданиеНаОснованииУТВызовСервера.ПараметрыОткрытияФормыНакладнойНаОснованииЗаказа(
							МассивСсылок, ИмяНакладной, ХозяйственнаяОперация);
	
	Если ПараметрыОткрытия.ПараметрыФормы.Основание.ОформлениеЧерезРМ Тогда
		
		ТекстОшибки = НСтр("ru = 'Документ не может быть оформлен. Для оформления воспользуйтесь рабочим местом ""Документы передачи в переработку (к оформлению)""'");
		ВызватьИсключение ТекстОшибки;
		
	Иначе
		ОткрытьФорму(
			ПараметрыОткрытия.ИмяФормы,
			ПараметрыОткрытия.ПараметрыФормы,
			ПараметрыВыполненияКоманды.Источник,
			ПараметрыВыполненияКоманды.Уникальность,
			ПараметрыВыполненияКоманды.Окно,
			ПараметрыВыполненияКоманды.НавигационнаяСсылка,,
			ПараметрыОткрытия.РежимОткрытияОкнаФормы);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
