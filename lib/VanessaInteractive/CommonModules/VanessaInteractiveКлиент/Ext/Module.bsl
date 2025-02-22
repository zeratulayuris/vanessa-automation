﻿#Область ПрограммныйИнтерфейс

Функция ПолучитьФормуVanessaAutomation(ПараметрыПриложения) Экспорт
	
	Ванесса = ПараметрыПриложения["VanessaAutomation"];
	
	Если Ванесса = Неопределено Тогда
		ДопПараметры = Новый Структура;
		ДопПараметры.Вставить("ИнициализироватьVanessaEditor", Ложь);
		Ванесса = ПолучитьФорму("Обработка.VanessaAutomationsingle.Форма.УправляемаяФорма", ДопПараметры);
		ПараметрыПриложения.Вставить("VanessaAutomation", Ванесса);
	КонецЕсли;	
	
	Возврат Ванесса;
	
КонецФункции	

#КонецОбласти
