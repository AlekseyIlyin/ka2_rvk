#Область СлужебныйПрограммныйИнтерфейс

// Получает содержимое текущего лога запросов и помещает во временной хранилище.
// 
// Параметры:
// 	УникальныйИдентификаторФормы - УникальныйИдентификатор - Уникальный идентификатор формы.
// Возвращаемое значение:
// 	Строка - Адрес содержания лога во временном хранилище.
Функция АдресСодержанияЛоговЗапросов(УникальныйИдентификаторФормы) Экспорт
	
	ПараметрыЛогирования = ЛогированиеЗапросовИСМП.ПараметрыЛогированияЗапросов();
	СодержаниеЛогаЗапросов = ЛогированиеЗапросовИС.СодержаниеЛогаЗапросов(ПараметрыЛогирования);
	
	Возврат ПоместитьВоВременноеХранилище(СодержаниеЛогаЗапросов, УникальныйИдентификаторФормы);
	
КонецФункции

// см. ЛогированиеЗапросовИС.ВключитьЛогированиеЗапросов
Процедура ВключитьЛогированиеЗапросов(ЗаписыватьСекунд = 300, НовыйЛог = Ложь) Экспорт
	
	ПараметрыЛогирования = ЛогированиеЗапросовИСМП.ПараметрыЛогированияЗапросов();
	ЛогированиеЗапросовИС.ВключитьЛогированиеЗапросов(ПараметрыЛогирования, ЗаписыватьСекунд, НовыйЛог);
	ЛогированиеЗапросовИСМП.УстановитьПараметрыЛогированияЗапросов(ПараметрыЛогирования);
	
КонецПроцедуры

// Выводит содержимое в лог запросов.
// 
// Параметры:
//  ТекстДляВывода            - Строка - Текст для вывода в лог
//  Штрихкод                  - Неопределено, Массив из Структура - список данных штрихкодов для вывода в лог
//  РезультатРазбораШтрихКода - Неопределено, Массив Из Структура - даннные разбора штрихкода для вывода в лог
Процедура Вывести(ТекстДляВывода, Штрихкод = Неопределено, РезультатРазбораШтрихКода = Неопределено) Экспорт
	
	ДанныеЗаписи = ЛогированиеЗапросовИС.НоваяСтруктураДанныхЗаписи();
	ДанныеЗаписи.ТекстОшибки               = ТекстДляВывода;
	ДанныеЗаписи.Штрихкод                  = Штрихкод;
	ДанныеЗаписи.РезультатРазбораШтрихКода = РезультатРазбораШтрихКода;
	
	ПараметрыЛогированияЗапросов = ЛогированиеЗапросовИСМП.ПараметрыЛогированияЗапросов();
	ЛогированиеЗапросовИС.Вывести(ДанныеЗаписи, ПараметрыЛогированияЗапросов);
	
КонецПроцедуры

// см. ЛогированиеЗапросовИС.ВыполняетсяЛогированиеЗапросов
Функция ВыполняетсяЛогированиеЗапросов() Экспорт
	ПараметрыЛогирования = ЛогированиеЗапросовИСМП.ПараметрыЛогированияЗапросов();
	Возврат ЛогированиеЗапросовИС.ВыполняетсяЛогированиеЗапросов(ПараметрыЛогирования);
КонецФункции

Процедура ДописатьВТекущийЛогДанныеИзФоновогоЗадания(ДанныеОтвета) Экспорт
	ЛогированиеЗапросовИСМП.ДописатьВТекущийЛогДанныеИзФоновогоЗадания(ДанныеОтвета);
КонецПроцедуры

