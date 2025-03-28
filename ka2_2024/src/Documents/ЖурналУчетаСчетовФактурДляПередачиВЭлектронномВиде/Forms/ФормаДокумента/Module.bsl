
#Область ОписаниеПеременных

&НаКлиенте
Перем ПараметрыОбработчикаОжидания;
&НаКлиенте
Перем ФормаДлительнойОперации;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	
	Если Параметры.Ключ.Пустая() Тогда
		ПодготовитьФормуНаСервере();
	КонецЕсли;
	
	РегламентированнаяОтчетностьКлиентСервер.ПриИнициализацииФормыРегламентированногоОтчета(ЭтаФорма);
	
	ЭлектронныйДокументооборотСКонтролирующимиОрганами.ОтметитьКакПрочтенное(Объект.Ссылка);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	ПодготовитьФормуНаСервере();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если ОрганизацияЗаполнения <> Объект.Организация
		ИЛИ НачалоКвартала(ПериодЗаполнения) <> НачалоКвартала(Объект.НалоговыйПериод) Тогда 
		ТекстВопроса	= НСтр("ru='Документ будет перезаполнен. Продолжить?'");
		Оповещение = Новый ОписаниеОповещения("ВопросЗаполнитьДокументЗавершение", ЭтотОбъект);
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		Отказ = Истина;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ЗаписыватьВХранилищеЗначения Тогда 
		ТекущийОбъект.ДополнительныеСвойства.Вставить("АдресДанныхДляПередачи", АдресХранилища);
		ЗаписыватьВХранилищеЗначения = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если НЕ Объект.Ссылка.Пустая()
		И ФорматПоПостановлению735 Тогда 
		ПодключитьОбработчикОжидания("Подключаемый_ВосстановитьИзХранилищаЗначения", 0.1, Истина);
	КонецЕсли;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	СохранитьСтатусОтправки();
	
	УстановитьСостояниеДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	Если Объект.ВыставленныеСчетаФактуры.Количество() > 0 
		ИЛИ Объект.ПолученныеСчетаФактуры.Количество() > 0 Тогда 
		Объект.ВыставленныеСчетаФактуры.Очистить();
		Объект.ПолученныеСчетаФактуры.Очистить();
	КонецЕсли;
	
	РегламентированнаяОтчетностьКлиентСервер.ПриИнициализацииФормыРегламентированногоОтчета(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура РеорганизацияПриИзменении(Элемент)
	
	УстановитьПериодПоСКНП();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаполнитьДокумент(Команда)

	Результат = ЗаполнитьДокументНаСервере();
	
	Если НЕ Результат.ЗаданиеВыполнено Тогда
		ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		АдресХранилища       = Результат.АдресХранилища;
		
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
		ФормаДлительнойОперации = ДлительныеОперацииКлиент.ОткрытьФормуДлительнойОперации(ЭтаФорма, ИдентификаторЗадания);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПредыдущийПериод(Команда)

	ИзменитьПериод(-1);

КонецПроцедуры

&НаКлиенте
Процедура СледующийПериод(Команда)

	ИзменитьПериод(1);

КонецПроцедуры

#Область ОтправкаВФНС

&НаКлиенте
Процедура ОтправитьВКонтролирующийОрган(Команда)
	
	РегламентированнаяОтчетностьКлиент.ПриНажатииНаКнопкуОтправкиВКонтролирующийОрган(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВИнтернете(Команда)
	
	РегламентированнаяОтчетностьКлиент.ПроверитьВИнтернете(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПодготовитьФормуНаСервере()
	
	УстановитьСостояниеДокумента();
	УправлениеФормой(ЭтаФорма);
	ОрганизацияЗаполнения = Объект.Организация;
	ПериодЗаполнения      = Объект.НалоговыйПериод;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВосстановитьИзХранилищаЗначения()
	
	Результат = ВосстановитьИзХранилищаЗначенияНаСервере();
	
	Если НЕ Результат.ЗаданиеВыполнено Тогда
		ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		АдресХранилища       = Результат.АдресХранилища;
		
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗаданияВосстановление", 1, Истина);
		ФормаДлительнойОперации = ДлительныеОперацииКлиент.ОткрытьФормуДлительнойОперации(ЭтаФорма, ИдентификаторЗадания);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ВосстановитьИзХранилищаЗначенияНаСервере()
	
	ПараметрыДляЗаполнения = Новый Структура;
	ПараметрыДляЗаполнения.Вставить("ДокументСсылка", 				Объект.Ссылка);
	НаименованиеЗадания = НСтр("ru = 'Открытие документа ""Журнал учета счетов-фактур для передачи в электронном виде""'");
	
	Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
	УникальныйИдентификатор,
	"Документы.ЖурналУчетаСчетовФактурДляПередачиВЭлектронномВиде.ВосстановитьДанныеДляОтправки", 
	ПараметрыДляЗаполнения, 
	НаименованиеЗадания);
	
	АдресХранилища = Результат.АдресХранилища;
	
	Если Результат.ЗаданиеВыполнено Тогда
		ВосстановитьДанные();
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Элементы = Форма.Элементы;
	Объект   = Форма.Объект;
	
	Форма.ФорматПоПостановлению735 = Объект.НалоговыйПериод >= '20141001';
	Форма.ПредставлениеНалоговогоПериода = ПредставлениеПериода(
		Объект.НалоговыйПериод,
		КонецКвартала(Объект.НалоговыйПериод),
		"ФП = Истина");
	
	Элементы.ТабличныйДокументФормат4кв2014.Видимость = Форма.ФорматПоПостановлению735;
	Элементы.СтраницыТабличнаяЧасть.Видимость         = НЕ Форма.ФорматПоПостановлению735;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьПериод(Шаг)
	
	Если Шаг > 0 Тогда 
		
		Число	= КонецДня(КонецКвартала(Объект.НалоговыйПериод));
		
		Число	= Число + 1;
		Объект.НалоговыйПериод	= НачалоКвартала(Число);
		
	ИначеЕсли Шаг < 0 Тогда 
		
		Число	= НачалоДня(Объект.НалоговыйПериод);
		
		Если Число = Дата(2012, 04, 01) Тогда
			ТекстСообщения	= НСтр("ru = 'Документ может быть составлен только в соответствии с постановлением Правительства Российской Федерации от 26 декабря 2011 г. № 1137'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "ПредставлениеНалоговогоПериода");
			Возврат;
		КонецЕсли;
		
		Число	= Число - 1;
		Объект.НалоговыйПериод	= НачалоКвартала(Число);
		
	КонецЕсли;
	
	Если Объект.ВыставленныеСчетаФактуры.Количество() > 0 Тогда 
		Объект.ВыставленныеСчетаФактуры.Очистить();
	КонецЕсли;
	
	Если Объект.ПолученныеСчетаФактуры.Количество() > 0 Тогда 
		Объект.ПолученныеСчетаФактуры.Очистить();
	КонецЕсли;
	
	УстановитьПериодПоСКНП();
	
	Объект.Дата	= КонецКвартала(Объект.НалоговыйПериод);
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПериодПоСКНП()
	
	ПериодПоСКНПНовый = УчетНДСКлиентСервер.ПолучитьКодПоСКНП(Объект.НалоговыйПериод, Объект.Реорганизация);
	
	Если ПериодПоСКНПНовый <> Объект.ПериодПоСКНП Тогда 
		Объект.ПериодПоСКНП = ПериодПоСКНПНовый;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСостояниеДокумента()
	
	СостояниеДокумента = ОбщегоНазначенияБП.СостояниеДокумента(Объект);
	
КонецПроцедуры

&НаКлиенте
Процедура ВопросЗаполнитьДокументЗавершение(Ответ, ДополнительныеПараметры) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		
		Результат = ЗаполнитьДокументНаСервере();
		
		Если НЕ Результат.ЗаданиеВыполнено Тогда
			ИдентификаторЗадания = Результат.ИдентификаторЗадания;
			АдресХранилища       = Результат.АдресХранилища;
			
			ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
			ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
			ФормаДлительнойОперации = ДлительныеОперацииКлиент.ОткрытьФормуДлительнойОперации(ЭтаФорма, ИдентификаторЗадания);
		КонецЕсли;
	Иначе
		Объект.Организация 		= ОрганизацияЗаполнения;
		Объект.НалоговыйПериод 	= ПериодЗаполнения;
		УправлениеФормой(ЭтаФорма);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЗаполнитьДокументНаСервере()

	ПараметрыДляЗаполнения = Новый Структура;
	ПараметрыДляЗаполнения.Вставить("Организация", 				Объект.Организация);
	ПараметрыДляЗаполнения.Вставить("НалоговыйПериод", 			Объект.НалоговыйПериод);
	ПараметрыДляЗаполнения.Вставить("ФорматПоПостановлению735", ФорматПоПостановлению735);
	
	ОрганизацияЗаполнения 	= Объект.Организация;
	ПериодЗаполнения 		= Объект.НалоговыйПериод;
	
	НаименованиеЗадания = НСтр("ru = 'Заполнение документа ""Журнал учета счетов-фактур для передачи в электронном виде""'");
	
	Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
		УникальныйИдентификатор, 
		"Документы.ЖурналУчетаСчетовФактурДляПередачиВЭлектронномВиде.ПодготовитьДанныеДляЗаполнения", 
		ПараметрыДляЗаполнения, 
		НаименованиеЗадания);
	
	АдресХранилища = Результат.АдресХранилища;
	
	Если Результат.ЗаданиеВыполнено Тогда
		ЗагрузитьПодготовленныеДанные();
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

&НаСервере
Процедура ЗагрузитьПодготовленныеДанные()

	СтруктураДанных = ПолучитьИзВременногоХранилища(АдресХранилища);
	
	Если ТипЗнч(СтруктураДанных) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	Если ФорматПоПостановлению735 Тогда
		
		ЗаписыватьВХранилищеЗначения = Истина;
		ТабличныйДокументФормат4кв2014.Очистить();
		ТабличныйДокументФормат4кв2014.Вывести(СтруктураДанных.СформированныйЖурнал);
		
	Иначе
		
		Если СтруктураДанных.Свойство("ВыставленныеСчетаФактуры") Тогда
			Объект.ВыставленныеСчетаФактуры.Загрузить(СтруктураДанных.ВыставленныеСчетаФактуры);
		КонецЕсли;
		
		Если СтруктураДанных.Свойство("ПолученныеСчетаФактуры") Тогда
			Объект.ПолученныеСчетаФактуры.Загрузить(СтруктураДанных.ПолученныеСчетаФактуры);
		КонецЕсли;
	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ВосстановитьДанные()
	
	ТаблицаДокумента = ПолучитьИзВременногоХранилища(АдресХранилища);
	Если ТаблицаДокумента <> Неопределено Тогда 
		ТабличныйДокументФормат4кв2014.Вывести(ТаблицаДокумента);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьДокумент(Команда)
	
	Если НЕ ПроверитьЗаполнениеНаСервере() Тогда
		Возврат;
	КонецЕсли;
	
	ВыгружаемыеДанные = ВыгрузитьНаСервере(УникальныйИдентификатор);
	
	Если ВыгружаемыеДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	#Если НЕ ВебКлиент Тогда
		ПутьВыгрузки = РегламентированнаяОтчетностьКлиент.ПолучитьПутьВыгрузки();
		Если ПутьВыгрузки = Ложь Тогда
			Возврат;
		КонецЕсли;
	#КонецЕсли
	
	Для Каждого ФайлВыгрузки Из ВыгружаемыеДанные Цикл
		
		#Если ВебКлиент Тогда
			Попытка
				ПолучитьФайл(ФайлВыгрузки.АдресФайлаВыгрузки, ФайлВыгрузки.ИмяФайлаВыгрузки);
			Исключение
				ТекстСообщения = НСтр("ru='Не удалось записать файл ""%1"". Возможно, недостаточно места на диске, диск защищен от записи или не подключено расширение для работы с файлами.'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ФайлВыгрузки.ИмяФайлаВыгрузки);
				
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = ТекстСообщения;
				Сообщение.Сообщить();
			КонецПопытки;
		#Иначе
			ДвоичныйФайл = ПолучитьИзВременногоХранилища(ФайлВыгрузки.АдресФайлаВыгрузки);
			Попытка
				ДвоичныйФайл.Записать(ПутьВыгрузки + ФайлВыгрузки.ИмяФайлаВыгрузки);
				
				ТекстСообщения = НСтр("ru='Файл выгрузки регламентированного отчета ""%1"" сохранен в каталог ""%2"".'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ФайлВыгрузки.ИмяФайлаВыгрузки, ПутьВыгрузки);
				
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = ТекстСообщения;
				Сообщение.Сообщить();
			Исключение
				ТекстСообщения = НСтр("ru='Не удалось записать файл ""%1"". Возможно, недостаточно места на диске или диск защищен от записи.'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ФайлВыгрузки.ИмяФайлаВыгрузки);
				
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = ТекстСообщения;
				Сообщение.Сообщить();
			КонецПопытки;
		#КонецЕсли
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ПроверитьЗаполнениеНаСервере()
	
	Возврат ПроверитьЗаполнение();
	
КонецФункции

&НаСервере
Функция ВыгрузитьНаСервере(УникальныйИдентификатор)
	
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;
	ОбъектДокумента = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектДокумента.ВыгрузитьДокумент(УникальныйИдентификатор);
	
КонецФункции

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	Попытка
		Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда 
			ЗагрузитьПодготовленныеДанные();
			ДлительныеОперацииКлиент.ЗакрытьФормуДлительнойОперации(ФормаДлительнойОперации);
		Иначе
			ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
			ПодключитьОбработчикОжидания(
				"Подключаемый_ПроверитьВыполнениеЗадания", 
				ПараметрыОбработчикаОжидания.ТекущийИнтервал, 
				Истина);
		КонецЕсли;
	Исключение
		ДлительныеОперацииКлиент.ЗакрытьФормуДлительнойОперации(ФормаДлительнойОперации);
		ВызватьИсключение ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗаданияВосстановление()
	
	Попытка
		Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда 
			ВосстановитьДанные();
			ДлительныеОперацииКлиент.ЗакрытьФормуДлительнойОперации(ФормаДлительнойОперации);
		Иначе
			ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
			ПодключитьОбработчикОжидания(
				"Подключаемый_ПроверитьВыполнениеЗаданияВосстановление", 
				ПараметрыОбработчикаОжидания.ТекущийИнтервал, 
				Истина);
		КонецЕсли;
	Исключение
		ДлительныеОперацииКлиент.ЗакрытьФормуДлительнойОперации(ФормаДлительнойОперации);
		ВызватьИсключение ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
	КонецПопытки;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторЗадания)
	
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
	
КонецФункции

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	Оповестить("Запись_ЖурналУчетаСчетовФактурДляПередачиВЭлектронномВиде", ПараметрыЗаписи, Объект.Ссылка);
	
КонецПроцедуры

#Область ПанельОтправкиВКонтролирующиеОрганы

&НаКлиенте
Процедура ОбновитьОтправку(Команда)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОбновитьОтправкуИзПанелиОтправки(ЭтаФорма, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаПротоколНажатие(Элемент)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьПротоколИзПанелиОтправки(ЭтаФорма, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьНеотправленноеИзвещение(Команда)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОтправитьНеотправленноеИзвещениеИзПанелиОтправки(ЭтаФорма, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ЭтапыОтправкиНажатие(Элемент)
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьСостояниеОтправкиИзПанелиОтправки(ЭтаФорма, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура КритическиеОшибкиОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылка, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьКритическиеОшибкиИзПанелиОтправки(ЭтаФорма, "ФНС");
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаНаименованиеЭтапаНажатие(Элемент)
	
	ПараметрыИзменения = Новый Структура;
	ПараметрыИзменения.Вставить("Форма", ЭтотОбъект);
	ПараметрыИзменения.Вставить("Организация", Объект.Организация);
	ПараметрыИзменения.Вставить("КонтролирующийОрган",
		ПредопределенноеЗначение("Перечисление.ТипыКонтролирующихОрганов.ФНС"));
	ПараметрыИзменения.Вставить("ТекстВопроса", НСтр("ru='Уведомление сдано?'"));
	
	ИнтерфейсыВзаимодействияБРОКлиент.ИзменитьСтатусОтправки(ПараметрыИзменения);
	
КонецПроцедуры

&НаСервере
Процедура СохранитьСтатусОтправки()
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("СсылкаНаОбъект", Объект.Ссылка);
	СтруктураПараметров.Вставить("Форма", ЭтаФорма);
	
	ИнтерфейсыВзаимодействияБРО.СохранитьСтатусОтправки(СтруктураПараметров);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти