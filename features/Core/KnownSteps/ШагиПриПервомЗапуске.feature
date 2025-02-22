﻿# language: ru
# encoding: utf-8
#parent uf:
@UF10_Запуск_VA
#parent ua:
@UA35_запускать_интерактивно

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnUFSovm82Builds
@IgnoreOnWeb

@IgnoreOn836
@IgnoreOn837
@IgnoreOn838
@IgnoreOn839
@IgnoreOn8310

@SingleCodeCoverage
@ServerCodeCoverage




Функционал: Шаги при первом запуске



Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

	
Сценарий: Шаги при первом запуске
	Когда Я открываю VanessaAutomation в режиме TestClient со стандартной библиотекой		
	

	И я перехожу к закладке с именем "ГруппаСлужебная"
	И я перехожу к закладке с именем "ГруппаСлужебноеВыполнитьКод"
	И в поле с именем 'РеквизитПроизвольныйКод' я ввожу текст 
		|'ТаблицаУжеСуществующихСценариев.Очистить();'|
		|'ТаблицаИзвестныхStepDefinition.Очистить();'|
	И я нажимаю на кнопку с именем 'ВыполнитьПроизвольныйКод'
	
	И пауза 1
	
	И я перехожу к закладке с именем "ГруппаДополнительно"
	И я нажимаю на кнопку с именем 'ДобавитьИзвестныйШаг'

	И пауза 5
	
	Когда открылось окно 'Известные шаги*'
	
	Тогда таблица "ДеревоШагов" содержит строки
		| 'Тип'                    |
		| 'UI'                     |
		| 'Встроенный язык'        |
		| 'Переменные'             |
		| 'Объекты конфигурации'   |
		| 'Переменные среды'       |
		| 'Подключение TestClient' |
		| 'Прочее'                 |
		| 'Скриншоты'              |
		| 'Файлы'                  |


	
