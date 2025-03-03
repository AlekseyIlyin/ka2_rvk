#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
	#Область ПрограммныйИнтерфейс

// Соотвествие со списком реквизитов, по которым определяется уникальность ключа
// 
// Возвращаемое значение:
//   Соответствие - ключ - имя реквизита 
//
Функция КлючевыеРеквизиты() Экспорт
	
	Возврат ОбщегоНазначенияУТ.КлючевыеРеквизитыСправочникаКлючейПоРегиструСведений(Метаданные.РегистрыСведений.АналитикаУчетаПоПартнерам);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ЗаменаДублейКлючейАналитики

Процедура ЗаменитьДублиКлючейАналитики() Экспорт
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ДанныеСправочника.Ссылка КАК Ссылка,
	|	ДанныеСправочника.ПометкаУдаления КАК ПометкаУдаления,
	|	Аналитика.КлючАналитики КАК КлючАналитики
	|ИЗ
	|	Справочник.КлючиАналитикиУчетаПоПартнерам КАК ДанныеСправочника
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрСведений.АналитикаУчетаПоПартнерам КАК ДанныеРегистра
	|	ПО
	|		ДанныеСправочника.Ссылка = ДанныеРегистра.КлючАналитики
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РегистрСведений.АналитикаУчетаПоПартнерам КАК Аналитика
	|	ПО
	|		ДанныеСправочника.Партнер = Аналитика.Партнер
	|		И ДанныеСправочника.Организация = Аналитика.Организация
	|		И ДанныеСправочника.Контрагент = Аналитика.Контрагент
	|		И ДанныеСправочника.Договор = Аналитика.Договор
	|		И ДанныеСправочника.НаправлениеДеятельности = Аналитика.НаправлениеДеятельности
	|ГДЕ
	|	ДанныеРегистра.КлючАналитики ЕСТЬ NULL
	|");
	
	// Сформируем соответствие ключей аналитики.
	СоответствиеАналитик = Новый Соответствие;
	
	РезультатЗапроса = Запрос.Выполнить();
	Если Не РезультатЗапроса.Пустой() Тогда
	
		Выборка = РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			СоответствиеАналитик.Вставить(Выборка.Ссылка, Выборка.КлючАналитики);
			
			Если Не Выборка.ПометкаУдаления Тогда
				СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
				Попытка
					СправочникОбъект.УстановитьПометкуУдаления(Истина, Ложь);
				Исключение
					ВызватьИсключение;
				КонецПопытки;
			КонецЕсли;

		КонецЦикла;
		
		Исключения = Новый Массив;
		Исключения.Добавить(Метаданные.РегистрыСведений.КоличествоЗаписейРегистраторовРасчетов);
		
		ОбщегоНазначенияУТ.ЗаменитьСсылки(СоответствиеАналитик, Исключения);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли