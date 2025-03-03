
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ВидПлана = Параметры.ВидПлана;
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Выбрать автоматически'");
	НоваяСтрока.ИмяВСервисе = "auto";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Модель 1с'");
	НоваяСтрока.ИмяВСервисе = "1C_model";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Экспоненциальное сглаживание'");
	НоваяСтрока.ИмяВСервисе = "exp_smoothing";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Экспоненциальное сглаживание на логарифмированных данных'");
	НоваяСтрока.ИмяВСервисе = "exp_smoothing_log";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Наивная модель (последнее известное значение продаж)'");
	НоваяСтрока.ИмяВСервисе = "naive";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Скользящее среднее'");
	НоваяСтрока.ИмяВСервисе = "rolling_mean3";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Скользящее среднее на логарифмированных данных'");
	НоваяСтрока.ИмяВСервисе = "rolling_mean3_log";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Сезонная модель'");
	НоваяСтрока.ИмяВСервисе = "season_mean";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Сезонное и трендовое разложение'");
	НоваяСтрока.ИмяВСервисе = "STL_model";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Модель Тригга-Лича'");
	НоваяСтрока.ИмяВСервисе = "TL_model";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Бустинг (решающие деревья)'");
	НоваяСтрока.ИмяВСервисе = "boosting_model";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'RNN (рекуррентные нейронные сети)'");
	НоваяСтрока.ИмяВСервисе = "rnn_model";
	
	НоваяСтрока = МоделиПрогнозирования.Добавить();
	НоваяСтрока.Имя = НСтр("ru = 'Экспериментальная модель со снижением размерности исходных данных'");
	НоваяСтрока.ИмяВСервисе = "dim_reduction_model";
	
	Попытка
		СтруктураОтвета = СервисПрогнозирования.ПолучитьКачествоМоделей(ВидПлана);
		
		Если ТипЗнч(СтруктураОтвета.ДесериализованноеЗначение) <> Тип("Массив") Тогда
			Возврат;
		КонецЕсли;
		
		Для Каждого ИсключенныйОбъект Из СтруктураОтвета.ДесериализованноеЗначение Цикл
			СтрокиМодели = МоделиПрогнозирования.НайтиСтроки(Новый Структура("ИмяВСервисе", ИсключенныйОбъект["model"]));
			Если СтрокиМодели.Количество() > 0 Тогда
				СтрокаМодели = СтрокиМодели[0];
				СтрокаМодели.Качество = "MAE: " + Число(ИсключенныйОбъект["MAE"]) + "; "
									+ "MAPE: " + Число(ИсключенныйОбъект["MAPE"]) + "; "
									+ "PMAPE: " + Число(ИсключенныйОбъект["PMAPE"]) + "; "
									+ "RMSE: " + Число(ИсключенныйОбъект["RMSE"]) + "; "
									+ "SMAPE: " + Число(ИсключенныйОбъект["SMAPE"]) + ";";
			КонецЕсли;
		КонецЦикла;
	Исключение
		ПредставлениеОшибки = ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(
			СервисПрогнозированияПереопределяемый.ТекстСобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Предупреждение,
			Неопределено, 
			Неопределено, 
			ПредставлениеОшибки);
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура МоделиПрогнозированияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Выбрать(Неопределено);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	ТекущаяСтрока = Элементы.МоделиПрогнозирования.ТекущиеДанные;
	
	ВыбранноеЗначение = "auto";
	Если ТекущаяСтрока <> Неопределено Тогда
		ВыбранноеЗначение = ТекущаяСтрока.ИмяВСервисе;
	КонецЕсли;
	
	ПараметрыОповещения = Новый Структура();
	ПараметрыОповещения.Вставить("ИмяВСервисе", ВыбранноеЗначение);
	
	Оповестить("ВыборМоделиПрогнозирования", ПараметрыОповещения, ВладелецФормы);
	
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти

