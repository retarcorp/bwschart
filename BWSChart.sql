-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Янв 24 2018 г., 00:42
-- Версия сервера: 5.5.53
-- Версия PHP: 7.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `BWSChart`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cata_apps_folders`
--

CREATE TABLE `cata_apps_folders` (
  `id` int(11) NOT NULL,
  `c_order_id` int(11) DEFAULT NULL,
  `title` mediumtext,
  `type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_apps_folders`
--

INSERT INTO `cata_apps_folders` (`id`, `c_order_id`, `title`, `type`) VALUES
(1, 4, 'Общие', 0),
(2, 3, 'Инструменты разработчика', 0),
(3, 1, 'Приложения администрирования', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `cata_apps_items`
--

CREATE TABLE `cata_apps_items` (
  `id` int(11) NOT NULL,
  `c_order_id` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `icon` varchar(300) DEFAULT NULL,
  `link` varchar(300) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `information` mediumtext,
  `type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_apps_items`
--

INSERT INTO `cata_apps_items` (`id`, `c_order_id`, `parent`, `name`, `title`, `icon`, `link`, `version`, `information`, `type`) VALUES
(1, 1, 3, 'Pagen', 'Структура сайта', '/Core/img/apps/pagen.png ', '/Core/apps/Content', '1.20 ', ' ', 2),
(2, 2, 2, 'cata ', 'Каталоги Cata', '/Core/img/apps/cata.png ', '/Core/apps/Cata/ ', '1.20 ', ' ', 2),
(3, 3, 2, 'logger', 'Система отчетов', '/Core/img/apps/logger.png  ', '/Core/apps/Logger/', '1.20 ', ' ', 2),
(4, 4, 2, 'sql ', 'SQL-консоль', '/Core/img/apps/sql.png ', '/Core/apps/Sql/ ', '1.20 ', ' ', 0),
(5, 5, 2, 'FileManager', 'Файловый менеджер', '/Core/img/apps/fileManager.png ', '/Core/apps/FileManager/ ', '1.20 ', ' ', 2),
(6, 6, 2, 'imager ', 'Хранилище изображений', '/Core/img/apps/imager.png ', '/Core/apps/Imager ', '1.20 ', ' ', 2),
(7, 7, 1, 'backup ', 'Восстановление системы', '/Core/img/apps/backup.png ', '/Core/apps/Backup ', '1.20 ', ' ', 0),
(8, 8, 1, 'docs', 'Документация', '/Core/img/apps/docs.png', '/Core/apps/Docs', '1.20 ', '', 0),
(9, 9, 1, 'Users', 'Пользователи системы', '/Core/img/apps/users.png ', '/Core/apps/Users/ ', '1.20 ', ' ', 2),
(10, 10, 1, 'AppManager', 'Менеджер приложений', '/Core/img/apps/AppManager.png ', '/Core/apps/AppManager ', '1.20 ', ' ', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `cata_catalogs`
--

CREATE TABLE `cata_catalogs` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `tables` mediumtext,
  `skin` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_catalogs`
--

INSERT INTO `cata_catalogs` (`id`, `name`, `type`, `tables`, `skin`) VALUES
(1, 'cata_env', 1, '{\"cata_env_items\":{\"title\":\"TEXT\", \"name\":\"VARCHAR(255)\", \"value\":\"TEXT\"}}', ''),
(2, 'cata_apps', 2, '{\"cata_apps_folders\":{\"title\":\"VARCHAR(300)\",\"type\":\"INT\"},\"cata_apps_items\":{\"name\":\"VARCHAR(300)\",\"title\":\"VARCHAR(250)\",\"icon\":\"VARCHAR(300)\",\"link\":\"VARCHAR(300)\",\"version\":\"VARCHAR(10)\",\"information\":\"TEXT\",\"type\":\"INT\"}}', '{\"cata_apps_folders\":{\"title\":{\"type\":\"TEXTLINE\",\"title\":\"Название группы приложений\"},\"type\":{\"type\":\"NUMBER\",\"title\":\"Тип\"}},\"cata_apps_items\":{\"name\":{\"type\":\"TEXTLINE\",\"title\":\"Имя приложения в системе\"},\"title\":{\"type\":\"TEXTLINE\",\"title\":\"Заголовок приложения\"},\"icon\":{\"type\":\"TEXTLINE\",\"title\":\"URL картинки приложения\"},\"link\":{\"type\":\"TEXTLINE\",\"title\":\"Ссылка на приложение\"},\"version\":{\"type\":\"TEXTLINE\",\"title\":\"Версия приложения\"},\"information\":{\"type\":\"PTEXT\",\"title\":\"Описание приложения\"},\"type\":{\"type\":\"NUMBER\",\"title\":\"Тип приложения (по умолчанию установить 2)\"}}}'),
(3, 'cata_content', 3, '{\"cata_content_folders\":{\"title\":\"VARCHAR(1000)\",\"data\":\"TEXT\"},\"cata_content_templates\":{\"body\":\"MEDIUMTEXT\",\"head\":\"TEXT\",\"title\":\"VARCHAR(1000)\",\"data\":\"TEXT\"},\"cata_content_elements\":{\"title\":\"VARCHAR(1000)\",\"code\":\"MEDIUMTEXT\",\"default\":\"TEXT\",\"isAtomic\":\"TINYINT\",\"data\":\"TEXT\"}}', '\n{\"cata_content_folders\":{\"title\":{\"type\":\"TEXTLINE\",\"title\":\"Р СњР В°Р В·Р Р†Р В°Р Р…Р С‘Р Вµ Р С—Р В°Р С—Р С”Р С‘\"},\"data\":{\"type\":\"FTEXT\",\"title\":\"data\"}},\"cata_content_templates\":{\"body\":{\"type\":\"CTEXT\",\"title\":\"body\"},\"head\":{\"type\":\"FTEXT\",\"title\":\"head\"},\"title\":{\"type\":\"TEXTLINE\",\"title\":\"title\"},\"data\":{\"type\":\"FTEXT\",\"title\":\"data\"}},\"cata_content_elements\":{\"title\":{\"type\":\"TEXTLINE\",\"title\":\"title\"},\"code\":{\"type\":\"CTEXT\",\"title\":\"code\"},\"default\":{\"type\":\"PTEXT\",\"title\":\"default\"},\"isAtomic\":{\"type\":\"TINYINT\",\"title\":\"isAtomic\"},\"data\":{\"type\":\"PTEXT\",\"title\":\"data\"}}}'),
(5, 'test', 2, '{\"test_people\":{\"name\":\"VARCHAR(1000)\",\"surname\":\"VARCHAR(1000)\"},\"test_comments\":{\"text\":\"TEXT\"}}', '{\"test_people\":{\"name\":{\"type\":\"TEXTLINE\",\"title\":\"Р ?Р С?РЎРЏ\"},\"surname\":{\"type\":\"TEXTLINE\",\"title\":\"Р В¤Р В°Р С?Р С‘Р В»Р С‘РЎРЏ\"}},\"test_comments\":{\"text\":{\"type\":\"PTEXT\",\"title\":\"Р СћР ВµР С”РЎРѓРЎвЂљ\"}}}'),
(6, 'cata_imager', 2, '{\"cata_imager_folders\":{\"title\":\"VARCHAR(1000)\"},\"cata_imager_images\":{\"url\":\"VARCHAR(1000)\",\"title\":\"VARCHAR(1000)\",\"description\":\"TEXT\",\"size\":\"INT\"}}', '{\"cata_imager_folders\":{\"title\":{\"type\":\"TEXTLINE\",\"title\":\"Название\"}},\"cata_imager_images\":{\"url\":{\"type\":\"TEXTLINE\",\"title\":\"URL изображения\"},\"title\":{\"type\":\"TEXTLINE\",\"title\":\"Заголовок картинки\"},\"description\":{\"type\":\"PTEXT\",\"title\":\"Описание картинки\"},\"size\":{\"type\":\"NUMBER\",\"title\":\"Размер картинки\"}}}'),
(7, 'goods_1', 1, '{\"goods_1_items\":{\"title\":\"VARCHAR(1000)\",\"description\":\"TEXT\",\"price\":\"FLOAT\",\"image\":\"INT\",\"amount\":\"INT\",\"content\":\"MEDIUMTEXT\",\"term\":\"DATETIME\",\"data\":\"VARCHAR(2000)\"}}', '{\"goods_1_items\":{\"title\":{\"type\":\"TEXTLINE\",\"title\":\"Заголовок\"},\"description\":{\"type\":\"PTEXT\",\"title\":\"Описание\"},\"price\":{\"type\":\"CFLOAT\",\"title\":\"Стоимость\"},\"image\":{\"type\":\"IMAGE\",\"title\":\"Изображение\"},\"amount\":{\"type\":\"CBOOL\",\"title\":\"Есть в наличии\"},\"content\":{\"type\":\"CTEXT\",\"title\":\"Содержимое\"},\"term\":{\"type\":\"CDATETIME\",\"title\":\"Дата хранения\"},\"data\":{\"type\":\"LINK\",\"title\":\"Данные\"}}}'),
(8, 'cata_portals', 1, '{\"cata_portals_items\":{\"portal\":\"VARCHAR(1000)\",\"method\":\"VARCHAR(1000)\",\"args\":\"TEXT\",\"app\":\"VARCHAR(1000)\",\"data\":\"INT\"}}', '{\"cata_portals_items\":{\"portal\":{\"type\":\"TEXTLINE\",\"title\":\"Имя портала\"},\"method\":{\"type\":\"TEXTLINE\",\"title\":\"Исполняемый метод\"},\"args\":{\"type\":\"PTEXT\",\"title\":\"Описание аргументов\"},\"app\":{\"type\":\"TEXTLINE\",\"title\":\"Приложение-создатель\"},\"data\":{\"type\":\"INT\",\"title\":\"data\"}}}');

-- --------------------------------------------------------

--
-- Структура таблицы `cata_content_elements`
--

