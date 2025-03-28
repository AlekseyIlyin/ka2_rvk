
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Для Каждого Элт Из СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок("Имя,ИННФЛ,ИННЮЛ,КПП,НаимОрг,Отчество,Фамилия,СумОпер", ",") Цикл 
		Параметры.Свойство(Элт, ЭтотОбъект[Элт]);
	КонецЦикла;
	Если ЗначениеЗаполнено(Фамилия) 
		Или ЗначениеЗаполнено(Имя) 
		Или ЗначениеЗаполнено(Отчество)
		Или ЗначениеЗаполнено(ИННФЛ) Тогда 
		
		ЮрФиз = 1;
	КонецЕсли;
	ВидимостьЭлементов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ЮрФизПриИзменении(Элемент)
	ВидимостьЭлементов(ЭтотОбъект);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ВидимостьЭлементов(Форма)
	Форма.Элементы.Фамилия.Видимость = (Форма.ЮрФиз = 1);
	Форма.Элементы.Имя.Видимость = (Форма.ЮрФиз = 1);
	Форма.Элементы.Отчество.Видимость = (Форма.ЮрФиз = 1);
	Форма.Элементы.ИННФЛ.Видимость = (Форма.ЮрФиз = 1);
	Форма.Элементы.НаимОрг.Видимость = (Форма.ЮрФиз = 0);
	Форма.Элементы.ИННЮЛ.Видимость = (Форма.ЮрФиз = 0);
	Форма.Элементы.КПП.Видимость = (Форма.ЮрФиз = 0);
	Если Форма.ЮрФиз = 0 Тогда 
		Форма.Фамилия = "";
		Форма.Имя = "";
		Форма.Отчество = "";
		Форма.ИННФЛ = "";
	Иначе
		Форма.НаимОрг = "";
		Форма.ИННЮЛ = "";
		Форма.КПП = "";
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Ок(Команда)
	Результат = Новый Структура();
	Для Каждого Элт Из СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок("Имя,ИННФЛ,ИННЮЛ,КПП,НаимОрг,Отчество,Фамилия,СумОпер", ",") Цикл 
		Результат.Вставить(Элт, ЭтотОбъект[Элт]);
	КонецЦикла;
	
	Если ЮрФиз = 0 Тогда
		Если ЗначениеЗаполнено(ИННЮЛ) и Не РегламентированныеДанныеКлиентСервер.ИННСоответствуетТребованиям(ИННЮЛ, Истина, "") Тогда 
			ОписаниеКА = "<Некорректно заполнен ИНН>";
			Результат.Вставить("ФлагОшибки", Истина);
		ИначеЕсли ЗначениеЗаполнено(КПП) и Не РегламентированнаяОтчетностьВызовСервера.КППСоответствуетТребованиямФНС(КПП) Тогда 
			ОписаниеКА = "<Некорректно заполнен КПП>";
			Результат.Вставить("ФлагОшибки", Истина);
		ИначеЕсли ЗначениеЗаполнено(НаимОрг) Тогда 
			ОписаниеКА = НаимОрг;
			Если ЗначениеЗаполнено(ИННЮЛ) Или ЗначениеЗаполнено(КПП) Тогда 
				ОписаниеКА = ОписаниеКА + ", ИНН/КПП: " + ИННЮЛ + "/" + КПП;
			КонецЕсли;
			Результат.Вставить("ФлагОшибки", Ложь);
		Иначе
			ОписаниеКА = "<Необходимо заполнить реквизиты контрагента>";
			Результат.Вставить("ФлагОшибки", Истина);
		КонецЕсли;
	Иначе
		Если ЗначениеЗаполнено(ИННФЛ) и Не РегламентированныеДанныеКлиентСервер.ИННСоответствуетТребованиям(ИННФЛ, Ложь, "") Тогда 
			ОписаниеКА = "<Некорректно заполнен ИНН>";
			Результат.Вставить("ФлагОшибки", Истина);
		ИначеЕсли ЗначениеЗаполнено(Фамилия) И ЗначениеЗаполнено(Имя) Тогда 
			ОписаниеКА = Фамилия + " " + Имя + " " + Отчество + ?(ЗначениеЗаполнено(ИННФЛ), ", ИНН: " + ИННФЛ, "");
			Результат.Вставить("ФлагОшибки", Ложь);
		Иначе
			ОписаниеКА = "<Необходимо заполнить фамилию и имя>";
			Результат.Вставить("ФлагОшибки", Истина);
		КонецЕсли;
	КонецЕсли;
	Результат.Вставить("ОписаниеКА", СокрЛП(СтрЗаменить(ОписаниеКА, "  ", " ")));
	Закрыть(Результат);
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть(Неопределено);
КонецПроцедуры
