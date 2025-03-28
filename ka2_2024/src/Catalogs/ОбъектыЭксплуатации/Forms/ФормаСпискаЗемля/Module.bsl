#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Отбор.Свойство("Организация") Тогда
		ОтборОрганизация = Параметры.Отбор.Организация;
		ЭлементОтбораОрганизация = ОтборыСписковКлиентСервер.ЭлементОтбораСпискаПоИмени(Список, "Организация");
		Если ЭлементОтбораОрганизация <> Неопределено Тогда
			ЭлементОтбораОрганизация.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
		КонецЕсли;
		Элементы.ОтборОрганизация.Видимость = Истина;
	Иначе
	
		//++ Локализация
		ОбщегоНазначенияБПВызовСервера.УстановитьОтборПоОсновнойОрганизации(ЭтотОбъект);
		Элементы.ОтборОрганизация.Видимость = Ложь;
		//-- Локализация
	
	КонецЕсли;
	
	РежимВыбора = (Параметры.РежимВыбора = Истина);
	Элементы.Список.РежимВыбора = РежимВыбора;
	Элементы.Список.МножественныйВыбор = (Параметры.МножественныйВыбор = Истина);
	
	РежимСверки = Ложь;
	Если Параметры.Свойство("РежимСверки") Тогда
		РежимСверки = Параметры.РежимСверки;
	КонецЕсли;
	
	УстановитьТекстЗапроса();
	
	Элементы.Выбрать.Видимость = РежимВыбора;
	Элементы.ОбъектаНетВСписке.Видимость = РежимВыбора И РежимСверки;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзмененаИнформацияОС" Тогда
		Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура СписокВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	Если Значение = Неопределено Или Не РежимСверки Тогда
		// Стандартная обработка
		Возврат;
	КонецЕсли;	
	
	СтандартнаяОбработка = Ложь;
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	ВыбранноеЗначение = Новый Структура;
	ВыбранноеЗначение.Вставить("ОсновноеСредство", ТекущиеДанные.Ссылка);
	ВыбранноеЗначение.Вставить("Наименование", ТекущиеДанные.Наименование);
	ВыбранноеЗначение.Вставить("КадастровыйНомер", ТекущиеДанные.КадастровыйНомер);
	ВыбранноеЗначение.Вставить("Поставлено", ТекущиеДанные.Поставлено);
	ВыбранноеЗначение.Вставить("Снято", ТекущиеДанные.Снято);
	ОповеститьОВыборе(ВыбранноеЗначение);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено И НЕ ТекущиеДанные.ЭтоГруппа Тогда
		ВыбранноеЗначение = Новый Структура;
		ВыбранноеЗначение.Вставить("ОсновноеСредство", ТекущиеДанные.Ссылка);
		ВыбранноеЗначение.Вставить("Наименование", ТекущиеДанные.Наименование);
		ВыбранноеЗначение.Вставить("КадастровыйНомер", ТекущиеДанные.КадастровыйНомер);
		ВыбранноеЗначение.Вставить("Поставлено", ТекущиеДанные.Поставлено);
		ВыбранноеЗначение.Вставить("Снято", ТекущиеДанные.Снято);
		ОповеститьОВыборе(ВыбранноеЗначение);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбъектаНетВСписке(Команда)
	ОповеститьОВыборе(Новый Структура);
КонецПроцедуры

