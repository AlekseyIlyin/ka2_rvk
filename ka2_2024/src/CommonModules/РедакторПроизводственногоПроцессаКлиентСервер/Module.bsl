////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции редактора производственного процесса
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

#Область ЭтапПроизводства

// Устанавливает доступность реквизитов длительности этапа
// 
// Параметры:
// 	Объект - СправочникОбъект.ЭтапыПроизводства
// 	Форма - ФормаКлиентскогоПриложения
// 	ПрефиксЭлементов - Строка - префикс элементов
Процедура НастроитьЭлементыГруппыДлительностьЭтапа(Объект, Форма, ПрефиксЭлементов = "") Экспорт
	
	Элементы = Форма.Элементы;
	
	ДлительностьТолькоПросмотр = РассчитыватьДлительностьАвтоматически(Объект,
		Форма.ИспользуетсяПроизводство21,
		Форма.ИспользуетсяПланированиеПоМатериальнымРесурсам,
		Форма.ИспользуетсяПланированиеПоПроизводственнымРесурсам);
	
	СоответствиеЭлементов = СоответствиеЭлементов(ПрефиксЭлементов);
	
	Элементы[СоответствиеЭлементов.ДлительностьЭтапа].ТолькоПросмотр                 = ДлительностьТолькоПросмотр;
	Элементы[СоответствиеЭлементов.ЕдиницаИзмеренияДлительностиЭтапа].ТолькоПросмотр = ДлительностьТолькоПросмотр;
	
КонецПроцедуры


// Производит заполнение реквизитов пояснения настроек этапа
// 
// Параметры:
// 	Объект - СправочникОбъект.ЭтапыПроизводства
// 	Форма - ФормаКлиентскогоПриложения
// 	ПрефиксЭлементов - Строка - префикс элементов
Процедура ЗаполнитьПояснениеОсновныхНастроек(Объект, Форма, ПрефиксЭлементов = "") Экспорт
	
	МассивСтрок = Новый Массив;
	
	Элементы = Форма.Элементы;
	
	СоответствиеЭлементов = СоответствиеЭлементов(ПрефиксЭлементов);
	
	
	ГруппаПояснение = Элементы[СоответствиеЭлементов.ГруппаДлительность];
	ГруппаПояснение.Подсказка = ?(МассивСтрок.ВГраница() <> -1, СтрСоединить(МассивСтрок, Символы.ПС), "");
	
КонецПроцедуры

Функция ОбязательностьЗаполненияЕдиницИзмеренияБуферов(Объект) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("ЕдиницаИзмеренияПредварительногоБуфера", Ложь);
	Результат.Вставить("ЕдиницаИзмеренияЗавершающегоБуфера", Ложь);
	
	Если НЕ ЗначениеЗаполнено(Объект.ЕдиницаИзмеренияПредварительногоБуфера)
		И Объект.ПредварительныйБуфер <> 0 Тогда
		Результат.ЕдиницаИзмеренияПредварительногоБуфера = Истина;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Объект.ЕдиницаИзмеренияЗавершающегоБуфера)
		И Объект.ЗавершающийБуфер <> 0 Тогда
		Результат.ЕдиницаИзмеренияЗавершающегоБуфера = Истина;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция РассчитыватьДлительностьАвтоматически(Объект,
	ИспользуетсяПроизводство21,
	ИспользуетсяПланированиеПоМатериальнымРесурсам,
	ИспользуетсяПланированиеПоПроизводственнымРесурсам) Экспорт
	
	Возврат Объект.ПланироватьРаботуВидовРабочихЦентров
		И ИспользуетсяПроизводство21
		И НЕ ИспользуетсяПланированиеПоМатериальнымРесурсам
		И НЕ ИспользуетсяПланированиеПоПроизводственнымРесурсам;
	
КонецФункции

#Область ВидыРабочихЦентров


// Настраивает элементы страницы "Виды рабочих центров" 
// 
// Параметры:
// 	Объект - СправочникОбъект.ЭтапыПроизводства
// 	Форма - ФормаКлиентскогоПриложения
// 	ПрефиксЭлементов - Строка - префикс элементов
Процедура НастроитьЭлементыГруппыВидыРабочихЦентров(Объект, Форма, ПрефиксЭлементов = "") Экспорт
	
	Элементы = Форма.Элементы;
	
	СобственноеПроизводство = НЕ Объект.ПроизводствоНаСтороне;
		
	ИспользоватьВРЦ = Объект.ПланироватьРаботуВидовРабочихЦентров;
	
	Планирование22 = Форма.ИспользуетсяПроизводство22
		И Форма.ИспользуетсяПланированиеПоПроизводственнымРесурсам;
	
	ПланированиеПоЗагрузкеВРЦ = ИспользоватьВРЦ
		И (Планирование22 ИЛИ Форма.ИспользуетсяПроизводство21 ИЛИ Форма.ДинамическаяСтруктураЗаказовНаПроизводство);
	
	СоответствиеЭлементов = СоответствиеЭлементов(ПрефиксЭлементов);
	
	Элементы[СоответствиеЭлементов.СтраницаВидыРабочихЦентров].Видимость = ИспользоватьВРЦ;
	
	Если ИспользоватьВРЦ Тогда
		
		Элементы[СоответствиеЭлементов.ВидыРабочихЦентров].Видимость = Истина;
		
		Элементы[СоответствиеЭлементов.ГруппаОдновременноПроизводимоеКоличество].Видимость = Истина;
		
		Элементы[СоответствиеЭлементов.ИнтервалПланирования].Видимость = ПланированиеПоЗагрузкеВРЦ
			И СобственноеПроизводство;
			
		Элементы[СоответствиеЭлементов.ГруппаБуферы].Видимость = ПланированиеПоЗагрузкеВРЦ И СобственноеПроизводство;
		
		Элементы[СоответствиеЭлементов.Непрерывный].Видимость = ПланированиеПоЗагрузкеВРЦ
			И СобственноеПроизводство;
		
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти


