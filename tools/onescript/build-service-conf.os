﻿#Использовать v8runner
#Использовать logos

Перем Лог;

Процедура ОчиститьВременныйКаталог(ВременныйКаталог)
	Файлы = НайтиФайлы(ВременныйКаталог,"*",Ложь);
	Для Каждого Файл Из Файлы Цикл
		УдалитьФайлы(Файл.ПолноеИмя);
	КонецЦикла;	
КонецПроцедуры

Процедура ОбработатьФайлConfiguration_xml(ИмяФайла,Версия)
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("xml");
	
	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ИмяФайла,"UTF-8");
	
	ЗТ = Новый ЗаписьТекста(ИмяВременногоФайла,"UTF-8",,Ложь); 
	
	ЗначениеВерсия = "DontUse";
	Если Версия = "8.3.9" Тогда
		ЗначениеВерсия = "VERSION" + СтрЗаменить(Версия,".","_");
	ИначеЕсли (Версия >= "8.3.10") И (СтрДлина(Версия) = 6) Тогда
		ЗначениеВерсия = "VERSION" + СтрЗаменить(Версия,".","_");
	КонецЕсли;	 
	
	
	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;	 
		
		Если Найти(Стр,"<CompatibilityMode>") > 0 Тогда
			Стр = "			<CompatibilityMode>" + ЗначениеВерсия + "</CompatibilityMode>";
		КонецЕсли;	 
		
		ЗТ.ЗаписатьСтроку(Стр); 
	КонецЦикла;	
	
	Текст.Закрыть();
	ЗТ.Закрыть();
	
	КопироватьФайл(ИмяВременногоФайла,ИмяФайла);
	УдалитьФайлы(ИмяВременногоФайла);
КонецПроцедуры

Функция ПолучитьВременныйКаталог()
	ИмяФайла = ПолучитьИмяВременногоФайла();
	СоздатьКаталог(ИмяФайла);
	Возврат ИмяФайла;
КонецФункции	

Процедура СоздатьБазу82ЕслиЕёНет(_конфигурация)
	Если _конфигурация.Версия = "8.2" Тогда
		указательНаБазу = Новый Файл(_конфигурация.СоздаваемаяБаза + "\1Cv8.1cd");
		Если НЕ указательНаБазу.Существует() Тогда
			лог.Отладка("Создание сервисной базы контрибьютора 8.2" + _конфигурация.СоздаваемаяБаза);
			
			УправлениеКонфигуратором = Новый УправлениеКонфигуратором();
			путьКПлатформе = УправлениеКонфигуратором.ПолучитьПутьКВерсииПлатформы("8.2");
			УправлениеКонфигуратором.ПутьКПлатформе1С(путьКПлатформе);
			УправлениеКонфигуратором.КаталогСборки(".\tools\ServiceBases\");	
			УправлениеКонфигуратором.СоздатьФайловуюБазу(_конфигурация.СоздаваемаяБаза);
		КонецЕсли;	
	КонецЕсли;	 
КонецПроцедуры

Лог = Логирование.ПолучитьЛог("behavior.build.log");

массивСервисныхБаз = Новый Массив();
массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\82\",".\tools\ServiceBases\v82ServiceBase82", "8.3.6"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase836", "8.3.6"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase837", "8.3.7"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase838", "8.3.8"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase839", "8.3.9"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8310r01", "8.3.10"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8310r02", "8.3.10"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8310r03", "8.3.10"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8310r04", "8.3.10"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8310r05", "8.3.10"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8310", "8.3.10"));

//массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
//	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8311", "8.3.11"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8312", "8.3.12"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8313", "8.3.13"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8314", "8.3.14"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8315", "8.3.15"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8316", "8.3.16"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8317", "8.3.17"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8318", "8.3.18"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8319", "8.3.19"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8320", "8.3.20"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83\",".\tools\ServiceBases\v83ServiceBase8321", "8.3.21"));

массивСервисныхБаз.Добавить(Новый Структура("ПутьКИсходникам,СоздаваемаяБаза, Версия",
	".\lib\CF\83NoSync\",".\tools\ServiceBases\v83NoSyncServiceBase", "8.3.17"));
	

УправлениеКонфигуратором = Новый УправлениеКонфигуратором();
УправлениеКонфигуратором.КаталогСборки(".\tools\ServiceBases\");	

Для каждого _конфигурация из массивСервисныхБаз Цикл
	
	СоздатьБазу82ЕслиЕёНет(_конфигурация);
	
	Лог.Информация("Обрабатываю исходные файлы " + _конфигурация.ПутьКИсходникам + ", " + _конфигурация.Версия);
	указательНаБазу = Новый Файл(_конфигурация.СоздаваемаяБаза + "\1Cv8.1cd");
	Попытка
		путьКПлатформе = УправлениеКонфигуратором.ПолучитьПутьКВерсииПлатформы(_конфигурация.Версия);
	Исключение
		Лог.Информация("Платформа версии " + _конфигурация.Версия + " на данном компьютере не установлена.");
		Продолжить;
	КонецПопытки;
	УправлениеКонфигуратором.ПутьКПлатформе1С(путьКПлатформе);

	Если указательНаБазу.Существует() Тогда
		лог.Отладка("Ранее был создан каталог " + _конфигурация.СоздаваемаяБаза);
	Иначе
		лог.Отладка("Создание сервисной базы контрибьютора " + _конфигурация.СоздаваемаяБаза);
		УправлениеКонфигуратором.СоздатьФайловуюБазу(_конфигурация.СоздаваемаяБаза);
	КонецЕсли;	

	УправлениеКонфигуратором.УстановитьКонтекст("/F" + _конфигурация.СоздаваемаяБаза + "\","","");

	ПараметрыЗапуска = УправлениеКонфигуратором.ПолучитьПараметрыЗапуска();
	ПараметрыЗапуска.Добавить("/LoadConfigFromFiles """ + _конфигурация.ПутьКИсходникам + """"); 

	УправлениеКонфигуратором.ВыполнитьКоманду(ПараметрыЗапуска);

	
	Если Найти(_конфигурация.ПутьКИсходникам,"82") = 0 Тогда
		//теперь выгрузим конфу в файлы ещё раз и заменим параметр CompatibilityMode на DontUse, чтобы гарантировать, что не используется режим совместимости
		ВременныйКаталог = ПолучитьВременныйКаталог();
		
		ПараметрыЗапуска = УправлениеКонфигуратором.ПолучитьПараметрыЗапуска();
		ПараметрыЗапуска.Добавить("/DumpConfigToFiles  """ + ВременныйКаталог + """"); 
		УправлениеКонфигуратором.ВыполнитьКоманду(ПараметрыЗапуска);
		
		//Сообщить("ВременныйКаталог="+ВременныйКаталог);
		ОбработатьФайлConfiguration_xml(ВременныйКаталог + "\Configuration.xml",_конфигурация.Версия);
		
		//теперь загрузим конфу обратно
		ПараметрыЗапуска = УправлениеКонфигуратором.ПолучитьПараметрыЗапуска();
		ПараметрыЗапуска.Добавить("/LoadConfigFromFiles  """ + ВременныйКаталог + """"); 
		УправлениеКонфигуратором.ВыполнитьКоманду(ПараметрыЗапуска);
		
		ОчиститьВременныйКаталог(ВременныйКаталог);
	КонецЕсли;	 
	
	//УправлениеКонфигуратором.ВыполнитьСинтаксическийКонтроль();

	УправлениеКонфигуратором.ОбновитьКонфигурациюБазыДанных();

КонецЦикла;

//УправлениеКонфигуратором.ЗапуститьВРежимеПредприятия("",Истина);
