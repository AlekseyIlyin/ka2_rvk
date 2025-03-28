#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Функция Настройки() Экспорт
	
	Настройки = РегистрыСведений.НастройкиПодключения1СПерсонал.СоздатьМенеджерЗаписи();
	Настройки.Прочитать();
	
	СтруктураНастроек = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(
							Настройки, Метаданные.РегистрыСведений.НастройкиПодключения1СПерсонал);
	
	Возврат СтруктураНастроек;

КонецФункции

Процедура УстановитьВерсиюAPI(ВерсияAPI) Экспорт

	НаборЗаписей = РегистрыСведений.НастройкиПодключения1СПерсонал.СоздатьНаборЗаписей();
	НаборЗаписей.Прочитать();
	Записывать = Ложь;
	Если НаборЗаписей.Количество() > 0 Тогда
		Если ВерсияAPI <> НаборЗаписей[0].ВерсияAPI Тогда
			НаборЗаписей[0].ВерсияAPI = ВерсияAPI;
			Записывать = Истина;
		КонецЕсли;
	Иначе
		ЗаписьНабора = НаборЗаписей.Добавить();
		ЗаписьНабора.ВерсияAPI = ВерсияAPI;
		Записывать = Истина;
	КонецЕсли;
	
	Если Записывать Тогда
		НаборЗаписей.Записать();
	КонецЕсли;

КонецПроцедуры

Процедура УстановитьВерсиюDTO(ВерсияDTO) Экспорт

	НаборЗаписей = РегистрыСведений.НастройкиПодключения1СПерсонал.СоздатьНаборЗаписей();
	НаборЗаписей.Прочитать();
	Записывать = Ложь;
	Если НаборЗаписей.Количество() > 0 Тогда
		Если ВерсияDTO <> НаборЗаписей[0].ВерсияDTO Тогда
			НаборЗаписей[0].ВерсияDTO = ВерсияDTO;
			Записывать = Истина;
		КонецЕсли;
	Иначе
		ЗаписьНабора = НаборЗаписей.Добавить();
		ЗаписьНабора.ВерсияDTO = ВерсияDTO;
		Записывать = Истина;
	КонецЕсли;
	
	Если Записывать Тогда
		НаборЗаписей.Записать();
	КонецЕсли;

КонецПроцедуры

Процедура УстановитьАдресПриложенияПоИмениДоступен(НовоеЗначение) Экспорт

	НаборЗаписей = РегистрыСведений.НастройкиПодключения1СПерсонал.СоздатьНаборЗаписей();
	НаборЗаписей.Прочитать();
	Записывать = Ложь;
	Если НаборЗаписей.Количество() > 0 Тогда
		Если НовоеЗначение <> НаборЗаписей[0].АдресПриложенияПоИмениДоступен Тогда
			НаборЗаписей[0].АдресПриложенияПоИмениДоступен = НовоеЗначение;
			Записывать = Истина;
		КонецЕсли;
	Иначе
		ЗаписьНабора = НаборЗаписей.Добавить();
		ЗаписьНабора.АдресПриложенияПоИмениДоступен = НовоеЗначение;
		Записывать = Истина;
	КонецЕсли;
	
	Если Записывать Тогда
		НаборЗаписей.Записать();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецЕсли