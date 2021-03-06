<?php

    require_once "../config.inc";
	
	use Core\Classes\System\CoreUsers;
	use Core\Classes\System\RSql;
	use_rights(CoreUsers::ADMIN);
	
	$types=array( 
		"TEXTLINE"=> "Строка текста до 1000 символов."
		,"PTEXT"=> "Абзац текста до 60 000 символов."
		,"FTEXT"=> "Форматированный текст до  32 Кб"
		,"CTEXT"=> "Контент до 8 Мб"
		,"NUMBER"=> "Целое число "
		,"BINT"=> "Целое число до 2<sup>64</sup>"
		,"CFLOAT"=> "Дробное число"
		,"CTIME"=> "Хранит время в формате ЧЧ:ММ:СС"
		,"CDATETIME"=> "Хранит дату и время."
		,"CHECKBOX"=> "Флажок. JSON  с полями checked и title"
		,"LIST"=> "Массив текстовых элементов."
		,"MAP"=> "Ассоциативный массив строковых элементов"
		,"JSON"=> "JSON-документ свободной природы."
		,"XML"=> "XML-документ"
		,"IMAGE"=> "Изображение из хранилища"
		,"FILE"=> "Файл из хранилища"
		,"EL"=> "Элемент другого каталога (ссылка на него)"
		,"TEMPLATE"=> "Шаблон"
		,"LINK"=> "Гиперссылка (URL)"
		,"LATLNG"=> "Координаты (широта, долгота)"
		,"CBOOL"=> "Логическое значение (0/1)"
	);

	$abstracts = '';
	foreach($types as $k=>$v){
		$abstracts.="<li data-type='$k'> <h3> $k</h3> <p> $v </p> </li>";
	}
?>