#Область Прочее

Процедура УстановитьКартинкуЭлемента(ДанныеСтроки, КартинкиЭлементов = Неопределено) Экспорт
	
	Если ДанныеСтроки.ВидЭлемента = "Этап" Тогда
		ИндексКартинки = 0;
	КонецЕсли;
	
	Если КартинкиЭлементов = Неопределено Тогда
		КартинкиЭлементов = Новый Массив;
		КартинкиЭлементов.Добавить(БиблиотекаКартинок.РедакторПроизводственногоПроцессаЭтап);
	КонецЕсли;
	
	ДанныеСтроки.Картинка = КартинкиЭлементов[ИндексКартинки];
	
КонецПроцедуры

Функция СоответствиеЭлементов(ПрефиксЭлементов) Экспорт
	
	Результат = Новый Структура;
	
	Если ПрефиксЭлементов = "Этап" ИЛИ ПустаяСтрока(ПрефиксЭлементов) Тогда
		
		Результат.Вставить("ГруппаБуферы",                                          "ЭтапГруппаБуферы");
		Результат.Вставить("ГруппаДлительность",                                    "ЭтапГруппаДлительность");
		Результат.Вставить("ГруппаОдновременноПроизводимоеКоличество",              "ЭтапГруппаОдновременноПроизводимоеКоличество");
		Результат.Вставить("СтраницаВидыРабочихЦентров",                            "ЭтапСтраницаВидыРабочихЦентров");
		Результат.Вставить("СтраницаРазбиватьМаршрутныеЛисты",                      "ЭтапСтраницаРазбиватьМаршрутныеЛисты");
		Результат.Вставить("СтраницыРазбиватьМаршрутныеЛисты",                      "ЭтапСтраницыРазбиватьМаршрутныеЛисты");
		Результат.Вставить("СтраницаРазбиватьМаршрутныеЛистыПоМаршрутнойКарте",     "ЭтапСтраницаРазбиватьМаршрутныеЛистыПоМаршрутнойКарте");
		
		Результат.Вставить("Непрерывный",                                           "ЭтапНепрерывный");
		Результат.Вставить("ИнтервалПланирования",                                  "ЭтапИнтервалПланирования");
		
		Результат.Вставить("ВидыРабочихЦентров",                                    "ЭтапВидыРабочихЦентров");
		
		Результат.Вставить("ПорядокРаботыВидовРабочихЦентров",                      "ЭтапПорядокРаботыВидовРабочихЦентров");
		Результат.Вставить("СпособПроизводства",                                    "ЭтапСпособПроизводства");
		Результат.Вставить("КоэффициентМаршрутнойКарты",                            "ЭтапКоэффициентМаршрутнойКарты");
		Результат.Вставить("РассчитатьКоэффициентМаршрутнойКарты",                  "ЭтапРассчитатьКоэффициентМаршрутнойКарты");
		Результат.Вставить("РассчитыватьКоэффициент",                               "ЭтапРассчитыватьКоэффициент");

		Результат.Вставить("РазбиватьМаршрутныеЛистыПоМаршрутнойКарте",             "ЭтапРазбиватьМаршрутныеЛистыПоМаршрутнойКарте");
		Результат.Вставить("РазбиватьМаршрутныеЛисты",                              "ЭтапРазбиватьМаршрутныеЛисты");
		Результат.Вставить("МаксимальноеКоличествоЕдиницПартийИзделия",             "ЭтапМаксимальноеКоличествоЕдиницПартийИзделия");
		
		Результат.Вставить("НомерЭтапа",                                            "ЭтапНомерЭтапа");
		Результат.Вставить("НомерСледующегоЭтапа",                                  "ЭтапНомерСледующегоЭтапа");
		Результат.Вставить("Подразделение",                                         "ЭтапПодразделение");
		Результат.Вставить("СпособПроизводства",                                    "ЭтапСпособПроизводства");
		Результат.Вставить("ОдновременноПроизводимоеКоличествоЕдиницПартийИзделий", "ЭтапОдновременноПроизводимоеКоличествоЕдиницПартийИзделий");
		Результат.Вставить("ПланироватьРаботуВидовРабочихЦентров",                  "ЭтапПланироватьРаботуВидовРабочихЦентров");
		Результат.Вставить("ВидыРабочихЦентров",                                    "ЭтапВидыРабочихЦентров");
		Результат.Вставить("Партнер",                                               "ЭтапПартнер");
		Результат.Вставить("Организация",                                           "ЭтапОрганизация");
		Результат.Вставить("УслугиПереработчика",                                   "ЭтапУслугиПереработчика");
		Результат.Вставить("ГрафикРаботыПартнера",                                  "ЭтапГрафикРаботыПартнера");
		Результат.Вставить("ПорядокРаботыВидовРабочихЦентров",                      "ЭтапПорядокРаботыВидовРабочихЦентров");
		Результат.Вставить("ЗаполнитьВидыРабочихЦентров",                           "ЭтапЗаполнитьВидыРабочихЦентров");
		Результат.Вставить("ВидыРабочихЦентровДобавитьАльтернативный",              "ЭтапВидыРабочихЦентровДобавитьАльтернативный");
		Результат.Вставить("ПредварительныйБуфер",                                  "ЭтапПредварительныйБуфер");
		Результат.Вставить("ЗавершающийБуфер",                                      "ЭтапЗавершающийБуфер");
		Результат.Вставить("ЕдиницаИзмеренияПредварительногоБуфера",                "ЭтапЕдиницаИзмеренияПредварительногоБуфера");
		Результат.Вставить("ЕдиницаИзмеренияЗавершающегоБуфера",                    "ЭтапЕдиницаИзмеренияЗавершающегоБуфера");
		Результат.Вставить("ДлительностьЭтапа",                                     "ЭтапДлительностьЭтапа");
		Результат.Вставить("ЕдиницаИзмеренияДлительностиЭтапа",                     "ЭтапЕдиницаИзмеренияДлительностиЭтапа");
		
		Результат.Вставить("ЕстьПараллельнаяЗагрузка",                              "ЭтапЕстьПараллельнаяЗагрузка");
		Результат.Вставить("ЕстьСинхроннаяЗагрузка",                                "ЭтапЕстьСинхроннаяЗагрузка");
		
	КонецЕсли;
		
	
	Если ПустаяСтрока(ПрефиксЭлементов) Тогда
		Для каждого КлючИЗначение из Результат Цикл
			Результат[КлючИЗначение.Ключ] = КлючИЗначение.Ключ;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Виды элементов производственного процесса
