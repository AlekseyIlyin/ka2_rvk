////////////////////////////////////////////////////////////////////////////////
// Подсистема "Расчет имущественных налогов".
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

#Область НалогНаИмущество

Процедура ПередРасчетомНалогаНаИмущество(ПараметрыРасчета, ДополнительныеПараметры = Неопределено) Экспорт

	РасчетИмущественныхНалоговУП.ПередРасчетомНалогаНаИмущество(ПараметрыРасчета, ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ПослеРасчетаНалогаНаИмущество(ПараметрыРасчета, ДополнительныеПараметры = Неопределено) Экспорт

	
КонецПроцедуры

Процедура ДобавитьТекстЗапросаКоэффициентыЕНВД_ПоОС(СписокЗапросов) Экспорт

	РасчетИмущественныхНалоговУП.ДобавитьТекстЗапросаКоэффициентыЕНВД_ПоОС(СписокЗапросов);
	
КонецПроцедуры

Процедура СоздатьВТКоэффициентыЕНВД(ПараметрыРасчета) Экспорт

	РасчетИмущественныхНалоговУП.СоздатьВТКоэффициентыЕНВД(ПараметрыРасчета);
	
КонецПроцедуры
 
Процедура СоздатьВТДвижимоеИмуществоПринятоеКУчетуПосле2013(ПараметрыРасчета, ДополнительныеПараметры = Неопределено) Экспорт

	РасчетИмущественныхНалоговУП.СоздатьВТДвижимоеИмуществоПринятоеКУчетуПосле2013(ПараметрыРасчета, ДополнительныеПараметры);
	
КонецПроцедуры

Процедура СформироватьТаблицуОССостоящиеНаУчете(ПараметрыРасчета, Период, ДополнительныеПараметры = Неопределено) Экспорт

	РасчетИмущественныхНалоговУП.СформироватьТаблицуОССостоящиеНаУчете(ПараметрыРасчета, Период, ДополнительныеПараметры);
	
КонецПроцедуры
  
Процедура СформироватьТаблицуСтавкиНалогаНаИмуществоПоОтдельнымОССрезПоследних(ПараметрыРасчета, Период, ДополнительныеПараметры = Неопределено, ИмяТаблицы = "") Экспорт

	РасчетИмущественныхНалоговУП.СформироватьТаблицуСтавкиНалогаНаИмуществоПоОтдельнымОССрезПоследних(
		ПараметрыРасчета, Период, ДополнительныеПараметры, ИмяТаблицы);
	
КонецПроцедуры

Процедура СформироватьТаблицуСтавкиНалогаНаИмуществоПоОтдельнымОСЗаписи(ПараметрыРасчета, НачалоПериода, КонецПериода, ДополнительныеПараметры = Неопределено, ИмяТаблицы = "") Экспорт

	РасчетИмущественныхНалоговУП.СформироватьТаблицуСтавкиНалогаНаИмуществоПоОтдельнымОСЗаписи(
		ПараметрыРасчета, НачалоПериода, КонецПериода, ДополнительныеПараметры, ИмяТаблицы);
	
КонецПроцедуры

Процедура СформироватьТаблицуСтавкиНалогаНаИмуществоСрезПоследних(ПараметрыРасчета, Период, ДополнительныеПараметры = Неопределено, ИмяТаблицы = "") Экспорт

	РасчетИмущественныхНалоговУП.СформироватьТаблицуСтавкиНалогаНаИмуществоСрезПоследних(
		ПараметрыРасчета, Период, ДополнительныеПараметры, ИмяТаблицы);
	
КонецПроцедуры

Процедура ДобавитьТекстЗапросаСписокОС(СписокЗапросов) Экспорт

	РасчетИмущественныхНалоговУП.ДобавитьТекстЗапросаСписокОС(СписокЗапросов);
	
КонецПроцедуры
 
Процедура ДобавитьТекстЗапросаСчетаБухгалтерскогоУчета(СписокЗапросов) Экспорт

	РасчетИмущественныхНалоговУП.ДобавитьТекстЗапросаСчетаБухгалтерскогоУчета(СписокЗапросов);
	
КонецПроцедуры
 
Процедура ДобавитьТекстЗапросаСтоимостьИАмортизация(Период, ПараметрыРасчета, СписокЗапросов, ДополнительныеПараметры = Неопределено) Экспорт

	РасчетИмущественныхНалоговУП.ДобавитьТекстЗапросаСтоимостьИАмортизация(Период, ПараметрыРасчета, СписокЗапросов, ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ДобавитьТекстЗапросаДанныеБухУчетаОС(СписокЗапросов) Экспорт

	РасчетИмущественныхНалоговУП.ДобавитьТекстЗапросаДанныеБухУчетаОС(СписокЗапросов);
	
КонецПроцедуры

Процедура ДобавитьТекстЗапросаУчетОсновныхСредств(Период, ПараметрыРасчета, СписокЗапросов) Экспорт

	РасчетИмущественныхНалоговУП.ДобавитьТекстЗапросаУчетОсновныхСредств(Период, ПараметрыРасчета, СписокЗапросов);
	
КонецПроцедуры

Процедура ДополнитьПараметрыРасчетаСтоимостиДвижимогоИмущества(ПараметрыРасчета, Организация, ПериодРасчета) Экспорт
		
КонецПроцедуры

Процедура ДополнитьПараметрыЗапросаДвижимогоИмущества(Запрос, Период) Экспорт 
	
	РасчетИмущественныхНалоговУП.ДополнитьПараметрыЗапросаДвижимогоИмущества(Запрос, Период);
	
КонецПроцедуры

Функция ИспользоватьПрежнийРасчетНалогаНаИмуществоВПереходныйПериод(Организация, ПериодРасчета) Экспорт
	
	Возврат РасчетИмущественныхНалоговУП.ИспользоватьПрежнийРасчетНалогаНаИмуществоВПереходныйПериод(Организация, ПериодРасчета);
	
КонецФункции

#КонецОбласти

#Область ТранспортныйНалог

Процедура ПередРасчетомТранспортногоНалога(ПараметрыРасчета, ДополнительныеПараметры = Неопределено) Экспорт

	
КонецПроцедуры

Процедура ПослеРасчетаТранспортногоНалога(ПараметрыРасчета, ДополнительныеПараметры = Неопределено) Экспорт

	
КонецПроцедуры

Функция ПолучитьАвансовыйРасчетПоТранспортномуНалогу(Организация, ПериодРасчета, ДополнительныеПараметры = Неопределено) Экспорт
	
	Возврат РасчетИмущественныхНалоговУП.ПолучитьАвансовыйРасчетПоТранспортномуНалогу(Организация, ПериодРасчета, ДополнительныеПараметры);

КонецФункции

Процедура СформироватьТаблицуРегистрацияТранспортныхСредствСрезПоследних(ПараметрыРасчета, Период, ДополнительныеПараметры = Неопределено, ИмяТаблицы = "") Экспорт

	РасчетИмущественныхНалоговУП.СформироватьТаблицуРегистрацияТранспортныхСредствСрезПоследних(
		ПараметрыРасчета, Период, ДополнительныеПараметры, ИмяТаблицы);
	
КонецПроцедуры

Процедура СформироватьТаблицуРегистрацияТранспортныхСредствЗаписи(ПараметрыРасчета, Период, ДополнительныеПараметры = Неопределено, ИмяТаблицы = "") Экспорт

	РасчетИмущественныхНалоговУП.СформироватьТаблицуРегистрацияТранспортныхСредствЗаписи(
		ПараметрыРасчета, Период, ДополнительныеПараметры, ИмяТаблицы);
	
КонецПроцедуры

Функция КодыВидовИКатегорииТранспортныхСредств() Экспорт

	Возврат РасчетИмущественныхНалоговУП.КодыВидовИКатегорииТранспортныхСредств();
		
КонецФункции

Функция УчестьРасходыНаПлатон(ПараметрыРасчета, ТаблицаРасчетНалога, ДополнительныеПараметры = Неопределено) Экспорт
	Возврат РасчетИмущественныхНалоговУП.УчестьРасходыНаПлатон(ПараметрыРасчета, ТаблицаРасчетНалога, ДополнительныеПараметры);
КонецФункции

#КонецОбласти

#Область ЗемельныйНалог

Процедура ПередРасчетомЗемельногоНалога(ПараметрыРасчета, ДополнительныеПараметры = Неопределено) Экспорт

	
КонецПроцедуры

Процедура ПослеРасчетаЗемельногоНалога(ПараметрыРасчета, ДополнительныеПараметры = Неопределено) Экспорт

	
КонецПроцедуры

Процедура СформироватьТаблицуРегистрацияЗемельныхУчастковСрезПоследних(ПараметрыРасчета, Период, ДополнительныеПараметры = Неопределено, ИмяТаблицы = "", УсловияЗапроса = "") Экспорт

	РасчетИмущественныхНалоговУП.СформироватьТаблицуРегистрацияЗемельныхУчастковСрезПоследних(
		ПараметрыРасчета, Период, ДополнительныеПараметры, ИмяТаблицы, УсловияЗапроса);
	
КонецПроцедуры

Процедура СформироватьТаблицуРегистрацияЗемельныхУчастковЗаписи(ПараметрыРасчета, Период, ДополнительныеПараметры = Неопределено, ИмяТаблицы = "") Экспорт

	РасчетИмущественныхНалоговУП.СформироватьТаблицуРегистрацияЗемельныхУчастковЗаписи(
		ПараметрыРасчета, Период, ДополнительныеПараметры, ИмяТаблицы);
	
КонецПроцедуры

#КонецОбласти

#Область ПрочиеЭкспортныеПроцедуры

// Это иностранная организация.
// 
// Параметры:
//  Организация - СправочникСсылка.Организации
//  Период      - Дата - Период
// 
// Возвращаемое значение:
//  Булево - Это иностранная организация
Функция ЭтоИностраннаяОрганизация(Организация, Период) Экспорт
	
	Возврат РасчетИмущественныхНалоговУП.ЭтоИностраннаяОрганизация(Организация, Период);
	
КонецФункции

Процедура УточнитьПараметрыРегистрацииОрганизацииВФНС(Параметры, Организация, Период) Экспорт

	РасчетИмущественныхНалоговУП.УточнитьПараметрыРегистрацииОрганизацииВФНС(Параметры, Организация, Период);
	
КонецПроцедуры

Процедура УточнитьПараметрыОсвобожденияОтУплатыНалогов(Параметры, ТаблицаРеквизиты) Экспорт

	ПараметрыРасчета = РасчетИмущественныхНалоговУП.ПодготовитьПараметрыРасчетНалога(ТаблицаРеквизиты);
	Реквизиты = ПараметрыРасчета.Реквизиты[0];
	
	РасчетИмущественныхНалоговУП.УточнитьПараметрыОсвобожденияОтУплатыНалогов(
		Параметры, Реквизиты.Организация, Реквизиты.Период);
	
КонецПроцедуры

Процедура СоздатьНалоговыеОрганыСУстановленнойУплатойАвансов(МенеджерВременныхТаблиц, СписокОрганизаций, Период, Налог) Экспорт

	РасчетИмущественныхНалоговУП.СоздатьНалоговыеОрганыСУстановленнойУплатойАвансов(
		МенеджерВременныхТаблиц, СписокОрганизаций, Период, Налог);
	
КонецПроцедуры

Функция ПодготовитьТаблицыРасчетНалога(ТаблицаРеквизиты, Отказ, ДополнительныеПараметры) Экспорт
	
	Возврат РасчетИмущественныхНалоговУП.ПодготовитьТаблицыРасчетНалога(ТаблицаРеквизиты, Отказ, ДополнительныеПараметры);

КонецФункции

Процедура СформироватьДвиженияРасчетНалога(ТаблицыНачислениеНалога, ТаблицаРеквизитов, Движения, Отказ, ДополнительныеПараметры) Экспорт

	РасчетИмущественныхНалоговУП.СформироватьДвиженияРасчетНалога(ТаблицыНачислениеНалога, ТаблицаРеквизитов, Движения, Отказ, ДополнительныеПараметры);

КонецПроцедуры

Функция ПустаяСправкаРасчет(ИмяРегистраСведений) Экспорт

	Возврат РасчетИмущественныхНалоговУП.ПустаяСправкаРасчет(ИмяРегистраСведений);
	
КонецФункции

Процедура ДополнитьПараметрыРасчетаНалогаНаИмущество(ПараметрыРасчета, Организация, ПериодРасчета, ДополнительныеПараметрыРасчета) Экспорт

	РасчетИмущественныхНалоговУП.ДополнитьПараметрыРасчетаНалогаНаИмущество(
		ПараметрыРасчета, 
		Организация, 
		ПериодРасчета, 
		ДополнительныеПараметрыРасчета);
	
КонецПроцедуры

Процедура УстановитьПараметрыЗапросаПриРасчетеНалогаЗаПериод(Запрос, Организация, Период) Экспорт
	
	РасчетИмущественныхНалоговУП.УстановитьПараметрыЗапросаПриРасчетеНалогаЗаПериод(Период, Запрос);
	
КонецПроцедуры

Функция ОрганизацииУплачивающиеАвансы(Организация, Период, Налог, ОднаОрганизация = Истина) Экспорт
	
	Возврат РасчетИмущественныхНалоговУП.ОрганизацииУплачивающиеАвансы(Организация, Период, Налог, ОднаОрганизация);
	
КонецФункции

Процедура ДополнитьПараметрыДвиженийСправкаРасчет(Реквизиты, ИмяРасчета, СписокОбязательныхКолонок) Экспорт

	РасчетИмущественныхНалоговУП.ДополнитьПараметрыДвиженийСправкаРасчет(Реквизиты, СписокОбязательныхКолонок);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