CREATE TABLE `cata_content_elements` (
  `id` int(11) NOT NULL,
  `c_order_id` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `title` varchar(1000) DEFAULT NULL,
  `code` longtext,
  `default` mediumtext,
  `isAtomic` tinyint(4) DEFAULT NULL,
  `data` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `cata_content_folders`
--

CREATE TABLE `cata_content_folders` (
  `id` int(11) NOT NULL,
  `c_order_id` int(11) DEFAULT NULL,
  `title` varchar(1000) DEFAULT NULL,
  `data` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_content_folders`
--

INSERT INTO `cata_content_folders` (`id`, `c_order_id`, `title`, `data`) VALUES
(7, 7, 'Тест', ''),
(8, 8, 'Тема сайта \"New\"', ''),
(9, 9, 'ООО ВТ-� есурс', '');

-- --------------------------------------------------------

--
-- Структура таблицы `cata_content_pages`
--

CREATE TABLE `cata_content_pages` (
  `id` int(11) NOT NULL,
  `parent` int(11) DEFAULT '0',
  `head` mediumtext,
  `body` longtext,
  `title` varchar(1000) DEFAULT NULL,
  `keywords` mediumtext,
  `description` mediumtext,
  `template` int(11) DEFAULT NULL,
  `url` varchar(2000) DEFAULT NULL,
  `data` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `cata_content_templates`
--

CREATE TABLE `cata_content_templates` (
  `id` int(11) NOT NULL,
  `c_order_id` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `body` longtext,
  `head` mediumtext,
  `title` varchar(1000) DEFAULT NULL,
  `data` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_content_templates`
--

INSERT INTO `cata_content_templates` (`id`, `c_order_id`, `parent`, `body`, `head`, `title`, `data`) VALUES
(1, 1, 9, '[[include path=\'/views/header.php\']]\r\n\r\n        <main>\r\n            <div class=\'wrap responsive\'>\r\n                <div class=\'crumbs\'>\r\n                    <ul>\r\n                        <li><a href=\'./\'>Р“Р»Р°РІРЅР°СЏ</a></li>\r\n                        <li><a href=\'./\'>РџРѕС‚СЂРµР±РёС‚РµР»СЏРј</a></li>\r\n                        <li><a href=\'\'>РўРµСЂСЂРёС‚РѕСЂРёСЏ РѕР±СЃР»СѓР¶РёРІР°РЅРёСЏ СЃРµС‚РµРІРѕР№ РѕСЂРіР°РЅРёР·Р°С†РёРё</a></li>\r\n                        <li><a href=\'\'>РћР±С‰Р°СЏ РёРЅС„РѕСЂРјР°С†РёСЏ</a></li>\r\n                    </ul>\r\n                </div>\r\n                <aside class=\'section-nav\'>\r\n                    <nav>\r\n                        <ul>\r\n                            <li>\r\n                                <a href=\'\'class=\'active\'>РўРµСЂСЂРёС‚РѕСЂРёСЏ РѕР±СЃР»СѓР¶РёРІР°СЋС‰РµР№ РѕСЂРіР°РЅРёР·Р°С†РёРё</a>\r\n                                <ol>\r\n                                    <li><a href=\'\'>РћР±С‰Р°СЏ РёРЅС„РѕСЂРјР°С†РёСЏ</a></li>\r\n                                    <li><a href=\'\'>РўРµС…РЅРёС‡РµСЃРєРѕРµ СЃРѕСЃС‚РѕСЏРЅРёРµ СЃРµС‚РµР№ </a></li>\r\n                                </ol>\r\n                            </li>\r\n                            <li><a href=\'\'>РџРµСЂРµРґР°С‡Р° СЌР»РµРєС‚СЂРёС‡РµСЃРєРѕР№ СЌРЅРµСЂРіРёРё</a></li>\r\n                            <li><a href=\'\'>РўРµС…РЅРѕР»РѕРіРёС‡РµСЃРєРѕРµ РїСЂРёСЃРѕРµРґРёРЅРµРЅРёРµ</a></li>\r\n                            <li><a href=\'\'>РљРѕРјРјРµСЂС‡РµСЃРєРёР№ СѓС‡РµС‚ СЌР»РµРєС‚СЂРёС‡РµСЃРєРѕР№ СЌРЅРµСЂРіРёРё</a></li>\r\n                            <li>\r\n                                <a href=\'\' >РћР±СЃР»СѓР¶РёРІР°РЅРёРµ РїРѕС‚СЂРµР±РёС‚РµР»РµР№</a>\r\n                                \r\n                            </li>\r\n                            \r\n                        </ul>\r\n                    </nav>\r\n                </aside>\r\n                <section class=\'section-content\'>\r\n                    <h2 atomic>РћР±С‰Р°СЏ РёРЅС„РѕСЂРјР°С†РёСЏ</h2>\r\n                    <div class=\'content\'>\r\n                        \r\n                        <div class=\'text\' richedit>\r\n                            <div>Condimentum vulputate ullamcorper a magna faucibus suspendisse leo sit congue natoque phasellus vestibulum scelerisque iaculis odio lorem leo ad nostra. A nascetur risus quis litora diam imperdiet felis tristique curabitur parturient in netus at non consectetur vivamus id parturient a augue orci vulputate suscipit curabitur curabitur. Adipiscing vestibulum vestibulum et id ligula at ut class nunc ad cum volutpat metus a cum senectus penatibus a nostra dis. Maecenas vestibulum consectetur duis parturient vestibulum vulputate sem fusce quisque condimentum cursus rutrum tellus imperdiet nam a augue dis accumsan vestibulum sem. At ad iaculis litora adipiscing nec luctus a nec pretium id ridiculus dignissim tempor arcu interdum ullamcorper. Mi sagittis dictumst elit hendrerit a faucibus eu arcu leo consectetur commodo habitasse proin senectus a elementum tempus vestibulum. Tellus pulvinar mollis est sodales a lectus urna consectetur pulvinar magna augue a sit mi.</div>\r\n                            \r\n                            <div>A natoque cum parturient vestibulum purus vestibulum feugiat tempus in urna sodales habitant imperdiet vehicula parturient vestibulum at quisque vestibulum ullamcorper aliquet maecenas purus nec. Posuere rhoncus non sed a convallis cum scelerisque consectetur a parturient arcu ac ullamcorper himenaeos accumsan rhoncus suspendisse molestie velit arcu a a enim mus aliquam ut taciti. Hac nostra dictum ullamcorper adipiscing taciti donec nostra id fringilla ad venenatis class commodo posuere purus augue justo amet vulputate a. Consectetur nibh enim duis lorem litora vel habitant euismod auctor viverra hac suspendisse ut netus a parturient ac. Nunc ac rhoncus scelerisque non natoque sociis libero ut etiam suscipit senectus a tortor a lobortis posuere primis condimentum.</div>\r\n                            \r\n                            <div>\r\n                                <ol>\r\n                                    <li>Enim pharetra lacinia bibendum vestibulum.</li>\r\n                                    <li>Lorem condimentum vestibulum quisque nulla a imperdiet sagittis fringilla</li>\r\n                                    <li>Scelerisque malesuada sit pretium arcu placerat suspendisse ultricies feugiat.</li>\r\n                                    <li>Ligula commodo torquent potenti orci dolor eget accumsan vestibulum litora.</li>\r\n                                    <li>Turpis himenaeos a mauris quis quam adipiscing a nam tempus scelerisque accumsan non scelerisque non dis erat adipiscing scelerisque netus donec adipiscing ad.Imperdiet a suspendisse himenaeos litora commodo condimentum magna eu erat proin a tincidunt dapibus lacus semper libero fames a volutpat.Pharetra nisl venenatis dictumst auctor consectetur hendrerit est dui diam tristique vestibulum. </li>\r\n                                </ol>\r\n                            </div>\r\n                            \r\n                            <div>Ullamcorper sit dapibus turpis suspendisse tristique consectetur vitae ullamcorper fermentum vestibulum vestibulum arcu eu duis a lorem a per nascetur sed et mattis. Facilisis a himenaeos condimentum facilisis conubia a habitasse sem nulla cras nisl urna integer a convallis vestibulum vitae.</div>\r\n                        </div>\r\n                        \r\n                        \r\n                    </div>\r\n                </section>\r\n            </div>\r\n        </main>\r\n\r\n        [[include path=\'/views/footer.php\']]', '<meta name=\'viewport\' content=\'initial-scale=1, width=device-width, user-scalable=no\'/>\r\n        <base href=\'/vtresurs\'/>\r\n        \r\n        \r\n        <link rel=\'stylesheet\' href=\'/css/main.css\'>\r\n        <link rel=\'stylesheet\' href=\'/css/section.css\'/>\r\n        \r\n        <script src=\'/js/jquery.js\'></script>\r\n        <link rel=\"stylesheet\" type=\"text/css\" href=\"//cdn.jsdelivr.net/jquery.slick/1.6.0/slick.css\"/>\r\n        <script type=\"text/javascript\" src=\"//cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js\"></script>\r\n        \r\n        \r\n        <script src=\'/js/index.js\'></script>', 'Текстовая страница', '');

-- --------------------------------------------------------

--
-- Структура таблицы `cata_env_items`
--

CREATE TABLE `cata_env_items` (
  `id` int(11) NOT NULL,
  `c_order_id` int(11) DEFAULT NULL,
  `title` mediumtext,
  `name` varchar(255) DEFAULT NULL,
  `value` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_env_items`
--

INSERT INTO `cata_env_items` (`id`, `c_order_id`, `title`, `name`, `value`) VALUES
(1, 1, 'Хост базы MySQL(только чтение)', 'mysql_hostname', 'localhost'),
(2, 2, 'Имя пользователя базы MySQL(только чтение)', 'mysql_username', 'host1316886_c20'),
(3, 3, 'Пароль базы MySQL(только чтение)', 'mysql_password', 'KC36QARa'),
(4, 4, 'Имя базы MySQL(только чтение)', 'mysql_maindb', 'host1316886_c20');

-- --------------------------------------------------------

--
-- Структура таблицы `cata_imager_folders`
--

CREATE TABLE `cata_imager_folders` (
  `id` int(11) NOT NULL,
  `c_order_id` int(11) NOT NULL,
  `title` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_imager_folders`
--

INSERT INTO `cata_imager_folders` (`id`, `c_order_id`, `title`) VALUES
(2, 2, 'Папка для приложения уровня 1'),
(3, 3, 'Новая папка 5'),
(4, 4, 'Новая папка');

-- --------------------------------------------------------

--
-- Структура таблицы `cata_imager_images`
--

CREATE TABLE `cata_imager_images` (
  `id` int(11) NOT NULL,
  `c_order_id` int(11) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `url` varchar(1000) DEFAULT NULL,
  `title` varchar(1000) DEFAULT NULL,
  `description` text,
  `size` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_imager_images`
--

INSERT INTO `cata_imager_images` (`id`, `c_order_id`, `parent`, `url`, `title`, `description`, `size`) VALUES
(2, 1, -1, '62da5751e11295cd433907e80afefd8f.png', '62da5751e11295cd433907e80afefd8f.png', '', 10037),
(10, 3, 4, '/img/Imager/972d8096fff0d61e0eae060fb034c53b.jpg', 'empty.jpg', '', 6465),
(12, 5, 4, '/img/Imager/c310fcced572a9dc7b75d9f50de23e5a.png', 'upload.png', '', 5652),
(13, 6, -1, '/img/Imager/b930e50917ae0aec59590ec866db7750.png', 'dom2.png', '', 10037),
(14, 7, -1, '/img/Imager/54631d329aef216b9332dbd1260f91be.png', 'dom3.png', '', 5067),
(15, 8, -1, '/img/Imager/56cfec5f2da21efb32fc5304767c7f44.png', 'dom1.png', '', 3181),
(16, 9, -1, '/img/Imager/3f62971eed8ca4701ae0729fbd184167.png', 'dom2.png', '', 10037),
(17, 10, -1, '/img/Imager/3f0a4fcd725d082547ba6e3f39d7a048.png', 'dom2.png', '', 10037),
(18, 11, -1, '/img/Imager/fc4ee1e4e72eb8bcc207e31abd15e0b2.png', 'dom1.png', '', 3181),
(19, 12, 2, '/img/Imager/70cbc0f623f989eb688a1c2a4fee899c.png', 'dom1.png', '', 3181),
(20, 13, 2, '/img/Imager/bf512c968a3794837f4b39cc0d13a750.png', 'dom3.png', '', 5067),
(21, 14, 4, '/img/Imager/1c9476e0f72694665a8ae8ae646d21ea.png', 'dom2.png', '', 10037),
(22, 15, 4, '/img/Imager/20ef202b3f996a46b4b98df24270d0ce.png', 'dom3.png', '', 5067),
(23, 16, 4, '/img/Imager/56448a80fbf5581ea04ed7eb63f73640.png', 'dom1.png', '', 3181),
(24, 17, 4, '/img/Imager/adcc04eed2f0302db00ef0260724a032.png', 'dom2.png', '', 10037),
(25, 18, 4, '/img/Imager/8959083306b6ade0682398b813e8e7a9.png', 'dom3.png', '', 5067),
(26, 19, 4, '/img/Imager/3ed6f27b84b23147ac4b1fb691b56273.png', 'dom1.png', '', 3181),
(27, 20, 4, '/img/Imager/d1064da38d35a924b0a874b9e8c3f304.png', 'dom3.png', '', 5067),
(28, 21, 4, '/img/Imager/cf76915a9351899a8a58007ee9b2c5c2.png', 'dom3.png', '', 5067),
(29, 22, 4, '/img/Imager/df93134a4bbf9e73bb39b61f2494bf7b.png', 'dom3.png', '', 5067),
(30, 23, 4, '/img/Imager/14a7c15cbade0b52c1690c714f41a880.png', 'dom2.png', '', 10037),
(31, 24, 4, '/img/Imager/3106aefcde75be4e7cf94e914257f4a1.png', 'dom2.png', '', 10037),
(32, 25, 3, '/img/Imager/9fea9fc0e6a51328ad5732ff64f60c64.png', 'dom1.png', '', 3181),
(33, 26, 3, '/img/Imager/3d455e43f2b681f83e0fadd32a92047f.png', 'dom1.png', '', 3181),
(34, 27, 2, '/img/Imager/722a10e59a3116763aa04a81980cd407.jpg', 'flag.jpg', '', 4060),
(35, 28, 2, '/img/Imager/15a6729e9a0501a1f931215763a2cd2a.png', '1496886548_11-Upload.png', '', 467),
(36, 29, 3, '/img/Imager/81a667bb2f607d73f39f40cb86c8cf9d.png', '1496871449_phone8.png', '', 971);

-- --------------------------------------------------------

--
-- Структура таблицы `cata_logger_journal`
--

CREATE TABLE `cata_logger_journal` (
  `id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `milliseconds` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `user` varchar(500) DEFAULT NULL,
  `app` varchar(200) DEFAULT NULL,
  `content` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_logger_journal`
--

INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(1, '2017-12-11 18:39:43', 134, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2, '2017-12-12 00:31:12', 586, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [93.125.107.6]\nE:/OpenServer/domains/localhost/Core/login.php'),
(3, '2017-12-12 00:33:34', 723, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(4, '2017-12-12 10:45:38', 469, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(5, '2017-12-12 10:46:11', 712, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(6, '2017-12-12 10:46:54', 410, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(7, '2017-12-12 10:48:50', 604, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(8, '2017-12-12 10:50:24', 277, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(9, '2017-12-12 10:50:29', 613, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(10, '2017-12-12 10:51:17', 28, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(11, '2017-12-12 10:54:44', 57, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(12, '2017-12-12 10:58:57', 455, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(13, '2017-12-12 10:58:59', 900, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(14, '2017-12-12 11:01:28', 305, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(15, '2017-12-12 11:02:29', 472, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(16, '2017-12-12 11:03:06', 28, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(17, '2017-12-12 11:03:07', 384, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(18, '2017-12-12 11:03:24', 128, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(19, '2017-12-12 11:27:48', 536, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(20, '2017-12-12 11:27:48', 536, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(21, '2017-12-12 11:27:48', 547, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(22, '2017-12-12 11:27:48', 549, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(23, '2017-12-12 11:27:48', 552, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(24, '2017-12-12 11:27:48', 554, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(25, '2017-12-12 11:27:48', 565, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(26, '2017-12-12 11:27:48', 568, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(27, '2017-12-12 11:35:40', 494, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(28, '2017-12-12 11:40:21', 114, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(29, '2017-12-12 11:40:34', 130, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(30, '2017-12-12 11:41:42', 398, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(31, '2017-12-12 11:45:34', 366, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(32, '2017-12-12 11:45:50', 328, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(33, '2017-12-12 11:51:58', 732, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(34, '2017-12-12 11:51:58', 735, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(35, '2017-12-12 11:51:58', 739, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(36, '2017-12-12 11:54:50', 903, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(37, '2017-12-12 11:55:08', 85, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(38, '2017-12-12 11:55:24', 755, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(39, '2017-12-12 11:55:48', 672, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(40, '2017-12-12 11:56:34', 303, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(41, '2017-12-12 12:03:22', 826, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(42, '2017-12-12 12:03:22', 842, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(43, '2017-12-12 12:05:39', 936, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(44, '2017-12-12 12:10:27', 555, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(45, '2017-12-12 12:11:08', 60, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(46, '2017-12-12 12:11:25', 142, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(47, '2017-12-12 12:11:29', 278, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(48, '2017-12-12 12:12:07', 769, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(49, '2017-12-12 12:12:23', 813, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(50, '2017-12-12 12:13:19', 655, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(51, '2017-12-12 12:13:55', 597, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(52, '2017-12-12 12:14:11', 439, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(53, '2017-12-12 12:14:47', 228, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(54, '2017-12-12 12:31:35', 680, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(55, '2017-12-12 12:36:53', 128, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(56, '2017-12-12 12:37:18', 150, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(57, '2017-12-12 12:37:39', 643, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(58, '2017-12-12 12:38:50', 663, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(59, '2017-12-12 12:39:03', 604, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(60, '2017-12-12 12:39:35', 328, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(61, '2017-12-12 12:40:12', 106, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(62, '2017-12-12 12:40:32', 633, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(63, '2017-12-12 12:40:41', 992, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(64, '2017-12-12 12:41:23', 35, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(65, '2017-12-12 12:45:14', 778, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(66, '2017-12-12 12:46:01', 284, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(67, '2017-12-12 12:46:27', 116, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(68, '2017-12-12 12:47:12', 165, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(69, '2017-12-12 12:47:31', 747, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(70, '2017-12-12 12:55:19', 581, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(71, '2017-12-12 12:55:50', 784, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(72, '2017-12-12 12:56:09', 437, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(73, '2017-12-12 12:56:12', 220, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(74, '2017-12-12 12:56:20', 831, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(75, '2017-12-12 12:57:20', 27, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(76, '2017-12-12 12:57:49', 543, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(77, '2017-12-12 12:58:04', 75, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(78, '2017-12-12 12:59:29', 121, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(79, '2017-12-12 12:59:43', 26, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(80, '2017-12-12 13:00:18', 692, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(81, '2017-12-12 13:00:36', 476, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(82, '2017-12-12 13:02:27', 413, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(83, '2017-12-12 13:02:36', 566, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(84, '2017-12-12 13:03:12', 827, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(85, '2017-12-12 13:03:21', 232, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(86, '2017-12-12 13:04:02', 959, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(87, '2017-12-12 13:04:17', 732, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(88, '2017-12-12 13:04:17', 848, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(89, '2017-12-12 13:04:52', 115, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(90, '2017-12-12 13:05:45', 954, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(91, '2017-12-12 13:05:56', 640, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(92, '2017-12-12 13:06:00', 778, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(93, '2017-12-12 13:06:14', 346, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(94, '2017-12-12 13:06:23', 806, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(95, '2017-12-12 13:06:45', 978, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(96, '2017-12-12 13:07:04', 292, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(97, '2017-12-12 13:07:53', 973, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(98, '2017-12-12 13:08:29', 933, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(99, '2017-12-12 13:10:34', 457, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(100, '2017-12-12 13:15:01', 185, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(101, '2017-12-12 13:15:24', 313, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(102, '2017-12-12 13:15:47', 470, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(103, '2017-12-12 13:15:47', 547, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(104, '2017-12-12 13:15:47', 615, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(105, '2017-12-12 13:16:46', 461, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(106, '2017-12-12 13:19:34', 747, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(107, '2017-12-12 13:22:50', 104, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(108, '2017-12-12 13:23:46', 637, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(109, '2017-12-12 13:23:46', 727, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(110, '2017-12-12 13:23:53', 842, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(111, '2017-12-12 13:23:57', 10, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(112, '2017-12-12 13:24:10', 776, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(113, '2017-12-12 13:25:54', 498, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(114, '2017-12-12 13:25:54', 576, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(115, '2017-12-12 13:26:22', 824, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(116, '2017-12-12 13:26:23', 129, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(117, '2017-12-12 13:27:26', 680, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(118, '2017-12-12 13:27:31', 180, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(119, '2017-12-12 13:27:32', 687, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(120, '2017-12-12 13:27:54', 755, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(121, '2017-12-12 13:27:54', 960, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(122, '2017-12-12 13:28:12', 902, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(123, '2017-12-12 13:30:59', 909, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(124, '2017-12-12 13:32:08', 333, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(125, '2017-12-12 13:32:16', 438, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(126, '2017-12-12 13:32:17', 663, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(127, '2017-12-12 13:32:25', 876, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(128, '2017-12-12 13:32:44', 661, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(129, '2017-12-12 13:33:47', 101, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(130, '2017-12-12 13:33:47', 176, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(131, '2017-12-12 13:33:47', 267, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(132, '2017-12-12 13:33:47', 343, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(133, '2017-12-12 13:33:47', 488, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(134, '2017-12-12 13:33:47', 609, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(135, '2017-12-12 13:33:47', 715, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(136, '2017-12-12 13:33:47', 726, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(137, '2017-12-12 13:33:47', 853, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(138, '2017-12-12 13:33:47', 854, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(139, '2017-12-12 13:33:47', 858, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(140, '2017-12-12 13:33:48', 24, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(141, '2017-12-12 13:34:00', 109, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(142, '2017-12-12 13:34:13', 571, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(143, '2017-12-12 13:35:07', 596, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(144, '2017-12-12 13:36:20', 593, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(145, '2017-12-12 13:36:21', 654, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(146, '2017-12-12 13:36:27', 398, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(147, '2017-12-12 13:36:28', 297, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(148, '2017-12-12 13:36:46', 658, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(149, '2017-12-12 13:37:16', 408, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(150, '2017-12-12 13:37:16', 485, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(151, '2017-12-12 13:37:16', 568, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(152, '2017-12-12 13:37:16', 652, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(153, '2017-12-12 13:37:37', 346, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(154, '2017-12-12 13:38:29', 736, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(155, '2017-12-12 13:39:20', 170, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(156, '2017-12-12 13:39:41', 349, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(157, '2017-12-12 14:00:31', 941, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [93.125.107.6]\nE:/OpenServer/domains/localhost/Core/login.php'),
(158, '2017-12-12 15:33:45', 45, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [217.21.43.95]\nE:/OpenServer/domains/localhost/Core/login.php'),
(159, '2017-12-13 10:19:41', 612, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [93.125.107.6]\nE:/OpenServer/domains/localhost/Core/login.php'),
(160, '2017-12-13 10:24:24', 131, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(161, '2017-12-13 10:24:56', 381, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(162, '2017-12-13 10:25:03', 133, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(163, '2017-12-13 10:25:07', 246, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(164, '2017-12-13 10:26:05', 424, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(165, '2017-12-13 10:26:48', 557, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(166, '2017-12-13 10:27:32', 998, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(167, '2017-12-13 10:28:03', 816, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(168, '2017-12-13 10:28:26', 986, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(169, '2017-12-13 10:29:11', 174, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(170, '2017-12-13 10:29:26', 901, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(171, '2017-12-13 10:29:38', 45, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(172, '2017-12-13 10:31:02', 910, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(173, '2017-12-13 10:31:30', 474, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(174, '2017-12-13 10:32:56', 738, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(175, '2017-12-13 10:33:14', 98, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(176, '2017-12-13 10:33:36', 501, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(177, '2017-12-13 10:34:02', 953, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(178, '2017-12-13 10:36:04', 943, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(179, '2017-12-13 10:36:58', 729, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(180, '2017-12-13 10:37:26', 418, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(181, '2017-12-13 10:40:22', 911, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(182, '2017-12-13 10:42:42', 803, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(183, '2017-12-13 10:43:12', 131, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(184, '2017-12-13 10:46:12', 611, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(185, '2017-12-13 10:46:38', 199, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(186, '2017-12-13 10:47:05', 940, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(187, '2017-12-13 10:47:33', 559, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(188, '2017-12-13 10:48:21', 448, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(189, '2017-12-13 10:48:32', 999, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(190, '2017-12-13 10:48:45', 729, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(191, '2017-12-13 10:49:09', 306, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(192, '2017-12-13 10:49:43', 559, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(193, '2017-12-13 10:49:52', 411, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(194, '2017-12-13 10:50:06', 884, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(195, '2017-12-13 10:50:32', 528, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(196, '2017-12-13 10:51:10', 590, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(197, '2017-12-13 10:51:12', 361, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(198, '2017-12-13 10:52:07', 252, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(199, '2017-12-13 10:52:20', 557, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(200, '2017-12-13 10:55:06', 246, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(201, '2017-12-13 10:56:24', 855, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(202, '2017-12-13 11:00:15', 604, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(203, '2017-12-13 11:01:13', 645, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(204, '2017-12-13 11:04:15', 89, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(205, '2017-12-13 11:04:23', 15, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(206, '2017-12-13 11:04:33', 186, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(207, '2017-12-13 11:04:51', 6, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(208, '2017-12-13 11:10:08', 320, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(209, '2017-12-13 11:11:44', 915, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(210, '2017-12-13 11:11:57', 354, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(211, '2017-12-13 11:15:59', 326, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(212, '2017-12-13 11:17:11', 633, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(213, '2017-12-13 11:17:15', 340, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(214, '2017-12-13 11:18:34', 835, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(215, '2017-12-13 11:18:36', 555, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(216, '2017-12-13 11:19:03', 367, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(217, '2017-12-13 11:19:25', 656, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(218, '2017-12-13 11:20:36', 250, 0, 'ArtimenyaEV', 'File Manager', 'Создан файл E:/OpenServer/domains/localhost//newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/create.php'),
(219, '2017-12-13 11:21:16', 11, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(220, '2017-12-13 11:21:40', 417, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(221, '2017-12-13 11:23:09', 868, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(222, '2017-12-13 11:23:37', 303, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(223, '2017-12-13 11:23:42', 831, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(224, '2017-12-13 11:23:45', 656, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(225, '2017-12-13 11:24:30', 407, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(226, '2017-12-13 11:24:56', 989, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(227, '2017-12-13 11:24:58', 931, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(228, '2017-12-13 11:25:08', 775, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(229, '2017-12-13 11:25:24', 856, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(230, '2017-12-13 11:25:37', 919, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(231, '2017-12-13 11:25:52', 405, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(232, '2017-12-13 11:25:55', 55, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(233, '2017-12-13 11:25:55', 199, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(234, '2017-12-13 11:26:30', 286, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(235, '2017-12-13 11:27:06', 110, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/test.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(236, '2017-12-13 11:28:31', 100, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(237, '2017-12-13 11:30:37', 546, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(238, '2017-12-13 11:30:40', 550, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(239, '2017-12-13 11:31:11', 146, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(240, '2017-12-13 11:32:45', 34, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(241, '2017-12-13 11:33:54', 783, 0, 'ArtimenyaEV', 'File Manager', 'Удален файл /parser.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(242, '2017-12-13 11:33:59', 470, 0, 'ArtimenyaEV', 'File Manager', 'Удален файл /Error_log.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(243, '2017-12-13 11:34:09', 715, 0, 'ArtimenyaEV', 'File Manager', 'Удален файл /RSqlCred.txt.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(244, '2017-12-13 11:34:15', 342, 0, 'ArtimenyaEV', 'File Manager', 'Удален файл /DB.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(245, '2017-12-13 11:34:28', 902, 0, 'ArtimenyaEV', 'File Manager', 'Удален файл /config.json.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(246, '2017-12-13 11:34:32', 378, 0, 'ArtimenyaEV', 'File Manager', 'Удален файл /db.sql.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(247, '2017-12-13 11:35:52', 932, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(248, '2017-12-13 11:36:54', 98, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(249, '2017-12-13 11:37:29', 239, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(250, '2017-12-13 11:39:08', 990, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(251, '2017-12-13 11:39:19', 801, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(252, '2017-12-13 11:40:08', 834, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(253, '2017-12-13 11:44:37', 696, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(254, '2017-12-13 11:45:12', 561, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(255, '2017-12-13 11:46:16', 981, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(256, '2017-12-13 11:48:48', 933, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(257, '2017-12-13 11:49:09', 108, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(258, '2017-12-13 11:50:25', 920, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/test.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(259, '2017-12-13 11:50:27', 587, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(260, '2017-12-13 11:50:40', 840, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(261, '2017-12-13 11:51:02', 913, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/test.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(262, '2017-12-13 11:52:01', 128, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(263, '2017-12-13 11:53:48', 254, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(264, '2017-12-13 11:54:24', 396, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(265, '2017-12-13 11:54:34', 643, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(266, '2017-12-13 11:55:29', 785, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(267, '2017-12-13 12:06:29', 683, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(268, '2017-12-13 12:06:31', 612, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(269, '2017-12-13 12:07:12', 440, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(270, '2017-12-13 12:08:57', 315, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(271, '2017-12-13 12:09:25', 603, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(272, '2017-12-13 12:09:48', 347, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(273, '2017-12-13 12:16:26', 628, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(274, '2017-12-13 12:16:46', 524, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(275, '2017-12-13 12:28:55', 879, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(276, '2017-12-13 12:29:27', 926, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(277, '2017-12-13 12:34:49', 423, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(278, '2017-12-13 12:34:58', 871, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(279, '2017-12-13 12:35:46', 479, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(280, '2017-12-13 12:49:37', 774, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(281, '2017-12-13 12:50:30', 180, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(282, '2017-12-13 12:51:11', 392, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(283, '2017-12-13 13:04:31', 7, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(284, '2017-12-13 13:04:32', 188, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(285, '2017-12-13 13:04:50', 194, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(286, '2017-12-13 13:06:19', 850, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(287, '2017-12-13 13:06:34', 595, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(288, '2017-12-13 13:06:53', 884, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(289, '2017-12-13 13:07:03', 663, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(290, '2017-12-13 13:10:54', 289, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(291, '2017-12-13 13:11:25', 79, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(292, '2017-12-13 13:13:25', 494, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(293, '2017-12-13 13:16:21', 417, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(294, '2017-12-13 13:16:28', 425, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(295, '2017-12-13 13:16:46', 137, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(296, '2017-12-13 13:16:51', 363, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(297, '2017-12-13 13:16:58', 386, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(298, '2017-12-13 13:17:13', 277, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(299, '2017-12-13 13:17:40', 252, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(300, '2017-12-13 13:19:10', 74, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(301, '2017-12-13 13:19:12', 159, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(302, '2017-12-13 13:19:27', 796, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(303, '2017-12-13 13:20:03', 515, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(304, '2017-12-13 13:20:10', 754, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(305, '2017-12-13 13:30:27', 416, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(306, '2017-12-13 13:32:02', 360, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(307, '2017-12-13 13:32:40', 432, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(308, '2017-12-14 09:39:41', 973, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(309, '2017-12-14 09:39:55', 733, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(310, '2017-12-14 09:47:16', 207, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(311, '2017-12-14 09:48:50', 405, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(312, '2017-12-14 09:50:07', 577, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(313, '2017-12-14 09:51:24', 986, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(314, '2017-12-14 09:52:07', 55, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(315, '2017-12-14 09:52:26', 441, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(316, '2017-12-14 09:56:53', 198, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(317, '2017-12-14 09:58:41', 892, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(318, '2017-12-14 10:01:17', 866, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(319, '2017-12-14 10:01:38', 326, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(320, '2017-12-14 10:02:08', 238, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(321, '2017-12-14 10:02:25', 311, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(322, '2017-12-14 10:02:47', 351, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(323, '2017-12-14 10:03:21', 948, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(324, '2017-12-14 10:03:53', 316, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(325, '2017-12-14 10:06:09', 376, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(326, '2017-12-14 10:06:33', 22, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(327, '2017-12-14 10:06:40', 404, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(328, '2017-12-14 10:07:25', 370, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(329, '2017-12-14 10:07:58', 580, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(330, '2017-12-14 10:08:28', 89, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(331, '2017-12-14 10:08:38', 257, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(332, '2017-12-14 10:08:52', 643, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(333, '2017-12-14 10:10:35', 498, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(334, '2017-12-14 10:10:51', 96, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(335, '2017-12-14 10:14:11', 111, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(336, '2017-12-14 10:18:27', 780, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(337, '2017-12-14 10:20:37', 697, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(338, '2017-12-14 10:20:45', 293, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(339, '2017-12-14 10:32:51', 230, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(340, '2017-12-14 10:34:11', 125, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(341, '2017-12-14 10:34:55', 147, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(342, '2017-12-14 10:37:31', 86, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(343, '2017-12-14 10:37:47', 846, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(344, '2017-12-14 10:38:20', 464, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(345, '2017-12-14 10:41:37', 927, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(346, '2017-12-14 10:42:17', 25, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(347, '2017-12-14 10:43:20', 615, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(348, '2017-12-14 10:44:12', 325, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(349, '2017-12-14 10:44:18', 673, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(350, '2017-12-14 10:44:49', 337, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(351, '2017-12-15 22:22:41', 125, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [195.50.26.61]\nE:/OpenServer/domains/localhost/Core/login.php'),
(352, '2017-12-15 23:30:32', 236, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [93.125.107.6]\nE:/OpenServer/domains/localhost/Core/login.php'),
(353, '2017-12-18 09:48:52', 261, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [93.125.107.6]\nE:/OpenServer/domains/localhost/Core/login.php'),
(354, '2017-12-18 10:02:47', 249, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(355, '2017-12-18 10:04:11', 696, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(356, '2017-12-18 10:05:45', 416, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(357, '2017-12-18 10:09:08', 123, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(358, '2017-12-18 10:10:27', 291, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(359, '2017-12-18 10:10:54', 716, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(360, '2017-12-18 10:11:01', 106, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(361, '2017-12-18 10:11:07', 131, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(362, '2017-12-18 10:12:46', 965, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(363, '2017-12-18 10:13:18', 112, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(364, '2017-12-18 10:14:06', 282, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(365, '2017-12-18 10:14:06', 728, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(366, '2017-12-18 10:14:24', 471, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(367, '2017-12-18 10:14:31', 282, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(368, '2017-12-18 10:14:40', 864, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(369, '2017-12-18 10:15:19', 110, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(370, '2017-12-18 10:15:27', 698, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(371, '2017-12-18 10:15:58', 573, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(372, '2017-12-18 10:17:11', 365, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(373, '2017-12-18 10:17:22', 692, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(374, '2017-12-18 10:17:27', 597, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(375, '2017-12-18 10:18:13', 77, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(376, '2017-12-18 10:18:21', 74, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(377, '2017-12-18 10:18:33', 34, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(378, '2017-12-18 10:20:09', 130, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(379, '2017-12-18 10:21:29', 372, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(380, '2017-12-18 10:21:39', 413, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(381, '2017-12-18 10:21:46', 600, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(382, '2017-12-18 10:25:08', 485, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(383, '2017-12-18 10:25:18', 947, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(384, '2017-12-18 10:25:27', 361, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(385, '2017-12-18 10:25:34', 952, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(386, '2017-12-18 10:26:07', 130, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(387, '2017-12-18 10:26:24', 567, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(388, '2017-12-18 10:27:23', 367, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(389, '2017-12-18 10:28:01', 191, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(390, '2017-12-18 10:28:55', 1, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(391, '2017-12-18 10:29:36', 796, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(392, '2017-12-18 10:29:47', 387, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(393, '2017-12-18 10:29:58', 614, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(394, '2017-12-18 10:30:05', 885, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(395, '2017-12-18 10:30:19', 587, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(396, '2017-12-18 10:30:22', 816, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(397, '2017-12-18 10:32:47', 292, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(398, '2017-12-18 10:33:05', 68, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(399, '2017-12-18 10:33:19', 676, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(400, '2017-12-18 10:34:04', 942, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(401, '2017-12-18 10:34:09', 600, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(402, '2017-12-18 10:34:28', 997, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(403, '2017-12-18 10:34:30', 679, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(404, '2017-12-18 10:34:55', 565, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(405, '2017-12-18 10:35:09', 943, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(406, '2017-12-18 10:36:14', 586, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(407, '2017-12-18 10:38:37', 783, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(408, '2017-12-18 10:39:13', 13, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(409, '2017-12-18 10:39:20', 425, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(410, '2017-12-18 10:41:10', 184, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(411, '2017-12-18 10:41:42', 462, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(412, '2017-12-18 10:41:50', 742, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(413, '2017-12-18 10:42:20', 60, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(414, '2017-12-18 10:43:00', 121, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(415, '2017-12-18 10:43:26', 32, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(416, '2017-12-18 10:43:44', 449, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(417, '2017-12-18 10:43:45', 516, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(418, '2017-12-18 10:44:23', 91, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(419, '2017-12-18 10:46:23', 298, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(420, '2017-12-18 10:46:39', 294, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(421, '2017-12-18 10:49:26', 429, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(422, '2017-12-18 10:51:42', 346, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(423, '2017-12-18 10:52:44', 692, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(424, '2017-12-18 10:54:01', 711, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(425, '2017-12-18 10:55:07', 99, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(426, '2017-12-18 10:55:33', 217, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(427, '2017-12-18 10:55:43', 473, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(428, '2017-12-18 10:59:27', 761, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(429, '2017-12-18 11:00:39', 130, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(430, '2017-12-18 11:01:07', 693, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(431, '2017-12-18 11:01:21', 824, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(432, '2017-12-18 11:01:30', 70, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(433, '2017-12-18 11:01:38', 815, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(434, '2017-12-18 11:01:57', 416, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(435, '2017-12-18 12:46:21', 99, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(436, '2017-12-18 12:47:37', 952, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(437, '2017-12-18 12:49:07', 90, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(438, '2017-12-18 12:50:10', 542, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(439, '2017-12-18 12:51:50', 864, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(440, '2017-12-18 12:52:35', 110, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(441, '2017-12-18 12:52:46', 77, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(442, '2017-12-18 12:54:15', 622, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(443, '2017-12-18 12:59:13', 34, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(444, '2017-12-18 13:01:03', 113, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(445, '2017-12-18 13:01:56', 382, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(446, '2017-12-18 13:02:39', 192, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(447, '2017-12-18 13:02:58', 871, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(448, '2017-12-18 13:03:13', 122, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(449, '2017-12-18 13:03:37', 126, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(450, '2017-12-18 13:04:44', 429, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(451, '2017-12-18 13:05:05', 776, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(452, '2017-12-18 13:05:48', 856, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(453, '2017-12-18 13:06:59', 820, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(454, '2017-12-18 13:07:27', 894, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(455, '2017-12-18 13:08:42', 589, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(456, '2017-12-18 13:09:50', 198, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(457, '2017-12-18 13:10:07', 691, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(458, '2017-12-18 13:14:03', 409, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(459, '2017-12-18 13:14:42', 793, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(460, '2017-12-18 13:20:49', 822, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(461, '2017-12-18 13:26:52', 289, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(462, '2017-12-18 13:27:17', 515, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(463, '2017-12-18 13:28:52', 113, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(464, '2017-12-18 13:29:36', 15, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(465, '2017-12-18 13:31:08', 296, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(466, '2017-12-18 13:31:35', 953, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(467, '2017-12-18 13:32:03', 868, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(468, '2017-12-18 13:33:29', 389, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(469, '2017-12-18 13:34:54', 406, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(470, '2017-12-18 13:35:25', 279, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(471, '2017-12-18 13:35:37', 700, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(472, '2017-12-18 13:35:52', 955, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(473, '2017-12-18 13:35:54', 21, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(474, '2017-12-18 15:54:21', 377, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(475, '2017-12-18 15:54:45', 478, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(476, '2017-12-18 15:55:29', 699, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(477, '2017-12-18 16:03:01', 666, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(478, '2017-12-18 16:03:01', 667, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(479, '2017-12-18 16:03:10', 837, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(480, '2017-12-18 16:06:06', 322, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(481, '2017-12-18 16:06:09', 505, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(482, '2017-12-18 16:08:15', 481, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(483, '2017-12-18 16:09:34', 24, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(484, '2017-12-18 16:10:12', 284, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(485, '2017-12-18 16:11:14', 530, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(486, '2017-12-18 16:12:54', 210, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(487, '2017-12-18 16:16:10', 886, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(488, '2017-12-18 16:16:13', 566, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(489, '2017-12-18 16:22:49', 470, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(490, '2017-12-18 16:23:34', 474, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(491, '2017-12-18 16:23:38', 741, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(492, '2017-12-18 16:25:41', 207, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(493, '2017-12-18 16:25:59', 788, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(494, '2017-12-18 16:26:26', 690, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(495, '2017-12-18 16:26:59', 888, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(496, '2017-12-18 16:27:00', 697, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(497, '2017-12-18 16:29:32', 624, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(498, '2017-12-18 16:30:33', 982, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(499, '2017-12-18 16:32:12', 224, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(500, '2017-12-18 16:32:13', 95, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(501, '2017-12-18 16:32:17', 72, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(502, '2017-12-18 16:32:17', 89, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(503, '2017-12-18 16:32:17', 221, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(504, '2017-12-18 16:32:17', 276, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(505, '2017-12-18 16:32:17', 326, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(506, '2017-12-18 16:32:17', 384, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(507, '2017-12-18 16:32:17', 441, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(508, '2017-12-18 16:32:17', 522, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(509, '2017-12-18 16:32:17', 523, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(510, '2017-12-18 16:32:17', 567, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(511, '2017-12-18 16:32:17', 705, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(512, '2017-12-18 16:32:17', 741, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(513, '2017-12-18 16:32:17', 831, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(514, '2017-12-18 16:32:17', 872, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(515, '2017-12-18 16:32:17', 918, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(516, '2017-12-18 16:32:17', 950, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(517, '2017-12-18 16:32:45', 709, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(518, '2017-12-18 16:34:41', 438, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(519, '2017-12-18 16:36:14', 440, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(520, '2017-12-18 16:36:14', 652, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(521, '2017-12-18 16:36:14', 650, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(522, '2017-12-18 16:36:14', 783, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(523, '2017-12-18 16:36:14', 840, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(524, '2017-12-18 16:36:14', 978, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(525, '2017-12-18 16:36:15', 46, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(526, '2017-12-18 16:36:15', 422, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(527, '2017-12-18 16:36:34', 610, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(528, '2017-12-18 16:38:56', 264, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(529, '2017-12-18 16:39:01', 347, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(530, '2017-12-18 16:39:30', 578, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(531, '2017-12-18 16:41:00', 979, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(532, '2017-12-18 16:41:49', 250, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(533, '2017-12-18 16:42:11', 892, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(534, '2017-12-18 16:42:52', 601, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(535, '2017-12-18 16:44:50', 120, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(536, '2017-12-18 16:44:54', 72, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(537, '2017-12-18 16:45:14', 197, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(538, '2017-12-18 16:45:43', 333, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(539, '2017-12-18 16:48:25', 574, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(540, '2017-12-18 16:48:43', 827, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(541, '2017-12-18 16:48:48', 354, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(542, '2017-12-18 16:52:04', 864, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(543, '2017-12-18 16:53:34', 501, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(544, '2017-12-18 16:53:41', 161, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(545, '2017-12-18 16:55:51', 131, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(546, '2017-12-18 16:56:08', 122, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(547, '2017-12-18 16:56:40', 990, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(548, '2017-12-18 16:56:42', 696, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(549, '2017-12-18 16:57:30', 70, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(550, '2017-12-18 16:57:41', 220, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(551, '2017-12-18 16:58:34', 83, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(552, '2017-12-18 16:58:34', 743, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(553, '2017-12-18 16:58:46', 236, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(554, '2017-12-18 16:59:25', 819, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(555, '2017-12-18 16:59:47', 267, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(556, '2017-12-18 17:00:18', 234, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(557, '2017-12-18 17:00:18', 242, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(558, '2017-12-18 17:00:18', 321, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(559, '2017-12-18 17:01:15', 818, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(560, '2017-12-18 17:01:27', 869, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(561, '2017-12-18 17:01:50', 817, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(562, '2017-12-18 17:04:19', 330, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(563, '2017-12-18 17:04:26', 715, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(564, '2017-12-18 17:04:34', 675, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(565, '2017-12-18 17:08:03', 655, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(566, '2017-12-18 17:08:03', 696, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(567, '2017-12-18 17:08:03', 864, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(568, '2017-12-18 17:09:48', 901, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(569, '2017-12-18 18:29:15', 338, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(570, '2017-12-18 18:40:42', 385, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(571, '2017-12-18 18:40:44', 835, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(572, '2017-12-18 18:42:13', 691, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(573, '2017-12-18 18:42:40', 128, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(574, '2017-12-18 18:43:00', 686, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(575, '2017-12-18 18:43:31', 800, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(576, '2017-12-18 18:44:55', 107, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(577, '2017-12-18 18:48:54', 492, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(578, '2017-12-18 18:49:38', 182, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(579, '2017-12-18 18:49:42', 968, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(580, '2017-12-18 18:49:44', 351, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(581, '2017-12-18 21:45:42', 940, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(582, '2017-12-18 21:48:04', 664, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(583, '2017-12-18 21:49:19', 998, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(584, '2017-12-18 21:49:51', 679, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(585, '2017-12-18 21:49:55', 226, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(586, '2017-12-18 21:49:59', 467, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(587, '2017-12-18 21:50:19', 34, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(588, '2017-12-19 11:00:22', 295, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(589, '2017-12-19 11:04:06', 309, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(590, '2017-12-19 11:04:59', 56, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(591, '2017-12-19 11:04:59', 76, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(592, '2017-12-19 11:04:59', 172, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(593, '2017-12-19 11:05:04', 89, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(594, '2017-12-19 11:07:02', 534, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(595, '2017-12-19 11:09:03', 657, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(596, '2017-12-19 11:09:39', 382, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(597, '2017-12-19 11:10:01', 892, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(598, '2017-12-19 11:10:23', 935, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(599, '2017-12-19 11:10:27', 261, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(600, '2017-12-19 11:10:47', 546, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(601, '2017-12-19 11:10:56', 386, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(602, '2017-12-19 11:14:39', 266, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(603, '2017-12-19 11:14:54', 526, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(604, '2017-12-19 11:15:37', 985, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(605, '2017-12-19 11:17:27', 42, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(606, '2017-12-19 11:17:31', 46, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(607, '2017-12-19 11:41:51', 181, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(608, '2017-12-19 11:43:14', 887, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(609, '2017-12-19 11:43:33', 855, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(610, '2017-12-19 11:45:36', 586, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(611, '2017-12-19 11:50:42', 674, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(612, '2017-12-19 11:51:33', 382, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(613, '2017-12-19 11:53:52', 776, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(614, '2017-12-19 11:53:57', 269, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(615, '2017-12-19 11:54:20', 806, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(616, '2017-12-19 11:55:17', 485, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(617, '2017-12-19 11:55:38', 221, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(618, '2017-12-19 11:55:58', 374, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(619, '2017-12-19 11:56:26', 113, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(620, '2017-12-19 11:56:37', 999, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(621, '2017-12-19 11:57:49', 575, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(622, '2017-12-19 11:58:49', 774, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(623, '2017-12-19 12:00:59', 235, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(624, '2017-12-19 12:02:00', 200, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(625, '2017-12-19 12:02:23', 626, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(626, '2017-12-19 12:02:50', 953, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(627, '2017-12-19 12:03:07', 482, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(628, '2017-12-19 12:03:54', 387, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(629, '2017-12-19 12:03:57', 885, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(630, '2017-12-19 12:04:03', 493, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(631, '2017-12-19 12:06:46', 499, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(632, '2017-12-19 12:07:26', 474, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(633, '2017-12-19 12:07:41', 105, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(634, '2017-12-19 12:08:01', 393, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(635, '2017-12-19 12:08:21', 232, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(636, '2017-12-19 12:08:31', 764, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(637, '2017-12-19 12:10:03', 616, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(638, '2017-12-19 12:10:58', 936, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(639, '2017-12-19 12:12:08', 529, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(640, '2017-12-19 12:12:22', 97, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(641, '2017-12-19 12:13:12', 464, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(642, '2017-12-19 12:13:41', 347, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(643, '2017-12-19 12:14:40', 267, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(644, '2017-12-19 12:15:25', 800, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(645, '2017-12-19 12:16:37', 385, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(646, '2017-12-19 12:17:01', 369, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(647, '2017-12-19 12:19:20', 218, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(648, '2017-12-19 12:20:22', 829, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(649, '2017-12-19 12:32:19', 293, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(650, '2017-12-19 12:36:09', 99, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(651, '2017-12-19 12:50:13', 920, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(652, '2017-12-19 12:55:55', 337, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(653, '2017-12-19 12:56:12', 579, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(654, '2017-12-19 12:56:32', 973, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(655, '2017-12-19 12:56:58', 40, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(656, '2017-12-19 12:57:10', 716, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(657, '2017-12-19 12:57:22', 21, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(658, '2017-12-20 11:59:46', 304, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(659, '2017-12-20 12:01:25', 712, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(660, '2017-12-20 12:02:11', 746, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(661, '2017-12-20 12:53:52', 185, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(662, '2017-12-20 12:54:07', 563, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(663, '2017-12-20 12:56:47', 185, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(664, '2017-12-20 12:57:02', 978, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(665, '2017-12-20 12:57:20', 175, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(666, '2017-12-20 13:01:27', 26, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(667, '2017-12-20 13:02:33', 297, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(668, '2017-12-20 13:02:37', 621, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(669, '2017-12-20 13:03:43', 915, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(670, '2017-12-20 13:03:57', 80, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(671, '2017-12-20 13:05:03', 134, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(672, '2017-12-20 13:05:26', 691, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(673, '2017-12-20 13:07:01', 378, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(674, '2017-12-20 13:07:36', 541, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(675, '2017-12-20 13:08:08', 141, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(676, '2017-12-20 13:08:31', 617, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(677, '2017-12-20 13:08:45', 784, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(678, '2017-12-20 13:09:21', 302, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(679, '2017-12-20 13:10:57', 704, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(680, '2017-12-20 13:13:28', 761, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(681, '2017-12-20 13:13:38', 977, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(682, '2017-12-20 13:13:49', 117, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(683, '2017-12-20 13:14:23', 890, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(684, '2017-12-20 13:14:36', 717, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(685, '2017-12-20 13:14:49', 207, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(686, '2017-12-20 13:14:56', 7, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(687, '2017-12-20 13:15:48', 771, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(688, '2017-12-20 13:16:04', 279, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(689, '2017-12-20 13:16:32', 324, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(690, '2017-12-20 13:17:47', 766, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(691, '2017-12-20 13:17:55', 334, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(692, '2017-12-20 13:18:15', 126, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(693, '2017-12-20 13:18:46', 359, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(694, '2017-12-20 13:18:47', 332, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(695, '2017-12-20 13:19:18', 170, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(696, '2017-12-20 13:19:27', 745, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(697, '2017-12-20 13:19:37', 320, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(698, '2017-12-20 13:20:01', 294, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(699, '2017-12-20 13:20:08', 30, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(700, '2017-12-20 13:20:39', 445, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(701, '2017-12-20 13:21:12', 686, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(702, '2017-12-20 13:21:34', 331, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(703, '2017-12-20 13:21:59', 10, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(704, '2017-12-20 13:22:23', 738, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(705, '2017-12-20 13:22:56', 68, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(706, '2017-12-20 13:23:25', 70, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(707, '2017-12-20 13:23:52', 35, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(708, '2017-12-20 13:24:29', 97, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(709, '2017-12-20 13:26:14', 152, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(710, '2017-12-20 13:32:30', 978, 0, 'ArtimenyaEV', 'File Manager', 'Удален файл /Classes/Instruments/TestInstrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(711, '2017-12-20 13:32:43', 690, 0, 'ArtimenyaEV', 'File Manager', 'Создан файл E:/OpenServer/domains/localhost//Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/create.php'),
(712, '2017-12-20 13:33:21', 502, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(713, '2017-12-20 13:35:16', 462, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(714, '2017-12-20 13:35:49', 174, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(715, '2017-12-20 13:36:24', 128, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(716, '2017-12-20 13:36:52', 747, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(717, '2017-12-20 13:37:15', 193, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(718, '2017-12-20 13:37:48', 347, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(719, '2017-12-20 13:38:55', 77, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(720, '2017-12-20 13:39:18', 826, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(721, '2017-12-20 13:39:35', 464, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(722, '2017-12-20 13:39:54', 761, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(723, '2017-12-20 13:40:29', 868, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(724, '2017-12-20 13:44:54', 428, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(725, '2017-12-20 13:45:06', 978, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(726, '2017-12-20 13:46:54', 3, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(727, '2017-12-20 13:47:21', 205, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(728, '2017-12-20 13:47:55', 492, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(729, '2017-12-20 13:48:33', 622, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(730, '2017-12-20 13:49:45', 805, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(731, '2017-12-20 13:50:17', 453, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(732, '2017-12-20 13:50:23', 425, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(733, '2017-12-20 13:51:00', 649, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/Instrument.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(734, '2017-12-20 13:51:18', 734, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(735, '2017-12-20 13:52:50', 586, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(736, '2017-12-20 13:53:01', 560, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(737, '2017-12-20 13:53:09', 911, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(738, '2017-12-20 13:53:33', 427, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(739, '2017-12-20 13:55:24', 800, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(740, '2017-12-20 13:55:56', 896, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(741, '2017-12-20 13:58:18', 549, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(742, '2017-12-20 13:59:11', 447, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(743, '2017-12-20 13:59:35', 10, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(744, '2017-12-20 14:00:00', 484, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(745, '2017-12-20 14:00:18', 175, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(746, '2017-12-20 14:00:24', 121, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(747, '2017-12-20 14:01:09', 921, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(748, '2017-12-20 14:01:21', 158, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(749, '2017-12-20 14:01:34', 199, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(750, '2017-12-20 14:01:48', 720, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(751, '2017-12-20 14:02:10', 768, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(752, '2017-12-20 14:02:34', 864, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(753, '2017-12-20 14:02:44', 521, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(754, '2017-12-20 14:03:32', 640, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(755, '2017-12-20 14:03:45', 66, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(756, '2017-12-20 14:04:22', 222, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(757, '2017-12-20 14:04:31', 494, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(758, '2017-12-20 14:04:43', 819, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(759, '2017-12-20 14:05:04', 298, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(760, '2017-12-20 14:05:16', 903, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(761, '2017-12-20 14:05:39', 655, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(762, '2017-12-20 14:06:10', 731, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(763, '2017-12-20 14:06:23', 437, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(764, '2017-12-20 14:07:48', 286, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(765, '2017-12-20 14:07:57', 215, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(766, '2017-12-20 14:08:04', 654, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(767, '2017-12-20 14:08:46', 468, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(768, '2017-12-20 14:08:58', 245, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(769, '2017-12-20 21:14:02', 44, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [86.57.159.26]\nE:/OpenServer/domains/localhost/Core/login.php'),
(770, '2017-12-20 21:15:29', 167, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(771, '2017-12-20 21:16:41', 966, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(772, '2017-12-20 21:17:41', 816, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(773, '2017-12-20 21:18:00', 403, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(774, '2017-12-20 21:18:33', 809, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(775, '2017-12-20 21:19:55', 413, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(776, '2017-12-20 21:27:48', 4, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(777, '2017-12-20 21:28:11', 355, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(778, '2017-12-20 21:28:28', 156, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(779, '2017-12-20 21:30:25', 475, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(780, '2017-12-21 11:19:13', 242, 0, 'KreidichAA', 'Core Users', 'Авторизован пользователь kreidichaa. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(781, '2017-12-21 11:21:57', 629, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(782, '2017-12-21 11:22:47', 638, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(783, '2017-12-21 11:23:53', 320, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(784, '2017-12-21 11:25:16', 95, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(785, '2017-12-21 11:25:46', 660, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(786, '2017-12-21 11:29:00', 341, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(787, '2017-12-21 11:30:42', 359, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(788, '2017-12-21 11:31:16', 711, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(789, '2017-12-21 11:31:38', 714, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(790, '2017-12-21 11:32:01', 415, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(791, '2017-12-21 11:40:57', 225, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(792, '2017-12-21 11:41:10', 872, 0, 'KuplevichIA', 'File Manager', 'Создан файл E:/OpenServer/domains/localhost//js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/create.php'),
(793, '2017-12-21 11:42:19', 32, 0, 'KreidichAA', 'File Manager', 'Удален файл /js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(794, '2017-12-21 11:42:42', 70, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(795, '2017-12-21 11:42:57', 210, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(796, '2017-12-21 11:43:46', 213, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(797, '2017-12-21 11:47:16', 450, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(798, '2017-12-21 11:53:53', 190, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(799, '2017-12-21 11:54:34', 326, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(800, '2017-12-21 11:56:03', 110, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(801, '2017-12-21 12:01:21', 267, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(802, '2017-12-21 12:01:33', 567, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(803, '2017-12-21 12:09:55', 260, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(804, '2017-12-21 12:11:07', 374, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(805, '2017-12-21 12:27:14', 369, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(806, '2017-12-21 12:27:29', 492, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(807, '2017-12-21 12:27:40', 530, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(808, '2017-12-21 12:27:48', 520, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(809, '2017-12-21 12:28:11', 436, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(810, '2017-12-21 12:28:55', 796, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(811, '2017-12-21 12:34:58', 248, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(812, '2017-12-21 12:35:05', 522, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(813, '2017-12-21 12:36:05', 953, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(814, '2017-12-21 12:36:24', 156, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(815, '2017-12-21 12:37:48', 916, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(816, '2017-12-21 12:38:37', 998, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(817, '2017-12-21 12:40:57', 675, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(818, '2017-12-21 12:41:38', 83, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(819, '2017-12-21 12:42:48', 298, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(820, '2017-12-21 12:43:12', 737, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(821, '2017-12-21 12:44:54', 777, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(822, '2017-12-21 12:46:09', 37, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(823, '2017-12-21 12:46:53', 332, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(824, '2017-12-21 12:47:20', 137, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(825, '2017-12-21 12:47:35', 706, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(826, '2017-12-21 12:48:02', 79, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(827, '2017-12-21 12:48:17', 906, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(828, '2017-12-21 12:48:34', 851, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(829, '2017-12-21 12:49:52', 141, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(830, '2017-12-21 12:52:37', 618, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(831, '2017-12-21 12:53:23', 622, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(832, '2017-12-21 12:54:41', 170, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(833, '2017-12-21 12:55:38', 62, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(834, '2017-12-21 12:55:50', 864, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(835, '2017-12-21 13:02:18', 3, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(836, '2017-12-21 13:04:45', 72, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(837, '2017-12-21 13:04:58', 937, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(838, '2017-12-21 13:05:50', 528, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(839, '2017-12-21 13:06:01', 766, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(840, '2017-12-21 13:07:03', 627, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(841, '2017-12-21 13:09:04', 566, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(842, '2017-12-21 13:09:26', 17, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(843, '2017-12-21 13:09:44', 911, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(844, '2017-12-21 13:10:11', 871, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(845, '2017-12-21 13:11:05', 53, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(846, '2017-12-21 13:11:48', 444, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(847, '2017-12-21 13:12:12', 611, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(848, '2017-12-21 13:12:15', 826, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(849, '2017-12-21 13:13:26', 260, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(850, '2017-12-21 13:13:45', 491, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(851, '2017-12-21 13:33:11', 372, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(852, '2017-12-21 13:51:58', 596, 0, 'retarcorp', 'Core Users', 'Авторизован пользователь retarcorp. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(853, '2017-12-21 14:26:44', 319, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(854, '2017-12-21 14:28:20', 328, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(855, '2017-12-21 14:28:36', 598, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(856, '2017-12-21 14:30:36', 237, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(857, '2017-12-21 14:31:10', 928, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(858, '2017-12-21 14:32:08', 881, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(859, '2017-12-21 14:32:19', 169, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(860, '2017-12-21 14:33:48', 339, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(861, '2017-12-21 14:35:08', 672, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(862, '2017-12-21 14:35:44', 613, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(863, '2017-12-21 14:36:25', 720, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(864, '2017-12-21 14:36:48', 449, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(865, '2017-12-21 14:38:16', 441, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(866, '2017-12-21 14:40:25', 361, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(867, '2017-12-21 14:41:17', 605, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(868, '2017-12-21 14:41:50', 949, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(869, '2017-12-21 14:50:57', 371, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(870, '2017-12-21 14:54:17', 488, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(871, '2017-12-21 14:55:07', 568, 0, 'KuplevichIA', 'File Manager', 'Создан файл E:/OpenServer/domains/localhost//js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/create.php'),
(872, '2017-12-21 14:55:31', 513, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(873, '2017-12-21 14:57:10', 280, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(874, '2017-12-21 14:57:15', 959, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(875, '2017-12-21 14:57:45', 162, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(876, '2017-12-21 14:58:02', 253, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(877, '2017-12-21 15:00:05', 633, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(878, '2017-12-21 15:01:34', 515, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(879, '2017-12-21 15:02:17', 911, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(880, '2017-12-21 15:02:36', 788, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(881, '2017-12-21 15:02:51', 856, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(882, '2017-12-21 15:05:11', 735, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(883, '2017-12-21 15:07:23', 783, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(884, '2017-12-21 15:07:55', 150, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(885, '2017-12-21 15:07:58', 279, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(886, '2017-12-21 15:08:45', 732, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(887, '2017-12-21 15:10:04', 274, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(888, '2017-12-21 15:12:00', 864, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(889, '2017-12-21 15:13:16', 643, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(890, '2017-12-21 15:13:47', 905, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(891, '2017-12-21 15:14:53', 356, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(892, '2017-12-21 15:15:11', 653, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(893, '2017-12-21 15:15:12', 410, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(894, '2017-12-21 15:16:13', 905, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(895, '2017-12-21 15:17:34', 521, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(896, '2017-12-21 15:19:36', 895, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(897, '2017-12-21 15:20:16', 588, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(898, '2017-12-21 15:21:06', 747, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(899, '2017-12-21 15:22:43', 573, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(900, '2017-12-21 15:24:28', 477, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(901, '2017-12-21 15:27:51', 677, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(902, '2017-12-21 15:28:17', 712, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(903, '2017-12-21 15:29:06', 641, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(904, '2017-12-21 15:29:41', 656, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(905, '2017-12-21 15:31:11', 975, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(906, '2017-12-21 15:31:31', 115, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(907, '2017-12-21 15:33:09', 642, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(908, '2017-12-21 15:34:06', 455, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(909, '2017-12-21 15:34:55', 256, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(910, '2017-12-21 15:35:20', 851, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(911, '2017-12-21 15:35:47', 767, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(912, '2017-12-21 15:36:25', 670, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(913, '2017-12-21 15:36:44', 412, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(914, '2017-12-21 15:37:46', 157, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(915, '2017-12-21 15:38:16', 573, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(916, '2017-12-21 15:39:16', 322, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(917, '2017-12-21 15:39:46', 985, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(918, '2017-12-21 15:39:53', 546, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(919, '2017-12-21 15:53:38', 897, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(920, '2017-12-21 15:54:01', 636, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(921, '2017-12-21 15:55:03', 967, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(922, '2017-12-21 15:55:18', 213, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(923, '2017-12-21 15:55:45', 817, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(924, '2017-12-21 15:55:59', 986, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(925, '2017-12-21 16:02:00', 533, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(926, '2017-12-21 16:03:04', 202, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(927, '2017-12-21 16:03:51', 133, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(928, '2017-12-21 16:04:04', 648, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(929, '2017-12-21 16:04:22', 122, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(930, '2017-12-21 16:04:22', 593, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(931, '2017-12-21 16:08:19', 149, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(932, '2017-12-21 16:09:01', 192, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(933, '2017-12-21 16:10:10', 305, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(934, '2017-12-21 16:10:49', 31, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(935, '2017-12-21 16:11:24', 46, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(936, '2017-12-21 16:11:36', 812, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(937, '2017-12-21 16:11:49', 84, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(938, '2017-12-21 16:14:00', 504, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(939, '2017-12-21 16:14:30', 757, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(940, '2017-12-21 16:14:41', 590, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(941, '2017-12-21 16:15:01', 879, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(942, '2017-12-21 16:15:42', 93, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(943, '2017-12-21 16:16:29', 215, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(944, '2017-12-21 16:16:52', 51, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(945, '2017-12-21 16:17:03', 109, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(946, '2017-12-21 16:18:53', 572, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(947, '2017-12-21 16:19:26', 31, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(948, '2017-12-21 16:19:49', 10, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(949, '2017-12-21 16:19:56', 404, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(950, '2017-12-21 16:20:18', 727, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(951, '2017-12-21 16:20:30', 455, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(952, '2017-12-21 16:21:12', 184, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(953, '2017-12-21 16:21:40', 5, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(954, '2017-12-21 16:23:22', 608, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(955, '2017-12-21 16:23:59', 590, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(956, '2017-12-21 16:24:19', 88, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(957, '2017-12-21 16:24:53', 663, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(958, '2017-12-21 16:25:22', 353, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(959, '2017-12-21 16:25:50', 276, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(960, '2017-12-21 16:26:26', 859, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(961, '2017-12-21 16:29:04', 654, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(962, '2017-12-21 16:29:32', 174, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(963, '2017-12-21 16:30:14', 380, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(964, '2017-12-21 16:30:29', 81, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(965, '2017-12-21 16:31:13', 324, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(966, '2017-12-21 16:31:42', 55, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(967, '2017-12-21 16:31:56', 791, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(968, '2017-12-21 16:32:16', 891, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(969, '2017-12-21 16:32:47', 800, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(970, '2017-12-21 16:32:51', 828, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(971, '2017-12-21 16:33:14', 729, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(972, '2017-12-21 16:33:25', 57, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(973, '2017-12-21 16:33:27', 816, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(974, '2017-12-21 16:33:48', 310, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(975, '2017-12-21 16:35:25', 320, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(976, '2017-12-21 16:35:43', 317, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(977, '2017-12-21 16:36:22', 452, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(978, '2017-12-21 16:36:24', 688, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(979, '2017-12-21 16:36:45', 704, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(980, '2017-12-21 16:37:01', 820, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(981, '2017-12-21 16:37:16', 526, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(982, '2017-12-21 16:37:45', 920, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(983, '2017-12-21 16:38:37', 727, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(984, '2017-12-21 16:38:49', 183, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(985, '2017-12-21 16:38:55', 571, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(986, '2017-12-21 16:41:57', 984, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(987, '2017-12-21 16:42:15', 900, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(988, '2017-12-21 16:43:37', 643, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(989, '2017-12-21 16:44:06', 630, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(990, '2017-12-21 16:44:58', 140, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(991, '2017-12-21 16:46:22', 250, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(992, '2017-12-21 16:46:38', 957, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(993, '2017-12-21 16:47:24', 153, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(994, '2017-12-21 16:47:56', 21, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(995, '2017-12-21 16:49:23', 655, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(996, '2017-12-21 18:24:54', 410, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(997, '2017-12-21 18:25:02', 485, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(998, '2017-12-21 18:25:39', 342, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(999, '2017-12-21 18:27:32', 285, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1000, '2017-12-21 18:28:01', 890, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1001, '2017-12-21 18:28:16', 902, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1002, '2017-12-21 18:29:10', 689, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1003, '2017-12-21 18:29:35', 465, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1004, '2017-12-21 18:30:53', 120, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1005, '2017-12-21 18:32:09', 849, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1006, '2017-12-21 18:32:28', 716, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1007, '2017-12-21 18:32:57', 341, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1008, '2017-12-21 18:33:43', 867, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1009, '2017-12-21 18:34:11', 557, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1010, '2017-12-21 18:34:42', 240, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1011, '2017-12-21 18:34:58', 260, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1012, '2017-12-21 18:35:33', 369, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1013, '2017-12-21 18:35:36', 128, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1014, '2017-12-21 18:36:03', 856, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1015, '2017-12-21 18:36:50', 696, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1016, '2017-12-21 18:37:48', 227, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1017, '2017-12-21 18:38:07', 147, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1018, '2017-12-21 18:39:20', 192, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1019, '2017-12-21 18:40:02', 733, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1020, '2017-12-21 18:41:00', 293, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1021, '2017-12-21 18:41:36', 169, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1022, '2017-12-21 18:42:01', 238, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1023, '2017-12-21 18:42:09', 615, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1024, '2017-12-21 18:42:12', 196, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1025, '2017-12-21 18:42:31', 83, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1026, '2017-12-21 18:42:37', 168, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1027, '2017-12-21 18:43:44', 194, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1028, '2017-12-21 18:43:56', 96, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1029, '2017-12-21 18:44:07', 878, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1030, '2017-12-21 18:44:30', 576, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1031, '2017-12-21 18:45:19', 874, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1032, '2017-12-21 18:46:17', 115, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1033, '2017-12-21 18:46:37', 870, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1034, '2017-12-21 18:46:56', 824, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1035, '2017-12-21 18:47:13', 832, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1036, '2017-12-21 18:47:25', 939, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1037, '2017-12-21 18:48:27', 147, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1038, '2017-12-21 18:48:46', 324, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1039, '2017-12-21 18:48:56', 724, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1040, '2017-12-21 18:49:50', 540, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1041, '2017-12-21 18:50:23', 522, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1042, '2017-12-21 18:50:23', 659, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1043, '2017-12-21 18:50:50', 80, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1044, '2017-12-21 18:51:21', 303, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1045, '2017-12-21 18:51:32', 623, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1046, '2017-12-21 18:52:45', 867, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1047, '2017-12-21 18:54:02', 43, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1048, '2017-12-21 18:54:38', 80, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1049, '2017-12-21 19:12:21', 397, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1050, '2017-12-21 19:14:03', 967, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1051, '2017-12-21 19:14:42', 26, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1052, '2017-12-21 19:15:00', 419, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1053, '2017-12-21 19:15:17', 381, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1054, '2017-12-21 19:15:45', 583, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1055, '2017-12-21 19:16:09', 579, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1056, '2017-12-21 19:16:36', 970, 0, 'retarcorp', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1057, '2017-12-21 19:16:37', 497, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1058, '2017-12-21 19:16:42', 199, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1059, '2017-12-21 19:17:23', 293, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1060, '2017-12-21 19:18:01', 589, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1061, '2017-12-21 19:18:18', 265, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1062, '2017-12-21 19:19:31', 857, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1063, '2017-12-21 19:19:37', 248, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1064, '2017-12-21 19:20:28', 665, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1065, '2017-12-21 19:21:00', 698, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1066, '2017-12-21 19:21:21', 952, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1067, '2017-12-21 19:22:06', 362, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1068, '2017-12-21 19:22:41', 256, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1069, '2017-12-21 19:22:54', 656, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1070, '2017-12-21 19:23:07', 745, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1071, '2017-12-21 19:23:11', 239, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1072, '2017-12-21 19:24:01', 475, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1073, '2017-12-21 19:27:17', 428, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1074, '2017-12-21 19:28:21', 148, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1075, '2017-12-21 19:29:30', 330, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1076, '2017-12-21 19:29:59', 430, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1077, '2017-12-21 19:30:26', 495, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1078, '2017-12-21 19:31:00', 797, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1079, '2017-12-21 19:31:35', 572, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1080, '2017-12-21 19:32:12', 933, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1081, '2017-12-21 19:33:45', 661, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1082, '2017-12-21 19:34:25', 749, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1083, '2017-12-21 19:34:48', 303, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1084, '2017-12-21 19:34:48', 779, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1085, '2017-12-21 19:36:00', 932, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1086, '2017-12-21 19:36:23', 857, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1087, '2017-12-21 19:36:48', 844, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1088, '2017-12-21 20:24:59', 727, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [195.50.26.61]\nE:/OpenServer/domains/localhost/Core/login.php'),
(1089, '2017-12-21 20:27:51', 872, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1090, '2017-12-21 20:29:31', 335, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1091, '2017-12-21 20:29:46', 227, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1092, '2017-12-21 20:29:50', 603, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1093, '2017-12-21 20:32:55', 359, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1094, '2017-12-21 20:32:56', 976, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1095, '2017-12-21 20:33:42', 169, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1096, '2017-12-21 20:34:03', 501, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1097, '2017-12-21 20:35:49', 472, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1098, '2017-12-21 20:35:53', 295, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1099, '2017-12-21 20:35:58', 670, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1100, '2017-12-21 20:36:46', 321, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1101, '2017-12-21 20:36:48', 458, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1102, '2017-12-21 20:37:55', 847, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1103, '2017-12-21 20:38:11', 141, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1104, '2017-12-21 20:46:39', 288, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1105, '2017-12-21 20:51:34', 986, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1106, '2017-12-21 21:57:22', 513, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1107, '2017-12-21 21:59:19', 748, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1108, '2017-12-21 21:59:42', 404, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1109, '2017-12-21 22:14:03', 666, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1110, '2017-12-21 22:14:35', 34, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1111, '2017-12-21 22:14:56', 191, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1112, '2017-12-21 22:15:22', 215, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1113, '2017-12-21 22:16:53', 993, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1114, '2017-12-21 22:17:42', 871, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1115, '2017-12-21 22:17:45', 807, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1116, '2017-12-21 22:18:20', 430, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1117, '2017-12-21 22:19:35', 82, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1118, '2017-12-21 22:19:46', 510, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1119, '2017-12-21 22:20:58', 836, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1120, '2018-01-09 11:05:24', 231, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(1121, '2018-01-09 11:24:02', 53, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1122, '2018-01-09 11:24:23', 564, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1123, '2018-01-09 11:26:24', 900, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1124, '2018-01-09 11:30:22', 44, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1125, '2018-01-09 11:31:34', 222, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1126, '2018-01-09 11:32:12', 818, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1127, '2018-01-09 11:32:28', 146, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1128, '2018-01-09 11:32:44', 61, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(1129, '2018-01-09 11:33:06', 361, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1130, '2018-01-09 11:33:37', 968, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1131, '2018-01-09 11:35:09', 390, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1132, '2018-01-09 11:36:01', 934, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1133, '2018-01-09 11:37:42', 637, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1134, '2018-01-09 11:37:52', 549, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1135, '2018-01-09 11:39:44', 512, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1136, '2018-01-09 11:40:21', 758, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1137, '2018-01-09 11:41:36', 63, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1138, '2018-01-09 11:42:00', 988, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1139, '2018-01-09 11:43:48', 571, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1140, '2018-01-09 11:43:55', 22, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1141, '2018-01-09 11:44:14', 51, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1142, '2018-01-09 11:48:18', 60, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1143, '2018-01-09 11:48:29', 32, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1144, '2018-01-09 11:48:42', 427, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1145, '2018-01-09 11:49:06', 30, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1146, '2018-01-09 11:49:14', 668, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1147, '2018-01-09 11:50:49', 639, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1148, '2018-01-09 11:51:10', 107, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1149, '2018-01-09 11:52:03', 95, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1150, '2018-01-09 11:52:18', 296, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1151, '2018-01-09 11:55:56', 526, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1152, '2018-01-09 11:56:08', 265, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1153, '2018-01-09 11:56:21', 690, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1154, '2018-01-09 11:56:59', 762, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1155, '2018-01-09 11:57:54', 711, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1156, '2018-01-09 11:58:28', 661, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1157, '2018-01-09 12:02:55', 130, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1158, '2018-01-09 12:03:17', 799, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1159, '2018-01-09 12:03:34', 243, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1160, '2018-01-09 12:04:26', 750, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1161, '2018-01-09 12:20:50', 345, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1162, '2018-01-09 12:21:26', 567, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1163, '2018-01-09 12:21:58', 974, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1164, '2018-01-09 12:22:18', 706, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1165, '2018-01-09 12:22:55', 369, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1166, '2018-01-09 12:23:29', 509, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1167, '2018-01-09 12:24:08', 278, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1168, '2018-01-09 12:25:27', 962, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1169, '2018-01-09 12:28:31', 590, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1170, '2018-01-09 12:42:20', 635, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1171, '2018-01-09 12:43:38', 576, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1172, '2018-01-09 12:44:06', 276, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1173, '2018-01-09 12:44:18', 550, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1174, '2018-01-09 12:45:12', 136, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1175, '2018-01-09 12:45:22', 983, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1176, '2018-01-09 12:45:43', 691, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1177, '2018-01-09 12:45:52', 764, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1178, '2018-01-09 12:46:01', 959, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1179, '2018-01-09 12:46:27', 718, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1180, '2018-01-09 12:46:39', 187, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1181, '2018-01-09 12:46:53', 214, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1182, '2018-01-09 12:47:10', 9, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1183, '2018-01-09 12:47:58', 122, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1184, '2018-01-09 12:48:27', 168, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1185, '2018-01-09 12:48:47', 753, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1186, '2018-01-09 12:49:20', 8, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1187, '2018-01-09 12:49:22', 5, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1188, '2018-01-09 12:49:27', 34, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1189, '2018-01-09 12:49:38', 20, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1190, '2018-01-09 12:50:01', 664, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1191, '2018-01-09 12:50:08', 257, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1192, '2018-01-09 12:50:30', 391, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1193, '2018-01-09 12:50:37', 536, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1194, '2018-01-09 12:51:18', 625, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1195, '2018-01-09 12:51:36', 1, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1196, '2018-01-09 12:52:27', 535, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1197, '2018-01-09 12:52:48', 223, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1198, '2018-01-09 12:55:29', 62, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1199, '2018-01-09 12:56:02', 788, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1200, '2018-01-09 12:58:03', 27, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1201, '2018-01-09 13:00:25', 103, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1202, '2018-01-09 13:03:32', 70, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1203, '2018-01-09 13:05:12', 513, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1204, '2018-01-09 13:05:17', 537, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1205, '2018-01-09 13:05:17', 989, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1206, '2018-01-09 13:06:02', 987, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1207, '2018-01-09 13:06:34', 961, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1208, '2018-01-09 13:08:52', 460, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1209, '2018-01-09 13:10:05', 215, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1210, '2018-01-09 13:10:38', 795, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1211, '2018-01-09 13:11:07', 895, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1212, '2018-01-09 13:11:13', 483, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1213, '2018-01-09 13:11:29', 703, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1214, '2018-01-09 13:15:33', 938, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1215, '2018-01-09 13:15:59', 378, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1216, '2018-01-09 13:17:02', 563, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1217, '2018-01-09 13:18:42', 835, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1218, '2018-01-09 13:19:16', 58, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1219, '2018-01-09 13:19:43', 483, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1220, '2018-01-09 13:20:35', 549, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1221, '2018-01-09 13:21:10', 98, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1222, '2018-01-09 13:21:38', 165, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1223, '2018-01-09 13:23:54', 214, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1224, '2018-01-09 13:24:23', 366, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1225, '2018-01-09 13:24:46', 595, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1226, '2018-01-09 13:27:44', 533, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1227, '2018-01-09 13:30:12', 545, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1228, '2018-01-09 13:34:07', 778, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1229, '2018-01-09 13:35:23', 93, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1230, '2018-01-09 13:35:55', 167, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1231, '2018-01-09 13:37:29', 229, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1232, '2018-01-09 13:38:59', 769, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1233, '2018-01-09 13:39:00', 938, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1234, '2018-01-09 13:40:08', 816, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1235, '2018-01-09 13:40:45', 488, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1236, '2018-01-09 13:40:51', 713, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1237, '2018-01-09 13:41:46', 678, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1238, '2018-01-09 13:41:50', 828, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1239, '2018-01-09 13:43:06', 661, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1240, '2018-01-09 13:44:11', 702, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1241, '2018-01-09 13:44:35', 666, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1242, '2018-01-09 13:47:09', 747, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1243, '2018-01-09 13:47:12', 76, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1244, '2018-01-09 13:49:57', 52, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1245, '2018-01-09 14:08:18', 190, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1246, '2018-01-09 14:09:02', 680, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1247, '2018-01-09 14:12:19', 545, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1248, '2018-01-09 14:15:48', 593, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1249, '2018-01-09 14:16:20', 40, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1250, '2018-01-09 14:16:48', 823, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1251, '2018-01-09 14:17:08', 583, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1252, '2018-01-09 14:17:30', 30, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1253, '2018-01-09 14:17:53', 818, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1254, '2018-01-09 14:18:20', 900, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1255, '2018-01-09 14:18:40', 304, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1256, '2018-01-09 14:18:53', 268, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1257, '2018-01-09 14:19:03', 751, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1258, '2018-01-09 14:19:29', 334, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1259, '2018-01-09 14:19:47', 11, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1260, '2018-01-09 14:19:56', 100, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1261, '2018-01-09 14:20:35', 796, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1262, '2018-01-09 14:23:25', 905, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1263, '2018-01-09 14:24:15', 17, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1264, '2018-01-09 14:28:32', 532, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1265, '2018-01-09 14:29:12', 892, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1266, '2018-01-09 14:30:15', 591, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1267, '2018-01-09 14:31:04', 968, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1268, '2018-01-09 14:31:33', 92, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1269, '2018-01-09 14:32:29', 579, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1270, '2018-01-09 14:32:50', 354, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1271, '2018-01-09 14:33:05', 739, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1272, '2018-01-09 14:33:35', 293, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1273, '2018-01-09 14:33:54', 756, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1274, '2018-01-09 14:34:04', 278, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1275, '2018-01-09 14:34:12', 580, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1276, '2018-01-09 14:34:18', 154, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1277, '2018-01-09 14:34:55', 891, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1278, '2018-01-09 14:35:14', 651, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1279, '2018-01-09 14:35:48', 402, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1280, '2018-01-09 14:37:24', 106, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1281, '2018-01-09 14:38:43', 777, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1282, '2018-01-09 14:39:05', 342, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1283, '2018-01-09 14:39:30', 43, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1284, '2018-01-09 14:42:15', 572, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1285, '2018-01-09 14:43:02', 966, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1286, '2018-01-09 14:44:54', 679, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1287, '2018-01-09 14:45:12', 401, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1288, '2018-01-09 14:46:17', 84, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1289, '2018-01-09 14:56:22', 77, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1290, '2018-01-09 14:56:47', 654, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1291, '2018-01-09 14:57:27', 309, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1292, '2018-01-09 14:57:49', 457, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1293, '2018-01-09 14:58:53', 339, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1294, '2018-01-09 15:00:18', 207, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1295, '2018-01-09 15:00:47', 625, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1296, '2018-01-09 15:01:46', 734, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1297, '2018-01-09 15:02:12', 141, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1298, '2018-01-09 15:02:17', 225, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1299, '2018-01-09 15:02:38', 114, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1300, '2018-01-09 15:02:59', 958, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1301, '2018-01-09 15:03:19', 817, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1302, '2018-01-09 15:04:06', 186, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1303, '2018-01-09 15:04:57', 676, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1304, '2018-01-09 15:06:01', 52, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1305, '2018-01-09 15:06:12', 155, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1306, '2018-01-09 15:06:52', 10, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1307, '2018-01-09 15:07:29', 546, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1308, '2018-01-09 15:08:07', 141, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1309, '2018-01-09 15:08:25', 915, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1310, '2018-01-09 15:08:45', 708, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1311, '2018-01-09 15:08:55', 74, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1312, '2018-01-09 15:09:00', 669, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1313, '2018-01-09 15:09:31', 456, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1314, '2018-01-09 15:09:46', 232, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1315, '2018-01-09 15:10:06', 178, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1316, '2018-01-09 15:14:57', 798, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1317, '2018-01-09 15:15:27', 625, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1318, '2018-01-09 15:15:29', 111, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1319, '2018-01-09 15:15:58', 185, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1320, '2018-01-09 15:17:35', 320, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1321, '2018-01-09 15:17:53', 247, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1322, '2018-01-09 15:17:56', 874, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1323, '2018-01-09 15:18:06', 247, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1324, '2018-01-09 15:18:12', 296, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1325, '2018-01-09 15:19:19', 665, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1326, '2018-01-09 15:19:37', 436, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1327, '2018-01-09 15:19:57', 623, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1328, '2018-01-09 15:20:15', 572, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1329, '2018-01-09 15:20:36', 24, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1330, '2018-01-09 15:20:58', 545, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1331, '2018-01-09 15:21:50', 72, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1332, '2018-01-09 15:22:05', 109, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1333, '2018-01-09 15:22:45', 360, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1334, '2018-01-09 15:23:10', 581, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1335, '2018-01-09 15:23:24', 88, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1336, '2018-01-09 15:23:55', 631, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1337, '2018-01-09 15:23:57', 462, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1338, '2018-01-09 15:24:11', 799, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1339, '2018-01-09 15:24:23', 667, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1340, '2018-01-09 15:24:45', 755, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1341, '2018-01-09 15:25:44', 537, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1342, '2018-01-09 15:28:14', 686, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1343, '2018-01-09 15:28:50', 921, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1344, '2018-01-09 15:28:57', 631, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1345, '2018-01-09 15:29:50', 831, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1346, '2018-01-09 15:29:57', 197, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1347, '2018-01-09 15:30:34', 106, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1348, '2018-01-09 15:32:38', 766, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1349, '2018-01-09 19:56:23', 172, 0, 'retarcorp', 'Core Users', 'Авторизован пользователь retarcorp. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(1350, '2018-01-12 08:40:56', 328, 0, 'retarcorp', 'Core Users', 'Авторизован пользователь retarcorp. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(1351, '2018-01-12 08:41:03', 33, 0, 'retarcorp', 'File Manager', 'Создан файл E:/OpenServer/domains/localhost//login_data.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/create.php'),
(1352, '2018-01-12 08:41:08', 156, 0, 'retarcorp', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/login_data.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1353, '2018-01-12 11:22:29', 882, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(1354, '2018-01-12 11:33:33', 538, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1355, '2018-01-12 11:36:45', 193, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1356, '2018-01-12 11:37:32', 85, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1357, '2018-01-12 11:38:14', 654, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1358, '2018-01-12 11:38:35', 225, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1359, '2018-01-12 11:39:02', 497, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1360, '2018-01-12 11:39:30', 485, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1361, '2018-01-12 11:40:01', 905, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1362, '2018-01-12 11:40:02', 109, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1363, '2018-01-12 11:41:29', 203, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1364, '2018-01-12 11:41:39', 596, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1365, '2018-01-12 11:42:44', 617, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1366, '2018-01-12 11:43:18', 508, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1367, '2018-01-12 11:43:41', 699, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1368, '2018-01-12 11:46:00', 35, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1369, '2018-01-12 11:46:19', 555, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1370, '2018-01-12 11:46:30', 714, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1371, '2018-01-12 11:47:47', 475, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1372, '2018-01-12 11:48:19', 892, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1373, '2018-01-12 11:51:28', 258, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1374, '2018-01-12 11:51:51', 224, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1375, '2018-01-12 11:57:01', 82, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1376, '2018-01-12 11:57:52', 535, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1377, '2018-01-12 12:03:57', 834, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1378, '2018-01-12 12:04:41', 942, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1379, '2018-01-12 12:05:31', 600, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1380, '2018-01-12 12:06:41', 184, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1381, '2018-01-12 12:07:29', 905, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1382, '2018-01-12 12:07:41', 909, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1383, '2018-01-12 12:08:39', 956, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1384, '2018-01-12 12:10:41', 969, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1385, '2018-01-12 12:10:58', 668, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1386, '2018-01-12 12:11:21', 916, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1387, '2018-01-12 12:12:07', 323, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1388, '2018-01-12 12:13:58', 594, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1389, '2018-01-12 12:14:42', 751, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1390, '2018-01-12 12:16:55', 473, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1391, '2018-01-12 12:18:28', 17, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1392, '2018-01-12 12:18:48', 654, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1393, '2018-01-12 12:19:36', 871, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1394, '2018-01-12 12:19:54', 253, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1395, '2018-01-12 12:21:51', 364, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1396, '2018-01-12 12:22:24', 211, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1397, '2018-01-12 12:22:45', 824, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1398, '2018-01-12 12:25:49', 647, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1399, '2018-01-12 12:27:25', 571, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1400, '2018-01-12 12:27:27', 786, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1401, '2018-01-12 12:29:24', 39, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1402, '2018-01-12 12:30:59', 101, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1403, '2018-01-12 12:31:26', 441, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1404, '2018-01-12 12:31:37', 177, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1405, '2018-01-12 12:31:45', 740, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1406, '2018-01-12 12:31:54', 53, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1407, '2018-01-12 12:32:00', 284, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1408, '2018-01-12 12:32:12', 129, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1409, '2018-01-12 12:32:31', 448, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1410, '2018-01-12 12:32:40', 625, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1411, '2018-01-12 12:32:47', 554, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1412, '2018-01-12 12:32:52', 549, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1413, '2018-01-12 12:32:55', 611, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1414, '2018-01-12 12:33:08', 716, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1415, '2018-01-12 13:19:37', 211, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1416, '2018-01-12 13:20:02', 972, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1417, '2018-01-12 13:44:22', 900, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1418, '2018-01-12 13:51:11', 73, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1419, '2018-01-12 13:52:35', 58, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1420, '2018-01-12 13:52:52', 149, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1421, '2018-01-12 13:53:17', 143, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1422, '2018-01-12 13:53:47', 880, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1423, '2018-01-12 13:55:51', 750, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1424, '2018-01-12 13:58:12', 726, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1425, '2018-01-12 13:58:45', 967, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1426, '2018-01-12 13:58:46', 929, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1427, '2018-01-12 13:59:41', 240, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1428, '2018-01-12 13:59:58', 54, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1429, '2018-01-12 14:00:08', 234, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1430, '2018-01-12 14:00:16', 815, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1431, '2018-01-12 14:00:47', 242, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1432, '2018-01-12 14:01:27', 762, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1433, '2018-01-12 14:01:39', 862, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1434, '2018-01-12 14:01:58', 256, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1435, '2018-01-12 14:02:29', 370, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1436, '2018-01-12 14:03:32', 567, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1437, '2018-01-12 14:03:47', 772, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1438, '2018-01-12 14:04:25', 799, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1439, '2018-01-12 14:05:25', 133, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1440, '2018-01-12 14:05:52', 360, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1441, '2018-01-12 14:06:32', 651, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1442, '2018-01-12 14:07:07', 906, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1443, '2018-01-12 14:08:22', 437, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1444, '2018-01-12 14:08:37', 693, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1445, '2018-01-12 14:08:39', 515, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1446, '2018-01-12 14:09:05', 303, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1447, '2018-01-12 14:09:15', 401, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1448, '2018-01-12 14:09:41', 950, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1449, '2018-01-12 14:09:51', 625, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1450, '2018-01-12 14:10:06', 882, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1451, '2018-01-12 14:11:41', 486, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1452, '2018-01-12 14:12:15', 941, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1453, '2018-01-12 14:12:29', 72, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1454, '2018-01-12 14:12:45', 393, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1455, '2018-01-12 14:13:18', 65, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1456, '2018-01-12 14:13:59', 947, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1457, '2018-01-12 14:14:50', 777, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1458, '2018-01-12 14:15:41', 349, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1459, '2018-01-12 14:16:15', 567, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1460, '2018-01-12 14:18:00', 884, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1461, '2018-01-12 14:20:24', 945, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1462, '2018-01-12 14:21:39', 308, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1463, '2018-01-12 14:22:11', 123, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1464, '2018-01-12 14:23:46', 409, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1465, '2018-01-12 14:25:38', 127, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1466, '2018-01-12 14:27:10', 607, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1467, '2018-01-12 14:33:24', 564, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1468, '2018-01-12 14:34:33', 730, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1469, '2018-01-12 14:34:48', 953, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1470, '2018-01-12 14:34:56', 832, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1471, '2018-01-12 14:35:16', 295, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1472, '2018-01-12 14:35:51', 414, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1473, '2018-01-12 14:36:25', 840, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1474, '2018-01-12 14:36:42', 5, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1475, '2018-01-12 14:36:52', 654, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1476, '2018-01-12 14:37:14', 40, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1477, '2018-01-12 14:37:16', 551, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1478, '2018-01-12 14:39:11', 59, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1479, '2018-01-12 14:39:49', 877, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1480, '2018-01-12 14:40:31', 880, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1481, '2018-01-12 14:40:39', 227, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1482, '2018-01-12 14:42:08', 138, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1483, '2018-01-12 14:52:19', 244, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1484, '2018-01-12 14:52:37', 981, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1485, '2018-01-12 14:53:14', 897, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1486, '2018-01-12 14:54:14', 179, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1487, '2018-01-12 14:54:42', 987, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1488, '2018-01-14 16:12:55', 750, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [93.125.107.6]\nE:/OpenServer/domains/localhost/Core/login.php'),
(1489, '2018-01-14 16:15:19', 366, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1490, '2018-01-14 16:16:05', 655, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1491, '2018-01-14 16:22:20', 429, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1492, '2018-01-14 16:42:22', 445, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1493, '2018-01-14 16:43:48', 805, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1494, '2018-01-14 16:44:39', 330, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1495, '2018-01-14 16:44:53', 744, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1496, '2018-01-14 16:46:53', 268, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1497, '2018-01-14 16:47:41', 776, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1498, '2018-01-14 17:00:59', 461, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1499, '2018-01-14 17:01:40', 286, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1500, '2018-01-14 17:02:52', 679, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1501, '2018-01-14 17:03:08', 327, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1502, '2018-01-14 17:04:01', 51, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1503, '2018-01-14 17:04:16', 903, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1504, '2018-01-14 17:06:16', 240, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1505, '2018-01-15 11:38:42', 337, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1506, '2018-01-15 11:38:49', 815, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1507, '2018-01-15 11:39:15', 580, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1508, '2018-01-15 11:40:30', 358, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1509, '2018-01-15 11:46:36', 996, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1510, '2018-01-15 11:47:00', 560, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1511, '2018-01-15 11:58:17', 493, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1512, '2018-01-15 11:58:26', 502, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1513, '2018-01-15 11:58:40', 387, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1514, '2018-01-15 12:00:31', 457, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1515, '2018-01-15 12:05:05', 55, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1516, '2018-01-15 12:05:18', 926, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1517, '2018-01-15 12:06:51', 25, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1518, '2018-01-15 12:06:58', 605, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1519, '2018-01-15 12:07:20', 210, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1520, '2018-01-15 12:07:59', 754, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1521, '2018-01-15 12:08:37', 236, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1522, '2018-01-15 12:08:56', 995, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1523, '2018-01-15 12:09:04', 158, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1524, '2018-01-15 12:09:28', 811, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1525, '2018-01-15 12:10:00', 375, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1526, '2018-01-15 12:10:07', 43, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1527, '2018-01-15 12:14:34', 65, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1528, '2018-01-15 12:18:04', 180, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1529, '2018-01-15 12:18:50', 609, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1530, '2018-01-15 12:22:21', 673, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1531, '2018-01-15 12:25:35', 341, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1532, '2018-01-15 12:26:10', 430, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1533, '2018-01-15 12:27:33', 772, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1534, '2018-01-15 12:28:07', 191, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1535, '2018-01-15 12:28:17', 2, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1536, '2018-01-15 12:31:39', 576, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1537, '2018-01-15 12:36:21', 715, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1538, '2018-01-15 12:37:43', 879, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1539, '2018-01-15 12:38:09', 589, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1540, '2018-01-15 12:38:18', 189, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1541, '2018-01-15 12:39:10', 126, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1542, '2018-01-15 12:39:51', 140, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1543, '2018-01-15 12:40:26', 546, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1544, '2018-01-15 12:40:27', 843, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1545, '2018-01-15 12:40:59', 438, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1546, '2018-01-15 12:41:53', 636, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1547, '2018-01-15 12:41:57', 427, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1548, '2018-01-15 12:42:37', 407, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1549, '2018-01-15 12:42:47', 118, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1550, '2018-01-15 12:43:36', 215, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1551, '2018-01-15 12:44:48', 958, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1552, '2018-01-15 12:45:07', 973, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1553, '2018-01-15 12:45:48', 691, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1554, '2018-01-15 12:46:19', 907, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1555, '2018-01-15 12:47:17', 430, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1556, '2018-01-15 12:47:22', 552, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1557, '2018-01-15 12:47:40', 747, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1558, '2018-01-15 12:47:53', 319, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1559, '2018-01-15 12:48:07', 1, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1560, '2018-01-15 12:48:18', 155, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1561, '2018-01-15 12:48:19', 370, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1562, '2018-01-15 12:48:36', 831, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1563, '2018-01-15 12:49:07', 373, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1564, '2018-01-15 12:50:10', 719, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1565, '2018-01-15 12:50:32', 297, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1566, '2018-01-15 12:50:40', 520, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1567, '2018-01-15 12:51:00', 924, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1568, '2018-01-15 12:51:54', 164, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1569, '2018-01-15 12:52:36', 805, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1570, '2018-01-15 12:52:44', 272, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1571, '2018-01-15 12:53:21', 813, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1572, '2018-01-15 12:53:26', 118, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1573, '2018-01-15 12:53:49', 131, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1574, '2018-01-15 12:54:41', 207, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1575, '2018-01-15 12:54:43', 600, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1576, '2018-01-15 12:54:45', 231, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1577, '2018-01-15 12:55:07', 70, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1578, '2018-01-15 12:56:33', 265, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1579, '2018-01-15 12:56:54', 435, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1580, '2018-01-15 12:57:03', 548, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(1581, '2018-01-15 12:58:02', 560, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1582, '2018-01-15 12:58:39', 555, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1583, '2018-01-15 12:59:13', 365, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1584, '2018-01-15 12:59:32', 339, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1585, '2018-01-15 13:00:30', 248, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1586, '2018-01-15 13:01:03', 319, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1587, '2018-01-15 13:01:45', 852, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1588, '2018-01-15 13:02:00', 377, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1589, '2018-01-15 13:02:21', 694, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1590, '2018-01-15 13:03:01', 477, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1591, '2018-01-15 13:03:28', 532, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1592, '2018-01-15 13:03:50', 755, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1593, '2018-01-15 13:03:56', 219, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1594, '2018-01-15 13:04:39', 327, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1595, '2018-01-15 13:07:46', 753, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1596, '2018-01-15 13:08:04', 682, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1597, '2018-01-15 13:08:11', 534, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1598, '2018-01-15 13:08:34', 713, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1599, '2018-01-15 13:09:10', 936, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1600, '2018-01-15 13:09:33', 858, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1601, '2018-01-15 13:09:58', 987, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1602, '2018-01-15 13:10:28', 131, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1603, '2018-01-15 13:10:47', 689, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1604, '2018-01-15 13:10:53', 584, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1605, '2018-01-15 13:11:26', 765, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1606, '2018-01-15 13:11:45', 358, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1607, '2018-01-15 13:20:01', 253, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1608, '2018-01-15 13:20:06', 646, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1609, '2018-01-15 13:20:19', 527, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1610, '2018-01-15 13:20:40', 958, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1611, '2018-01-15 13:20:53', 915, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1612, '2018-01-15 13:21:44', 714, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1613, '2018-01-15 13:21:53', 648, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1614, '2018-01-15 13:23:21', 613, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1615, '2018-01-15 13:23:55', 953, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1616, '2018-01-15 13:24:23', 830, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1617, '2018-01-15 13:25:10', 311, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1618, '2018-01-15 13:25:37', 675, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1619, '2018-01-15 13:27:54', 590, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1620, '2018-01-15 13:42:43', 677, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1621, '2018-01-15 13:43:15', 871, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1622, '2018-01-15 13:43:29', 162, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1623, '2018-01-15 13:44:01', 707, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1624, '2018-01-15 13:44:11', 810, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1625, '2018-01-15 13:44:21', 887, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1626, '2018-01-15 13:44:44', 123, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1627, '2018-01-15 13:45:51', 477, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1628, '2018-01-15 13:46:23', 325, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1629, '2018-01-15 13:46:27', 205, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1630, '2018-01-15 13:46:53', 174, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1631, '2018-01-15 13:47:46', 186, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1632, '2018-01-15 13:48:58', 62, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1633, '2018-01-15 13:49:18', 608, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1634, '2018-01-15 13:49:53', 372, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1635, '2018-01-15 13:50:33', 197, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1636, '2018-01-15 13:50:56', 667, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1637, '2018-01-15 13:51:29', 927, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1638, '2018-01-15 13:51:51', 324, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1639, '2018-01-15 13:52:16', 217, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1640, '2018-01-15 13:52:49', 258, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1641, '2018-01-15 13:53:47', 469, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1642, '2018-01-15 13:54:08', 350, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1643, '2018-01-15 13:54:23', 316, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1644, '2018-01-15 13:54:41', 999, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1645, '2018-01-15 13:55:04', 925, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1646, '2018-01-15 13:55:26', 88, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1647, '2018-01-15 13:56:15', 924, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1648, '2018-01-15 13:58:45', 743, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1649, '2018-01-15 13:59:05', 69, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1650, '2018-01-15 14:00:10', 915, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1651, '2018-01-15 14:00:32', 312, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1652, '2018-01-15 14:00:43', 216, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1653, '2018-01-15 14:01:21', 202, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1654, '2018-01-15 14:01:59', 904, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1655, '2018-01-15 14:02:08', 444, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1656, '2018-01-15 14:02:34', 77, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1657, '2018-01-15 14:02:48', 280, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1658, '2018-01-15 14:03:57', 467, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1659, '2018-01-15 14:04:52', 848, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1660, '2018-01-15 14:04:59', 503, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1661, '2018-01-15 14:05:13', 254, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1662, '2018-01-15 14:05:21', 771, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1663, '2018-01-15 14:06:11', 823, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1664, '2018-01-15 14:06:12', 726, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1665, '2018-01-15 14:06:42', 421, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1666, '2018-01-15 14:07:25', 826, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1667, '2018-01-15 14:07:53', 538, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1668, '2018-01-15 14:08:26', 478, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1669, '2018-01-15 14:08:42', 633, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1670, '2018-01-15 14:09:21', 277, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1671, '2018-01-15 14:11:34', 488, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1672, '2018-01-15 14:11:39', 18, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1673, '2018-01-15 14:12:06', 208, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1674, '2018-01-15 14:14:36', 414, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1675, '2018-01-15 14:15:13', 968, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1676, '2018-01-15 14:15:28', 836, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1677, '2018-01-15 14:17:34', 759, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1678, '2018-01-15 14:18:33', 443, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1679, '2018-01-15 14:22:12', 990, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1680, '2018-01-15 14:23:02', 908, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1681, '2018-01-15 14:23:15', 671, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1682, '2018-01-15 14:23:45', 62, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1683, '2018-01-15 14:25:20', 297, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1684, '2018-01-15 14:25:39', 515, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1685, '2018-01-15 14:26:16', 810, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1686, '2018-01-15 14:27:05', 24, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1687, '2018-01-15 14:27:25', 224, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1688, '2018-01-15 14:31:21', 186, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1689, '2018-01-15 14:31:47', 473, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1690, '2018-01-15 14:32:33', 400, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1691, '2018-01-15 14:33:22', 595, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1692, '2018-01-15 14:33:47', 839, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1693, '2018-01-15 14:34:19', 54, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1694, '2018-01-15 14:34:20', 174, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1695, '2018-01-15 14:34:36', 358, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1696, '2018-01-15 14:34:52', 173, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1697, '2018-01-15 14:35:59', 315, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1698, '2018-01-15 14:37:13', 883, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1699, '2018-01-15 14:37:15', 71, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1700, '2018-01-15 14:38:00', 705, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1701, '2018-01-15 14:38:09', 307, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1702, '2018-01-15 14:38:46', 907, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1703, '2018-01-15 14:39:00', 679, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1704, '2018-01-15 14:39:25', 362, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1705, '2018-01-15 14:39:33', 909, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1706, '2018-01-15 14:39:43', 518, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1707, '2018-01-15 14:41:08', 555, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1708, '2018-01-15 14:43:22', 415, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1709, '2018-01-15 14:45:00', 43, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1710, '2018-01-15 14:50:15', 996, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1711, '2018-01-15 14:50:19', 713, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1712, '2018-01-15 14:50:36', 69, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1713, '2018-01-15 14:50:46', 658, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1714, '2018-01-15 14:51:03', 98, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1715, '2018-01-15 14:52:33', 84, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1716, '2018-01-15 14:52:36', 796, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1717, '2018-01-15 14:55:11', 377, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1718, '2018-01-15 14:56:21', 899, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1719, '2018-01-15 14:56:28', 401, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1720, '2018-01-15 14:56:42', 188, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1721, '2018-01-15 14:57:27', 614, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1722, '2018-01-15 14:58:46', 332, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1723, '2018-01-15 14:59:18', 795, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1724, '2018-01-15 15:00:22', 372, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1725, '2018-01-15 15:00:31', 841, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1726, '2018-01-15 15:00:44', 177, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1727, '2018-01-15 15:03:44', 682, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1728, '2018-01-15 15:06:52', 800, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1729, '2018-01-15 15:07:31', 249, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1730, '2018-01-15 15:07:53', 335, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1731, '2018-01-15 15:08:50', 999, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1732, '2018-01-15 15:09:27', 513, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1733, '2018-01-15 15:09:43', 904, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1734, '2018-01-15 15:10:18', 645, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1735, '2018-01-15 15:10:46', 195, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1736, '2018-01-15 15:11:15', 600, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1737, '2018-01-15 15:11:50', 793, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1738, '2018-01-15 15:12:02', 541, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1739, '2018-01-15 15:12:09', 994, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1740, '2018-01-15 15:24:08', 18, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1741, '2018-01-15 15:24:31', 777, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1742, '2018-01-15 15:24:49', 61, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1743, '2018-01-15 15:27:17', 17, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1744, '2018-01-15 15:28:54', 68, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1745, '2018-01-15 15:29:12', 398, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1746, '2018-01-15 15:29:31', 568, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1747, '2018-01-15 15:30:07', 680, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1748, '2018-01-15 15:30:37', 481, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1749, '2018-01-15 15:31:01', 622, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1750, '2018-01-15 15:31:11', 975, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1751, '2018-01-15 15:31:21', 681, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1752, '2018-01-15 15:32:39', 256, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1753, '2018-01-15 15:33:04', 502, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1754, '2018-01-15 15:34:08', 283, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1755, '2018-01-15 15:34:31', 414, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1756, '2018-01-15 15:34:48', 228, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1757, '2018-01-15 15:35:18', 34, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1758, '2018-01-15 15:38:40', 229, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1759, '2018-01-15 15:40:54', 294, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1760, '2018-01-15 15:45:46', 619, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1761, '2018-01-15 15:51:15', 962, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1762, '2018-01-15 15:51:27', 355, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [195.50.26.61]\nE:/OpenServer/domains/localhost/Core/login.php'),
(1763, '2018-01-15 15:51:35', 657, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1764, '2018-01-15 15:55:01', 597, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1765, '2018-01-15 15:55:56', 799, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1766, '2018-01-15 15:57:09', 482, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1767, '2018-01-15 15:57:59', 976, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1768, '2018-01-15 15:58:42', 497, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1769, '2018-01-15 15:58:59', 173, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1770, '2018-01-15 15:59:03', 991, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1771, '2018-01-15 15:59:13', 83, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1772, '2018-01-15 15:59:42', 398, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1773, '2018-01-15 16:01:03', 85, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1774, '2018-01-15 16:01:51', 675, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1775, '2018-01-15 16:02:24', 305, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1776, '2018-01-15 16:03:52', 640, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1777, '2018-01-15 16:05:08', 880, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1778, '2018-01-15 16:06:58', 153, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1779, '2018-01-15 16:08:41', 564, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1780, '2018-01-15 16:09:33', 685, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1781, '2018-01-15 16:10:25', 384, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1782, '2018-01-15 16:10:33', 503, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1783, '2018-01-15 16:11:20', 86, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1784, '2018-01-15 16:11:37', 83, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1785, '2018-01-15 16:13:09', 830, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(1786, '2018-01-15 16:13:13', 556, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1787, '2018-01-15 16:14:16', 788, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1788, '2018-01-15 16:16:05', 447, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1789, '2018-01-15 16:16:58', 488, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1790, '2018-01-15 16:17:02', 496, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1791, '2018-01-15 16:18:58', 239, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1792, '2018-01-15 16:18:58', 256, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1793, '2018-01-15 16:19:00', 396, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1794, '2018-01-15 16:19:01', 4, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1795, '2018-01-15 16:20:21', 951, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1796, '2018-01-15 16:21:35', 625, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1797, '2018-01-15 16:22:08', 786, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1798, '2018-01-15 16:22:14', 114, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1799, '2018-01-15 16:22:47', 177, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1800, '2018-01-15 16:23:32', 694, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1801, '2018-01-15 16:24:03', 32, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1802, '2018-01-15 16:24:06', 647, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1803, '2018-01-15 16:25:46', 981, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1804, '2018-01-15 16:26:05', 307, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1805, '2018-01-15 16:26:26', 65, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1806, '2018-01-15 16:28:27', 346, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1807, '2018-01-15 16:29:22', 8, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(1808, '2018-01-15 16:30:04', 81, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1809, '2018-01-15 16:30:42', 227, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1810, '2018-01-15 16:30:49', 181, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1811, '2018-01-15 16:31:27', 131, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1812, '2018-01-15 16:32:07', 238, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1813, '2018-01-15 16:37:28', 361, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1814, '2018-01-15 16:37:28', 362, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1815, '2018-01-15 16:37:28', 363, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1816, '2018-01-15 16:37:28', 366, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1817, '2018-01-15 16:37:28', 373, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1818, '2018-01-15 16:37:28', 375, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1819, '2018-01-15 16:37:28', 406, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1820, '2018-01-15 16:37:28', 416, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1821, '2018-01-15 16:37:28', 432, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1822, '2018-01-15 16:37:28', 436, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1823, '2018-01-15 16:37:28', 442, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1824, '2018-01-15 16:37:28', 473, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1825, '2018-01-15 16:37:28', 482, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1826, '2018-01-15 16:38:13', 154, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1827, '2018-01-15 16:40:41', 651, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1828, '2018-01-15 16:40:53', 807, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1829, '2018-01-15 16:41:13', 210, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1830, '2018-01-15 16:41:27', 672, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1831, '2018-01-15 16:41:27', 672, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1832, '2018-01-15 16:41:27', 677, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1833, '2018-01-15 16:47:39', 293, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1834, '2018-01-15 16:52:53', 72, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1835, '2018-01-15 16:56:11', 73, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1836, '2018-01-15 16:56:15', 304, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1837, '2018-01-15 16:59:50', 560, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1838, '2018-01-15 17:01:47', 274, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1839, '2018-01-15 17:03:10', 918, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1840, '2018-01-15 17:03:23', 682, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1841, '2018-01-15 17:03:35', 613, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1842, '2018-01-15 17:04:38', 327, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1843, '2018-01-15 17:04:48', 82, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1844, '2018-01-15 17:05:37', 241, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1845, '2018-01-15 17:05:38', 886, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1846, '2018-01-15 17:05:43', 711, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1847, '2018-01-15 17:06:10', 413, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1848, '2018-01-15 17:06:41', 776, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1849, '2018-01-15 17:06:58', 425, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1850, '2018-01-15 17:07:26', 360, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1851, '2018-01-15 17:10:17', 545, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1852, '2018-01-15 17:11:22', 292, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1853, '2018-01-15 17:11:26', 780, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1854, '2018-01-15 17:12:03', 628, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1855, '2018-01-15 17:12:59', 852, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1856, '2018-01-15 17:16:09', 612, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1857, '2018-01-15 17:17:07', 66, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1858, '2018-01-15 17:18:03', 666, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1859, '2018-01-15 17:18:12', 667, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1860, '2018-01-15 17:19:53', 300, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1861, '2018-01-15 17:24:48', 494, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1862, '2018-01-15 17:24:55', 151, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1863, '2018-01-15 17:25:30', 767, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1864, '2018-01-15 17:25:44', 246, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1865, '2018-01-15 17:27:04', 141, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1866, '2018-01-15 17:27:08', 695, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1867, '2018-01-15 17:27:17', 241, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1868, '2018-01-15 17:27:42', 411, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1869, '2018-01-15 17:28:56', 599, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1870, '2018-01-15 17:29:34', 201, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1871, '2018-01-15 17:30:46', 432, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1872, '2018-01-15 17:31:45', 545, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1873, '2018-01-15 17:34:32', 559, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1874, '2018-01-15 17:35:00', 797, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1875, '2018-01-15 17:35:39', 43, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1876, '2018-01-15 17:35:53', 524, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1877, '2018-01-15 17:36:07', 452, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1878, '2018-01-15 17:36:10', 958, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1879, '2018-01-15 17:36:20', 262, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1880, '2018-01-16 08:55:57', 502, 0, 'retarcorp', 'Core Users', 'Авторизован пользователь retarcorp. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(1881, '2018-01-16 08:56:13', 246, 0, 'retarcorp', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/config.ini.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1882, '2018-01-16 10:09:34', 835, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1883, '2018-01-16 10:10:25', 473, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1884, '2018-01-16 10:11:17', 833, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1885, '2018-01-16 10:11:39', 154, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1886, '2018-01-16 10:12:53', 0, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1887, '2018-01-16 10:13:30', 278, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1888, '2018-01-16 10:14:24', 498, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1889, '2018-01-16 10:15:05', 57, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1890, '2018-01-16 10:16:21', 677, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1891, '2018-01-16 10:17:29', 196, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1892, '2018-01-16 10:17:59', 29, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1893, '2018-01-16 10:18:08', 686, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1894, '2018-01-16 10:18:48', 360, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1895, '2018-01-16 10:19:06', 611, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1896, '2018-01-16 10:19:56', 998, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1897, '2018-01-16 10:20:14', 347, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1898, '2018-01-16 10:20:31', 129, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1899, '2018-01-16 10:20:57', 109, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1900, '2018-01-16 10:21:26', 798, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1901, '2018-01-16 10:22:14', 232, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1902, '2018-01-16 10:24:35', 387, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1903, '2018-01-16 10:24:54', 253, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1904, '2018-01-16 10:25:02', 3, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1905, '2018-01-16 10:25:43', 909, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1906, '2018-01-16 10:26:17', 12, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1907, '2018-01-16 10:27:08', 683, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1908, '2018-01-16 10:27:37', 954, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1909, '2018-01-16 10:28:31', 143, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1910, '2018-01-16 10:30:27', 147, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1911, '2018-01-16 10:31:33', 690, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1912, '2018-01-16 10:32:04', 398, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1913, '2018-01-16 10:32:27', 821, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1914, '2018-01-16 10:32:49', 879, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1915, '2018-01-16 10:32:56', 394, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1916, '2018-01-16 10:33:15', 74, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1917, '2018-01-16 10:34:35', 799, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1918, '2018-01-16 10:35:57', 330, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1919, '2018-01-16 10:36:27', 492, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1920, '2018-01-16 10:43:13', 559, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1921, '2018-01-16 10:48:54', 741, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1922, '2018-01-16 10:53:55', 856, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1923, '2018-01-16 10:56:14', 830, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1924, '2018-01-16 10:57:39', 464, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1925, '2018-01-16 10:57:57', 10, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1926, '2018-01-16 10:59:56', 808, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1927, '2018-01-16 11:01:38', 589, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1928, '2018-01-16 11:01:58', 660, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1929, '2018-01-16 11:02:39', 660, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1930, '2018-01-16 11:04:54', 806, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1931, '2018-01-16 11:05:43', 386, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1932, '2018-01-16 11:05:49', 227, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1933, '2018-01-16 11:06:00', 481, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1934, '2018-01-16 11:06:49', 889, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1935, '2018-01-16 11:07:21', 841, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1936, '2018-01-16 11:07:49', 100, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1937, '2018-01-16 11:07:58', 810, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1938, '2018-01-16 11:08:21', 478, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1939, '2018-01-16 11:08:36', 99, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1940, '2018-01-16 11:08:57', 461, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1941, '2018-01-16 11:09:16', 22, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1942, '2018-01-16 11:09:38', 996, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1943, '2018-01-16 11:14:35', 860, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1944, '2018-01-16 11:15:37', 134, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1945, '2018-01-16 11:17:03', 235, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1946, '2018-01-16 11:17:18', 306, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1947, '2018-01-16 11:17:32', 265, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1948, '2018-01-16 11:18:24', 95, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1949, '2018-01-16 11:19:45', 52, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1950, '2018-01-16 11:19:48', 658, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1951, '2018-01-16 11:20:19', 380, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1952, '2018-01-16 11:21:19', 899, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1953, '2018-01-16 11:22:02', 579, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1954, '2018-01-16 11:22:11', 185, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1955, '2018-01-16 11:22:39', 99, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1956, '2018-01-16 11:25:28', 457, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1957, '2018-01-16 11:25:28', 490, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1958, '2018-01-16 11:25:56', 608, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1959, '2018-01-16 11:25:56', 640, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1960, '2018-01-16 11:26:02', 823, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1961, '2018-01-16 11:26:14', 928, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1962, '2018-01-16 11:31:09', 95, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1963, '2018-01-16 11:33:04', 743, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1964, '2018-01-16 11:34:21', 172, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1965, '2018-01-16 11:34:38', 559, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1966, '2018-01-16 11:37:28', 534, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1967, '2018-01-16 11:38:49', 496, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1968, '2018-01-16 11:39:22', 997, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1969, '2018-01-16 11:41:33', 188, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1970, '2018-01-16 11:42:44', 511, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1971, '2018-01-16 11:43:11', 77, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1972, '2018-01-16 11:43:59', 146, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1973, '2018-01-16 11:44:28', 44, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1974, '2018-01-16 11:46:33', 55, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1975, '2018-01-16 11:46:36', 410, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1976, '2018-01-16 11:46:51', 468, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1977, '2018-01-16 11:52:19', 85, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1978, '2018-01-16 11:54:24', 495, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1979, '2018-01-16 11:55:39', 42, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1980, '2018-01-16 11:56:05', 595, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1981, '2018-01-16 11:56:38', 646, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1982, '2018-01-16 11:56:41', 151, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1983, '2018-01-16 11:58:10', 919, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1984, '2018-01-16 11:58:16', 530, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1985, '2018-01-16 11:58:29', 443, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1986, '2018-01-16 11:59:08', 172, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1987, '2018-01-16 11:59:20', 229, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1988, '2018-01-16 12:00:20', 969, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1989, '2018-01-16 12:00:42', 427, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1990, '2018-01-16 12:01:21', 797, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1991, '2018-01-16 12:01:38', 899, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1992, '2018-01-16 12:04:58', 358, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1993, '2018-01-16 12:06:30', 381, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1994, '2018-01-16 12:06:58', 50, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1995, '2018-01-16 12:07:07', 422, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1996, '2018-01-16 12:07:10', 323, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1997, '2018-01-16 12:07:15', 87, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1998, '2018-01-16 12:07:32', 482, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(1999, '2018-01-16 12:08:36', 211, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2000, '2018-01-16 12:09:05', 774, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2001, '2018-01-16 12:10:13', 547, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2002, '2018-01-16 12:11:06', 921, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2003, '2018-01-16 12:12:03', 226, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta_Demo.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2004, '2018-01-16 12:12:04', 919, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2005, '2018-01-16 12:15:04', 684, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2006, '2018-01-16 12:15:21', 392, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2007, '2018-01-16 12:16:07', 217, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2008, '2018-01-16 12:16:21', 125, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2009, '2018-01-16 12:16:32', 5, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2010, '2018-01-16 12:31:09', 328, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2011, '2018-01-16 12:32:15', 731, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2012, '2018-01-16 12:32:53', 200, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2013, '2018-01-16 12:33:47', 857, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2014, '2018-01-16 12:34:25', 238, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2015, '2018-01-16 12:35:00', 585, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2016, '2018-01-16 12:35:47', 538, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2017, '2018-01-16 12:37:24', 777, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2018, '2018-01-16 12:37:51', 82, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2019, '2018-01-16 12:38:01', 986, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2020, '2018-01-16 12:38:33', 531, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2021, '2018-01-16 12:38:40', 741, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2022, '2018-01-16 12:39:07', 244, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2023, '2018-01-16 12:39:08', 454, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2024, '2018-01-16 12:40:11', 102, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2025, '2018-01-16 12:41:56', 233, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2026, '2018-01-16 12:43:13', 494, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2027, '2018-01-16 12:43:52', 334, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2028, '2018-01-16 12:47:11', 839, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(2029, '2018-01-16 12:50:17', 930, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2030, '2018-01-16 12:51:49', 470, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2031, '2018-01-16 12:52:21', 393, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2032, '2018-01-16 12:52:40', 100, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2033, '2018-01-16 12:53:29', 34, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2034, '2018-01-16 12:54:13', 195, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2035, '2018-01-16 12:54:44', 168, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2036, '2018-01-16 18:46:00', 893, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [195.50.26.61]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2037, '2018-01-16 18:47:49', 147, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2038, '2018-01-16 18:49:47', 751, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2039, '2018-01-16 18:50:56', 40, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/newtest.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2040, '2018-01-16 18:54:33', 22, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2041, '2018-01-16 18:55:38', 294, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2042, '2018-01-16 18:56:34', 975, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2043, '2018-01-16 18:57:01', 276, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2044, '2018-01-16 18:57:57', 332, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2045, '2018-01-16 18:58:24', 932, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2046, '2018-01-16 18:58:49', 307, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2047, '2018-01-16 18:59:31', 10, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2048, '2018-01-16 18:59:50', 690, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2049, '2018-01-16 18:59:56', 578, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2050, '2018-01-16 19:00:03', 323, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2051, '2018-01-16 19:00:19', 716, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/api/Handler.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2052, '2018-01-16 19:00:59', 740, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2053, '2018-01-16 19:01:11', 53, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2054, '2018-01-16 19:01:32', 371, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2055, '2018-01-16 19:02:03', 309, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2056, '2018-01-16 19:02:15', 385, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2057, '2018-01-16 19:03:33', 290, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2058, '2018-01-16 19:04:11', 519, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2059, '2018-01-16 19:04:29', 521, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2060, '2018-01-16 19:05:58', 886, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2061, '2018-01-16 19:06:03', 129, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2062, '2018-01-16 19:06:20', 264, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2063, '2018-01-16 19:07:43', 934, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2064, '2018-01-16 19:10:03', 285, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2065, '2018-01-16 19:10:31', 848, 0, 'ArtimenyaEV', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/Classes/Instruments/DeltaCandlesBuilder.php.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2066, '2018-01-17 10:19:53', 37, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2067, '2018-01-17 10:30:47', 742, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2068, '2018-01-17 10:31:45', 177, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2069, '2018-01-17 10:34:27', 994, 0, 'KreidichAA', 'Core Users', 'Авторизован пользователь kreidichaa. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2070, '2018-01-17 10:34:28', 872, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2071, '2018-01-17 10:42:23', 161, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2072, '2018-01-17 10:42:40', 729, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2073, '2018-01-17 10:43:08', 624, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2074, '2018-01-17 10:44:13', 199, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2075, '2018-01-17 10:44:34', 338, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2076, '2018-01-17 10:45:33', 489, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2077, '2018-01-17 10:45:45', 184, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2078, '2018-01-17 10:45:59', 647, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2079, '2018-01-17 10:46:12', 947, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2080, '2018-01-17 10:46:45', 433, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2081, '2018-01-17 10:46:53', 636, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2082, '2018-01-17 10:47:17', 888, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2083, '2018-01-17 10:47:39', 780, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2084, '2018-01-17 10:48:07', 476, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2085, '2018-01-17 10:48:16', 196, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2086, '2018-01-17 10:48:55', 87, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2087, '2018-01-17 10:49:18', 216, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2088, '2018-01-17 10:50:23', 763, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2089, '2018-01-17 10:53:04', 979, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2090, '2018-01-17 10:53:53', 121, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2091, '2018-01-17 10:53:54', 316, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2092, '2018-01-17 10:55:04', 410, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2093, '2018-01-17 10:55:27', 47, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2094, '2018-01-17 10:55:47', 524, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2095, '2018-01-17 10:55:59', 367, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2096, '2018-01-17 10:56:36', 324, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2097, '2018-01-17 10:56:39', 508, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2098, '2018-01-17 10:57:45', 956, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2099, '2018-01-17 10:58:35', 876, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2100, '2018-01-17 11:00:54', 772, 0, 'KuplevichIA', 'File Manager', 'Удален файл /js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(2101, '2018-01-17 11:01:05', 534, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2102, '2018-01-17 11:09:40', 321, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2103, '2018-01-17 11:11:44', 630, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2104, '2018-01-17 11:14:09', 837, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2105, '2018-01-17 11:18:13', 223, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2106, '2018-01-17 11:19:30', 678, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2107, '2018-01-17 11:22:28', 299, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2108, '2018-01-17 11:23:07', 761, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2109, '2018-01-17 11:23:16', 245, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2110, '2018-01-17 11:23:44', 224, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2111, '2018-01-17 11:24:03', 51, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2112, '2018-01-17 11:25:43', 813, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2113, '2018-01-17 11:27:10', 183, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2114, '2018-01-17 11:48:03', 12, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2115, '2018-01-17 11:48:28', 693, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2116, '2018-01-17 11:50:15', 996, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2117, '2018-01-17 11:56:53', 927, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2118, '2018-01-17 11:56:58', 669, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2119, '2018-01-17 11:59:22', 894, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2120, '2018-01-17 11:59:38', 68, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2121, '2018-01-17 12:00:05', 306, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2122, '2018-01-17 12:00:18', 80, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2123, '2018-01-17 12:00:36', 216, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2124, '2018-01-17 12:00:42', 395, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2125, '2018-01-17 12:00:48', 618, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2126, '2018-01-17 12:02:12', 980, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2127, '2018-01-17 12:02:24', 739, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2128, '2018-01-17 12:09:04', 545, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2129, '2018-01-17 12:09:38', 429, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2130, '2018-01-17 12:13:08', 272, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2131, '2018-01-17 12:13:37', 323, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2132, '2018-01-17 12:14:09', 551, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2133, '2018-01-17 12:16:10', 841, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2134, '2018-01-17 12:16:18', 151, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2135, '2018-01-17 12:16:24', 749, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2136, '2018-01-17 12:17:41', 497, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2137, '2018-01-17 12:17:48', 612, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2138, '2018-01-17 12:18:16', 285, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2139, '2018-01-17 12:18:17', 645, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2140, '2018-01-17 12:18:17', 820, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2141, '2018-01-17 12:18:18', 178, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2142, '2018-01-17 12:18:18', 304, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2143, '2018-01-17 12:18:18', 608, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2144, '2018-01-17 12:18:18', 733, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2145, '2018-01-17 12:19:23', 567, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2146, '2018-01-17 12:19:24', 691, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2147, '2018-01-17 12:21:06', 496, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2148, '2018-01-17 12:21:21', 990, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2149, '2018-01-17 12:21:45', 914, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2150, '2018-01-17 12:22:05', 804, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2151, '2018-01-17 12:22:13', 956, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2152, '2018-01-17 12:25:31', 811, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2153, '2018-01-17 12:26:32', 741, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2154, '2018-01-17 12:32:16', 679, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2155, '2018-01-17 12:32:51', 829, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2156, '2018-01-17 12:34:31', 572, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2157, '2018-01-17 12:42:04', 809, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2158, '2018-01-17 12:42:12', 403, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2159, '2018-01-17 12:45:42', 32, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2160, '2018-01-17 12:46:54', 970, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2161, '2018-01-17 12:55:35', 535, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2162, '2018-01-17 12:58:07', 472, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2163, '2018-01-17 12:58:41', 86, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2164, '2018-01-17 12:59:15', 568, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2165, '2018-01-17 13:00:34', 245, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2166, '2018-01-17 13:00:52', 162, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2167, '2018-01-17 13:01:28', 426, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2168, '2018-01-17 13:01:39', 368, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2169, '2018-01-17 13:02:37', 563, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2170, '2018-01-17 13:03:05', 81, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2171, '2018-01-17 13:05:21', 632, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2172, '2018-01-17 13:05:30', 458, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2173, '2018-01-17 13:05:31', 711, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2174, '2018-01-17 13:06:07', 259, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2175, '2018-01-17 13:06:09', 890, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2176, '2018-01-17 13:06:32', 109, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2177, '2018-01-17 13:06:35', 603, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2178, '2018-01-17 13:07:00', 160, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2179, '2018-01-17 13:07:15', 893, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2180, '2018-01-17 13:07:29', 109, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2181, '2018-01-17 13:07:41', 919, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2182, '2018-01-17 13:08:08', 190, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2183, '2018-01-17 13:08:16', 417, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2184, '2018-01-17 13:08:29', 971, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2185, '2018-01-17 13:09:07', 739, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2186, '2018-01-17 13:09:14', 468, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2187, '2018-01-17 13:09:28', 515, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2188, '2018-01-17 13:10:23', 325, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2189, '2018-01-17 13:10:34', 490, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2190, '2018-01-17 13:11:14', 155, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2191, '2018-01-17 13:11:34', 217, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2192, '2018-01-17 13:12:01', 115, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2193, '2018-01-17 13:12:08', 336, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2194, '2018-01-17 13:12:48', 976, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2195, '2018-01-17 13:12:50', 411, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2196, '2018-01-17 13:12:59', 955, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2197, '2018-01-17 13:13:32', 179, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2198, '2018-01-17 13:15:30', 276, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2199, '2018-01-17 13:15:43', 493, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2200, '2018-01-17 13:15:57', 448, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2201, '2018-01-17 13:16:39', 984, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2202, '2018-01-17 13:16:55', 33, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2203, '2018-01-17 13:17:15', 684, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2204, '2018-01-17 13:17:59', 824, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2205, '2018-01-17 13:18:49', 70, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2206, '2018-01-17 13:19:31', 358, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2207, '2018-01-17 13:20:15', 663, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2208, '2018-01-17 13:21:36', 708, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2209, '2018-01-17 13:21:47', 427, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2210, '2018-01-17 13:21:59', 72, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2211, '2018-01-17 13:22:00', 934, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2212, '2018-01-17 13:24:18', 788, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2213, '2018-01-17 23:02:15', 632, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [195.50.26.61]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2214, '2018-01-17 23:02:21', 264, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [195.50.26.61]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2215, '2018-01-17 23:02:28', 779, 0, 'ArtimenyaEV', 'Core Users', 'Авторизован пользователь ArtimenyaEV. [195.50.26.61]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2216, '2018-01-18 11:04:37', 660, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [46.216.129.224]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2217, '2018-01-18 11:13:33', 177, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2218, '2018-01-18 11:13:41', 519, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2219, '2018-01-18 11:41:32', 506, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2220, '2018-01-18 11:41:34', 205, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2221, '2018-01-18 11:42:06', 983, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2222, '2018-01-18 11:42:11', 183, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2223, '2018-01-18 11:46:25', 904, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2224, '2018-01-18 11:46:38', 704, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2225, '2018-01-18 11:46:40', 879, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2226, '2018-01-18 11:46:48', 287, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2227, '2018-01-18 11:46:51', 958, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2228, '2018-01-18 11:48:05', 535, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2229, '2018-01-18 11:48:42', 837, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2230, '2018-01-18 11:49:04', 558, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2231, '2018-01-18 11:49:32', 331, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2232, '2018-01-18 11:49:41', 235, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2233, '2018-01-18 11:50:01', 310, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2234, '2018-01-18 11:50:09', 94, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2235, '2018-01-18 11:50:28', 519, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2236, '2018-01-18 11:50:57', 995, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2237, '2018-01-18 11:51:08', 706, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2238, '2018-01-18 11:51:36', 214, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2239, '2018-01-18 11:52:19', 101, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2240, '2018-01-18 11:53:03', 994, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2241, '2018-01-18 11:53:52', 560, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2242, '2018-01-18 11:54:38', 365, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2243, '2018-01-18 12:03:02', 627, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2244, '2018-01-18 12:03:49', 919, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2245, '2018-01-18 12:06:38', 210, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2246, '2018-01-18 12:07:57', 467, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2247, '2018-01-18 12:08:26', 302, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2248, '2018-01-18 12:08:44', 565, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2249, '2018-01-18 12:09:33', 578, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2250, '2018-01-18 12:10:08', 468, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2251, '2018-01-18 12:12:30', 28, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2252, '2018-01-18 12:12:30', 31, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2253, '2018-01-18 12:12:30', 37, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2254, '2018-01-18 12:15:05', 579, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(2255, '2018-01-18 12:15:13', 473, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2256, '2018-01-18 12:15:36', 413, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2257, '2018-01-18 12:15:53', 942, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2258, '2018-01-18 12:16:25', 121, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2259, '2018-01-18 12:19:46', 562, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2260, '2018-01-18 12:20:27', 935, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2261, '2018-01-18 12:21:37', 993, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2262, '2018-01-18 12:21:57', 942, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2263, '2018-01-18 12:22:17', 289, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2264, '2018-01-18 12:23:40', 767, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2265, '2018-01-18 12:24:01', 683, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2266, '2018-01-18 12:24:32', 823, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2267, '2018-01-18 12:25:16', 942, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2268, '2018-01-18 12:25:48', 833, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2269, '2018-01-18 12:26:16', 54, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2270, '2018-01-18 12:26:34', 825, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2271, '2018-01-18 12:27:00', 77, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2272, '2018-01-18 12:28:10', 398, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2273, '2018-01-18 12:28:28', 841, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2274, '2018-01-18 12:29:21', 161, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2275, '2018-01-18 12:29:30', 156, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2276, '2018-01-18 12:30:12', 733, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2277, '2018-01-18 12:30:44', 250, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2278, '2018-01-18 12:31:36', 685, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2279, '2018-01-18 12:31:49', 697, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2280, '2018-01-18 12:32:35', 598, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2281, '2018-01-18 12:33:09', 108, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2282, '2018-01-18 12:33:34', 803, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2283, '2018-01-18 12:33:48', 711, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2284, '2018-01-18 12:34:15', 290, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2285, '2018-01-18 12:34:28', 574, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2286, '2018-01-18 12:34:48', 985, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2287, '2018-01-18 12:35:11', 804, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2288, '2018-01-18 12:35:21', 506, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2289, '2018-01-18 12:35:55', 701, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2290, '2018-01-18 12:36:17', 583, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2291, '2018-01-18 12:42:35', 343, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2292, '2018-01-18 12:44:09', 356, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2293, '2018-01-18 12:44:32', 734, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2294, '2018-01-18 12:46:26', 175, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2295, '2018-01-18 12:46:34', 803, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2296, '2018-01-18 12:47:08', 351, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2297, '2018-01-18 13:47:40', 413, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2298, '2018-01-18 13:48:46', 372, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2299, '2018-01-18 13:48:57', 754, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2300, '2018-01-18 13:50:35', 462, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2301, '2018-01-18 13:50:44', 225, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2302, '2018-01-18 13:50:49', 928, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2303, '2018-01-18 13:51:22', 166, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2304, '2018-01-18 13:51:42', 843, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2305, '2018-01-18 13:52:14', 229, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2306, '2018-01-18 13:52:27', 272, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2307, '2018-01-18 13:53:02', 380, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2308, '2018-01-18 13:53:13', 454, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2309, '2018-01-18 13:54:05', 825, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2310, '2018-01-18 13:54:27', 293, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2311, '2018-01-18 13:54:44', 559, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2312, '2018-01-18 13:55:19', 864, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2313, '2018-01-18 13:55:26', 141, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2314, '2018-01-18 13:55:38', 696, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2315, '2018-01-18 13:56:27', 350, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2316, '2018-01-18 13:56:28', 696, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2317, '2018-01-18 13:56:39', 78, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2318, '2018-01-18 14:00:39', 259, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2319, '2018-01-18 14:00:54', 0, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2320, '2018-01-18 14:01:17', 40, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2321, '2018-01-18 14:01:21', 288, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2322, '2018-01-18 14:04:56', 475, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2323, '2018-01-18 14:05:12', 873, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2324, '2018-01-18 14:08:33', 152, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2325, '2018-01-18 14:09:20', 895, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2326, '2018-01-18 14:10:05', 935, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/css/style.css.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2327, '2018-01-18 14:10:21', 34, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2328, '2018-01-18 14:10:59', 892, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2329, '2018-01-18 14:12:01', 496, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2330, '2018-01-18 14:22:06', 403, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/index.html.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2331, '2018-01-18 15:03:00', 42, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2332, '2018-01-18 15:03:32', 496, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2333, '2018-01-18 15:04:23', 174, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2334, '2018-01-18 15:04:56', 350, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2335, '2018-01-18 15:05:10', 749, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2336, '2018-01-18 15:05:29', 69, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2337, '2018-01-18 15:05:55', 822, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2338, '2018-01-18 23:05:12', 580, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2339, '2018-01-18 23:05:43', 775, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2340, '2018-01-18 23:06:17', 855, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2341, '2018-01-18 23:06:21', 866, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2342, '2018-01-18 23:07:05', 99, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2343, '2018-01-18 23:07:59', 50, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2344, '2018-01-19 12:21:54', 501, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2345, '2018-01-19 12:23:18', 300, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2346, '2018-01-19 12:27:34', 817, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2347, '2018-01-19 12:29:23', 280, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2348, '2018-01-19 12:31:49', 752, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2349, '2018-01-19 12:49:41', 493, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2350, '2018-01-19 12:55:26', 691, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2351, '2018-01-19 12:56:08', 744, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2352, '2018-01-19 12:56:18', 790, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2353, '2018-01-19 12:57:47', 849, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2354, '2018-01-19 12:58:54', 83, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2355, '2018-01-19 13:01:39', 818, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2356, '2018-01-19 13:02:22', 537, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2357, '2018-01-19 13:04:12', 719, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2358, '2018-01-19 13:06:09', 341, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2359, '2018-01-19 13:07:50', 220, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2360, '2018-01-19 13:08:10', 389, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2361, '2018-01-19 13:08:25', 230, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2362, '2018-01-19 13:08:41', 22, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2363, '2018-01-19 13:09:13', 667, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2364, '2018-01-19 13:10:45', 64, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2365, '2018-01-19 13:22:54', 537, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2366, '2018-01-19 13:48:35', 623, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2367, '2018-01-19 13:48:53', 128, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2368, '2018-01-19 13:57:29', 126, 0, 'KreidichAA', 'Core Users', 'Авторизован пользователь kreidichaa. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2369, '2018-01-19 14:22:40', 94, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2370, '2018-01-19 14:56:14', 506, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2371, '2018-01-19 14:59:29', 895, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2372, '2018-01-19 15:00:00', 97, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2373, '2018-01-19 15:00:37', 553, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2374, '2018-01-19 15:02:02', 198, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2375, '2018-01-19 15:04:50', 369, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2376, '2018-01-19 15:13:13', 486, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2377, '2018-01-19 15:17:31', 666, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2378, '2018-01-19 15:19:13', 765, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2379, '2018-01-19 15:19:48', 98, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2380, '2018-01-19 15:20:11', 147, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2381, '2018-01-19 15:22:49', 281, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2382, '2018-01-19 15:23:12', 357, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2383, '2018-01-19 15:25:49', 808, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2384, '2018-01-19 15:26:02', 961, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2385, '2018-01-19 15:28:04', 728, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2386, '2018-01-19 15:28:28', 883, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2387, '2018-01-19 15:28:36', 129, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2388, '2018-01-19 15:29:05', 694, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2389, '2018-01-19 15:32:47', 120, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2390, '2018-01-19 15:32:55', 178, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2391, '2018-01-19 15:35:02', 285, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2392, '2018-01-19 15:35:08', 828, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2393, '2018-01-19 15:35:17', 934, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2394, '2018-01-19 15:35:24', 349, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2395, '2018-01-19 15:35:32', 47, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2396, '2018-01-19 15:35:37', 563, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2397, '2018-01-19 15:38:51', 85, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2398, '2018-01-19 15:38:51', 828, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2399, '2018-01-19 15:39:03', 321, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2400, '2018-01-19 15:39:13', 192, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2401, '2018-01-19 15:39:30', 117, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2402, '2018-01-19 15:41:52', 170, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2403, '2018-01-19 15:42:08', 929, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2404, '2018-01-19 15:42:50', 860, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2405, '2018-01-19 15:43:44', 379, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2406, '2018-01-19 15:46:09', 168, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2407, '2018-01-19 15:47:56', 196, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2408, '2018-01-19 15:47:56', 303, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2409, '2018-01-19 15:48:29', 1, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2410, '2018-01-19 15:50:41', 494, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2411, '2018-01-19 15:51:02', 184, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2412, '2018-01-19 15:51:06', 1, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2413, '2018-01-19 15:55:27', 751, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2414, '2018-01-19 15:56:44', 858, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2415, '2018-01-19 15:56:52', 298, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2416, '2018-01-19 16:10:19', 252, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2417, '2018-01-19 16:12:30', 595, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2418, '2018-01-19 16:13:38', 808, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2419, '2018-01-19 16:14:00', 119, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2420, '2018-01-19 16:17:58', 680, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2421, '2018-01-19 16:18:23', 70, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2422, '2018-01-19 16:19:01', 463, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2423, '2018-01-19 16:19:20', 751, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2424, '2018-01-19 16:19:44', 607, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2425, '2018-01-19 16:20:32', 675, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2426, '2018-01-19 16:21:38', 413, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2427, '2018-01-19 16:22:35', 39, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2428, '2018-01-19 16:45:08', 718, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2429, '2018-01-19 16:45:24', 220, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2430, '2018-01-19 16:49:41', 826, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2431, '2018-01-19 16:51:00', 872, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2432, '2018-01-19 16:51:12', 31, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2433, '2018-01-19 16:53:15', 216, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2434, '2018-01-19 16:53:48', 233, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2435, '2018-01-19 16:54:03', 49, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2436, '2018-01-19 16:55:48', 177, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2437, '2018-01-19 16:56:21', 580, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2438, '2018-01-19 16:59:34', 125, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2439, '2018-01-19 17:01:14', 645, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2440, '2018-01-19 17:01:43', 170, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2441, '2018-01-19 17:01:58', 764, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2442, '2018-01-19 17:02:42', 336, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2443, '2018-01-19 17:03:06', 73, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2444, '2018-01-19 17:03:24', 332, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2445, '2018-01-19 17:03:41', 370, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2446, '2018-01-19 17:03:58', 117, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2447, '2018-01-19 17:04:19', 539, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2448, '2018-01-19 17:04:32', 557, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2449, '2018-01-19 17:06:51', 484, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2450, '2018-01-19 17:11:53', 462, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2451, '2018-01-19 17:12:55', 436, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2452, '2018-01-19 17:14:17', 494, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2453, '2018-01-19 17:15:56', 728, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2454, '2018-01-19 17:17:49', 779, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2455, '2018-01-19 17:17:54', 526, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2456, '2018-01-19 17:18:10', 139, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2457, '2018-01-19 17:19:26', 916, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2458, '2018-01-19 17:19:42', 165, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2459, '2018-01-19 17:21:12', 101, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2460, '2018-01-19 17:21:58', 878, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2461, '2018-01-21 21:04:58', 961, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [93.125.107.6]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2462, '2018-01-21 21:06:52', 971, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2463, '2018-01-21 21:07:04', 203, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2464, '2018-01-21 21:08:58', 850, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2465, '2018-01-21 21:09:33', 262, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2466, '2018-01-21 21:10:16', 769, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2467, '2018-01-21 21:13:52', 714, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2468, '2018-01-21 21:15:21', 944, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2469, '2018-01-21 21:16:49', 230, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2470, '2018-01-21 21:43:09', 235, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2471, '2018-01-21 21:43:11', 315, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2472, '2018-01-21 21:48:18', 994, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2473, '2018-01-21 21:50:30', 295, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2474, '2018-01-21 21:51:10', 480, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2475, '2018-01-21 21:51:54', 447, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2476, '2018-01-21 21:52:09', 722, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2477, '2018-01-21 21:52:58', 71, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2478, '2018-01-21 21:54:56', 440, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2479, '2018-01-21 21:55:22', 874, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2480, '2018-01-21 21:56:22', 858, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2481, '2018-01-21 21:56:55', 810, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2482, '2018-01-21 21:57:04', 314, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2483, '2018-01-21 21:59:00', 176, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(2484, '2018-01-21 22:00:00', 519, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2485, '2018-01-21 22:01:01', 157, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2486, '2018-01-21 22:02:10', 871, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2487, '2018-01-21 22:03:29', 343, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2488, '2018-01-21 22:04:20', 739, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2489, '2018-01-21 22:04:43', 178, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2490, '2018-01-21 22:05:51', 435, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2491, '2018-01-21 22:07:05', 338, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2492, '2018-01-21 22:07:19', 183, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2493, '2018-01-21 22:08:06', 392, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2494, '2018-01-21 22:11:29', 432, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2495, '2018-01-22 10:21:59', 798, 0, 'KreidichAA', 'Core Users', 'Авторизован пользователь kreidichaa. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2496, '2018-01-22 10:29:58', 663, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2497, '2018-01-22 10:30:38', 935, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2498, '2018-01-22 10:32:09', 635, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2499, '2018-01-22 10:32:42', 912, 0, 'KreidichAA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2500, '2018-01-22 10:38:04', 140, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2501, '2018-01-22 10:38:32', 345, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2502, '2018-01-22 10:39:03', 397, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2503, '2018-01-22 10:40:20', 245, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2504, '2018-01-22 10:41:23', 405, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2505, '2018-01-22 10:41:29', 64, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2506, '2018-01-22 10:41:43', 135, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2507, '2018-01-22 10:42:59', 485, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2508, '2018-01-22 10:44:41', 446, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2509, '2018-01-22 10:46:07', 25, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2510, '2018-01-22 10:47:01', 452, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2511, '2018-01-22 10:47:06', 95, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2512, '2018-01-22 10:48:20', 556, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2513, '2018-01-22 10:54:10', 630, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2514, '2018-01-22 10:54:38', 775, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2515, '2018-01-22 10:57:01', 653, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2516, '2018-01-22 10:59:05', 17, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2517, '2018-01-22 11:02:46', 480, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2518, '2018-01-22 11:06:00', 450, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2519, '2018-01-22 11:13:24', 255, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2520, '2018-01-22 11:16:14', 963, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2521, '2018-01-22 11:16:40', 52, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2522, '2018-01-22 11:17:26', 629, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2523, '2018-01-22 11:19:31', 31, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2524, '2018-01-22 11:19:51', 526, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2525, '2018-01-22 11:22:13', 690, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2526, '2018-01-22 11:23:50', 238, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2527, '2018-01-22 11:25:22', 585, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2528, '2018-01-22 11:26:04', 340, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2529, '2018-01-22 11:27:26', 474, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2530, '2018-01-22 11:28:35', 762, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2531, '2018-01-22 11:29:12', 154, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2532, '2018-01-22 11:29:25', 210, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2533, '2018-01-22 11:31:21', 330, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2534, '2018-01-22 11:32:38', 394, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2535, '2018-01-22 11:33:46', 199, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2536, '2018-01-22 11:33:47', 33, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2537, '2018-01-22 11:35:05', 481, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2538, '2018-01-22 11:35:53', 46, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2539, '2018-01-22 11:36:22', 553, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2540, '2018-01-22 11:36:56', 867, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2541, '2018-01-22 11:37:09', 423, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2542, '2018-01-22 11:37:19', 114, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2543, '2018-01-22 11:38:09', 745, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2544, '2018-01-22 11:41:22', 591, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2545, '2018-01-22 11:42:25', 389, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2546, '2018-01-22 11:43:28', 752, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2547, '2018-01-22 11:43:48', 212, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2548, '2018-01-22 11:45:11', 419, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2549, '2018-01-22 11:45:49', 484, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2550, '2018-01-22 11:46:09', 712, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2551, '2018-01-22 11:47:08', 955, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2552, '2018-01-22 11:47:48', 930, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2553, '2018-01-22 11:47:59', 352, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2554, '2018-01-22 11:48:15', 363, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2555, '2018-01-22 11:48:27', 453, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2556, '2018-01-22 11:48:39', 582, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2557, '2018-01-22 11:48:50', 568, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2558, '2018-01-22 11:49:12', 865, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2559, '2018-01-22 11:49:36', 531, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2560, '2018-01-22 11:53:05', 526, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2561, '2018-01-22 12:18:50', 16, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2562, '2018-01-22 12:19:29', 457, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2563, '2018-01-22 12:19:48', 822, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2564, '2018-01-22 12:22:34', 934, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2565, '2018-01-22 12:24:06', 746, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2566, '2018-01-22 12:24:42', 633, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2567, '2018-01-22 12:25:02', 673, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2568, '2018-01-22 12:25:45', 254, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2569, '2018-01-22 12:26:02', 267, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2570, '2018-01-22 12:26:07', 44, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2571, '2018-01-22 12:26:43', 189, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2572, '2018-01-22 12:27:25', 390, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2573, '2018-01-22 12:27:56', 482, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2574, '2018-01-22 12:28:06', 208, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2575, '2018-01-22 12:28:45', 712, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2576, '2018-01-22 12:29:31', 583, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2577, '2018-01-22 12:30:03', 707, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2578, '2018-01-22 12:30:14', 342, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2579, '2018-01-22 12:30:25', 811, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2580, '2018-01-22 12:30:28', 616, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2581, '2018-01-22 12:32:02', 715, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2582, '2018-01-22 12:32:29', 707, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2583, '2018-01-22 12:32:41', 528, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2584, '2018-01-22 12:32:56', 202, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2585, '2018-01-22 12:32:57', 541, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2586, '2018-01-22 12:34:22', 332, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2587, '2018-01-22 12:34:42', 121, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2588, '2018-01-22 12:34:52', 571, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2589, '2018-01-22 12:35:03', 168, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2590, '2018-01-22 12:35:38', 1, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2591, '2018-01-22 12:36:14', 242, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2592, '2018-01-22 12:36:40', 195, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2593, '2018-01-22 12:37:31', 933, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2594, '2018-01-22 12:39:50', 635, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2595, '2018-01-22 12:42:05', 1, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2596, '2018-01-22 12:42:16', 924, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2597, '2018-01-22 12:43:21', 789, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2598, '2018-01-22 12:43:31', 139, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2599, '2018-01-22 12:43:51', 37, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2600, '2018-01-22 12:44:50', 19, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2601, '2018-01-22 12:46:25', 135, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2602, '2018-01-22 12:46:35', 827, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2603, '2018-01-22 12:51:13', 517, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2604, '2018-01-22 12:51:44', 43, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2605, '2018-01-22 12:52:22', 759, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2606, '2018-01-22 12:53:53', 848, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2607, '2018-01-22 12:54:58', 196, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2608, '2018-01-22 12:55:00', 101, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2609, '2018-01-22 12:55:41', 681, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2610, '2018-01-22 12:59:17', 995, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2611, '2018-01-22 12:59:38', 206, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2612, '2018-01-22 12:59:53', 818, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2613, '2018-01-22 13:00:57', 88, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2614, '2018-01-22 13:01:01', 115, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2615, '2018-01-22 13:01:26', 375, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2616, '2018-01-22 13:02:09', 994, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2617, '2018-01-22 13:05:23', 877, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2618, '2018-01-22 13:05:46', 91, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2619, '2018-01-22 13:05:46', 881, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2620, '2018-01-22 13:12:51', 690, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2621, '2018-01-22 13:13:22', 737, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2622, '2018-01-22 13:15:55', 720, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2623, '2018-01-22 13:16:43', 859, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2624, '2018-01-22 13:17:01', 76, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2625, '2018-01-22 13:17:30', 88, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2626, '2018-01-22 13:18:06', 945, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2627, '2018-01-22 13:18:45', 167, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2628, '2018-01-22 13:20:35', 730, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2629, '2018-01-22 13:24:26', 898, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2630, '2018-01-22 13:25:46', 528, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2631, '2018-01-22 13:26:00', 796, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2632, '2018-01-22 13:27:36', 60, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2633, '2018-01-22 13:28:10', 473, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2634, '2018-01-22 13:28:14', 903, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2635, '2018-01-22 13:29:04', 8, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2636, '2018-01-22 13:30:58', 37, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2637, '2018-01-22 13:31:46', 264, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2638, '2018-01-22 13:36:57', 762, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2639, '2018-01-22 13:37:31', 437, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2640, '2018-01-22 13:38:55', 664, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2641, '2018-01-22 13:39:39', 157, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2642, '2018-01-22 13:40:45', 520, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2643, '2018-01-22 13:41:30', 148, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2644, '2018-01-22 13:42:22', 65, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2645, '2018-01-22 13:44:01', 865, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2646, '2018-01-22 13:44:24', 899, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2647, '2018-01-22 13:45:08', 101, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2648, '2018-01-22 13:45:17', 8, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2649, '2018-01-22 13:45:41', 134, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2650, '2018-01-22 13:46:47', 681, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2651, '2018-01-22 13:47:12', 442, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2652, '2018-01-22 13:47:53', 66, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2653, '2018-01-22 13:48:37', 652, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2654, '2018-01-22 13:52:46', 949, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2655, '2018-01-22 13:53:40', 988, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2656, '2018-01-22 13:54:30', 42, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2657, '2018-01-22 14:02:03', 33, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2658, '2018-01-22 14:02:04', 831, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2659, '2018-01-22 14:02:05', 651, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2660, '2018-01-22 14:02:06', 375, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2661, '2018-01-22 14:02:06', 734, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2662, '2018-01-22 14:02:07', 202, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2663, '2018-01-22 14:02:10', 255, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2664, '2018-01-22 14:02:10', 653, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2665, '2018-01-22 14:02:10', 849, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2666, '2018-01-22 14:02:11', 55, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2667, '2018-01-22 14:02:11', 238, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2668, '2018-01-22 14:02:16', 448, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2669, '2018-01-22 14:02:16', 802, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2670, '2018-01-22 14:02:17', 156, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2671, '2018-01-22 14:02:17', 507, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2672, '2018-01-22 14:02:17', 869, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2673, '2018-01-22 14:02:18', 240, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2674, '2018-01-22 14:02:18', 420, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2675, '2018-01-22 14:02:28', 1, 0, '', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2676, '2018-01-22 14:02:49', 931, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2677, '2018-01-22 14:03:16', 214, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2678, '2018-01-22 14:03:39', 332, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2679, '2018-01-22 14:04:04', 622, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2680, '2018-01-22 14:04:15', 315, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2681, '2018-01-22 14:04:48', 528, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2682, '2018-01-22 14:07:22', 898, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2683, '2018-01-22 14:07:57', 513, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2684, '2018-01-22 14:08:49', 220, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2685, '2018-01-22 14:09:07', 112, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2686, '2018-01-22 14:11:40', 757, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2687, '2018-01-22 14:12:50', 590, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2688, '2018-01-22 14:12:57', 0, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2689, '2018-01-22 14:13:38', 532, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2690, '2018-01-22 14:19:36', 249, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2691, '2018-01-22 14:20:04', 595, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2692, '2018-01-22 14:21:20', 964, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2693, '2018-01-22 14:23:29', 848, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2694, '2018-01-22 14:23:45', 983, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2695, '2018-01-22 14:24:33', 25, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2696, '2018-01-22 14:25:41', 332, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2697, '2018-01-22 14:26:47', 949, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2698, '2018-01-22 14:28:02', 374, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2699, '2018-01-22 14:29:20', 908, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2700, '2018-01-22 14:29:36', 815, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2701, '2018-01-22 14:29:57', 94, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2702, '2018-01-22 14:30:23', 486, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2703, '2018-01-22 14:30:41', 802, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2704, '2018-01-22 14:31:17', 432, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2705, '2018-01-22 14:34:22', 330, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2706, '2018-01-22 14:34:39', 423, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2707, '2018-01-22 14:36:03', 932, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/App.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2708, '2018-01-22 14:37:13', 705, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2709, '2018-01-22 14:38:07', 826, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2710, '2018-01-22 14:38:38', 43, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2711, '2018-01-22 14:39:03', 778, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2712, '2018-01-22 14:39:08', 446, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2713, '2018-01-22 14:39:36', 479, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2714, '2018-01-22 14:43:26', 404, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2715, '2018-01-22 14:44:21', 951, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2716, '2018-01-22 14:44:56', 917, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2717, '2018-01-22 14:45:15', 849, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');
INSERT INTO `cata_logger_journal` (`id`, `date`, `milliseconds`, `status`, `user`, `app`, `content`) VALUES
(2718, '2018-01-22 14:46:22', 171, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2719, '2018-01-22 14:53:14', 474, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2720, '2018-01-22 14:53:55', 921, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2721, '2018-01-22 14:55:01', 629, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2722, '2018-01-22 14:55:26', 412, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2723, '2018-01-22 14:55:26', 885, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2724, '2018-01-22 14:55:51', 870, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2725, '2018-01-22 14:56:09', 399, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2726, '2018-01-22 14:57:04', 142, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2727, '2018-01-22 14:57:39', 403, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2728, '2018-01-22 14:59:07', 364, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2729, '2018-01-22 14:59:25', 32, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2730, '2018-01-22 15:00:16', 362, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2731, '2018-01-22 15:05:22', 669, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2732, '2018-01-22 15:06:30', 283, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2733, '2018-01-22 15:06:40', 596, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2734, '2018-01-22 15:06:43', 524, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2735, '2018-01-22 15:15:18', 926, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2736, '2018-01-22 15:15:45', 816, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2737, '2018-01-22 15:16:30', 373, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2738, '2018-01-22 15:16:39', 750, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2739, '2018-01-22 15:17:33', 448, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2740, '2018-01-22 15:17:46', 827, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2741, '2018-01-22 15:18:01', 95, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2742, '2018-01-22 15:18:28', 397, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2743, '2018-01-22 15:22:11', 507, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2744, '2018-01-22 15:22:16', 354, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2745, '2018-01-22 15:22:55', 720, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2746, '2018-01-22 15:23:20', 66, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2747, '2018-01-22 15:24:47', 297, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2748, '2018-01-22 15:25:03', 739, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2749, '2018-01-22 15:25:14', 840, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2750, '2018-01-22 15:25:45', 274, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2751, '2018-01-22 15:26:24', 635, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2752, '2018-01-22 15:26:39', 690, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2753, '2018-01-22 15:27:19', 465, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2754, '2018-01-22 15:27:41', 775, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2755, '2018-01-22 15:30:45', 501, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2756, '2018-01-22 15:31:08', 860, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2757, '2018-01-22 15:31:59', 149, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2758, '2018-01-22 15:33:45', 47, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2759, '2018-01-22 15:34:18', 898, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2760, '2018-01-22 15:35:14', 811, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Graph.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2761, '2018-01-22 15:35:24', 162, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2762, '2018-01-22 15:35:32', 776, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2763, '2018-01-22 15:36:53', 943, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2764, '2018-01-22 15:37:10', 991, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2765, '2018-01-22 15:37:45', 595, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2766, '2018-01-22 15:39:21', 190, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2767, '2018-01-22 15:39:41', 236, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2768, '2018-01-22 15:39:58', 980, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2769, '2018-01-22 15:42:26', 914, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Sprites.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2770, '2018-01-22 16:51:47', 692, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2771, '2018-01-22 16:52:00', 846, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Delta.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2772, '2018-01-23 17:10:50', 767, 0, 'KuplevichIA', 'Core Users', 'Авторизован пользователь KuplevichIA. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2773, '2018-01-23 17:10:51', 435, 0, 'KreidichAA', 'Core Users', 'Авторизован пользователь kreidichaa. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2774, '2018-01-23 17:12:32', 563, 0, 'KuplevichIA', 'File Manager', 'Удален файл /js(0).zip.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/delete.php'),
(2775, '2018-01-23 17:13:58', 598, 0, 'retarcorp', 'Core Users', 'Авторизован пользователь retarcorp. [213.184.249.183]\nE:/OpenServer/domains/localhost/Core/login.php'),
(2776, '2018-01-23 17:28:02', 600, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2777, '2018-01-23 17:34:41', 394, 0, 'retarcorp', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Ui.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2778, '2018-01-23 17:50:51', 950, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2779, '2018-01-23 17:58:07', 178, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2780, '2018-01-23 17:58:42', 623, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php'),
(2781, '2018-01-23 17:59:00', 290, 0, 'KuplevichIA', 'Файловый менеджер', 'Перезаписан файл E:/OpenServer/domains/localhost/js/Data.js.\nE:/OpenServer/domains/localhost/Core/apps/FileManager/modules/files/content.php');

-- --------------------------------------------------------

--
-- Структура таблицы `cata_manual`
--

CREATE TABLE `cata_manual` (
  `id` int(11) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `title` varchar(1000) DEFAULT NULL,
  `content` mediumtext,
  `shorthand` text,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `cata_portals_items`
--

CREATE TABLE `cata_portals_items` (
  `id` int(11) NOT NULL,
  `c_order_id` int(11) NOT NULL,
  `portal` varchar(1000) DEFAULT NULL,
  `method` varchar(1000) DEFAULT NULL,
  `args` text,
  `app` varchar(1000) DEFAULT NULL,
  `data` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_portals_items`
--

INSERT INTO `cata_portals_items` (`id`, `c_order_id`, `portal`, `method`, `args`, `app`, `data`) VALUES
(1, 1, 'include', 'Core\\Classes\\Portals\\CustomPortal$content', '', 'Custom ', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `cata_settings_vars`
--

CREATE TABLE `cata_settings_vars` (
  `id` int(11) NOT NULL,
  `key` varchar(250) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `value` mediumtext,
  `type` int(11) DEFAULT NULL,
  `variants` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_settings_vars`
--

INSERT INTO `cata_settings_vars` (`id`, `key`, `title`, `value`, `type`, `variants`) VALUES
(1, 'theme', 'Р В РЎС›Р В Р’ВµР В РЎ?Р В Р’В°', 'Modern', 3, 'Modern[|]Minimalistic[|]Р В РЎСџР В РЎвЂўР В Р’В»Р РЋР Р‰Р В Р’В·Р В РЎвЂўР В Р вЂ Р В Р’В°Р РЋРІР‚С™Р В Р’ВµР В Р’В»Р РЋР Р‰Р РЋР С“Р В РЎвЂќР В Р’В°Р РЋР РЏ Р В Р вЂ¦Р В Р’В°Р РЋР С“Р РЋРІР‚С™Р РЋР вЂљР В РЎвЂўР В РІвЂћвЂ“Р В РЎвЂќР В Р’В°'),
(2, 'logout_timeout', 'Р В РЎС™Р В Р’В°Р В РЎвЂќР РЋР С“Р В РЎвЂ?Р В РЎ?Р В Р’В°Р В Р’В»Р РЋР Р‰Р В Р вЂ¦Р В РЎвЂўР В Р’Вµ Р В Р вЂ Р РЋР вЂљР В Р’ВµР В РЎ?Р РЋР РЏ Р РЋР С“Р В Р’ВµР В Р’В°Р В Р вЂ¦Р РЋР С“Р В Р’В°, Р В РЎ?Р В РЎвЂ?Р В Р вЂ¦', '1200', 2, '');

-- --------------------------------------------------------

--
-- Структура таблицы `cata_users`
--

CREATE TABLE `cata_users` (
  `id` int(11) NOT NULL,
  `login` varchar(300) DEFAULT NULL,
  `password` varchar(300) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `info` mediumtext,
  `ssid` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cata_users`
--

INSERT INTO `cata_users` (`id`, `login`, `password`, `role`, `info`, `ssid`) VALUES
(1, 'retarcorp', '82eb3b2081cd679f7c3869d4a76a0fea', 3, '', '44c8b99d2095f6937aa981f6a98c5717'),
(5, 'KreidichAA', '928be4475edcc2a9677a7f3ff4dbc400', 3, '', 'b3889d13495e53f1653d4726fa8a8519'),
(6, 'KuplevichIA', 'd922b71dcb5871cda8a513f1e02ade22', 3, '', '4530ab179b6edb371afb36d3c8eaad72'),
(7, 'ArtimenyaEV', 'c4ca4238a0b923820dcc509a6f75849b', 3, '', 'a09a52eee1de9c6475c76c9a656fae83');

-- --------------------------------------------------------

--
-- Структура таблицы `core_docs`
--

CREATE TABLE `core_docs` (
  `id` int(11) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `title` varchar(1000) DEFAULT NULL,
  `content` mediumtext,
  `shorthand` text,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `core_docs`
--

INSERT INTO `core_docs` (`id`, `parent`, `type`, `title`, `content`, `shorthand`, `data`) VALUES
(2, 1, 0, 'Справочный документ', '', '', ''),
(4, 1, 1, '1', '', '', ''),
(5, 1, 1, '2', '', '', ''),
(6, 1, 1, '3', '', '', ''),
(7, 0, 1, 'Документация по серверной части', NULL, NULL, NULL),
(8, 7, 1, 'Классы системы', NULL, NULL, NULL),
(9, 8, 1, 'Instruments', NULL, NULL, NULL),
(10, 8, 1, 'Utils', NULL, NULL, NULL),
(11, 8, 0, 'App', '<p>Класс, хранящий константы.</p>\n\n<h2>Константы:</h2>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TF_M1 =&nbsp;&quot;M1&quot;</div>\n\n<p>Константа обозначающая 1 минуту.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TF_M2&nbsp;=&nbsp;&quot;M2&quot;</div>\n\n<p>Константа обозначающая 2&nbsp;минуты.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TF_M5&nbsp;=&nbsp;&quot;M5&quot;</div>\n\n<p>Константа обозначающая 5&nbsp;минут.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TF_M10 =&nbsp;&quot;M10&quot;</div>\n\n<p>Константа обозначающая 10 минут.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TF_M15 =&nbsp;&quot;M15&quot;</div>\n\n<p>Константа обозначающая 15 минут.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TF_M30&nbsp;=&nbsp;&quot;M30&quot;</div>\n\n<p>Константа обозначающая 30&nbsp;минут.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TF_H1 =&nbsp;&quot;H1&quot;</div>\n\n<p>Константа обозначающая 1 час.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TF_H4 =&nbsp;&quot;H4&quot;</div>\n\n<p>Константа обозначающая 4 часа.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TF_D1 =&nbsp;&quot;D1&quot;</div>\n\n<p>Константа обозначающая 1 день.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::INSTRUMENT_OIL = &quot;OIL&quot;</div>\n\n<p>&nbsp;</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::PRICE_STEP = 0.05</div>\n\n<p>Ценовой шаг.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TICK_BUY = 1</div>\n\n<p>Тип покупки.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">App::TICK_SELL = 2</div>\n\n<p>Тип продажи.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">static $Timeframe= [</div>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;M1&quot;=&gt;1<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,&quot;M2&quot;=&gt;2<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,&quot;M5&quot;=&gt;5<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,&quot;M10&quot;=&gt;10<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,&quot;M15&quot;=&gt;15<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,&quot;M20&quot;=&gt;20<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,&quot;M30&quot;=&gt;30<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,&quot;H1&quot;=&gt;60<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,&quot;H4&quot;=&gt;240<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ,&quot;D1&quot;=&gt;1440</div>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">]</div>\n\n<p>Массив соответсвий между timeframe и количеством минут.</p>\n', NULL, NULL),
(12, 8, 0, 'Candle', '<p>Класс свечи FOOTPRINT</p>\n\n<h2>Методы:</h2>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><strong>Конструктор </strong>принимает $timeframe и начальную метку времени Timestamp $startTS, устанавливает эти поля, а также нулевые значения для всех остальных.</div>\n\n<p>&nbsp;</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code><font face=\"sans-serif, Arial, Verdana, Trebuchet MS\">Array&lt;String =&gt; String&gt;&nbsp;</font><strong>toArray</strong></code>()</div>\n\n<p>Преобразует объект в ассоциативный массив.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Array&lt;String =&gt; String&gt;&nbsp;<strong>toJSON</strong></code>()</div>\n\n<p>Преобразует объект в ассоциативный массив, а затем в JSON.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setFinished</strong></code>(bool $flag)</div>\n\n<p>Устанавливает поле $finished.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setStartPrice</strong></code>(float $price)</div>\n\n<p>Устанавливает поле $start_price.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setLastPrice</strong></code>(float $price)</div>\n\n<p>Устанавливает поле $last_price.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setTickMaxPrice</strong></code>(float $price)</div>\n\n<p>Устанавливает поле $tick_max_price.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setVolume</strong></code>(int $vol)</div>\n\n<p>Устанавливает поле $volume.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setTicks</strong></code>(Array&lt;Array&lt;int&gt;&gt;)</div>\n\n<p>Устанавливает поле $ticks.</p>\n', NULL, NULL),
(13, 10, 0, 'TimeCalculator', NULL, NULL, NULL),
(14, 10, 0, 'Timestamp', '<h2>Методы:</h2>\n\n<p>Конструктор создает объект метки времени.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">String     <code><strong>toString</strong></code>(void)</div>\n\n<p>Возвращает метку времени как строку.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">Int     <code><strong>getTimestamp</strong></code>(void)</div>\n\n<p>Возвращает метку времени.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">void    <code><strong>addSeconds</strong></code>(Int $seconds)</div>\n\n<p>Добавляет количество секунд $seconds к метке времени.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">void    <code><strong>subtractSeconds</strong></code>(Int $seconds)</div>\n\n<p>Вычитает количество секунд $seconds из метки времени.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">void    <code><strong>addMinutes</strong></code>(Int $minutes)</div>\n\n<p>Добавляет количество минут $minutes к метке времени.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">void    <code><strong>subtractMinutes</strong></code>(Int $minutes)</div>\n\n<p>Вычитает количество минут $minutes от метки времени.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">Timestamp <code><strong>getLaterForSeconds</strong></code>(Int $seconds)</div>\n\n<p>Возвращает новую метку времени, которая больше текущей на $seconds секунд.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">Timestamp <code><strong>getEarlierForSeconds</strong></code>(Int $seconds)</div>\n\n<p>Возвращает новую метку времени, которая меньше текущей на $seconds секунд.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">Timestamp <code><strong>getLaterForMinutes</strong></code>(Int $minutes)</div>\n\n<p>Возвращает новую метку времени, которая больше текущей на $minutes минут.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">Timestamp <code><strong>getEarlierForMinutes</strong></code>(Int $minutes)</div>\n\n<p>Возвращает новую метку времени, которая меньше текущей на $minutes минут.</p>', NULL, NULL),
(15, 9, 0, 'Instrument', '<p>Абстрактный класс объекта инструмент.</p>\n\n<h2>Методы:</h2>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">String <code><strong>getTableName</strong></code>(int $const)</div>\n\n<p>Возвращает название таблицы в БД, в зависимости от константы $const, которая указывает на разницу между начальной и конечной метками времени.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Array&lt;Candle&gt;&nbsp;<strong>getCandles</strong></code>(string $timeframe, Timestamp $startTS, Timestamp $endTS)</div>\n\n<p>Возвращает все свечи графика FOOTPRINT от $startTS до $endTS.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Int&nbsp;<strong>getValueForTimeframe</strong></code>(string&nbsp;$timeframe)</div>\n\n<p>Возвращает численное значение $timeframe в секундах.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Timestamp&nbsp;<strong>getStartTSForTimeframe</strong></code>(Timestamp $startTS, string&nbsp;$timeframe)</div>\n\n<p>Возвращает новую валидную метку времени по $startTS и $timeframe.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Timestamp&nbsp;<strong>getEndTSForTimeframe</strong></code>(Timestamp $endTS, string&nbsp;$timeframe)</div>\n\n<p>Возвращает новую валидную метку времени по $endTS и $timeframe.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Bool&nbsp;<strong>isFinished</strong></code>(Timestamp $startTS, string&nbsp;$timeframe)</div>\n\n<p>Проверяет окончилась ли данная свеча по текущему времени.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>fillCandle</strong></code>(Timestamp $startTS, string&nbsp;$timeframe, Candle $candle, string $tableName)</div>\n\n<p>Заполняет все поля свечи&nbsp;$candle.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>void&nbsp;<strong>fillPricesAndVolumeOfCandle</strong></code>(Timestamp $startTS, string&nbsp;$timeframe, Candle $candle, string $tableName)</div>\n\n<p>Заполняет поля цены и объема свечи&nbsp;$candle.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Candle&nbsp;<strong>getLastCandle</strong></code>(string&nbsp;$timeframe)</div>\n\n<p>Возвращает последную неоконченную свечу FOOTPRINT.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>putRandomData</strong></code>(string&nbsp;$timeframe = null)</div>\n\n<p>Заполняет таблицу инструмента, на котором был вызван метод, случайными данными.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Array&lt;DeltaCandle&gt;&nbsp;<strong>getDeltaCandles</strong></code>(int $delta, Timestamp $startTS, Timestamp $endTS)</div>\n\n<p>Возвращает массив дельта - свечей по $delta и меткам времени $startTS и $endTS.</p>\n\n<h2>Константы:</h2>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">DAY = 1</div>\n\n<p>Константы указывающая на разницу между начальной и конечной метками времени. Создана для получения названия необходимой таблицы в БД. (Один день)</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">WEEK = 7</div>\n\n<p>Константы указывающая на разницу между начальной и конечной метками времени. Создана для получения названия необходимой таблицы в БД. (Неделя)</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">ALL = 8</div>\n\n<p>Константы указывающая на разницу между начальной и конечной метками времени. Создана для получения названия необходимой таблицы в БД. (Все)</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">static $TYPE_ROUND_CORRESPONDENCE = [</div>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">&nbsp; &nbsp; &nbsp; &nbsp; &#39;6A&#39; =&gt; 4,<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &#39;6B&#39; =&gt; 4,<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &#39;6C&#39; =&gt; 5,<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &#39;6E&#39; =&gt; 5,<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &#39;6J&#39; =&gt; 7,<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &#39;6N&#39; =&gt; 4,<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &#39;6S&#39; =&gt; 4,<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &#39;CL&#39; =&gt; 2,<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &#39;GC&#39; =&gt; 1</div>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">]</div>\n\n<p>Массив, указывающий соответствие между типом инструмента и максимальный числом знаков после запятой.</p>\n', NULL, NULL),
(18, 0, 1, 'Документация по клиентской части', NULL, NULL, NULL),
(19, 18, 0, 'Graph', '<p>Graph:<br />\n  - init(canvas, callback): задает работу с отрисовкой графика, установка обработчиков событий<br />\n  - isLastCandlesVisible(): return true/false : возвращает true, если последняя свеча сейчас в зоне видимости, false - если нет<br />\n  - recursiveRender(): если видно последнюю свечу, то запускается еще раз<br />\n  - getDimensions(): определяет и назначает локальным переменным значения размера холста, DOM объектов и тд<br />\n  - onResize(): запускает getDimensions() и render(). используется в обработчике событий на изменение размера экрана<br />\n  - render(function): вызывает в себе функции setTimePerPx, setPriceStep, setTimeStep, getStartTsOnNull, setOxMs, resetCanvas, buildData;<br />\n  - resetCanvas(): очищает холст<br />\n  - fillRect(ctx, gs): очищает пространство под осью OX и правее от оси OY<br />\n  - buildData(function): запускает функцию buildSprites(function); отвечает за построенние данных на графике<br />\n  - buildSprites(function): запускает функцию getSprites, после чего отрисовывает все графические элементы, сетку и координатные оси; в конце запускает переданную в аргументы функцию, которая является recursiveRender;<br />\n  - drawAxes(ctx, gs): отрисовка координатных осей<br />\n  - drawGrid(ctx, gs): вызывает функции drawXGrid и drawYGrid; задает цвет и ширину линий для отрисовки сетки<br />\n  - drawXGrid(ctx, gs): отрисовывает вертикальную сетку<br />\n  - drawYGrid(ctx, gs): отрисовывает горизонтальную сетку<br />\n  - drawGridMarks(ctx, gs): вызывает функции drawXGridMarks и drawYGridMarks;<br />\n  - drawXGridMarks(ctx, gs): отрисовывает метки на оси OX;<br />\n  - drawYGridMarks(ctx, gs): отрисовывает метки на оси OY;<br />\n  - dragByButtons(e, gs): используется в обработчике событий на нажатие клавиш клавиатуры(в частности стрелки); определяет на какую клавишу нажали и в конкретном случает вызывает функцию onDragged(value, \'_направление перемещения_\'); val = (pxToTime(speed) || pxToPrice(speed));<br />\n  - onDown(e, gs): используется в обрабтчике события на нажатие левой кнопки мыши; <br />\n  - onMove(e, gs): используется в обработчике событий при движении мыши<br />\n  - onUp(e, gs): используется в обработчике событий при отпускании ЛКМ<br />\n  - onZoom(e, gs): функция для определения какой тип зума используется, вызывает функцию zoomOnWheel<br />\n  - zoomOnWheel(e, gs, flag): получает данные с функции onZoom и в дальнейшем вызывает нужные функции для зума<br />\n  - zoomIn(e, gs): функция для увеличения зума; передает измененные значения в функцию transform(q)<br />\n  - zoomOut(e, gs): функция для уменьшения зума; передает измененные значения в функцию transform(q)<br />\n  - transform(q): функция, которая принимает в себя измененные значения, и от их типа изменяет значение в GraphSetting<br />\n  - transferImgData(): переносит ImageData невидимого холста, на видимый<br />\n  - onDragged(x, y): функция для обработки движения графика.<br />\n  - setStartTs(ts): переопределяет значение StartTs в GraphSettings<br />\n  - setScale(scale): переопределяет значение Scale в GraphSettings<br />\n  - setStartPrice(price): переопределяет значение StartPrice в GraphSettings<br />\n  - getSprites(f): абстрактный метод, получает все спрайты на графике в вызывает на них функцию<br />\n___________________________________________________________________________________<br />\nFootPrintGraph: <br />\n  - setTimeframe(timeframe): устанавливает timeframe у графика<br />\n  - setInstrument(instrument): устанавливает инструмент(тип валюты) у графика<br />\n  - getSprites(f): получает все спрайты на заданном промежутке и вызывает на них функцию<br />\n___________________________________________________________________________________<br />\nCandleSprite:<br />\n  - isVisible(gs): return (true || false): возвращает true, если свеча в поле зрения, false - если нет<br />\n  - render(ctx, gs): отрисовывает свечу на график<br />\n  - renderIfVisible(ctx, gs): отрисовывает свечу на график, если она в поле зрения<br />\n___________________________________________________________________________________<br />\nGraphSettings(zoom, speed_of_moving_graph, price_per_px, price_points, min_px_per_detailed_candle, visualSettings):<br />\n  - getBorderTs(): return _координата крайней правой точки графика на оси Ох_<br />\n  - getBorderPrice(): return _координата крайней правой точки графика на оси Оу_<br />\n  - getXCoordForTs(ts): return _координата полученой метки времени на ось Ox_<br />\n  - getYCoordForPrice(price): return _координата полученной метки времени на ось Oy_ <br />\n  - realY(y) return _координата по Y в канвасе_<br />\n  - calculateIndentOnX(): return _отступ_: функция подсчитывает какой отступ нужно сделать от начала графика до следующей метки по оси Ox(используется в функции отрисовки сетки и меток)<br />\n  - calculateIndentOnY(): return _отступ_: функция подсчитывает какой отступ нужно сделать от начала графика до следующей метки по оси Oy(используется в функции отрисовки сетки и меток)<br />\n  - pxToTime(x): return x*timePerPx: переводит координату в миллисекунды<br />\n  - pxToPrice(y): return y*pricePerPX: переводит координату в цену<br />\n  - tsToData(ts): return str: переводит метку времени в строку вида YYYY-MM-DD<br />\n  - tsToTime(ts): return str: переводит метку времени в строку вида HH:MM:SS<br />\n  - getStartTsOnNull(): перемещает значение начальной метки времени в крайний правый угол графика<br />\n  - setTimePerPx(): переопределяет количество миллисекунд в пикселе<br />\n  - setTimeStep(): переопределяет шаг отрисовки меток и сетки на оси Ox<br />\n  - setPriceStep(): переопределяет шаг отрисовки меток и сетки на оси Oy<br />\n  - setOxMs(): переопределяет значение длинны оси Ox в миллисекундах<br />\n  - setStartPrice(): переопределяет значение StartPrice<br />\n  - setTimeFrame(): переопределяет timeframe графика<br />\n  - setInstrument(): переопределяет инструмент(тип валюты) графика<br />\n___________________________________________________________________________________<br />\nVisualSettings:<br />\n  - setVisualSettings(plus, minus, sprites, background, grid, text): устанавливает значения в визуальных настройках</p>', NULL, NULL),
(20, 18, 0, 'Data', '<p>currentTimeframe - текущий таймфрейм</p>\n\n<p>currentDeltaValue - текущая дельта</p>\n\n<p>lastCandle - последняя свеча</p>\n\n<p>xhr - текущий запрос</p>\n\n<p>footprintGraph - строковое представление типа графика</p>\n\n<p>deltaGraph - строковое представление типа графика&nbsp;</p>\n\n<p>getCandlesForInterval(obj) return void&nbsp;<br />\nВ зависимости от типа графика (footprint/delta) вызывает функции&nbsp;<br />\nзапроса свечей с сервера для соответствующего графика.</p>\n\n<p>getCandlesForFootprintGraph(obj) - Функция делает запрос на сервер для получения свечей для footprint графика.<br />\n{<br />\n&nbsp;&nbsp; &nbsp;obj: &nbsp; &nbsp;<br />\n&nbsp;&nbsp; &nbsp;start_ts - левая граница запроса (ts)<br />\n&nbsp;&nbsp; &nbsp;duration - длина графика в милисекундах<br />\n&nbsp;&nbsp; &nbsp;timeframe - объект с информацией о текущем таймфрейме<br />\n&nbsp;&nbsp; &nbsp;instrument - инструмент<br />\n&nbsp;&nbsp; &nbsp;price_tick_step - шаг цены для свечи<br />\n&nbsp;&nbsp; &nbsp;lastCandleVisible - индикатор, показывающий, находится ли последняя свеча на экране<br />\n&nbsp;&nbsp; &nbsp;f - функция для рекурсивной перерисовки графика</p>\n\n<p>&nbsp;&nbsp; &nbsp;flagForInterval - есть ли участок в кеше полностью и без пробелов(true - да, false - нет)<br />\n&nbsp;&nbsp; &nbsp;1-если последняя свеча не видна или видна и flagForInterval - false -&gt; делается запрос на весь отрезок<br />\n&nbsp;&nbsp; &nbsp;2-если последняя свеча видна и flagForInterval - true -&gt; делается запрос на последюю свечу<br />\n&nbsp;&nbsp; &nbsp;3-в остальных случаях вызывается callback<br />\n&nbsp;&nbsp; &nbsp;<br />\n}</p>\n\n<p>getCandlesForDeltaGraph(obj) - Функция делает запрос на сервер для получения свечей для delta графика.<br />\n{<br />\n&nbsp;&nbsp; &nbsp;obj:<br />\n&nbsp;&nbsp; &nbsp;delta - объект с информацией о текущей дельта<br />\n&nbsp;&nbsp; &nbsp;instrument - инструмент<br />\n&nbsp;&nbsp; &nbsp;ammount - количество запрашиваемых свечей<br />\n&nbsp;&nbsp; &nbsp;last_start - (не обязательный параметр) метка времени в секундах, которая указывает до начала какой свечи присылать результаты,&nbsp;<br />\n&nbsp;&nbsp; &nbsp;если этого аргумента нет, то за эту метку берется текущая метка времени&nbsp;</p>\n\n<p>&nbsp;&nbsp; &nbsp;flagForInterval - есть ли участок в кеше полностью и без пробелов(true - да, false - нет)<br />\n&nbsp;&nbsp; &nbsp;1-если последняя свеча не видна или видна и flagForInterval - false -&gt; делается запрос на весь отрезок<br />\n&nbsp;&nbsp; &nbsp;2-если последняя свеча видна и flagForInterval - true -&gt; делается запрос на последюю свечу<br />\n&nbsp;&nbsp; &nbsp;3-в остальных случаях вызывается callback<br />\n}</p>\n\n<p>пространство имен для работы с запросами к серверу<br />\nRequest:&nbsp;<br />\n{<br />\n&nbsp;&nbsp; &nbsp;onXHRChanged - вызывается приизменении параметров запроса либо при изменении типа графика<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;- останавлвает текущий запрос<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;- очищает кеш<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;- удаляет значение последней свечи<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;- ставит индикатор запроса в false<br />\n&nbsp;&nbsp; &nbsp;}</p>\n\n<p>&nbsp;&nbsp; &nbsp;get(url, f, isForLastCandleFlag) - запрос на свечи<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;url - адресс запроса<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;f - функция для постоянного обновления данных (рекурсивной отрисовки)<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;isForLastCandleFlag - true -&gt; запрос на последнюю свечу/ false -&gt; запрос на отрезок</p>\n\n<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;если статус запроса == 200 -&gt; вызывается parseData(response, f, isForLastCandleFlag)<br />\n&nbsp;&nbsp; &nbsp;}<br />\n&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br />\n&nbsp;&nbsp; &nbsp;parseData(response, f, isForLastCandleFlag) - в зависимости от типа графика вызывает разные функции для парсинга<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;если тип графика Data.footprintGraph -&gt; Data.parseCandlesForFootprintGraph(response, f, isForLastCandleFlag)<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;если тип графика Data.deltaGraph -&gt; Data.parseCandlesForDeltaGraph(response, f, isForLastCandleFlag)<br />\n&nbsp;&nbsp; &nbsp;}</p>\n\n<p>&nbsp;&nbsp; &nbsp;parseCandlesForFootprintGraph(resp, f, isForLastCandleFlag) - парсинг данных для footprint графа<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;resp - JSON(ответ запроса)<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;f - функция для постоянного обновления данных (рекурсивной отрисовки)<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;isForLastCandleFlag - true -&gt; запрос на последнюю свечу/ false -&gt; запрос на отрезок</p>\n\n<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;создаётся массив свечей, и все данные сохраняются в него;<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;массив со свечами сохраняется в кеш;<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;индикатор запроса Graph.requestInProcess становится в false<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;вызывается f<br />\n&nbsp;&nbsp; &nbsp;}</p>\n\n<p>&nbsp;&nbsp; &nbsp;parseCandlesForDeltaGraph(resp, f, isForLastCandleFlag) - парсинг данных для delta графа<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;resp - JSON(ответ запроса)<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;f - функция для постоянного обновления данных (рекурсивной отрисовки)<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;isForLastCandleFlag - true -&gt; запрос на последнюю свечу/ false -&gt; запрос на отрезок</p>\n\n<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;создаётся массив свечей, и все данные сохраняются в него;<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;массив со свечами сохраняется в кеш;<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;индикатор запроса Graph.requestInProcess становится в false<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;вызывается f<br />\n&nbsp;&nbsp; &nbsp;}<br />\n}</p>\n\n<p>пространство имён для работы с кешем<br />\nCache:<br />\n{<br />\n&nbsp;&nbsp; &nbsp;containEmptySegment(start_ts, duration) - проверяет на наличие пробелов в кеше на заданном промежутке&nbsp;<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;start_ts - начальная метка времени<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;duration - длина отрезка в милисекундах</p>\n\n<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;Проверяет на заданном промежутке расстояние в милисекундах между свечами.<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;Если оно больше текущего timeframe, значит есть пробелы.<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return true/false (true - содержит пробелы &nbsp;/ false - не содержит)<br />\n&nbsp;&nbsp; &nbsp;}</p>\n\n<p>&nbsp;&nbsp; &nbsp;containsInterval(start_ts, duration) - проверяет, есть ли участок в кеше полностью и без пробелов<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;start_ts - начальная метка времени<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;duration - длина отрезка в милисекундах</p>\n\n<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;end = start_ts + duration - конечная метка времени</p>\n\n<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;1 - если кеш не пустой<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;2 - крайняя левая свеча(первая в кеше) меньше\\равна старту<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;3 - крайняя правая лежит либо после(по времени) правой границы, либо до, но все равно должна быть отрисована<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;так как часть ее находится после правой границы, а начало до || если еще не может быть свечек в том промежутке<br />\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;4 - если нет пробелов в таком интервале</p>\n\n<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return true/false (true - есть участок и он без пробелов/ false - либо участок с пробелами, либо не весь)<br />\n&nbsp;&nbsp; &nbsp;}</p>\n\n<p>&nbsp;&nbsp; &nbsp;get(start_ts, duration) - для запроса данных из кеша<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;start_ts - начальная метка времени<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;duration - длина отрезка в милисекундах</p>\n\n<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;возвращает массив свечей на заданном промежутке<br />\n&nbsp;&nbsp; &nbsp;}</p>\n\n<p>&nbsp;&nbsp; &nbsp;save(candles) - сохраняет массив свечей в кеш<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;candles - массив свечей, которые нужно сохранить</p>\n\n<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;Сохраняет только те свечи, которых нет в кеше. Обновляет последнюю свечу, если она завершилась - это отмечается.<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;Сортирует все свечи в кеше по возрастанию.<br />\n&nbsp;&nbsp; &nbsp;}</p>\n\n<p>&nbsp;&nbsp; &nbsp;Candles : [] - объект данных кеша<br />\n}</p>\n\n<p>объект для работы с локальным хранилищем<br />\nLocalStorage:<br />\n{<br />\n&nbsp;&nbsp; &nbsp;save(_case, obj) - принимает ключ и объект, сохраняет его по заданному ключу<br />\n&nbsp;&nbsp; &nbsp;{<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;_case - ключ<br />\n&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;obj - объект<br />\n&nbsp;&nbsp; &nbsp;}</p>\n\n<p>&nbsp;&nbsp; &nbsp;get(_case) - извлекает из локального хранилища объект по ключу</p>\n\n<p>&nbsp;&nbsp; &nbsp;remove(_case) - удаляет из локального хранилища объект по ключу<br />\n}</p>\n\n<p><br />\nvar Candle = function(){} - класс свечи</p>\n\n<p>Candle.prototype = {</p>\n\n<p>&nbsp; &nbsp; constructor: Candle,<br />\n&nbsp; &nbsp;&nbsp;<br />\n&nbsp; &nbsp; addTick(bid, ask, price)&nbsp;<br />\n&nbsp; &nbsp; {</p>\n\n<p>&nbsp; &nbsp; &nbsp; &nbsp; bid - количество продаж<br />\n&nbsp;&nbsp; &nbsp;ask - количество покупок<br />\n&nbsp;&nbsp; &nbsp;price - цена&nbsp;</p>\n\n<p>&nbsp;&nbsp; &nbsp;создаёт новый тик и добавляет к массиву тиков свечи<br />\n&nbsp; &nbsp; },</p>\n\n<p>&nbsp; &nbsp; getVolume() - возвращает объём свечи<br />\n&nbsp; &nbsp; {<br />\n&nbsp; &nbsp; &nbsp; &nbsp; volume;<br />\n&nbsp; &nbsp; },<br />\n&nbsp; &nbsp;&nbsp;<br />\n&nbsp; &nbsp; getTicks() - возвращает массив тиков для свечи<br />\n&nbsp; &nbsp; {<br />\n&nbsp;&nbsp; &nbsp;сначала вычисляет максимальный объём тика, для него ставит isMain - true<br />\n&nbsp;&nbsp; &nbsp;в соответствии с ним вычисляет относительную длину для всех тиков в долях<br />\n&nbsp; &nbsp; }<br />\n}</p>\n\n<p>DeltaCandle(start_price, last_price, volume, realDelta, startTS, endTS, finished) - свеча для delta графика, наследуется от класса Candle&nbsp;<br />\n{<br />\n&nbsp; &nbsp; start_price - начальная цена (цена покупки/продажи на начальный момент времени свечи)<br />\n&nbsp; &nbsp; last_price - конечная цена (цена покупки/продажи в последний момент времени свечи)<br />\n&nbsp; &nbsp; volume - объём (количество покупок и продаж)<br />\n&nbsp; &nbsp; realDelta - дельта<br />\n&nbsp; &nbsp; startTS - начальная метка времени в милисекундах<br />\n&nbsp; &nbsp; endTS - конечная метка времени в милисекундах<br />\n&nbsp; &nbsp; finished - флаг, показывает завершена ли свеча<br />\n&nbsp; &nbsp; ticks[] - массив тиков для свечи<br />\n}</p>\n\n<p>FootprintCandle(start_price, last_price, from, timeframe, finished, volume) - свеча для footprint графика, наследуется от класса Candle<br />\n{<br />\n&nbsp; &nbsp; start_price - начальная цена (цена покупки/продажи на начальный момент времени свечи)<br />\n&nbsp; &nbsp; last_price - конечная цена (цена покупки/продажи в последний момент времени свечи)<br />\n&nbsp; &nbsp; volume - объём (количество покупок и продаж)<br />\n&nbsp; &nbsp; from - время в милисекундах, показывающее начальное время свечи<br />\n&nbsp; &nbsp; timeframe - временной промежуток для свечи<br />\n&nbsp; &nbsp; finished - флаг, показывает завершена ли свеча<br />\n&nbsp; &nbsp; ticks[] - массив тиков для свечи<br />\n}</p>\n\n<p>Tick(ask, bid, price) - объект тика для свечи<br />\n{<br />\n&nbsp; &nbsp; ask - количество продаж<br />\n&nbsp; &nbsp; bid - количество покупок<br />\n&nbsp; &nbsp; price - цена<br />\n&nbsp; &nbsp; isMain - флаг, показывает содержит ли тик самое большое количество (в сумме) продаж и покупок в рамках одной свечи<br />\n&nbsp; &nbsp; dir = (this.ask &gt; this.bid) ? Tick.Dir.DIR_MINUS : Tick.Dir.DIR_PLUS - если продаж больше, чем покупок -&gt; цвет тика устанавливается в красный<br />\n&nbsp;&nbsp; &nbsp;иначе - цвет устанавливается в зелёный<br />\n&nbsp; &nbsp; length - длина свечи в долях (изначально нуль); высчитывается в процессе получения тиков для свечи<br />\n}</p>\n\n<p>Tick.Dir - переменные для задания цвета тикам<br />\n{<br />\n&nbsp; &nbsp; DIR_PLUS: 1, - если продаж больше, чем покупок<br />\n&nbsp; &nbsp; DIR_MINUS: 2 - если покупок больше чем продаж<br />\n}</p>\n\n<p>Tick.prototype - класс тика<br />\n{<br />\n&nbsp; &nbsp; constructor: Tick,</p>\n\n<p>&nbsp; &nbsp; getVolume() - возвращает объём тика<br />\n&nbsp; &nbsp; {<br />\n&nbsp;&nbsp; &nbsp;складывает число покупок и продаж тика<br />\n&nbsp; &nbsp; &nbsp; &nbsp; return ask + bid;<br />\n&nbsp; &nbsp; }<br />\n}</p>\n', NULL, NULL),
(21, 18, 0, 'Ui', '<p>init: function() return void<br />\nполучает дом объекты для взаимодействия со страницей и вешает на них обработчики событий<br />\nchangeVisualSettings: function(e) return void<br />\nоткрывает/закрывает модальное окно при нажатии на кнопке меню<br />\nchangeTimeframe: function(e) return void<br />\nсмена таймфрейма<br />\nchangeInstrument: function(e) return void<br />\nсмена инструмента<br />\nonModal: function(e) return void<br />\nоткрывает/закрывает модальное окно при нажатии на экран<br />\nonVisualSettingsModal: function(e) return void<br />\nоткрывает/закрывает модальное окно для смены визуальных настроек при нажатии на кнопке меню<br />\nsetVisualSettingsColor: function() return void<br />\nсмена визуальных настроек графика<br />\ngetVisualSettingsDefault: function() return void<br />\nустановление стандартных визуальных настроек графика<br />\nonMenu: function(e) return void<br />\nзакрытие модального окна при нажатии на меню<br />\n </p>', NULL, NULL),
(22, 8, 0, 'DeltaCandle', '<p>Класс свечи Delta</p>\n\n<h2>Методы:</h2>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><strong>Конструктор </strong>принимает начальную Timestamp $startTS и конечную.Timestamp $endTS метки&nbsp;времени, устанавливает эти поля, а также нулевые значения для всех остальных.</div>\n\n<p>&nbsp;</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Array&lt;String =&gt; String&gt;&nbsp;<strong>toArray</strong></code>()</div>\n\n<p>Преобразует объект в ассоциативный массив.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Array&lt;String =&gt; String&gt;&nbsp;<strong>toJSON</strong></code>()</div>\n\n<p>Преобразует объект в ассоциативный массив, а затем в JSON.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>int&nbsp;<strong>getStartTimestamp</strong></code>(void)</div>\n\n<p>Возвращает начальную метку времени свечи.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>int&nbsp;<strong>getEndTimestamp</strong></code>(void)</div>\n\n<p>Возвращает конечную метку времени свечи.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setFinished</strong></code>(bool $flag)</div>\n\n<p>Устанавливает поле $finished.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setStartPrice</strong></code>(float $price)</div>\n\n<p>Устанавливает поле $start_price.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setLastPrice</strong></code>(float $price)</div>\n\n<p>Устанавливает поле $last_price.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setTickMaxPrice</strong></code>(float $price)</div>\n\n<p>Устанавливает поле $tick_max_price.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setVolume</strong></code>(int $vol)</div>\n\n<p>Устанавливает поле $volume.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setTicks</strong></code>(Array&lt;Array&lt;int&gt;&gt;)</div>\n\n<p>Устанавливает поле $ticks.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\"><code>Void&nbsp;<strong>setRealDelta</strong></code>(int $delta)</div>\n\n<p>Устанавливает поле $realDelta.</p>\n', NULL, NULL),
(24, 7, 0, 'api', '<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">GET /candles/</div>\n\n<p>Принимает get - параметры:</p>\n\n<p>&nbsp; -instrument - название инструмента;</p>\n\n<p>&nbsp; -start - начальная метка времени в секундах;</p>\n\n<p>&nbsp; -end - конечная метка времени в секундах;</p>\n\n<p>&nbsp; -timeframe - продолжительность свечи.</p>\n\n<p>Возвращает массив свечей&nbsp;FOOTPRINT в формате JSON.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">GET /candle/last/</div>\n\n<p>Принимает get - параметры:</p>\n\n<p>&nbsp; -instrument - название инструмента;</p>\n\n<p>&nbsp; -timeframe - продолжительность свечи.</p>\n\n<p>Возвращает последнюю неоконченную свечу FOOTPRINT в формате JSON.</p>\n\n<div style=\"background:#eee;border:1px solid #ccc;padding:5px 10px;\">GET /candles/delta/</div>\n\n<p>Принимает get - параметры:</p>\n\n<p>&nbsp; -instrument - название инструмента;</p>\n\n<p>&nbsp; -start - начальная метка времени в секундах;</p>\n\n<p>&nbsp; -end - конечная метка времени в секундах;</p>\n\n<p>&nbsp; -delta - значение дельты.</p>\n\n<p>Возвращает массив свечей Delta в формате JSON.</p>\n', NULL, NULL),
(25, 7, 0, 'Соответствия инструментов', '<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:700px\">\n	<tbody>\n		<tr>\n			<td>Инструмент</td>\n			<td>Название</td>\n			<td>Макс. кратность</td>\n			<td>Символ</td>\n		</tr>\n		<tr>\n			<td>6A</td>\n			<td>Австралийский доллар</td>\n			<td>4</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>6B</td>\n			<td>Фунт</td>\n			<td>4</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>6C</td>\n			<td>Канадский доллар</td>\n			<td>5</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>6E</td>\n			<td>Евро</td>\n			<td>5</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>6J</td>\n			<td>Йена</td>\n			<td>7</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>6N</td>\n			<td>Новозеладский доллар</td>\n			<td>4</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>6S</td>\n			<td>Франк</td>\n			<td>4</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>CL</td>\n			<td>Нефть</td>\n			<td>2</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>GC</td>\n			<td>Золото</td>\n			<td>1</td>\n			<td>&nbsp;</td>\n		</tr>\n	</tbody>\n</table>\n\n<p>&nbsp;</p>\n', NULL, NULL),
(26, 7, 0, ' Расписание', '<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:700px\">\n	<tbody>\n		<tr>\n			<td>Месяц</td>\n			<td>Символ</td>\n		</tr>\n		<tr>\n			<td>Jan</td>\n			<td>F</td>\n		</tr>\n		<tr>\n			<td>Feb</td>\n			<td>G</td>\n		</tr>\n		<tr>\n			<td>Mar</td>\n			<td>H</td>\n		</tr>\n		<tr>\n			<td>Apr</td>\n			<td>J</td>\n		</tr>\n		<tr>\n			<td>May</td>\n			<td>K</td>\n		</tr>\n		<tr>\n			<td>Jun</td>\n			<td>M</td>\n		</tr>\n		<tr>\n			<td>Jul</td>\n			<td>N</td>\n		</tr>\n		<tr>\n			<td>Aug</td>\n			<td>Q</td>\n		</tr>\n		<tr>\n			<td>Sep</td>\n			<td>U</td>\n		</tr>\n		<tr>\n			<td>Oct</td>\n			<td>V</td>\n		</tr>\n		<tr>\n			<td>Nov</td>\n			<td>X</td>\n		</tr>\n		<tr>\n			<td>Dec</td>\n			<td>Z</td>\n		</tr>\n	</tbody>\n</table>\n\n<p>&nbsp;</p>\n', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `core_pages`
--

CREATE TABLE `core_pages` (
  `id` int(11) NOT NULL,
  `c_order_id` float NOT NULL DEFAULT '0',
  `name` varchar(1000) NOT NULL DEFAULT '',
  `url` varchar(2048) NOT NULL DEFAULT '/',
  `head` longtext,
  `body` longtext,
  `title` varchar(1000) NOT NULL DEFAULT '',
  `metakeys` varchar(2000) NOT NULL DEFAULT '',
  `metadescription` varchar(2000) NOT NULL DEFAULT '',
  `includes` longtext,
  `parent` int(11) NOT NULL DEFAULT '0',
  `is_static` tinyint(4) DEFAULT '0',
  `template` int(11) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `data` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `core_pages`
--

INSERT INTO `core_pages` (`id`, `c_order_id`, `name`, `url`, `head`, `body`, `title`, `metakeys`, `metadescription`, `includes`, `parent`, `is_static`, `template`, `created`, `modified`, `data`) VALUES
(1, 300, 'Новая страница', '/text/', '<meta name=\'viewport\' content=\'initial-scale=1, width=device-width, user-scalable=no\'/>\r\n        <base href=\'/vtresurs\'/>\r\n        \r\n        \r\n        <link rel=\'stylesheet\' href=\'/css/main.css\'>\r\n        <link rel=\'stylesheet\' href=\'/css/section.css\'/>\r\n        \r\n        <script src=\'/js/jquery.js\'></script>\r\n        <link rel=\"stylesheet\" type=\"text/css\" href=\"//cdn.jsdelivr.net/jquery.slick/1.6.0/slick.css\"/>\r\n        <script type=\"text/javascript\" src=\"//cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js\"></script>\r\n        \r\n        \r\n        <script src=\'/js/index.js\'></script>', '\n                [[include path=\'/views/header.php\']]\n\n        <main>\n            <div class=\"wrap responsive\">\n                <div class=\"crumbs\">\n                    <ul>\n                        <li><a href=\"./\">Р“Р»Р°РІРЅР°СЏ</a></li>\n                        <li><a href=\"./\">РџРѕС‚СЂРµР±РёС‚РµР»СЏРј</a></li>\n                        <li><a href=\"\">РўРµСЂСЂРёС‚РѕСЂРёСЏ РѕР±СЃР»СѓР¶РёРІР°РЅРёСЏ СЃРµС‚РµРІРѕР№ РѕСЂРіР°РЅРёР·Р°С†РёРё</a></li>\n                        <li><a href=\"\">РћР±С‰Р°СЏ РёРЅС„РѕСЂРјР°С†РёСЏ</a></li>\n                    </ul>\n                </div>\n                <aside class=\"section-nav\">\n                    <nav>\n                        <ul>\n                            <li>\n                                <a href=\"\" class=\"active\">РўРµСЂСЂРёС‚РѕСЂРёСЏ РѕР±СЃР»СѓР¶РёРІР°СЋС‰РµР№ РѕСЂРіР°РЅРёР·Р°С†РёРё</a>\n                                <ol>\n                                    <li><a href=\"\">РћР±С‰Р°СЏ РёРЅС„РѕСЂРјР°С†РёСЏ</a></li>\n                                    <li><a href=\"\">РўРµС…РЅРёС‡РµСЃРєРѕРµ СЃРѕСЃС‚РѕСЏРЅРёРµ СЃРµС‚РµР№ </a></li>\n                                </ol>\n                            </li>\n                            <li><a href=\"\">РџРµСЂРµРґР°С‡Р° СЌР»РµРєС‚СЂРёС‡РµСЃРєРѕР№ СЌРЅРµСЂРіРёРё</a></li>\n                            <li><a href=\"\">РўРµС…РЅРѕР»РѕРіРёС‡РµСЃРєРѕРµ РїСЂРёСЃРѕРµРґРёРЅРµРЅРёРµ</a></li>\n                            <li><a href=\"\">РљРѕРјРјРµСЂС‡РµСЃРєРёР№ СѓС‡РµС‚ СЌР»РµРєС‚СЂРёС‡РµСЃРєРѕР№ СЌРЅРµСЂРіРёРё</a></li>\n                            <li>\n                                <a href=\"\">РћР±СЃР»СѓР¶РёРІР°РЅРёРµ РїРѕС‚СЂРµР±РёС‚РµР»РµР№</a>\n                                \n                            </li>\n                            \n                        </ul>\n                    </nav>\n                </aside>\n                <section class=\"section-content\">\n                    <h2 atomic=\"\">РћР±С‰Р°СЏ РёРЅС„РѕСЂРјР°С†РёСЏ</h2>\n                    <div class=\"content\">\n                        \n                        <div class=\"text\" richedit=\"\"><p>Condimentum vulputate ullamcorper a magna faucibus suspendisse leo sit congue natoque phasellus vestibulum scelerisque iaculis odio lorem leo ad nostra. A nascetur risus quis litora diam imperdiet felis tristique curabitur parturient in netus at non consectetur vivamus id parturient a augue orci vulputate suscipit curabitur curabitur. Adipiscing vestibulum vestibulum et id ligula at ut class nunc ad cum volutpat metus a cum senectus penatibus a nostra dis. Maecenas vestibulum consectetur duis parturient vestibulum vulputate sem fusce quisque condimentum cursus rutrum tellus imperdiet nam a augue dis accumsan vestibulum sem. At ad iaculis litora adipiscing nec luctus a nec pretium id ridiculus dignissim tempor arcu interdum ullamcorper. Mi sagittis dictumst elit hendrerit a faucibus eu arcu leo consectetur commodo habitasse proin senectus a elementum tempus vestibulum. Tellus pulvinar mollis est sodales a lectus urna consectetur pulvinar magna augue a sit mi.</p>\n\n<p>A natoque cum parturient vestibulum purus vestibulum feugiat tempus in urna sodales habitant imperdiet vehicula parturient vestibulum at quisque vestibulum ullamcorper aliquet maecenas purus nec. Posuere rhoncus non sed a convallis cum scelerisque consectetur a parturient arcu ac ullamcorper himenaeos accumsan rhoncus suspendisse molestie velit arcu a a enim mus aliquam ut taciti. Hac nostra dictum ullamcorper adipiscing taciti donec nostra id fringilla ad venenatis class commodo posuere purus augue justo amet vulputate a. Consectetur nibh enim duis lorem litora vel habitant euismod auctor viverra hac suspendisse ut netus a parturient ac. Nunc ac rhoncus scelerisque non natoque sociis libero ut etiam suscipit senectus a tortor a lobortis posuere primis condimentum.</p>\n\n<ol>\n	<li>Enim pharetra lacinia bibendum vestibulum.</li>\n	<li>Lorem condimentum vestibulum quisque nulla a imperdiet sagittis fringilla</li>\n	<li>Scelerisque malesuada sit pretium arcu placerat suspendisse ultricies feugiat.</li>\n	<li>Ligula commodo torquent potenti orci dolor eget accumsan vestibulum litora.</li>\n	<li>Turpis himenaeos a mauris quis quam adipiscing a nam tempus scelerisque accumsan non scelerisque non dis erat adipiscing scelerisque netus donec adipiscing ad.Imperdiet a suspendisse himenaeos litora commodo condimentum magna eu erat proin a tincidunt dapibus lacus semper libero fames a volutpat.Pharetra nisl venenatis dictumst auctor consectetur hendrerit est dui diam tristique vestibulum.</li>\n</ol>\n\n<p>[[form id=\'4\' title=\'Р—Р°РїРѕР»РЅРёС‚Рµ Р·Р°СЏРІРєСѓ РЅР° РїСЂРёСЃРѕРµРґРёРЅРµРЅРёРµ\']]</p>\n\n<p>Ullamcorper sit dapibus turpis suspendisse tristique consectetur vitae ullamcorper fermentum vestibulum vestibulum arcu eu duis a lorem a per nascetur sed et mattis. Facilisis a himenaeos condimentum facilisis conubia a habitasse sem nulla cras nisl urna integer a convallis vestibulum vitae.</p>\n</div>\n                        \n                        \n                    </div>\n                </section>\n            </div>\n        </main>\n\n        [[include path=\'/views/footer.php\']]\n            \n        \n        \n', 'ООО ВТ-� есурс', '', '', '{\"body_before\":\"\",\"body_after\":\"\",\"head_after\":\"\",\"head_before\":\"\",\"page_after\":\"\",\"page_before\":\"\"}', 0, 0, 1, '2017-06-26 21:08:34', '2017-06-26 21:12:24', '');

-- --------------------------------------------------------

--
-- Структура таблицы `core_pages_tmp`
--

CREATE TABLE `core_pages_tmp` (
  `id` int(11) NOT NULL,
  `url` varchar(2048) NOT NULL DEFAULT '/',
  `head` longtext,
  `body` longtext,
  `title` varchar(1000) NOT NULL DEFAULT '',
  `metakeys` varchar(2000) NOT NULL DEFAULT '',
  `metadescription` varchar(2000) NOT NULL DEFAULT '',
  `includes` longtext,
  `parent` int(11) NOT NULL DEFAULT '0',
  `is_static` tinyint(4) DEFAULT '0',
  `template` int(11) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `data` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `core_pages_tmp`
--

INSERT INTO `core_pages_tmp` (`id`, `url`, `head`, `body`, `title`, `metakeys`, `metadescription`, `includes`, `parent`, `is_static`, `template`, `created`, `modified`, `data`) VALUES
(2, '/test', '<meta  charset=\"utf-8\"/>', '<h1>Hello!</h1>', 'My New Page', 'Р В РЎСљР В РЎвЂўР В Р вЂ Р В Р’В°Р РЋР РЏ, Р РЋР С“Р РЋРІР‚С™Р РЋР вЂљР В Р’В°Р В Р вЂ¦Р В РЎвЂ?Р РЋРІР‚В Р В Р’В°', 'New page', '{\"top_body\":\"Inherited content!\"}', 0, 0, 0, '2017-06-02 21:30:25', '2017-06-02 21:30:25', '');

-- --------------------------------------------------------

--
-- Структура таблицы `core_portals`
--

CREATE TABLE `core_portals` (
  `id` int(11) NOT NULL,
  `portal` varchar(200) NOT NULL DEFAULT '',
  `method` varchar(1000) NOT NULL DEFAULT '',
  `args` mediumtext,
  `app` varchar(1000) DEFAULT NULL,
  `data` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `core_portals`
--

INSERT INTO `core_portals` (`id`, `portal`, `method`, `args`, `app`, `data`) VALUES
(2, 'content', 'Core\\Classes\\Portals\\CustomPortal$content', '{\"arg\"=>{\"required\"=>\"true\",\"type\"=>\"string\",\"description\"=>\"Custom portal\"}}', 'Pagen', ''),
(3, 'custom_portal', 'Core\\Classes\\Portals\\CustomPortal$custom', '{}', 'Pagen', '');

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6A`
--

CREATE TABLE `ticks_6A` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6A_day`
--

CREATE TABLE `ticks_6A_day` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6A_week`
--

CREATE TABLE `ticks_6A_week` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6B`
--

CREATE TABLE `ticks_6B` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6B_day`
--

CREATE TABLE `ticks_6B_day` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6B_week`
--

CREATE TABLE `ticks_6B_week` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6C`
--

CREATE TABLE `ticks_6C` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6C_day`
--

CREATE TABLE `ticks_6C_day` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6C_week`
--

CREATE TABLE `ticks_6C_week` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6E`
--

CREATE TABLE `ticks_6E` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6E_day`
--

CREATE TABLE `ticks_6E_day` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6E_week`
--

CREATE TABLE `ticks_6E_week` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6J`
--

CREATE TABLE `ticks_6J` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6J_day`
--

CREATE TABLE `ticks_6J_day` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6J_week`
--

CREATE TABLE `ticks_6J_week` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6N`
--

CREATE TABLE `ticks_6N` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6N_day`
--

CREATE TABLE `ticks_6N_day` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6N_week`
--

CREATE TABLE `ticks_6N_week` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6S`
--

CREATE TABLE `ticks_6S` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6S_day`
--

CREATE TABLE `ticks_6S_day` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_6S_week`
--

CREATE TABLE `ticks_6S_week` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_CL`
--

CREATE TABLE `ticks_CL` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_CL_day`
--

CREATE TABLE `ticks_CL_day` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_CL_week`
--

CREATE TABLE `ticks_CL_week` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_GC`
--

CREATE TABLE `ticks_GC` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_GC_day`
--

CREATE TABLE `ticks_GC_day` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ticks_GC_week`
--

CREATE TABLE `ticks_GC_week` (
  `id` int(11) NOT NULL,
  `secs` int(11) DEFAULT NULL,
  `usecs` int(11) DEFAULT NULL,
  `direction` tinyint(1) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cata_apps_folders`
--
ALTER TABLE `cata_apps_folders`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_apps_items`
--
ALTER TABLE `cata_apps_items`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_catalogs`
--
ALTER TABLE `cata_catalogs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_content_elements`
--
ALTER TABLE `cata_content_elements`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_content_folders`
--
ALTER TABLE `cata_content_folders`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_content_pages`
--
ALTER TABLE `cata_content_pages`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_content_templates`
--
ALTER TABLE `cata_content_templates`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_env_items`
--
ALTER TABLE `cata_env_items`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_imager_folders`
--
ALTER TABLE `cata_imager_folders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `c_order_id` (`c_order_id`);

--
-- Индексы таблицы `cata_imager_images`
--
ALTER TABLE `cata_imager_images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `c_order_id` (`c_order_id`);

--
-- Индексы таблицы `cata_logger_journal`
--
ALTER TABLE `cata_logger_journal`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_manual`
--
ALTER TABLE `cata_manual`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_portals_items`
--
ALTER TABLE `cata_portals_items`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_settings_vars`
--
ALTER TABLE `cata_settings_vars`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cata_users`
--
ALTER TABLE `cata_users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `core_docs`
--
ALTER TABLE `core_docs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `core_pages`
--
ALTER TABLE `core_pages`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `core_pages_tmp`
--
ALTER TABLE `core_pages_tmp`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `core_portals`
--
ALTER TABLE `core_portals`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6A`
--
ALTER TABLE `ticks_6A`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6A_day`
--
ALTER TABLE `ticks_6A_day`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6A_week`
--
ALTER TABLE `ticks_6A_week`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6B`
--
ALTER TABLE `ticks_6B`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6B_day`
--
ALTER TABLE `ticks_6B_day`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6B_week`
--
ALTER TABLE `ticks_6B_week`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6C`
--
ALTER TABLE `ticks_6C`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6C_day`
--
ALTER TABLE `ticks_6C_day`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6C_week`
--
ALTER TABLE `ticks_6C_week`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6E`
--
ALTER TABLE `ticks_6E`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6E_day`
--
ALTER TABLE `ticks_6E_day`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6E_week`
--
ALTER TABLE `ticks_6E_week`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6J`
--
ALTER TABLE `ticks_6J`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6J_day`
--
ALTER TABLE `ticks_6J_day`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6J_week`
--
ALTER TABLE `ticks_6J_week`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6N`
--
ALTER TABLE `ticks_6N`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6N_day`
--
ALTER TABLE `ticks_6N_day`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6N_week`
--
ALTER TABLE `ticks_6N_week`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6S`
--
ALTER TABLE `ticks_6S`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6S_day`
--
ALTER TABLE `ticks_6S_day`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_6S_week`
--
ALTER TABLE `ticks_6S_week`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_CL`
--
ALTER TABLE `ticks_CL`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_CL_day`
--
ALTER TABLE `ticks_CL_day`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_CL_week`
--
ALTER TABLE `ticks_CL_week`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_GC`
--
ALTER TABLE `ticks_GC`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_GC_day`
--
ALTER TABLE `ticks_GC_day`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ticks_GC_week`
--
ALTER TABLE `ticks_GC_week`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `cata_apps_folders`
--
ALTER TABLE `cata_apps_folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `cata_apps_items`
--
ALTER TABLE `cata_apps_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `cata_catalogs`
--
ALTER TABLE `cata_catalogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `cata_content_elements`
--
ALTER TABLE `cata_content_elements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `cata_content_folders`
--
ALTER TABLE `cata_content_folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT для таблицы `cata_content_pages`
--
ALTER TABLE `cata_content_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `cata_content_templates`
--
ALTER TABLE `cata_content_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `cata_env_items`
--
ALTER TABLE `cata_env_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `cata_imager_folders`
--
ALTER TABLE `cata_imager_folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `cata_imager_images`
--
ALTER TABLE `cata_imager_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT для таблицы `cata_logger_journal`
--
ALTER TABLE `cata_logger_journal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2782;
--
-- AUTO_INCREMENT для таблицы `cata_manual`
--
ALTER TABLE `cata_manual`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `cata_portals_items`
--
ALTER TABLE `cata_portals_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `cata_settings_vars`
--
ALTER TABLE `cata_settings_vars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `cata_users`
--
ALTER TABLE `cata_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `core_docs`
--
ALTER TABLE `core_docs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT для таблицы `core_pages`
--
ALTER TABLE `core_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `core_pages_tmp`
--
ALTER TABLE `core_pages_tmp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `core_portals`
--
ALTER TABLE `core_portals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `ticks_6A`
--
ALTER TABLE `ticks_6A`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=457097;
--
-- AUTO_INCREMENT для таблицы `ticks_6A_day`
--
ALTER TABLE `ticks_6A_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=501841;
--
-- AUTO_INCREMENT для таблицы `ticks_6A_week`
--
ALTER TABLE `ticks_6A_week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=501820;
--
-- AUTO_INCREMENT для таблицы `ticks_6B`
--
ALTER TABLE `ticks_6B`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=480756;
--
-- AUTO_INCREMENT для таблицы `ticks_6B_day`
--
ALTER TABLE `ticks_6B_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=536841;
--
-- AUTO_INCREMENT для таблицы `ticks_6B_week`
--
ALTER TABLE `ticks_6B_week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=536805;
--
-- AUTO_INCREMENT для таблицы `ticks_6C`
--
ALTER TABLE `ticks_6C`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=306284;
--
-- AUTO_INCREMENT для таблицы `ticks_6C_day`
--
ALTER TABLE `ticks_6C_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=329587;
--
-- AUTO_INCREMENT для таблицы `ticks_6C_week`
--
ALTER TABLE `ticks_6C_week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=329582;
--
-- AUTO_INCREMENT для таблицы `ticks_6E`
--
ALTER TABLE `ticks_6E`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=571092;
--
-- AUTO_INCREMENT для таблицы `ticks_6E_day`
--
ALTER TABLE `ticks_6E_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=631701;
--
-- AUTO_INCREMENT для таблицы `ticks_6E_week`
--
ALTER TABLE `ticks_6E_week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=631661;
--
-- AUTO_INCREMENT для таблицы `ticks_6J`
--
ALTER TABLE `ticks_6J`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=621082;
--
-- AUTO_INCREMENT для таблицы `ticks_6J_day`
--
ALTER TABLE `ticks_6J_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=659939;
--
-- AUTO_INCREMENT для таблицы `ticks_6J_week`
--
ALTER TABLE `ticks_6J_week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=659881;
--
-- AUTO_INCREMENT для таблицы `ticks_6N`
--
ALTER TABLE `ticks_6N`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135978;
--
-- AUTO_INCREMENT для таблицы `ticks_6N_day`
--
ALTER TABLE `ticks_6N_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157648;
--
-- AUTO_INCREMENT для таблицы `ticks_6N_week`
--
ALTER TABLE `ticks_6N_week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157645;
--
-- AUTO_INCREMENT для таблицы `ticks_6S`
--
ALTER TABLE `ticks_6S`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=265912;
--
-- AUTO_INCREMENT для таблицы `ticks_6S_day`
--
ALTER TABLE `ticks_6S_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=334136;
--
-- AUTO_INCREMENT для таблицы `ticks_6S_week`
--
ALTER TABLE `ticks_6S_week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=334129;
--
-- AUTO_INCREMENT для таблицы `ticks_CL`
--
ALTER TABLE `ticks_CL`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125191;
--
-- AUTO_INCREMENT для таблицы `ticks_CL_day`
--
ALTER TABLE `ticks_CL_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125191;
--
-- AUTO_INCREMENT для таблицы `ticks_CL_week`
--
ALTER TABLE `ticks_CL_week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125191;
--
-- AUTO_INCREMENT для таблицы `ticks_GC`
--
ALTER TABLE `ticks_GC`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94503;
--
-- AUTO_INCREMENT для таблицы `ticks_GC_day`
--
ALTER TABLE `ticks_GC_day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=329036;
--
-- AUTO_INCREMENT для таблицы `ticks_GC_week`
--
ALTER TABLE `ticks_GC_week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=329035;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
