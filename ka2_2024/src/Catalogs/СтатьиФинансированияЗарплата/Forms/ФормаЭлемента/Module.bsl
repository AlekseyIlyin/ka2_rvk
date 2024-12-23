
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Первоначальное заполнение объекта.
	Если Параметры.Ключ.Пустая() Тогда
		ПрочитатьДанные();
		УчетПоСтатьямФинансированияЗарплата.ДополнитьФормуСтатьиФинансирования(ЭтаФорма, "ГруппаБюджетныйУчет");
	КонецЕсли;
	
	СозданиеНовой = Параметры.Ключ.Пустая();
	ОбновитьЭУИспользованияСтатьи(ЭтаФорма);
	УстановитьЗаголовокСвернутойГруппыИспользованиеВБазеСреднего(ЭтаФорма);
	
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	УстановитьВидимостьКатегорииСтатистическогоНаблюденияЗПОбразование();
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ПрочитатьДанные();
	УчетПоСтатьямФинансированияЗарплата.ДополнитьФормуСтатьиФинансирования(ЭтаФорма, "ГруппаБюджетныйУчет");
	УчетПоСтатьямФинансированияЗарплата.ПрочитатьДополнительныеДанныеСтатьиФинансирования(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	УчетПоСтатьямФинансированияЗарплата.ЗаписатьДополнительныеДанныеСтатьиФинансирования(ЭтаФорма, ТекущийОбъект.Ссылка);
	
	ДополнительныеСвойства = Новый Структура;
	Если ТекущийОбъект.ИспользованиеВБазеСреднегоЗаработка = Перечисления.ИспользованиеСтатьиФинансированияВБазеСреднегоЗаработка.Используется Тогда
		
		НаборЗаписей = РегистрыСведений.СтатьиФинансированияБазыСреднегоЗаработка.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.СтатьяФинансирования.Установить(ТекущийОбъект.Ссылка);
		НаборЗаписей.Прочитать();
		
		Если НаборЗаписей.Количество() <> 0 Тогда
			НаборЗаписей.Очистить();
			ДополнительныеСвойства.Вставить("ОтключитьПроверкуДатыЗапретаИзменения", Истина);
			НаборЗаписей.Записать();
		КонецЕсли;
		
	Иначе
		
		Если СозданиеНовой Тогда
			ДополнительныеСвойства.Вставить("ОтключитьПроверкуДатыЗапретаИзменения", Истина);
		КонецЕсли;
		РедактированиеПериодическихСведений.ЗаписатьЗаписьПослеРедактированияВФорме(ЭтотОбъект, "СтатьиФинансированияБазыСреднегоЗаработка", ТекущийОбъект.Ссылка, , ДополнительныеСвойства);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	Если ИмяСобытия = "ОтредактированаИстория" И Объект.Ссылка = Источник Тогда
		Если Параметр.ИмяРегистра = "СтатьиФинансированияБазыСреднегоЗаработка" Тогда
			Если СтатьиФинансированияБазыСреднегоЗаработкаНаборЗаписейПрочитан Тогда
				РедактированиеПериодическихСведенийКлиент.ОбработкаОповещения(
					ЭтаФорма,
					Объект.Ссылка,
					ИмяСобытия,
					Параметр,
					Источник);
				ОбновитьПолеСтатьяФинансированияДляЗаменыПериод(ЭтаФорма, ОбщегоНазначенияКлиент.ДатаСеанса());
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаЗаписатьИЗакрыть(Команда)
	ЗаписатьНаКлиенте(Истина);
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗаписать(Команда)
	ЗаписатьНаКлиенте(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура СтатьиФинансированияБазыСреднегоЗаработкаИстория(Команда)
	РедактированиеПериодическихСведенийКлиент.ОткрытьИсторию("СтатьиФинансированияБазыСреднегоЗаработка", Объект.Ссылка, ЭтаФорма, ТолькоПросмотр);
КонецПроцедуры

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ИспользованиеВБазеСреднегоЗаработкаПриИзменении(Элемент)
	ОбновитьЭУИспользованияСтатьи(ЭтаФорма);
	УстановитьЗаголовокСвернутойГруппыИспользованиеВБазеСреднего(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокойПриИзменении(Элемент)
	ЗарплатаКадрыКлиент.ВводМесяцаПриИзменении(ЭтотОбъект, "СтатьиФинансированияБазыСреднегоЗаработка.Период", "СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокой", Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокойНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаНачалоВыбора(
		ЭтотОбъект,
		ЭтотОбъект,
		"СтатьиФинансированияБазыСреднегоЗаработка.Период",
		"СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокой");
КонецПроцедуры

&НаКлиенте
Процедура СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокойРегулирование(Элемент, Направление, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаРегулирование(ЭтотОбъект, "СтатьиФинансированияБазыСреднегоЗаработка.Период", "СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокой", Направление, Модифицированность);
КонецПроцедуры

&НаКлиенте
Процедура СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокойАвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокойОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура СтатьяФинансированияДляЗаменыПриИзменении(Элемент)
	
	ОбновитьПолеСтатьяФинансированияДляЗаменыПериод(ЭтотОбъект, ОбщегоНазначенияКлиент.ДатаСеанса());
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗаписатьНаКлиенте(ЗакрытьПослеЗаписи, ОповещениеЗавершения = Неопределено) Экспорт 

	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ЗакрытьПослеЗаписи", ЗакрытьПослеЗаписи);
	ДополнительныеПараметры.Вставить("ОповещениеЗавершения", ОповещениеЗавершения);
		
	Если Объект.ИспользованиеВБазеСреднегоЗаработка <> ПредопределенноеЗначение("Перечисление.ИспользованиеСтатьиФинансированияВБазеСреднегоЗаработка.Используется") Тогда
		
		Если Не ЗначениеЗаполнено(СтатьиФинансированияБазыСреднегоЗаработка.СтатьяФинансированияДляЗамены) Тогда
			СообщениеОбОшибке = НСтр("ru =  'Не указана статья финансирования для замены.'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"СтатьиФинансированияБазыСреднегоЗаработка.СтатьяФинансированияДляЗамены");
			Возврат;
		КонецЕсли;
		
		Если Объект.ИспользованиеВБазеСреднегоЗаработка = ПредопределенноеЗначение("Перечисление.ИспользованиеСтатьиФинансированияВБазеСреднегоЗаработка.ИспользуетсяДляУказанныхКатегорийНачислений")
			И Объект.КатегорииНачислений.Количество() = 0 Тогда
			СообщениеОбОшибке = НСтр("ru =  'Не указаны категории начислений.'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"Объект.КатегорииНачислений");
			Возврат;
		КонецЕсли;
		
		Оповещение = Новый ОписаниеОповещения("ЗаписатьНаКлиентеЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		
		ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru =  'При редактировании Вы изменили статью финансирования для замены. 
			|Если Вы просто исправили прежние данные (они были ошибочны), нажмите ""Исправлена ошибка"".
			|Если статья измениласьс %1, нажмите ""Статья изменилась""'"), 
			Формат(СтатьиФинансированияБазыСреднегоЗаработка.Период, "ДФ='д ММММ гггг ""г""'"));
		ТекстКнопкиДа = НСтр("ru = 'Статья изменилась'");
		
		РедактированиеПериодическихСведенийКлиент.ЗапроситьРежимИзмененияРегистра(ЭтотОбъект,"СтатьиФинансированияБазыСреднегоЗаработка", ТекстВопроса, ТекстКнопкиДа, Ложь, Оповещение);
		
	Иначе
		
		ЗаписатьНаКлиентеЗавершение(Ложь, ДополнительныеПараметры);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьНаКлиентеЗавершение(Отказ, ДополнительныеПараметры) Экспорт 

	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыЗаписи = Новый Структура("ПроверкаПередЗаписьюВыполнена", Истина);
	
	Если ДополнительныеПараметры.ОповещениеЗавершения <> Неопределено Тогда 
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ОповещениеЗавершения, ПараметрыЗаписи);
	ИначеЕсли Записать(ПараметрыЗаписи) И ДополнительныеПараметры.ЗакрытьПослеЗаписи Тогда 
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьЭУИспользованияСтатьи(Форма)

	ИспользованиеВБазеСреднегоЗаработка = Форма.Объект.ИспользованиеВБазеСреднегоЗаработка;
	СтатьяЗаменыДоступна = Ложь;
	ТекстПодсказки = НСтр("ru = 'Используется в бухучете начислениях, после даты окончания действия будет заменяться статьей указанной в настройках организации.'");
	
	КатегорииНачисленийДоступны = Ложь;
	Если ИспользованиеВБазеСреднегоЗаработка = ПредопределенноеЗначение("Перечисление.ИспользованиеСтатьиФинансированияВБазеСреднегоЗаработка.НеИспользуется") Тогда
		СтатьяЗаменыДоступна = Истина;
		ТекстПодсказки = НСтр("ru = 'Для всех начислений заменяется значением, указанным в поле ""Статья для замены"", не зависимо от даты окончания действия статьи.'");
	ИначеЕсли ИспользованиеВБазеСреднегоЗаработка = ПредопределенноеЗначение("Перечисление.ИспользованиеСтатьиФинансированияВБазеСреднегоЗаработка.ИспользуетсяДляУказанныхКатегорийНачислений") Тогда
		СтатьяЗаменыДоступна = Истина;
		КатегорииНачисленийДоступны = Истина;
		ТекстПодсказки = НСтр("ru = 'Используется в бухучете только для указанных категорий начисления, после даты окончания действия будет заменяться статьей указанной в настройках организации. Для остальных начислений заменяется значением, указанным в поле ""Статья для замены"", не зависимо от даты окончания действия статьи.'");
	КонецЕсли;
	
	Если СтатьяЗаменыДоступна Тогда
		Если Не ЗначениеЗаполнено(Форма.СтатьиФинансированияБазыСреднегоЗаработка.СтатьяФинансированияДляЗамены)
			И ЗначениеЗаполнено(Форма.СтатьиФинансированияБазыСреднегоЗаработкаПрежнееЗначение) Тогда
			ЗаполнитьЗначенияСвойств(Форма.СтатьиФинансированияБазыСреднегоЗаработка, Форма.СтатьиФинансированияБазыСреднегоЗаработкаПрежнееЗначение);
			ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(Форма, "СтатьиФинансированияБазыСреднегоЗаработка.Период", "СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокой");
		КонецЕсли;
	Иначе
		Если ЗначениеЗаполнено(Форма.СтатьиФинансированияБазыСреднегоЗаработка.СтатьяФинансированияДляЗамены) Тогда
			ПержнееЗначение = Новый Структура();
			ПержнееЗначение.Вставить("Период", Форма.СтатьиФинансированияБазыСреднегоЗаработка.Период);
			ПержнееЗначение.Вставить("СтатьяФинансирования", Форма.СтатьиФинансированияБазыСреднегоЗаработка.СтатьяФинансирования);
			ПержнееЗначение.Вставить("СтатьяФинансированияДляЗамены", Форма.СтатьиФинансированияБазыСреднегоЗаработка.СтатьяФинансированияДляЗамены);
			Форма.СтатьиФинансированияБазыСреднегоЗаработкаПрежнееЗначение = Новый ФиксированнаяСтруктура(ПержнееЗначение);
			Форма.СтатьиФинансированияБазыСреднегоЗаработка.Период = Дата(1,1,1);
			Форма.СтатьиФинансированияБазыСреднегоЗаработка.СтатьяФинансирования = Неопределено;
			Форма.СтатьиФинансированияБазыСреднегоЗаработка.СтатьяФинансированияДляЗамены = Неопределено;
			ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(Форма, "СтатьиФинансированияБазыСреднегоЗаработка.Период", "СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокой");
		КонецЕсли;
	КонецЕсли;
	
	Если КатегорииНачисленийДоступны Тогда
		Если Форма.Объект.КатегорииНачислений.Количество() = 0 
			И ЗначениеЗаполнено(Форма.КатегорииНачисленийПрежнееЗначение) Тогда
			Для каждого КатегорияНачисления Из Форма.КатегорииНачисленийПрежнееЗначение Цикл
				НоваяСтрока = Форма.Объект.КатегорииНачислений.Добавить();
				НоваяСтрока.КатегорияНачисления = КатегорияНачисления;
			КонецЦикла;
		КонецЕсли;
	Иначе
		Если Форма.Объект.КатегорииНачислений.Количество() > 0 Тогда
			ПрежнееЗначение = Новый Массив;
			Для каждого СтрокаТЧ Из Форма.Объект.КатегорииНачислений Цикл
				ПрежнееЗначение.Добавить(СтрокаТЧ.КатегорияНачисления);
			КонецЦикла;
			Форма.КатегорииНачисленийПрежнееЗначение = Новый ФиксированныйМассив(ПрежнееЗначение);
			Форма.Объект.КатегорииНачислений.Очистить();
		КонецЕсли;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ГруппаСтатьяДляЗамены",
		"Доступность",
		СтатьяЗаменыДоступна);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"КатегорииНачислений",
		"Доступность",
		КатегорииНачисленийДоступны);
		
		
	Форма.Элементы.ИспользованиеВБазеСреднегоЗаработка.РасширеннаяПодсказка.Заголовок = ТекстПодсказки;

КонецПроцедуры

&НаСервере
Процедура ПрочитатьНаборЗаписейПериодическихСведений(ИмяРегистра, ВедущийОбъект) Экспорт
	
	РедактированиеПериодическихСведений.ПрочитатьНаборЗаписей(ЭтаФорма, ИмяРегистра, ВедущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьДанные()

	Если Не ЗначениеЗаполнено(Объект.ИспользованиеВБазеСреднегоЗаработка) Тогда
		// Учтем отложенное обновление ИБ.
		Объект.ИспользованиеВБазеСреднегоЗаработка = Перечисления.ИспользованиеСтатьиФинансированияВБазеСреднегоЗаработка.Используется;
	КонецЕсли;
	
	РедактированиеПериодическихСведений.ПрочитатьЗаписьДляРедактированияВФорме(ЭтаФорма, "СтатьиФинансированияБазыСреднегоЗаработка", Объект.Ссылка);
	ОбновитьПолеСтатьяФинансированияДляЗаменыПериод(ЭтаФорма);

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьПолеСтатьяФинансированияДляЗаменыПериод(Форма, ДатаСеанса = Неопределено)
	
	Если Не ЗначениеЗаполнено(Форма.СтатьиФинансированияБазыСреднегоЗаработка.Период) И ЗначениеЗаполнено(ДатаСеанса) Тогда
		Форма.СтатьиФинансированияБазыСреднегоЗаработка.Период = НачалоМесяца(ДатаСеанса);
	КонецЕсли;
	
	РедактированиеПериодическихСведенийКлиентСервер.ОбновитьОтображениеПолейВвода(Форма, "СтатьиФинансированияБазыСреднегоЗаработка", Форма.Объект.Ссылка);
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(Форма, "СтатьиФинансированияБазыСреднегоЗаработка.Период", "СтатьиФинансированияБазыСреднегоЗаработкаПериодСтрокой");
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьЗаголовокСвернутойГруппыИспользованиеВБазеСреднего(Форма)

	ТекстЗаголовка = НСтр("ru = 'Используется в базе среднего заработка'");
	Если Форма.Объект.ИспользованиеВБазеСреднегоЗаработка = ПредопределенноеЗначение("Перечисление.ИспользованиеСтатьиФинансированияВБазеСреднегоЗаработка.НеИспользуется") Тогда
		ТекстЗаголовка = НСтр("ru = 'Не используется в базе среднего заработка'");
	ИначеЕсли Форма.Объект.ИспользованиеВБазеСреднегоЗаработка = ПредопределенноеЗначение("Перечисление.ИспользованиеСтатьиФинансированияВБазеСреднегоЗаработка.ИспользуетсяДляУказанныхКатегорийНачислений") Тогда
		ТекстЗаголовка = НСтр("ru = 'Используется в базе среднего заработка только для указанных категорий начислений'");
	КонецЕсли;
	Форма.Элементы.ГруппаИспользованиеВБазеСреднего.ЗаголовокСвернутогоОтображения = ТекстЗаголовка;
	
КонецПроцедуры

// СтандартныеПодсистемы.Свойства 
&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства    

&НаСервере
Процедура УстановитьВидимостьКатегорииСтатистическогоНаблюденияЗПОбразование()
	Настройки = СтатистикаПерсоналаРасширенный.НастройкиСтатистикиПерсонала();
	Видимость = Настройки.ИспользоватьОтчетностьМониторингаРаботниковСоциальнойСферы 
		И Настройки.ФормаЗПОбразование;
	Элементы.ГруппаКатегорияСтатистическогоНаблюдения.Видимость = Видимость;
КонецПроцедуры

#КонецОбласти





