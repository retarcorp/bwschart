<aside id='filter' class='Scrollable'>
    <form>
        <label>
            <span>Поиск по части названия:</span>
            <input type='text' id='shop-search-name'/>
        </label>
        
        <fieldset>
            <h5>Категория приложения</h5>
            <ul id='shop-category'>
                <template id='ShopCategory'>
                    <li>
                        <label>
                            <input type='checkbox' value='{{id}}' checked/>
                            <span>{{title}}</span>
                        </label>
                    </li>
                </template>
            </ul>
        </fieldset>
        
        <label>
            <input type='checkbox' id='shop-free-only' />
            <span>Только бесплатные</span>
        </label>
        
        <!-- 
            Поиск по тегам
        -->
        
        <fieldset>
            <label>
                <input type='radio' name='shop-sort' value='popular'/>
                <span>Сортировать по популярности</span>
            </label>
            <label>
                <input type='radio' name='shop-sort' value='latest' checked/>
                <span>Сначала новые</span>
            </label>
            <label>
                <input type='radio' name='shop-sort' value='oldest'/>
                <span>Сначала старые</span>
            </label>
            <label>
                <input type='radio' name='shop-sort' value='biggest'/>
                <span>Сначала большие</span>
            </label>
            <label>
                <input type='radio' name='shop-sort' value='smallest'/>
                <span>Сначала маленькие</span>
            </label>
        </fieldset>
        
    </form>
</aside>

<article id='apps' class='Scrollable'>
    <ul id='app-list'>
        <template id='Application'>
            <li data-id='{{id}}' data-name='{{name}}'>
                <figure>
                    <img src='{{image}}'/>
                    <figcaption>
                        <h3>{{title}}</h3>
                        <h5>Версия: {{version}}</h5>
                        <div class='desc'>{{description}}</div>
                    </figcaption>
                </figure>
                
                <div class='tags'>
                    <p>Теги: {{tags}}</p>
                </div>
                
                <div class='col-2'>
                    <div class='chars'>
                        <span class='installs' title='Количество установок'>{{installs}}</span>
                        <span class='published' title='Дата последнего обновления'>{{published_at}}</span>
                        <span class='size' title='Размер'>{{size}}</span>
                    </div>
                    <div class='buttons'>
                        <input type='button' data-action='{{action}}' value='Установить' class='action'/>
                    </div>
                </div>
                
            </li>
        </template>
    </ul>
</article>