// Процедура осуществляет запись данных в лог ИС МП
// 
// Параметры:
//  СтруктураДанныхДляЛогирования - см. ОбменДаннымиИСМПКлиентСервер.СтруктураДанныхЛогирования
Процедура ЗаписатьДанныеЛогирования(СтруктураДанныхДляЛогирования) Экспорт
	
	ПутьКФайлу = Неопределено;
	ОбщегоНазначенияИСМППереопределяемый.ПриОпределенииПутиКФайлуЛогирования(ПутьКФайлу);
	Если ПутьКФайлу <> Неопределено Тогда
		
		ОбщегоНазначенияИСМП.ВывестиHTTPЗапросВЛог(СтруктураДанныхДляЛогирования.HTTPЗапрос,
			СтруктураДанныхДляЛогирования.ПараметрыОтправкиHTTPЗапросов,
			СтруктураДанныхДляЛогирования.HTTPМетод,
			СтруктураДанныхДляЛогирования.ПутьКФайлу);
			
		ОбщегоНазначенияИСМП.ВывестиHTTPЗапросВЛог(СтруктураДанныхДляЛогирования.HTTPОтвет,
			Неопределено,
			Неопределено,
			ПутьКФайлу,
			СтруктураДанныхДляЛогирования.ТекстОшибки);
			
	КонецЕсли;
	
	ПараметрыЛогированияЗапросов = ЛогированиеЗапросовИСМП.ПараметрыЛогированияЗапросов();
	
	ДанныеЗаписи                          = ЛогированиеЗапросовИС.НоваяСтруктураДанныхЗаписи();
	ДанныеЗаписи.HTTPЗапросОтветЗаголовки = СтруктураДанныхДляЛогирования.HTTPЗапросЗаголовки;
	ДанныеЗаписи.HTTPЗапросОтветТело      = СтруктураДанныхДляЛогирования.HTTPЗапросТело;
	ДанныеЗаписи.HTTPМетод                = СтруктураДанныхДляЛогирования.HTTPМетод;
	ДанныеЗаписи.АдресРесурса             = ОбщегоНазначенияИСМП.URLЗапроса(,
		СтруктураДанныхДляЛогирования.ПараметрыОтправкиHTTPЗапросов,
		СтруктураДанныхДляЛогирования.HTTPМетод,
		СтруктураДанныхДляЛогирования.HTTPЗапросАдресРесурса);
	ДанныеЗаписи.ЛогироватьHTTPЗапрос     = Истина;
	ДанныеЗаписи.ЭмуляцияЗапроса          = СтруктураДанныхДляЛогирования.ЭмуляцияЗапроса;
	
	ЛогированиеЗапросовИС.Вывести(ДанныеЗаписи, ПараметрыЛогированияЗапросов);
	
	ДанныеЗаписи                          = ЛогированиеЗапросовИС.НоваяСтруктураДанныхЗаписи();
	ДанныеЗаписи.HTTPЗапросОтветЗаголовки = СтруктураДанныхДляЛогирования.HTTPОтветЗаголовки;
	ДанныеЗаписи.HTTPЗапросОтветТело      = СтруктураДанныхДляЛогирования.HTTPОтветТело;
	ДанныеЗаписи.HTTPОтветКодСостояния    = СтруктураДанныхДляЛогирования.HTTPОтветКодСостояния;
	ДанныеЗаписи.ТекстОшибки              = СтруктураДанныхДляЛогирования.ТекстОшибки;
	ДанныеЗаписи.ЛогироватьHTTPОтвет      = Истина;
	ДанныеЗаписи.ЭмуляцияЗапроса          = СтруктураДанныхДляЛогирования.ЭмуляцияЗапроса;
	
	ЛогированиеЗапросовИС.Вывести(ДанныеЗаписи, ПараметрыЛогированияЗапросов);
	
	Если СтруктураДанныхДляЛогирования.ПараметрыОтправкиHTTPЗапросов.Свойство("ДатаПоследнегоЗапроса") Тогда
		СтруктураДанныхДляЛогирования.ПараметрыОтправкиHTTPЗапросов.ДатаПоследнегоЗапроса = ТекущаяДатаСеанса();
	КонецЕсли;
	
	ЛогированиеЗапросовИСМП.ВывестиДанныеДляПротоколаОбмена(СтруктураДанныхДляЛогирования);
	
КонецПроцедуры

#КонецОбласти