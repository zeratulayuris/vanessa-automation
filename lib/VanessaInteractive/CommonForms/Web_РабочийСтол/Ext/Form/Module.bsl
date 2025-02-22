﻿
#Область ОписаниеПеременных

&НаКлиенте
Перем WshShell;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Страницу будем создавать программно, не из макета.
	//МакетБиблиотекиJavaScript = ПолучитьОбщийМакет("Web_БиблиотекаJavaScript");
	//МестоположениеБиблиотекиJavaScript = ПоместитьВоВременноеХранилище(МакетБиблиотекиJavaScript, УникальныйИдентификатор);
	//МакетЗвуковыхФайлов = ПолучитьОбщийМакет("Web_ЗвуковойФайл");
	//МестоположениеЗвуковыхФайлов = ПоместитьВоВременноеХранилище(МакетЗвуковыхФайлов, УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	#Если ВебКлиент Тогда
	Отказ = Истина;
	Возврат;
	#КонецЕсли
	
	#Если НЕ ВебКлиент Тогда
	
	#КонецЕсли
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьВэбКлиент(Команда)
	
	#Если НЕ ВебКлиент Тогда
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	АдресПубликации = АдресБазы;
	
	// Подставляем вместо параметров путь проекта
	ШаблонКомандаЗапускаБраузера = 
		"start chrome --start-maximized --new-window ""http://%2:@%1/hs/ExchangeWithWebClient/"" ";
	КомандаЗапускаБраузера = СтрШаблон(ШаблонКомандаЗапускаБраузера, АдресБазы, ИмяПользователя());
	КомандаЗапускаChrome(КомандаЗапускаБраузера);
	#КонецЕсли
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура КомандаЗапускаChrome(Команда)
	
	ВыполнитьКомандуОСБезПоказаЧерногоОкна(Команда);
	
КонецПроцедуры

// Выполняет команду системы, при этом на экране не будет показано окно cmd
// Использует WshShell.
//
// Параметры:
//  СтрокаКоманды		 - Строка - выполняемая команда
//  ЖдатьОкончания		 - Число  - флаг ожидания окончания выполнения команды:
//
// Возвращаемое значение:
//   - Результат выполнения скрипта. 0 - если не было ошибок.
//
&НаКлиенте
Функция ВыполнитьКомандуОСБезПоказаЧерногоОкна(Знач ТекстКоманды, ЖдатьОкончания = -1) Экспорт
	#Если НЕ ВебКлиент Тогда
		
	ТекстКоманды = СтрЗаменить(ТекстКоманды, "%", "%%");
		
	Если ЭтоLinux Тогда
			
		КомандаСистемы(ТекстКоманды);
		Возврат 0;
		
	КонецЕсли;
		
	// если ЖдатьОкончания = -1, тогда будет ожидание окончания работы приложения
	
	ИмяВременногоФайлаКоманды = ПолучитьИмяВременногоФайла("bat");
	
	// эти две строки нужны для записи файла без BOM - начало
	ЗТ = Новый ЗаписьТекста(ИмяВременногоФайлаКоманды, КодировкаТекста.ANSI, , Ложь); 
	ЗТ.Закрыть();
	// эти две строки нужны для записи файла без BOM - окончание
	
	ЗТ = Новый ЗаписьТекста(ИмяВременногоФайлаКоманды, КодировкаТекста.UTF8, , Истина); 
	Если НЕ ЭтоWindowsXP Тогда
		ЗТ.ЗаписатьСтроку("chcp 65001"); 
	КонецЕсли;	 
	ЗТ.ЗаписатьСтроку(ТекстКоманды); 
	ЗТ.Закрыть();
	
	Если WshShell = Неопределено Тогда
		WshShell = ПолучитьWshShell();
		// Далее переменная WshShell будет закеширована, чтобы не создавать ComObject каждый раз
	КонецЕсли;	 
	Рез = WshShell.Run("""" + ИмяВременногоФайлаКоманды + """", 0, ЖдатьОкончания);
	
	Если ЖдатьОкончания = -1 И НЕ ЗапрещеныСинхронныеВызовы Тогда
		// иначе удалять нельзя
		Попытка
			УдалитьФайлыКомандаСистемы(ИмяВременногоФайлаКоманды);
		Исключение
			ЗаписатьЛогВЖРОшибка("VanessaAutomation.УдалениеВременногоФайла", СтрШаблон(
				//Локализовать("Не получилось удалить файл %1"),
				"Не получилось удалить файл %1", 
				ИмяВременногоФайлаКоманды
			));
		КонецПопытки;
	КонецЕсли;	 
	
	Возврат Рез;
	
	#КонецЕсли
КонецФункции

&НаКлиенте
Функция ПолучитьWshShell() Экспорт

	Если WshShell = Неопределено Тогда
		Попытка
			WshShell = Новый COMОбъект("WScript.Shell");
		Исключение
			//ВызватьИсключение Локализовать("Не удалось подключить COM объект <WScript.Shell>");
			ВызватьИсключение "Не удалось подключить COM объект <WScript.Shell>";
		КонецПопытки;
	КонецЕсли;
	
	Возврат WshShell;

КонецФункции

&НаКлиенте
Процедура УдалитьФайлыКомандаСистемы(Знач ИмяФайла) Экспорт
	#Если НЕ ВебКлиент Тогда
		
	Если НЕ ЗапрещеныСинхронныеВызовы Тогда
		УдалитьФайлы(ИмяФайла);
	ИначеЕсли ЗапрещеныСинхронныеВызовы И ВозможнаОптимизацияРаботыСФайлами Тогда
		УдалитьФайлыСервер(ИмяФайла);
	Иначе
		Если ЭтоLinux Тогда 
			ИмяФайла = СтрЗаменить(ИмяФайла, "\", "/");
			КомандаСистемы("rm -Rf """ + ИмяФайла + """");
		Иначе 
			ИмяФайла = СтрЗаменить(ИмяФайла, "/", "\");
			ВыполнитьКомандуОСБезПоказаЧерногоОкна("DEL /Q """ + ИмяФайла + """");
		КонецЕсли;
	КонецЕсли;
	
	#КонецЕсли
КонецПроцедуры

//Записывает произвольное событие в журнал регистрации с типом "Ошибка"
&НаКлиенте
Процедура ЗаписатьЛогВЖРОшибка(ИмяСобытия, Стр) Экспорт
	ЗаписатьЛогВЖРОшибкаСервер(ИмяСобытия, Стр);
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаписатьЛогВЖРОшибкаСервер(ИмяСобытия, Стр)
	ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , Стр);
КонецПроцедуры

&НаСервереБезКонтекста
Процедура УдалитьФайлыСервер(ИмяФайла)
	УдалитьФайлы(ИмяФайла);
КонецПроцедуры 

#КонецОбласти
