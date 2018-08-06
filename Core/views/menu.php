<?php require_once $_SERVER['DOCUMENT_ROOT']."/Core/views/templates.php";?>

<!-- Nav panel -->
        <header id='navPanel'>
            <nav>
                <ul>
                    <li>
                        <ol>
                            <li>
                                <a href='/Core/' style='background-image: url(/Core/img/apps/main.png)'> Консоль</a>
                            </li>
                        </ol>
                    </li>
                    
                    <?php
                        use Core\Classes\System\RCatalog;
                        $catalog = new RCatalog("cata_apps");
                        $cats = $catalog->getItemsAt(0);
                        
                        foreach($cats as $cat){
                            echo "<li> <ol>";
                            
                            $apps = $catalog->getChildrenOf($cat['id'],0);
                            foreach($apps as $app){
                                echo "<li><a href='{$app['link']}' style='background-image: url({$app['icon']})'>{$app['title']}</a></li>";
                            }
                            
                            echo "</ol></li>";
                            
                        }
                    ?>
                    <!--<li>-->
                    <!--    <ol>-->
                    <!--        <li> <a href='/Core/apps/Content/' style='background-image: url(/Core/img/apps/pagen.png)'>Управление страницами</a></li>-->
                    <!--        <li> <a href='/Core/apps/' style='background-image: url(/Core/img/apps/app.png)'>Тестовое приложение</a></li>-->
                            
                    <!--    </ol>-->
                    <!--</li>-->
                    
                    <!--<li>-->
                    <!--    <ol>-->
                    <!--        <li> <a href='/Core/apps/Sql/' style='background-image: url(/Core/img/apps/sql.png)'>SQL-консоль</a></li>-->
                    <!--        <li> <a href='/Core/apps/FileManager/' style='background-image: url(/Core/img/apps/fileManager.png)'>Файловый менеджер</a></li>-->
                    <!--        <li> <a href='/Core/apps/Logger/' style='background-image: url(/Core/img/apps/logger.png)'>Отчеты системы</a></li>-->
                    <!--        <li> <a href='/Core/apps/Cata/' style='background-image: url(/Core/img/apps/cata.png)'>Управление каталогами Cata</a></li>-->
                            
                    <!--    </ol>-->
                    <!--</li>-->
                    
                    <!--<li>-->
                    <!--    <ol>-->
                    <!--        <li> <a href='/Core/apps/Info/' style='background-image: url(/Core/img/apps/info.png)'>Справочная система</a></li>-->
                    <!--        <li> <a href='/Core/apps/Users/' style='background-image: url(/Core/img/apps/users.png)'>Пользователи системы</a></li>-->
                    <!--        <li> <a href='/Core/apps/Backup/' style='background-image: url(/Core/img/apps/backup.png)'>Резервные копии</a></li>-->
                    <!--        <li> <a href='/Core/apps/Settings/' style='background-image: url(/Core/img/apps/settings.png)'>Настройки системы</a></li>-->
                    <!--    </ol>-->
                    <!--</li>-->
                    
                    <li>
                        <ol>
                            <li> <a href='/Core/views/logout.php' style='background-image: url(/Core/img/apps/logout.png)'>Выйти</a></li>
                        </ol>
                    </li>
                </ul>
            </nav>
        </header>