#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура("КлючВарианта", "ДвиженияТоваровПереданныхНаКомиссию25");
	
	ОткрытьФорму("Отчет.ВедомостьПоТоварамОрганизацийВЦенахНоменклатуры.Форма", 
			ПараметрыФормы, 
			ПараметрыВыполненияКоманды.Источник, 
			ПараметрыВыполненияКоманды.Уникальность, 
			ПараметрыВыполненияКоманды.Окно, 
			ПараметрыВыполненияКоманды.НавигационнаяСсылка);
		
КонецПроцедуры

#КонецОбласти 