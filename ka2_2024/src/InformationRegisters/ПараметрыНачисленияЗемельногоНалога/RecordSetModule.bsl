#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	ТаблицаПередЗаписью.Период КАК Период,
	|	ТаблицаПередЗаписью.Организация КАК Организация,
	|	ТаблицаПередЗаписью.ОсновноеСредство КАК ОсновноеСредство,
	|	ТаблицаПередЗаписью.ВключатьВНалоговуюБазу КАК ВключатьВНалоговуюБазу,
	|	ТаблицаПередЗаписью.КодКатегорииЗемель КАК КодКатегорииЗемель,
	|	ТаблицаПередЗаписью.КадастровыйНомер КАК КадастровыйНомер,
	|	ТаблицаПередЗаписью.КадастроваяСтоимость КАК КадастроваяСтоимость,
	|	ТаблицаПередЗаписью.ОбщаяСобственность КАК ОбщаяСобственность,
	|	ТаблицаПередЗаписью.ДоляВПравеОбщейСобственностиЧислитель КАК ДоляВПравеОбщейСобственностиЧислитель,
	|	ТаблицаПередЗаписью.ДоляВПравеОбщейСобственностиЗнаменатель КАК ДоляВПравеОбщейСобственностиЗнаменатель,
	|	ТаблицаПередЗаписью.ЖилищноеСтроительство КАК ЖилищноеСтроительство,
	|	ТаблицаПередЗаписью.ДатаНачалаПроектированияДо2008 КАК ДатаНачалаПроектированияДо2008,
	|	ТаблицаПередЗаписью.ДатаРегистрацииПравНаОбъектНедвижимости КАК ДатаРегистрацииПравНаОбъектНедвижимости,
	|	ТаблицаПередЗаписью.ПостановкаНаУчетВНалоговомОргане КАК ПостановкаНаУчетВНалоговомОргане,
	|	ТаблицаПередЗаписью.НалоговыйОрган КАК НалоговыйОрган,
	|	ТаблицаПередЗаписью.КодПоОКТМО КАК КодПоОКТМО,
	|	ТаблицаПередЗаписью.КодПоОКАТО КАК КодПоОКАТО,
	|	ТаблицаПередЗаписью.КБК КАК КБК,
	|	ТаблицаПередЗаписью.НалоговаяСтавка КАК НалоговаяСтавка,
	|	ТаблицаПередЗаписью.НалоговаяЛьготаПоНалоговойБазеДо2020 КАК НалоговаяЛьготаПоНалоговойБазеДо2020,
	|	ТаблицаПередЗаписью.КодНалоговойЛьготыОсвобождениеОтНалогообложенияПоСтатье395До2020 КАК
	|		КодНалоговойЛьготыОсвобождениеОтНалогообложенияПоСтатье395До2020,
	|	ТаблицаПередЗаписью.КодНалоговойЛьготыУменьшениеНалоговойБазыПоСтатье391До2020 КАК
	|		КодНалоговойЛьготыУменьшениеНалоговойБазыПоСтатье391До2020,
	|	ТаблицаПередЗаписью.УменьшениеНалоговойБазыПоСтатье391До2020 КАК УменьшениеНалоговойБазыПоСтатье391До2020,
	|	ТаблицаПередЗаписью.УменьшениеНалоговойБазыНаСуммуДо2020 КАК УменьшениеНалоговойБазыНаСуммуДо2020,
	|	ТаблицаПередЗаписью.ДоляНеОблагаемойНалогомПлощадиЧислитель КАК ДоляНеОблагаемойНалогомПлощадиЧислитель,
	|	ТаблицаПередЗаписью.ДоляНеОблагаемойНалогомПлощадиЗнаменатель КАК ДоляНеОблагаемойНалогомПлощадиЗнаменатель,
	|	ТаблицаПередЗаписью.НеОблагаемаяНалогомСумма КАК НеОблагаемаяНалогомСумма,
	|	ТаблицаПередЗаписью.СниженнаяНалоговаяСтавка КАК СниженнаяНалоговаяСтавка,
	|	ТаблицаПередЗаписью.ПроцентУменьшенияСуммыНалогаДо2020 КАК ПроцентУменьшенияСуммыНалогаДо2020,
	|	ТаблицаПередЗаписью.СуммаУменьшенияСуммыНалога КАК СуммаУменьшенияСуммыНалога,
	|	ТаблицаПередЗаписью.Комментарий,
	|	ТаблицаПередЗаписью.ОснованиеЛьготыПоНалоговойБазе,
	|	ТаблицаПередЗаписью.НачалоДействияЛьготыПоНалоговойБазе,
	|	ТаблицаПередЗаписью.ОкончаниеДействияЛьготыПоНалоговойБазе,
	|	ТаблицаПередЗаписью.ОснованиеЛьготыСнижениеСтавки,
	|	ТаблицаПередЗаписью.НачалоДействияЛьготыСнижениеСтавки,
	|	ТаблицаПередЗаписью.ОкончаниеДействияЛьготыСнижениеСтавки,
	|	ТаблицаПередЗаписью.ОснованиеЛьготыСнижениеСуммыНалога,
	|	ТаблицаПередЗаписью.НачалоДействияЛьготыСнижениеСуммыНалога,
	|	ТаблицаПередЗаписью.ОкончаниеДействияЛьготыСнижениеСуммыНалога
	|ПОМЕСТИТЬ ПараметрыНачисленияЗемельногоНалогаПередЗаписью
	|ИЗ
	|	РегистрСведений.ПараметрыНачисленияЗемельногоНалога КАК ТаблицаПередЗаписью
	|ГДЕ
	|	ТаблицаПередЗаписью.Регистратор = &Регистратор
	|	И ТаблицаПередЗаписью.ДатаИсправления = ДАТАВРЕМЯ(1, 1, 1)";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	Запрос.Выполнить();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Или Не ПроведениеДокументов.КонтролироватьИзменения(ДополнительныеСвойства) Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Таблица.Период            КАК Период,
	|	Таблица.Организация       КАК Организация,
	|	Таблица.ОсновноеСредство  КАК ОсновноеСредство,
	|	ИСТИНА                    КАК ОтражатьВРеглУчете,
	|	ЛОЖЬ                      КАК ОтражатьВУпрУчете,
	|	&Регистратор              КАК Документ
	|ПОМЕСТИТЬ ПараметрыНачисленияЗемельногоНалогаИзменение
	|ИЗ
	|	(ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		НАЧАЛОПЕРИОДА(ТаблицаПередЗаписью.Период, МЕСЯЦ) КАК Период,
	|		ТаблицаПередЗаписью.Организация КАК Организация,
	|		ТаблицаПередЗаписью.ОсновноеСредство КАК ОсновноеСредство
	|	ИЗ
	|		ПараметрыНачисленияЗемельногоНалогаПередЗаписью КАК ТаблицаПередЗаписью
	|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПараметрыНачисленияЗемельногоНалога КАК ТаблицаПриЗаписи
	|			ПО (ТаблицаПриЗаписи.Организация = ТаблицаПередЗаписью.Организация)
	|				И (ТаблицаПриЗаписи.ОсновноеСредство = ТаблицаПередЗаписью.ОсновноеСредство)
	|				И НАЧАЛОПЕРИОДА(ТаблицаПриЗаписи.Период, ДЕНЬ) = НАЧАЛОПЕРИОДА(ТаблицаПередЗаписью.Период, ДЕНЬ)
	|				И (ТаблицаПриЗаписи.Регистратор = &Регистратор)
	|				И ТаблицаПриЗаписи.ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
	|	ГДЕ
	|		(ТаблицаПередЗаписью.ВключатьВНалоговуюБазу <> ЕСТЬNULL(ТаблицаПриЗаписи.ВключатьВНалоговуюБазу, НЕОПРЕДЕЛЕНО)
	|			ИЛИ ТаблицаПередЗаписью.КодКатегорииЗемель <> ТаблицаПриЗаписи.КодКатегорииЗемель
	|			ИЛИ ТаблицаПередЗаписью.КадастровыйНомер <> ТаблицаПриЗаписи.КадастровыйНомер
	|			ИЛИ ТаблицаПередЗаписью.КадастроваяСтоимость <> ТаблицаПриЗаписи.КадастроваяСтоимость
	|			ИЛИ ТаблицаПередЗаписью.ОбщаяСобственность <> ТаблицаПриЗаписи.ОбщаяСобственность
	|			ИЛИ ТаблицаПередЗаписью.ДоляВПравеОбщейСобственностиЧислитель <> ТаблицаПриЗаписи.ДоляВПравеОбщейСобственностиЧислитель
	|			ИЛИ ТаблицаПередЗаписью.ДоляВПравеОбщейСобственностиЗнаменатель <> ТаблицаПриЗаписи.ДоляВПравеОбщейСобственностиЗнаменатель
	|			ИЛИ ТаблицаПередЗаписью.ЖилищноеСтроительство <> ТаблицаПриЗаписи.ЖилищноеСтроительство
	|			ИЛИ ТаблицаПередЗаписью.ДатаНачалаПроектированияДо2008 <> ТаблицаПриЗаписи.ДатаНачалаПроектированияДо2008
	|			ИЛИ ТаблицаПередЗаписью.ДатаРегистрацииПравНаОбъектНедвижимости <> ТаблицаПриЗаписи.ДатаРегистрацииПравНаОбъектНедвижимости
	|			ИЛИ ТаблицаПередЗаписью.ПостановкаНаУчетВНалоговомОргане <> ТаблицаПриЗаписи.ПостановкаНаУчетВНалоговомОргане
	|			ИЛИ ТаблицаПередЗаписью.НалоговыйОрган <> ТаблицаПриЗаписи.НалоговыйОрган
	|			ИЛИ ТаблицаПередЗаписью.КодПоОКТМО <> ТаблицаПриЗаписи.КодПоОКТМО
	|			ИЛИ ТаблицаПередЗаписью.КодПоОКАТО <> ТаблицаПриЗаписи.КодПоОКАТО
	|			ИЛИ ТаблицаПередЗаписью.КБК <> ТаблицаПриЗаписи.КБК
	|			ИЛИ ТаблицаПередЗаписью.НалоговаяСтавка <> ТаблицаПриЗаписи.НалоговаяСтавка
	|			ИЛИ ТаблицаПередЗаписью.НалоговаяЛьготаПоНалоговойБазеДо2020 <> ТаблицаПриЗаписи.НалоговаяЛьготаПоНалоговойБазеДо2020
	|			ИЛИ ТаблицаПередЗаписью.КодНалоговойЛьготыОсвобождениеОтНалогообложенияПоСтатье395До2020 <> ТаблицаПриЗаписи.КодНалоговойЛьготыОсвобождениеОтНалогообложенияПоСтатье395До2020
	|			ИЛИ ТаблицаПередЗаписью.КодНалоговойЛьготыУменьшениеНалоговойБазыПоСтатье391До2020 <> ТаблицаПриЗаписи.КодНалоговойЛьготыУменьшениеНалоговойБазыПоСтатье391До2020
	|			ИЛИ ТаблицаПередЗаписью.УменьшениеНалоговойБазыПоСтатье391До2020 <> ТаблицаПриЗаписи.УменьшениеНалоговойБазыПоСтатье391До2020
	|			ИЛИ ТаблицаПередЗаписью.УменьшениеНалоговойБазыНаСуммуДо2020 <> ТаблицаПриЗаписи.УменьшениеНалоговойБазыНаСуммуДо2020
	|			ИЛИ ТаблицаПередЗаписью.ДоляНеОблагаемойНалогомПлощадиЧислитель <> ТаблицаПриЗаписи.ДоляНеОблагаемойНалогомПлощадиЧислитель
	|			ИЛИ ТаблицаПередЗаписью.ДоляНеОблагаемойНалогомПлощадиЗнаменатель <> ТаблицаПриЗаписи.ДоляНеОблагаемойНалогомПлощадиЗнаменатель
	|			ИЛИ ТаблицаПередЗаписью.НеОблагаемаяНалогомСумма <> ТаблицаПриЗаписи.НеОблагаемаяНалогомСумма
	|			ИЛИ ТаблицаПередЗаписью.СниженнаяНалоговаяСтавка <> ТаблицаПриЗаписи.СниженнаяНалоговаяСтавка
	|			ИЛИ ТаблицаПередЗаписью.ПроцентУменьшенияСуммыНалогаДо2020 <> ТаблицаПриЗаписи.ПроцентУменьшенияСуммыНалогаДо2020
	|			ИЛИ ТаблицаПередЗаписью.СуммаУменьшенияСуммыНалога <> ТаблицаПриЗаписи.СуммаУменьшенияСуммыНалога
	|			ИЛИ ТаблицаПриЗаписи.Организация ЕСТЬ NULL
	|			ИЛИ Подстрока(ТаблицаПередЗаписью.Комментарий, 1, 500) <> Подстрока(ТаблицаПриЗаписи.Комментарий, 1, 500)
	|			ИЛИ ТаблицаПередЗаписью.ОснованиеЛьготыПоНалоговойБазе <> ТаблицаПриЗаписи.ОснованиеЛьготыПоНалоговойБазе
	|			ИЛИ ТаблицаПередЗаписью.НачалоДействияЛьготыПоНалоговойБазе <> ТаблицаПриЗаписи.НачалоДействияЛьготыПоНалоговойБазе
	|			ИЛИ ТаблицаПередЗаписью.ОкончаниеДействияЛьготыПоНалоговойБазе <> ТаблицаПриЗаписи.ОкончаниеДействияЛьготыПоНалоговойБазе
	|			ИЛИ ТаблицаПередЗаписью.ОснованиеЛьготыСнижениеСтавки <> ТаблицаПриЗаписи.ОснованиеЛьготыСнижениеСтавки
	|			ИЛИ ТаблицаПередЗаписью.НачалоДействияЛьготыСнижениеСтавки <> ТаблицаПриЗаписи.НачалоДействияЛьготыСнижениеСтавки
	|			ИЛИ ТаблицаПередЗаписью.ОкончаниеДействияЛьготыСнижениеСтавки <> ТаблицаПриЗаписи.ОкончаниеДействияЛьготыСнижениеСтавки
	|			ИЛИ ТаблицаПередЗаписью.ОснованиеЛьготыСнижениеСуммыНалога <> ТаблицаПриЗаписи.ОснованиеЛьготыСнижениеСуммыНалога
	|			ИЛИ ТаблицаПередЗаписью.НачалоДействияЛьготыСнижениеСуммыНалога <> ТаблицаПриЗаписи.НачалоДействияЛьготыСнижениеСуммыНалога
	|			ИЛИ ТаблицаПередЗаписью.ОкончаниеДействияЛьготыСнижениеСуммыНалога <> ТаблицаПриЗаписи.ОкончаниеДействияЛьготыСнижениеСуммыНалога)
	|		И ТаблицаПередЗаписью.Организация.ЮридическоеФизическоеЛицо <> ЗНАЧЕНИЕ(Перечисление.ЮридическоеФизическоеЛицо.ФизическоеЛицо)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		НАЧАЛОПЕРИОДА(ТаблицаПриЗаписи.Период, МЕСЯЦ),
	|		ТаблицаПриЗаписи.Организация,
	|		ТаблицаПриЗаписи.ОсновноеСредство
	|	ИЗ
	|		РегистрСведений.ПараметрыНачисленияЗемельногоНалога КАК ТаблицаПриЗаписи
	|			ЛЕВОЕ СОЕДИНЕНИЕ ПараметрыНачисленияЗемельногоНалогаПередЗаписью КАК ТаблицаПередЗаписью
	|			ПО ТаблицаПриЗаписи.Организация = ТаблицаПередЗаписью.Организация
	|				И ТаблицаПриЗаписи.ОсновноеСредство = ТаблицаПередЗаписью.ОсновноеСредство
	|				И НАЧАЛОПЕРИОДА(ТаблицаПриЗаписи.Период, ДЕНЬ) = НАЧАЛОПЕРИОДА(ТаблицаПередЗаписью.Период, ДЕНЬ)
	|	ГДЕ
	|		(ТаблицаПриЗаписи.ВключатьВНалоговуюБазу <> ЕСТЬNULL(ТаблицаПередЗаписью.ВключатьВНалоговуюБазу, НЕОПРЕДЕЛЕНО)
	|			ИЛИ ТаблицаПередЗаписью.КодКатегорииЗемель <> ТаблицаПриЗаписи.КодКатегорииЗемель
	|			ИЛИ ТаблицаПередЗаписью.КадастровыйНомер <> ТаблицаПриЗаписи.КадастровыйНомер
	|			ИЛИ ТаблицаПередЗаписью.КадастроваяСтоимость <> ТаблицаПриЗаписи.КадастроваяСтоимость
	|			ИЛИ ТаблицаПередЗаписью.ОбщаяСобственность <> ТаблицаПриЗаписи.ОбщаяСобственность
	|			ИЛИ ТаблицаПередЗаписью.ДоляВПравеОбщейСобственностиЧислитель <> ТаблицаПриЗаписи.ДоляВПравеОбщейСобственностиЧислитель
	|			ИЛИ ТаблицаПередЗаписью.ДоляВПравеОбщейСобственностиЗнаменатель <> ТаблицаПриЗаписи.ДоляВПравеОбщейСобственностиЗнаменатель
	|			ИЛИ ТаблицаПередЗаписью.ЖилищноеСтроительство <> ТаблицаПриЗаписи.ЖилищноеСтроительство
	|			ИЛИ ТаблицаПередЗаписью.ДатаНачалаПроектированияДо2008 <> ТаблицаПриЗаписи.ДатаНачалаПроектированияДо2008
	|			ИЛИ ТаблицаПередЗаписью.ДатаРегистрацииПравНаОбъектНедвижимости <> ТаблицаПриЗаписи.ДатаРегистрацииПравНаОбъектНедвижимости
	|			ИЛИ ТаблицаПередЗаписью.ПостановкаНаУчетВНалоговомОргане <> ТаблицаПриЗаписи.ПостановкаНаУчетВНалоговомОргане
	|			ИЛИ ТаблицаПередЗаписью.НалоговыйОрган <> ТаблицаПриЗаписи.НалоговыйОрган
	|			ИЛИ ТаблицаПередЗаписью.КодПоОКТМО <> ТаблицаПриЗаписи.КодПоОКТМО
	|			ИЛИ ТаблицаПередЗаписью.КодПоОКАТО <> ТаблицаПриЗаписи.КодПоОКАТО
	|			ИЛИ ТаблицаПередЗаписью.КБК <> ТаблицаПриЗаписи.КБК
	|			ИЛИ ТаблицаПередЗаписью.НалоговаяСтавка <> ТаблицаПриЗаписи.НалоговаяСтавка
	|			ИЛИ ТаблицаПередЗаписью.НалоговаяЛьготаПоНалоговойБазеДо2020 <> ТаблицаПриЗаписи.НалоговаяЛьготаПоНалоговойБазеДо2020
	|			ИЛИ ТаблицаПередЗаписью.КодНалоговойЛьготыОсвобождениеОтНалогообложенияПоСтатье395До2020 <> ТаблицаПриЗаписи.КодНалоговойЛьготыОсвобождениеОтНалогообложенияПоСтатье395До2020
	|			ИЛИ ТаблицаПередЗаписью.КодНалоговойЛьготыУменьшениеНалоговойБазыПоСтатье391До2020 <> ТаблицаПриЗаписи.КодНалоговойЛьготыУменьшениеНалоговойБазыПоСтатье391До2020
	|			ИЛИ ТаблицаПередЗаписью.УменьшениеНалоговойБазыПоСтатье391До2020 <> ТаблицаПриЗаписи.УменьшениеНалоговойБазыПоСтатье391До2020
	|			ИЛИ ТаблицаПередЗаписью.УменьшениеНалоговойБазыНаСуммуДо2020 <> ТаблицаПриЗаписи.УменьшениеНалоговойБазыНаСуммуДо2020
	|			ИЛИ ТаблицаПередЗаписью.ДоляНеОблагаемойНалогомПлощадиЧислитель <> ТаблицаПриЗаписи.ДоляНеОблагаемойНалогомПлощадиЧислитель
	|			ИЛИ ТаблицаПередЗаписью.ДоляНеОблагаемойНалогомПлощадиЗнаменатель <> ТаблицаПриЗаписи.ДоляНеОблагаемойНалогомПлощадиЗнаменатель
	|			ИЛИ ТаблицаПередЗаписью.НеОблагаемаяНалогомСумма <> ТаблицаПриЗаписи.НеОблагаемаяНалогомСумма
	|			ИЛИ ТаблицаПередЗаписью.СниженнаяНалоговаяСтавка <> ТаблицаПриЗаписи.СниженнаяНалоговаяСтавка
	|			ИЛИ ТаблицаПередЗаписью.ПроцентУменьшенияСуммыНалогаДо2020 <> ТаблицаПриЗаписи.ПроцентУменьшенияСуммыНалогаДо2020
	|			ИЛИ ТаблицаПередЗаписью.СуммаУменьшенияСуммыНалога <> ТаблицаПриЗаписи.СуммаУменьшенияСуммыНалога
	|			ИЛИ ТаблицаПередЗаписью.Организация ЕСТЬ NULL
	|			ИЛИ Подстрока(ТаблицаПередЗаписью.Комментарий, 1, 500) <> Подстрока(ТаблицаПриЗаписи.Комментарий, 1, 500)
	|			ИЛИ ТаблицаПередЗаписью.ОснованиеЛьготыПоНалоговойБазе <> ТаблицаПриЗаписи.ОснованиеЛьготыПоНалоговойБазе
	|			ИЛИ ТаблицаПередЗаписью.НачалоДействияЛьготыПоНалоговойБазе <> ТаблицаПриЗаписи.НачалоДействияЛьготыПоНалоговойБазе
	|			ИЛИ ТаблицаПередЗаписью.ОкончаниеДействияЛьготыПоНалоговойБазе <> ТаблицаПриЗаписи.ОкончаниеДействияЛьготыПоНалоговойБазе
	|			ИЛИ ТаблицаПередЗаписью.ОснованиеЛьготыСнижениеСтавки <> ТаблицаПриЗаписи.ОснованиеЛьготыСнижениеСтавки
	|			ИЛИ ТаблицаПередЗаписью.НачалоДействияЛьготыСнижениеСтавки <> ТаблицаПриЗаписи.НачалоДействияЛьготыСнижениеСтавки
	|			ИЛИ ТаблицаПередЗаписью.ОкончаниеДействияЛьготыСнижениеСтавки <> ТаблицаПриЗаписи.ОкончаниеДействияЛьготыСнижениеСтавки
	|			ИЛИ ТаблицаПередЗаписью.ОснованиеЛьготыСнижениеСуммыНалога <> ТаблицаПриЗаписи.ОснованиеЛьготыСнижениеСуммыНалога
	|			ИЛИ ТаблицаПередЗаписью.НачалоДействияЛьготыСнижениеСуммыНалога <> ТаблицаПриЗаписи.НачалоДействияЛьготыСнижениеСуммыНалога
	|			ИЛИ ТаблицаПередЗаписью.ОкончаниеДействияЛьготыСнижениеСуммыНалога <> ТаблицаПриЗаписи.ОкончаниеДействияЛьготыСнижениеСуммыНалога)
	|		И ТаблицаПриЗаписи.Организация.ЮридическоеФизическоеЛицо <> ЗНАЧЕНИЕ(Перечисление.ЮридическоеФизическоеЛицо.ФизическоеЛицо)
	|		И ТаблицаПриЗаписи.Регистратор = &Регистратор
	|		И ТаблицаПриЗаписи.ДатаИсправления = ДАТАВРЕМЯ(1,1,1)
	|
	|	) КАК Таблица
	|
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|УНИЧТОЖИТЬ ПараметрыНачисленияЗемельногоНалогаПередЗаписью";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Регистратор", Отбор.Регистратор.Значение);
	
	Выборка = Запрос.ВыполнитьПакет()[0].Выбрать();
	ПроведениеДокументов.ЗарегистрироватьТаблицуКонтроля(ДополнительныеСвойства,
		"ПараметрыНачисленияЗемельногоНалогаИзменение", Выборка.Следующий() И Выборка.Количество > 0);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