#Область СтандартныеПодсистемы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтотОбъект, Команда);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьТекстЗапроса()
	
	//++ Локализация
	Запросы = Новый Массив;
	
	ТекстЗапроса = РасчетИмущественныхНалоговУП.ТекстЗапросаЗаписиРегистраСУчетомИсправлений(
					"ПараметрыНачисленияЗемельногоНалога",
					"РегистрацияЗемельныхУчастков_Записи");
	
	Запросы.Добавить(ТекстЗапроса);
	
	ТекстЗапроса = ВнеоборотныеАктивы.ТекстЗапросаСрезПоследнихРегистраСУчетомИсправлений(
					"ПараметрыНачисленияЗемельногоНалога",
					"РегистрацияЗемельныхУчастков_СрезПоследних");
	
	Запросы.Добавить(ТекстЗапроса);
	
	// Основные средства - недвижимость с налоговой базой "Кадастровая стоимость".
	ТекстЗапроса = 
	"
	|ВЫБРАТЬ
	|	РегистрацияЗемельныхУчастков.ОсновноеСредство КАК ОсновноеСредство,
	|	МАКСИМУМ(РегистрацияЗемельныхУчастков.Период) КАК Период
	|
	|ПОМЕСТИТЬ ВТ_ПоследняяРегистрация
	|
	|ИЗ
	|	РегистрацияЗемельныхУчастков_Записи КАК РегистрацияЗемельныхУчастков
	|ГДЕ
	|	РегистрацияЗемельныхУчастков.ВидЗаписи = ЗНАЧЕНИЕ(Перечисление.ВидЗаписиОРегистрации.Регистрация)
	|{ГДЕ
	|	РегистрацияЗемельныхУчастков.Организация КАК Организация}
	|СГРУППИРОВАТЬ ПО
	|	РегистрацияЗемельныхУчастков.ОсновноеСредство
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	| ВЫБРАТЬ
	|	РегистрацияЗемельныхУчастков.ОсновноеСредство КАК ОсновноеСредство,
	|	РегистрацияЗемельныхУчастков.Период           КАК Период,
	|	РегистрацияЗемельныхУчастков.КадастровыйНомер КАК КадастровыйНомер
	|
	|ПОМЕСТИТЬ ВТ_ДанныеПоследнейРегистрации
	|
	|ИЗ
	|	РегистрацияЗемельныхУчастков_Записи КАК РегистрацияЗемельныхУчастков
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_ПоследняяРегистрация
	|		ПО РегистрацияЗемельныхУчастков.ОсновноеСредство = ВТ_ПоследняяРегистрация.ОсновноеСредство
	|		И РегистрацияЗемельныхУчастков.Период = ВТ_ПоследняяРегистрация.Период
	|ГДЕ
	|	РегистрацияЗемельныхУчастков.ВидЗаписи = ЗНАЧЕНИЕ(Перечисление.ВидЗаписиОРегистрации.Регистрация)
	|{ГДЕ
	|	РегистрацияЗемельныхУчастков.Организация КАК Организация}
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	| ВЫБРАТЬ
	|	РегистрацияЗемельныхУчастков.ОсновноеСредство КАК ОсновноеСредство,
	|	МАКСИМУМ(РегистрацияЗемельныхУчастков.Период) КАК Период
	|
	|ПОМЕСТИТЬ ВТ_Снятия
	|
	|ИЗ
	|	РегистрацияЗемельныхУчастков_Записи КАК РегистрацияЗемельныхУчастков
	|ГДЕ
	|	РегистрацияЗемельныхУчастков.ВидЗаписи = ЗНАЧЕНИЕ(Перечисление.ВидЗаписиОРегистрации.СнятиеСРегистрационногоУчета)
	|{ГДЕ
	|	РегистрацияЗемельныхУчастков.Организация КАК Организация}
	|СГРУППИРОВАТЬ ПО
	|	РегистрацияЗемельныхУчастков.ОсновноеСредство
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	| ВЫБРАТЬ
	|	СправочникОсновныеСредства.Ссылка                                   КАК Ссылка,
	|	СправочникОсновныеСредства.ПометкаУдаления                          КАК ПометкаУдаления,
	|	СправочникОсновныеСредства.Родитель                                 КАК Родитель,
	|	СправочникОсновныеСредства.ЭтоГруппа                                КАК ЭтоГруппа,
	|	СправочникОсновныеСредства.Код                                      КАК Код,
	|	СправочникОсновныеСредства.Наименование                             КАК Наименование,
	|	СправочникОсновныеСредства.НаименованиеПолное                       КАК НаименованиеПолное,
	|	СправочникОсновныеСредства.Изготовитель                             КАК Изготовитель,
	|	СправочникОсновныеСредства.ЗаводскойНомер                           КАК ЗаводскойНомер,
	|	СправочникОсновныеСредства.НомерПаспорта                            КАК НомерПаспорта,
	|	СправочникОсновныеСредства.ДатаВыпуска                              КАК ДатаВыпуска,
	|	СправочникОсновныеСредства.КодПоОКОФ                                КАК КодПоОКОФ,
	|	СправочникОсновныеСредства.ГруппаОС                                 КАК ГруппаОС,
	|	ПорядокУчетаОСБУ.АмортизационнаяГруппа                              КАК АмортизационнаяГруппа,
	|	СправочникОсновныеСредства.ШифрПоЕНАОФ                              КАК ШифрПоЕНАОФ,
	|	СправочникОсновныеСредства.Комментарий                              КАК Комментарий,
	|	СправочникОсновныеСредства.Предопределенный                         КАК Предопределенный,
	|	СправочникОсновныеСредства.ИмяПредопределенныхДанных                КАК ИмяПредопределенныхДанных,
	|	ЕСТЬNULL(ВТ_ДанныеПоследнейРегистрации.Период, ДАТАВРЕМЯ(1, 1, 1))  КАК Поставлено,
	|	ЕСТЬNULL(ВТ_Снятия.Период, ДАТАВРЕМЯ(1, 1, 1))                      КАК Снято,
	|	ЕСТЬNULL(ВТ_ДанныеПоследнейРегистрации.КадастровыйНомер, """")      КАК КадастровыйНомер
	|ИЗ
	|	Справочник.ОбъектыЭксплуатации КАК СправочникОсновныеСредства
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ДанныеПоследнейРегистрации КАК ВТ_ДанныеПоследнейРегистрации
	|		ПО СправочникОсновныеСредства.Ссылка = ВТ_ДанныеПоследнейРегистрации.ОсновноеСредство
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Снятия КАК ВТ_Снятия
	|		ПО СправочникОсновныеСредства.Ссылка = ВТ_Снятия.ОсновноеСредство
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПорядокУчетаОСБУ.СрезПоследних КАК ПорядокУчетаОСБУ
	|		ПО СправочникОсновныеСредства.Ссылка = ПорядокУчетаОСБУ.ОсновноеСредство
	|ГДЕ
	|	СправочникОсновныеСредства.ГруппаОС = ЗНАЧЕНИЕ(Перечисление.ГруппыОС.ЗемельныеУчастки)
	|";
	
	Запросы.Добавить(ТекстЗапроса);
	
	ТекстЗапроса = СтрСоединить(Запросы, ОбщегоНазначения.РазделительПакетаЗапросов());
	
	СвойстваСписка = ОбщегоНазначения.СтруктураСвойствДинамическогоСписка();
	ЗаполнитьЗначенияСвойств(СвойстваСписка, Список, "ОсновнаяТаблица, ДинамическоеСчитываниеДанных");
	СвойстваСписка.ТекстЗапроса = ТекстЗапроса;
	
	ОбщегоНазначения.УстановитьСвойстваДинамическогоСписка(Элементы.Список, СвойстваСписка);
	//-- Локализация
		
	Список.Параметры.УстановитьЗначениеПараметра("НачалоПериода",Дата(1,1,1));
	Список.Параметры.УстановитьЗначениеПараметра("КонецПериода",Дата(1,1,1));
	Если Параметры.Свойство("Период") Тогда
		Список.Параметры.УстановитьЗначениеПараметра("ДатаДокумента", КонецГода(Параметры.Период));
		Список.Параметры.УстановитьЗначениеПараметра("Дата", КонецГода(Параметры.Период));
	Иначе
		Список.Параметры.УстановитьЗначениеПараметра("ДатаДокумента", ОбщегоНазначения.ТекущаяДатаПользователя());
		Список.Параметры.УстановитьЗначениеПараметра("Дата", ОбщегоНазначения.ТекущаяДатаПользователя());
	КонецЕсли;
	
	Список.Параметры.УстановитьЗначениеПараметра("СписокОС", Неопределено);
	Список.Параметры.УстановитьЗначениеПараметра("БезОтбораОС", Истина);
	
	Если Параметры.Отбор.Свойство("Организация") Тогда
		Список.Параметры.УстановитьЗначениеПараметра("Организация", Параметры.Отбор.Организация);
	Иначе
		Список.Параметры.УстановитьЗначениеПараметра("Организация", Справочники.Организации.ПустаяСсылка());
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти