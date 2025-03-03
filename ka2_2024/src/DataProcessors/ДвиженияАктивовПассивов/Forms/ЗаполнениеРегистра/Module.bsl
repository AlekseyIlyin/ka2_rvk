#Область ОписаниеПеременных

&НаКлиенте
Перем ПараметрыОбработчикаОжидания;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("НеЗаписыватьДвижения") Тогда
		Обработки.ДвиженияАктивовПассивов.БалансовыеРегистры();
		НеЗаписыватьДвижения = Параметры.НеЗаписыватьДвижения;
		Элементы.НадписьВыполняетсяЗаполнение.Заголовок = НСтр("ru = 'Выполняется тестирование'") + "...";
	КонецЕсли;
	
	Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ЗаполнениеРегистров;
	ЗавершеноОбновление = Константы.ОтложенноеОбновлениеЗавершеноУспешно.Получить();
	Если НЕ ЗавершеноОбновление Тогда
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.НевозможноЗаполнить;
	КонецЕсли;
	
	Сведения = Константы.СведенияОбОбновленииИБ.Получить().Получить();
	Если ТипЗнч(Сведения) = Тип("Структура") И Сведения.Свойство("ЗаполнениеАктивовПассивов") Тогда
		Процесс = Сведения.ЗаполнениеАктивовПассивов;
		Если Пользователи.ТекущийПользователь() <> Процесс.Пользователь Тогда
			Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.НевозможноЗаполнить;
			Элементы.Декорация1.Картинка = БиблиотекаКартинок.Предупреждение32;
			Шаблон = НСтр("ru = 'Выполняется формирование движений управленческого баланса.
					|Формирование запустил %1 %2.'");
			Элементы.ПричинаОтказаВЗаполнении.Заголовок = СтрШаблон(Шаблон, Процесс.Пользователь, Процесс.ВремяЗапуска);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьИзмененияВИнтерфейсе();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Далее(Команда)
	
	Если Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаРезультат Тогда
		
		Закрыть(Истина);
		
	Иначе
		
		Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ВыполняетсяЗаполнение;
		ПодключитьОбработчикОжидания("ВыполнитьЗадание", 1, Истина);
		
	КонецЕсли;
	
	УстановитьИзмененияВИнтерфейсе();

КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Если ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ЗавершитьФоновоеЗадание(ИдентификаторЗадания);
	КонецЕсли;
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьДанныеНаСервере(Параметры)
	
	НаименованиеЗадания = НСтр("ru = 'Заполнение регистра активов и пассивов'");
	Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
		УникальныйИдентификатор,
		"Обработки.ДвиженияАктивовПассивов.СформироватьДвиженияПоРегистру",
		Параметры, 
		НаименованиеЗадания);
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ЗагрузитьРезультат()
	
	ПараметрыЗагрузки = ПолучитьИзВременногоХранилища(АдресХранилища);
	Источник = "";
	
	Индикатор = Элементы.Индикатор.МаксимальноеЗначение;
	Элементы.НадписьОбработано.Заголовок = "";

	Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.СтраницаРезультат;
		
	УстановитьИзмененияВИнтерфейсе();
	
КонецПроцедуры

// Унифицированная процедура проверки выполнения фонового задания
&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	ДанныеЗадания = ПолучитьИзВременногоХранилища(АдресХранилища);
	ОбновитьПрогресс(ДанныеЗадания);
	
	Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда 
		ЗагрузитьРезультат();
	Иначе
		ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания(
			"Подключаемый_ПроверитьВыполнениеЗадания", 
			ПараметрыОбработчикаОжидания.ТекущийИнтервал, 
			Истина);
	КонецЕсли;

КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторЗадания)
	
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
	
КонецФункции

// В зависимости от текущей страницы устанавливает доступность тех или иных полей для пользователя.
//
&НаСервере
Процедура УстановитьИзмененияВИнтерфейсе()
	
	Если Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ЗаполнениеРегистров Тогда
		Элементы.ФормаКнопкаДалее.Заголовок    = НСтр("ru ='Начать проведение >>'");
		Элементы.ФормаКнопкаОтмена.Доступность = Истина;
		Элементы.ФормаКнопкаДалее.Доступность  = Истина;
	ИначеЕсли Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.ВыполняетсяЗаполнение
		ИЛИ Элементы.СтраницыФормы.ТекущаяСтраница = Элементы.НевозможноЗаполнить Тогда
		Элементы.ФормаКнопкаДалее.Видимость  = Ложь;
		Элементы.ФормаКнопкаОтмена.Доступность = Истина;
	Иначе
		Элементы.ФормаКнопкаОтмена.Видимость   = Ложь;
		Элементы.ФормаКнопкаДалее.Заголовок    = НСтр("ru ='Готово'");
		Элементы.ФормаКнопкаДалее.Видимость    = Истина;
		Элементы.ФормаКнопкаДалее.Доступность  = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗавершитьФоновоеЗадание(ИдентификаторЗадания)
	
	ФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(ИдентификаторЗадания);
	Если ФоновоеЗадание <> Неопределено Тогда
		ФоновоеЗадание.Отменить();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьЗадание()
	
	ПараметрыЗагрузки = Новый Структура;
	ПараметрыЗагрузки.Вставить("ТекстСообщения", "");
	ПараметрыЗагрузки.Вставить("ЗагрузкаВыполнена", Ложь);
	ПараметрыЗагрузки.Вставить("НеЗаписыватьДвижения", НеЗаписыватьДвижения);
	
	Результат = ПолучитьДанныеНаСервере(ПараметрыЗагрузки);
	
	АдресХранилища = Результат.АдресХранилища;
	Если НЕ Результат.ЗаданиеВыполнено Тогда
		ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
	Иначе
		ЗагрузитьРезультат();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьПрогресс(ДанныеЗадания)

	Сведения = Константы.СведенияОбОбновленииИБ.Получить().Получить();
	Если ТипЗнч(Сведения) = Тип("Структура") И Сведения.Свойство("ЗаполнениеАктивовПассивов") Тогда
		Процесс = Сведения.ЗаполнениеАктивовПассивов; // см. Обработки.ДвиженияАктивовПассивов.ИнициализироватьСведенияОЗаполнении
		Элементы.Индикатор.МаксимальноеЗначение = Процесс.ВсегоДокументов;
		Индикатор = Процесс.ОбработаноДокументов;
		Элементы.НадписьОбработано.Заголовок = Процесс.Описание;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
