﻿
Процедура ОбработкаПроведения(Отказ, Режим)

	Движения.ОсновныеНачисления.Записывать = Истина;
	Движения.ДополнительныеНачисления.Записывать = Истина;
	Для Каждого ТекСтрокаОсновныеНачисления Из ОсновныеНачисления Цикл
		Если ТипЗнч(ТекСтрокаОсновныеНачисления.ВидРасчета) = Тип("ПланВидовРасчетаСсылка.ОсновныеНачисления") Тогда
			Движение = Движения.ОсновныеНачисления.Добавить();
			Движение.Сторно = Ложь;
			Движение.ВидРасчета = ТекСтрокаОсновныеНачисления.ВидРасчета;
			Движение.ПериодДействияНачало = ТекСтрокаОсновныеНачисления.ДатаНачала;
			Движение.ПериодДействияКонец = ТекСтрокаОсновныеНачисления.ДатаОкончания;
			Движение.ПериодРегистрации = НачалоМесяца(ТекСтрокаОсновныеНачисления.ДатаНачала);
			Движение.Сотрудник = ТекСтрокаОсновныеНачисления.Сотрудник;
			Движение.Размер = ТекСтрокаОсновныеНачисления.Размер;
			Если Движение.ВидРасчета = ПланыВидовРасчета.ОсновныеНачисления.Командировка Тогда
				Движение.БазовыйПериодНачало = ДобавитьМесяц(Движение.ПериодРегистрации, -2);
				Движение.БазовыйПериодКонец = Движение.ПериодРегистрации - 1;
			КонецЕсли;
			Движение.Часы = 0;
		ИначеЕсли ТипЗнч(ТекСтрокаОсновныеНачисления.ВидРасчета) = Тип("ПланВидовРасчетаСсылка.ДополнительныеНачисления") Тогда
			Движение = Движения.ДополнительныеНачисления.Добавить();
			Движение.Сторно = Ложь;
			Движение.ВидРасчета = ТекСтрокаОсновныеНачисления.ВидРасчета;
			Движение.ПериодДействияНачало = НачалоМесяца(ТекСтрокаОсновныеНачисления.ДатаНачала);
			Движение.ПериодДействияКонец = КонецМесяца(ТекСтрокаОсновныеНачисления.ДатаОкончания);
			Движение.ПериодРегистрации = НачалоМесяца(ТекСтрокаОсновныеНачисления.ДатаНачала);
			Движение.Сотрудник = ТекСтрокаОсновныеНачисления.Сотрудник;
			Движение.Размер = ТекСтрокаОсновныеНачисления.Размер;
			Если Движение.ВидРасчета = ПланыВидовРасчета.ДополнительныеНачисления.Премия Тогда
				к = 3;
				Движение.БазовыйПериодНачало = Движение.ПериодДействияНачало;
				Движение.БазовыйПериодКонец = Движение.ПериодДействияКонец;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	//Движения.ОсновныеНачисления.Записать();
	Движения.Записать();
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Измерения = Новый Массив;
	Измерения.Добавить("Сотрудник");
	Запрос.УстановитьПараметр("Измерения", Измерения);
		
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДГ.ПериодРегистрации КАК ПериодРегистрации,
	|	ДГ.Регистратор КАК Регистратор,
	|	ДГ.НомерСтроки КАК НомерСтроки,
	|	ДГ.ВидРасчета КАК ВидРасчета,
	|	ДГ.ПериодДействия КАК ПериодДействия,
	|	ДГ.ПериодДействияНачало КАК ПериодДействияНачало,
	|	ДГ.ПериодДействияКонец КАК ПериодДействияКонец,
	|	ДГ.Активность КАК Активность,
	|	ДГ.Сторно КАК Сторно,
	|	ДГ.Сотрудник КАК Сотрудник,
	|	ДГ.Сумма КАК Сумма,
	|	ДГ.Часы КАК Часы,
	|	ДГ.ЗначениеПериодДействия КАК ЗначениеПериодДействия,
	|	ДГ.ЗначениеФактическийПериодДействия КАК ЗначениеФактическийПериодДействия,
	|	ДГ.ЗначениеПериодРегистрации КАК ЗначениеПериодРегистрации
	|ПОМЕСТИТЬ ВТ_ДГ
	|ИЗ
	|	РегистрРасчета.ОсновныеНачисления.ДанныеГрафика(Регистратор = &Ссылка) КАК ДГ
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	База.НомерСтроки КАК НомерСтроки,
	|	База.СуммаБаза КАК СуммаБаза,
	|	База.ЧасыБаза КАК ЧасыБаза
	|ПОМЕСТИТЬ ВТ_База
	|ИЗ
	|	РегистрРасчета.ОсновныеНачисления.БазаОсновныеНачисления(&Измерения, &Измерения, , Регистратор = &Ссылка) КАК База
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	База.НомерСтроки КАК НомерСтроки,
	|	База.СуммаБаза КАК СуммаБаза
	|ПОМЕСТИТЬ ВТ_БазаПремии
	|ИЗ
	|	РегистрРасчета.ДополнительныеНачисления.БазаОсновныеНачисления(&Измерения, &Измерения, , Регистратор = &Ссылка) КАК База
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОН.ПериодРегистрации КАК ПериодРегистрации,
	|	ОН.Регистратор КАК Регистратор,
	|	ОН.НомерСтроки КАК НомерСтроки,
	|	ОН.ВидРасчета КАК ВидРасчета,
	|	ОН.ПериодДействия КАК ПериодДействия,
	|	ОН.ПериодДействияНачало КАК ПериодДействияНачало,
	|	ОН.ПериодДействияКонец КАК ПериодДействияКонец,
	|	ОН.Активность КАК Активность,
	|	ОН.Сторно КАК Сторно,
	|	ОН.Сотрудник КАК Сотрудник,
	|	ОН.Сумма КАК Сумма,
	|	ОН.Часы КАК Часы,
	|	ЕСТЬNULL(ВТ_ДГ.ЗначениеФактическийПериодДействия, 0) КАК ЧасыФакт,
	|	ЕСТЬNULL(ВТ_ДГ.ЗначениеПериодДействия, 0) КАК ЧасыГрафик,
	|	ЕСТЬNULL(ВТ_ДГ.ЗначениеПериодРегистрации, 0) КАК ЗначениеПериодРегистрации,
	|	ЕСТЬNULL(ВТ_База.СуммаБаза, 0) КАК БазаСумма,
	|	ЕСТЬNULL(ВТ_База.ЧасыБаза, 0) КАК ЧасыБаза
	|ИЗ
	|	РегистрРасчета.ОсновныеНачисления КАК ОН
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ДГ КАК ВТ_ДГ
	|		ПО ОН.НомерСтроки = ВТ_ДГ.НомерСтроки
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_База КАК ВТ_База
	|		ПО ОН.НомерСтроки = ВТ_База.НомерСтроки
	|ГДЕ
	|	ОН.Регистратор = &Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДН.ПериодРегистрации КАК ПериодРегистрации,
	|	ДН.Регистратор КАК Регистратор,
	|	ДН.НомерСтроки КАК НомерСтроки,
	|	ДН.ВидРасчета КАК ВидРасчета,
	|	ДН.БазовыйПериодНачало КАК БазовыйПериодНачало,
	|	ДН.БазовыйПериодКонец КАК БазовыйПериодКонец,
	|	ДН.Активность КАК Активность,
	|	ДН.Сторно КАК Сторно,
	|	ДН.Сотрудник КАК Сотрудник,
	|	ДН.Сумма КАК Сумма,
	|	ДН.Размер КАК Размер,
	|	ЕСТЬNULL(ВТ_БазаПремии.СуммаБаза, 0) КАК СуммаБаза
	|ИЗ
	|	РегистрРасчета.ДополнительныеНачисления КАК ДН
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_БазаПремии КАК ВТ_БазаПремии
	|		ПО ДН.НомерСтроки = ВТ_БазаПремии.НомерСтроки
	|ГДЕ
	|	ДН.Регистратор = &Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_БазаПремии.НомерСтроки КАК НомерСтроки,
	|	ВТ_БазаПремии.СуммаБаза КАК СуммаБаза
	|ИЗ
	|	ВТ_БазаПремии КАК ВТ_БазаПремии";
	Результаты = Запрос.ВыполнитьПакет();
	
	// Основные начисления
	Результат = Результаты[3];
	Выборка = Результат.Выбрать();
	Для Каждого ТекДвижение Из Движения.ОсновныеНачисления Цикл
		Если ТекДвижение.ВидРасчета = ПланыВидовРасчета.ОсновныеНачисления.Оклад Тогда
			Выборка.Сбросить();
			Если Выборка.НайтиСледующий(ТекДвижение.НомерСтроки, "НомерСтроки") Тогда
				ТекДвижение.Часы = Выборка.ЧасыФакт;
				ТекДвижение.Сумма = ?(Выборка.ЧасыГрафик = 0, 0, ТекДвижение.Размер * ТекДвижение.Часы / Выборка.ЧасыГрафик);
			КонецЕсли;
		ИначеЕсли ТекДвижение.ВидРасчета = ПланыВидовРасчета.ОсновныеНачисления.Командировка Тогда
			к = 3;
			Выборка.Сбросить();
			Если Выборка.НайтиСледующий(ТекДвижение.НомерСтроки, "НомерСтроки") Тогда
				ТекДвижение.Часы = Выборка.ЧасыФакт;
				ЧасоваяСтавка = Выборка.БазаСумма / ?(Выборка.ЧасыБаза = 0, 1, Выборка.ЧасыБаза);
				ТекДвижение.Размер = ЧасоваяСтавка;
				ТекДвижение.Сумма = ЧасоваяСтавка * ТекДвижение.Часы;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	Движения.ОсновныеНачисления.Записать(, Ложь);
	
	// Дополнительные начисления
	Результат = Результаты[4];
	Выборка = Результат.Выбрать();
	Для Каждого ТекДвижение Из Движения.ДополнительныеНачисления Цикл
		Если ТекДвижение.ВидРасчета = ПланыВидовРасчета.ДополнительныеНачисления.Премия Тогда
			Выборка.Сбросить();
			Если Выборка.НайтиСледующий(ТекДвижение.НомерСтроки, "НомерСтроки") Тогда
				ТекДвижение.Сумма = Выборка.СуммаБаза * ТекДвижение.Размер / 100;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	Движения.ДополнительныеНачисления.Записать(, Ложь);
	
КонецПроцедуры
