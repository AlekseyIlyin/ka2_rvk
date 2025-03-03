#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Функция ТекущиеНастройки() Экспорт
	
	Результат = Новый Структура;
	
	Результат.Вставить("ПоказыватьЭлементыНастройкиИнтерфейса", Истина);
	Результат.Вставить("ПроверятьЗамечанияПередСозданиемДокументов", Истина);
	Результат.Вставить("ЗадаватьВопросОСохраненииСоответствийДляРаспознанныхСтрок", Ложь);
	Результат.Вставить("ВариантСохраненияСоответствий", Перечисления.ВариантыСохраненияСоответствийБРД.СохранятьАвтоматически);
	Результат.Вставить("ОткрыватьНовыеЭлементыСправочниковПослеСоздания", Ложь);
	
	Результат.Вставить("ФормаОбработчикаПоказыватьИзображенияВШапке", Ложь);
	
	Результат.Вставить("РаспознаватьВложенияИзПочты", Ложь);
	Результат.Вставить("ЧастотаОтправкиВложенийИзПочтыНаРаспознавание", 30);
	Результат.Вставить("ЭлектроннаяПочтаДляОбработкиВложений", Неопределено);
	Результат.Вставить("ДатаПоследнейОбработкиВложений", '00010101');
	
	Результат.Вставить("РаспознаватьФайлыИзКаталога", Ложь);
	Результат.Вставить("ЧастотаОтправкиФайловИзКаталогаНаРаспознавание", 30);
	Результат.Вставить("КаталогДляОбработкиФайлов", 0);
	Результат.Вставить("ВключаяВложенныеКаталоги", 0);
	
	Результат.Вставить("СкладПоУмолчанию");
	Результат.Вставить("АдресЭлПочты", "");
	
	Результат.Вставить("НеПрикреплятьИзображения", Ложь);
	Результат.Вставить("ПомечатьДокументОбработаннымПриНайденномВБазе", Истина);
	Результат.Вставить("ПриОбнаруженииДокументаПрикреплятьИзображениеАвтоматически", Ложь);
	Результат.Вставить("АвтоматическиУстанавливатьКонечноеСостояниеУПервичныхДокументов", Ложь);
	Результат.Вставить("СоздаватьСчетФактуруПриСозданииОснования", Ложь);
	
	Результат.Вставить("АвтоматическиУдалятьОбработанныеИПомеченныеНаУдаление", Истина);
	Результат.Вставить("ПериодОтсрочкиУдаленияУстаревшихДокументов", Перечисления.ПериодыОтсрочкиУдаленияУстаревшихДокументов.Через1Неделю);
	
	Результат.Вставить("АвтоматическиУдалятьНеобработанные", Истина);
	Результат.Вставить("ПериодОтсрочкиУдаленияНеобработанныхДокументов", Перечисления.ПериодыОтсрочкиУдаленияУстаревшихДокументов.Через3Месяца);
	
	Результат.Вставить("АвтоматическиРегистрироватьЧеки", Истина);
	
	// Извлечение сохраненных настроек
	
	ИзвлеченныеНастройки = ОбщегоНазначения.СкопироватьРекурсивно(Результат);
	
	МенеджерЗаписи = РегистрыСведений.ОбщиеНастройкиРаспознаваниеДокументов.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Прочитать();
	Если МенеджерЗаписи.Выбран() Тогда
		ЗаполнитьЗначенияСвойств(ИзвлеченныеНастройки, МенеджерЗаписи);
	КонецЕсли;

	// Применение настроек, отличающихся от значений по-умолчанию
	// Если настройка была добавлена, то при обновлении БД ресурс будет иметь незаполненное значение
	// Потому после чтения следует незаполненные настроки привести к значениям по-умолчанию
	// Или же перенести к настройкам по-умолчанию заполненные прочитанные настройки.
	
	Для Каждого Настройка Из ИзвлеченныеНастройки Цикл
		
		Если ЗначениеЗаполнено(Настройка.Значение) Тогда
			Результат[Настройка.Ключ] = Настройка.Значение;
		КонецЕсли;
		
	КонецЦикла;
	
	// Обнуление настроек, сохраненных в базе, для временного отключения подсистемы.
	
	Результат.Вставить("РаспознаватьВложенияИзПочты", Ложь);
	Результат.Вставить("ЧастотаОтправкиВложенийИзПочтыНаРаспознавание", 30);
	Результат.Вставить("ЭлектроннаяПочтаДляОбработкиВложений", Неопределено);
	Результат.Вставить("ДатаПоследнейОбработкиВложений", '00010101');
	
	Результат.Вставить("РаспознаватьФайлыИзКаталога", Ложь);
	Результат.Вставить("ЧастотаОтправкиФайловИзКаталогаНаРаспознавание", 30);
	Результат.Вставить("КаталогДляОбработкиФайлов", 0);
	Результат.Вставить("ВключаяВложенныеКаталоги", 0);
	
	Возврат ОбщегоНазначения.ФиксированныеДанные(Результат);
	
КонецФункции

Процедура УстановитьАвтоматическиУдалятьОбработанныеИПомеченныеНаУдаление(Значение) Экспорт
	
	МенеджерЗаписи = РегистрыСведений.ОбщиеНастройкиРаспознаваниеДокументов.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Прочитать();
	МенеджерЗаписи.АвтоматическиУдалятьОбработанныеИПомеченныеНаУдаление = Значение;
	МенеджерЗаписи.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