// 
// Возвращаемое значение:
//  Массив из Строка - Виды элементов
Функция ВидыЭлементов() Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить("Этап");
	
	Возврат Результат;
	
КонецФункции

// Определяет вид элемента производственного процесса по переданной ссылке
// 
// Параметры:
//  Ссылка - СправочникСсылка.ЭтапыПроизводства
// 
// Возвращаемое значение:
//  Строка, Неопределено - Вид элемента по ссылке
Функция ВидЭлементаПоСсылке(Ссылка) Экспорт
	
	ТипЭлемента = ТипЗнч(Ссылка);
	
	Если ТипЭлемента = Тип("СправочникСсылка.ЭтапыПроизводства") Тогда
		Возврат "Этап";
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

// Имена типов элементов производственного процесса
// 
// Параметры:
//  Префикс - Строка - Префикс
// 
// Возвращаемое значение:
//  Массив из Строка - Имена типов элементов
Функция ИменаТиповЭлементов(Префикс = "") Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить(СтрШаблон("%1ЭтапыПроизводства", Префикс));
	
	Возврат Результат;
	
КонецФункции

// Имя типа элемента производственного процесса по ссылке.
// 
// Параметры:
//  Ссылка - СправочникСсылка.ЭтапыПроизводства
// 
// Возвращаемое значение:
//  Неопределено, Строка, Произвольный - Имя типа элемента по ссылке
Функция ИмяТипаЭлементаПоСсылке(Ссылка) Экспорт
	
	ТипЭлемента = ТипЗнч(Ссылка);
	Для каждого ИмяТипа Из ИменаТиповЭлементов() Цикл
		Если ТипЭлемента = Тип("СправочникСсылка."+ИмяТипа) Тогда
			Возврат ИмяТипа;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Конструктор структуры значения элемента производственного процесса.
// 
// Возвращаемое значение:
//  Структура - Структура - из:
// * Этап - СправочникСсылка.ЭтапыПроизводства
// * ЭтапПредставление - Строка
Функция СтруктураЗначенияЭлементаПроизводственногоПроцессаКонструктор() Экспорт
	
	Результат = Новый Структура;
	
	Результат.Вставить("Этап");
	Результат.Вставить("ЭтапПредставление", "");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецОбласти
