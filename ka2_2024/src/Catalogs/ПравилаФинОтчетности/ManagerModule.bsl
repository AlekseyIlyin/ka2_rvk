#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Функция НайтиПоРеквизитам(Организация, Получатель, ИдентификаторКомплекта, Период = Неопределено) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Получатель", Получатель);
	Запрос.УстановитьПараметр("ИдентификаторКомплекта", ИдентификаторКомплекта);
	Запрос.УстановитьПараметр("Период", Период);
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	ПравилаФинОтчетности.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ПравилаФинОтчетности КАК ПравилаФинОтчетности
	|ГДЕ
	|	ПравилаФинОтчетности.Организация = &Организация
	|	И ПравилаФинОтчетности.Получатель = &Получатель
	|	И ПравилаФинОтчетности.ИдентификаторКомплекта = &ИдентификаторКомплекта
	|	И ПравилаФинОтчетности.НачалоВыполнения <= НАЧАЛОПЕРИОДА(&Период, МЕСЯЦ)
	|	И (ПравилаФинОтчетности.ОкончаниеВыполнения >= НАЧАЛОПЕРИОДА(&Период, МЕСЯЦ)
	|			ИЛИ ПравилаФинОтчетности.ОкончаниеВыполнения = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0))
	|	И ПравилаФинОтчетности.ПометкаУдаления = ЛОЖЬ";
	Если Период = Неопределено Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст,
			"ПравилаФинОтчетности.НачалоВыполнения <= НАЧАЛОПЕРИОДА(&Период, МЕСЯЦ)", "ИСТИНА");
		Запрос.Текст = СтрЗаменить(Запрос.Текст,
			"ПравилаФинОтчетности.ОкончаниеВыполнения >= НАЧАЛОПЕРИОДА(&Период, МЕСЯЦ)", "ИСТИНА");
	КонецЕсли;
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	Иначе
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		Возврат Выборка.Ссылка;
	КонецЕсли;
	
КонецФункции

Функция СрокиСдачиПоОрганизацииЗаПериод(Организация, НачалоОбзора, КонецОбзора) Экспорт
	
	Результат = Новый ТаблицаЗначений;
	Результат.Колонки.Добавить("Правило", Новый ОписаниеТипов("СправочникСсылка.ПравилаФинОтчетности"));
	Результат.Колонки.Добавить("Получатель", Новый ОписаниеТипов("СправочникСсылка.БанкиУниверсальногоОбмена"));
	Результат.Колонки.Добавить("ИдентификаторКомплекта", ОбщегоНазначения.ОписаниеТипаСтрока(100));
	Результат.Колонки.Добавить("Периодичность", Новый ОписаниеТипов("ПеречислениеСсылка.Периодичность"));
	Результат.Колонки.Добавить("НачалоВыполнения", ОбщегоНазначения.ОписаниеТипаДата(ЧастиДаты.Дата));
	Результат.Колонки.Добавить("ОкончаниеВыполнения", ОбщегоНазначения.ОписаниеТипаДата(ЧастиДаты.Дата));
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("НачалоОбзора", НачалоОбзора);
	Запрос.УстановитьПараметр("КонецОбзора", КонецОбзора);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПравилаФинОтчетности.Ссылка КАК Правило,
	|	ПравилаФинОтчетности.Получатель КАК Получатель,
	|	ПравилаФинОтчетности.ИдентификаторКомплекта КАК ИдентификаторКомплекта,
	|	ПравилаФинОтчетности.Периодичность КАК Периодичность,
	|	ПравилаФинОтчетности.НачалоВыполнения КАК НачалоВыполнения,
	|	ПравилаФинОтчетности.ОкончаниеВыполнения КАК ОкончаниеВыполнения
	|ИЗ
	|	Справочник.ПравилаФинОтчетности КАК ПравилаФинОтчетности
	|ГДЕ
	|	ПравилаФинОтчетности.ПометкаУдаления = ЛОЖЬ
	|	И ПравилаФинОтчетности.Организация = &Организация
	|	И ПравилаФинОтчетности.НачалоВыполнения <= &КонецОбзора
	|	И (ПравилаФинОтчетности.ОкончаниеВыполнения >= &НачалоОбзора
	|			ИЛИ ПравилаФинОтчетности.ОкончаниеВыполнения = ДАТАВРЕМЯ(1, 1, 1))
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПравилаФинОтчетности.Получатель,
	|	ПравилаФинОтчетности.ИдентификаторКомплекта,
	|	ПравилаФинОтчетности.НачалоВыполнения,
	|	ПравилаФинОтчетности.ОкончаниеВыполнения";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НачалоВыполнения = Выборка.НачалоВыполнения;
		ОкончаниеВыполнения = Выборка.ОкончаниеВыполнения;
		
		Отбор = Новый Структура;
		Отбор.Вставить("Получатель", Выборка.Получатель);
		Отбор.Вставить("ИдентификаторКомплекта", Выборка.ИдентификаторКомплекта);
		НайденныеСтроки = Результат.НайтиСтроки(Отбор);
		
		Если НайденныеСтроки.Количество() > 0 Тогда
			ПоследняяСтрока = НайденныеСтроки[НайденныеСтроки.ВГраница()];
			НачалоВыполнения = Макс(ПоследняяСтрока.ОкончаниеВыполнения, НачалоВыполнения);
			ОкончаниеВыполнения = Макс(ПоследняяСтрока.ОкончаниеВыполнения, ОкончаниеВыполнения);
			
			Если НачалоВыполнения = ОкончаниеВыполнения Тогда
				Продолжить;
			КонецЕсли;
		КонецЕсли;
		
		НоваяСтрока = Результат.Добавить();
		НоваяСтрока.Правило = Выборка.Правило;
		НоваяСтрока.Получатель = Выборка.Получатель;
		НоваяСтрока.ИдентификаторКомплекта = Выборка.ИдентификаторКомплекта;
		НоваяСтрока.Периодичность = Выборка.Периодичность;
		НоваяСтрока.НачалоВыполнения = НачалоВыполнения;
		НоваяСтрока.ОкончаниеВыполнения = ОкончаниеВыполнения;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Процедура УстановитьОкончаниеВыполнения(Правило, ОкончаниеВыполнения) Экспорт
	
	Попытка
		Объект = Правило.ПолучитьОбъект();
		Объект.ОкончаниеВыполнения = ОкончаниеВыполнения;
		Объект.Записать();
	Исключение
		ОписаниеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Ошибка'"), УровеньЖурналаРегистрации.Ошибка,
			Справочники.ПравилаФинОтчетности,, ОписаниеОшибки);
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)";
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецЕсли