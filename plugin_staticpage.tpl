{* frontend plugin_staticpage.tpl file v. 1.03, 2014-12-16 *}
<article id="staticpage_{$staticpage_pagetitle|@makeFilename}" class="clearfix serendipity_staticpage{if $staticpage_articleformat} serendipity_entry{/if}">
    <header>
        <h2>{if $staticpage_articleformat}{if $staticpage_articleformattitle}{$staticpage_articleformattitle|escape:'html':$CONST.LANG_CHARSET:false}{else}{$staticpage_pagetitle}{/if}{else}{if $staticpage_headline}{$staticpage_headline|escape:'html':$CONST.LANG_CHARSET:false}{else}{$staticpage_pagetitle}{/if}{/if}</h2>
    {if is_array($staticpage_navigation) AND ($staticpage_shownavi OR $staticpage_show_breadcrumb)}
        <div id="staticpage_nav">
        {if $staticpage_shownavi}
            <ul class="staticpage_navigation">
                <li class="staticpage_navigation_left">{if !empty($staticpage_navigation.prev.link)}<a href="{$staticpage_navigation.prev.link}" title="prev">{$staticpage_navigation.prev.name|escape:'html':$CONST.LANG_CHARSET:false}</a>{else}<span class="staticpage_navigation_dummy">{$CONST.PREVIOUS}</span>{/if}</li>
                <li class="staticpage_navigation_center">{if $staticpage_navigation.top.new}{if !empty($staticpage_navigation.top.topp_name)}<a href="{$staticpage_navigation.top.topp_link}" title="top">{$staticpage_navigation.top.topp_name}</a> | {/if}&#171 {$staticpage_navigation.top.curr_name|escape:'html':$CONST.LANG_CHARSET:false} &#187; {if !empty($staticpage_navigation.top.exit_name)}| <a href="{$staticpage_navigation.top.exit_link}" title="exit">{$staticpage_navigation.top.exit_name}</a>{/if}{else}<a href="{$staticpage_navigation.top.link}" title="current page">{$staticpage_navigation.top.name|escape:'html':$CONST.LANG_CHARSET:false}</a>{/if}</li>
                <li class="staticpage_navigation_right">{if !empty($staticpage_navigation.next.link)}<a href="{$staticpage_navigation.next.link}" title="next">{$staticpage_navigation.next.name|escape:'html':$CONST.LANG_CHARSET:false}</a>{else}<span class="staticpage_navigation_dummy">{$CONST.NEXT}</span>{/if}</li>
            </ul>{* 'top' is just a synonym for current page, or top parent, or exit *}
        {/if}
        {if $staticpage_show_breadcrumb}
            <div class="staticpage_navigation_breadcrumb">
                <a href="{$serendipityBaseURL}">{$CONST.HOMEPAGE}</a> &#187;
            {foreach name="crumbs" from=$staticpage_navigation.crumbs item="crumb"}
                {if !$smarty.foreach.crumbs.first}&#187;{/if}{if $crumb.id != $staticpage_pid}<a href="{$crumb.link}">{$crumb.name|escape:'html':$CONST.LANG_CHARSET:false}</a>{else}{$crumb.name|escape:'html':$CONST.LANG_CHARSET:false}{/if}
            {/foreach}
            </div>
        {/if}
        </div>
    {/if}
    </header>
{if $staticpage_pass AND $staticpage_form_pass != $staticpage_pass}
    <form class="staticpage_password_form" action="{$staticpage_form_url}" method="post">
    <fieldset>
        <legend>{$CONST.STATICPAGE_PASSWORD_NOTICE}</legend>
        <input name="serendipity[pass]" type="password" value="">
        <input name="submit" type="submit" value="{$CONST.GO}" >
    </fieldset>
    </form>
{else}
    {if $staticpage_precontent}
    <div class="clearfix content serendipity_preface">
    {$staticpage_precontent}
    </div>
    {/if}
    {if is_array($staticpage_childpages)}
    <div class="clearfix content staticpage_childpages">
        <ul id="staticpage_childpages">
            {foreach from=$staticpage_childpages item="childpage"}
            <li><a href="{$childpage.permalink|escape:'html':$CONST.LANG_CHARSET:false}" title="{$childpage.pagetitle|escape:'html':$CONST.LANG_CHARSET:false}">{$childpage.pagetitle|escape:'html':$CONST.LANG_CHARSET:false}</a></li>
            {/foreach}
        </ul>
    </div>
    {/if}
    {if $staticpage_content}
    <div class="clearfix content {if $staticpage_articleformat}serendipity_entry_body{else}staticpage_content{/if}">
    {$staticpage_content}
    </div>
    {/if}
{/if}
{if $staticpage_author or $staticpage_lastchange or $staticpage_adminlink}
    <footer class="staticpage_metainfo">
        <p>
        {if $staticpage_author}
            <span class="single_user"><span class="visuallyhidden">{$CONST.POSTED_BY} </span>{$staticpage_author|escape:'html':$CONST.LANG_CHARSET:false}
        {/if}
        {if $staticpage_author AND $staticpage_lastchange} | </span>{/if}
        {if $staticpage_lastchange}
            <span class="visuallyhidden">{$CONST.ON} </span>
            {if $staticpage_use_lmdate}
            <time datetime="{$staticpage_lastchange|@serendipity_html5time}">{$staticpage_lastchange|@formatTime:$template_option.date_format}</time>
            {if $staticpage_adminlink AND $staticpage_adminlink.page_user} ({$CONST.CREATED_ON|lower}: {$staticpage_created_on|@date_format:"%Y-%m-%d"}){/if}
            {else}
            <time datetime="{$staticpage_created_on|@serendipity_html5time}">{$staticpage_created_on|@formatTime:$template_option.date_format}</time>
            {if $staticpage_adminlink AND $staticpage_adminlink.page_user} ({$CONST.LAST_UPDATED|lower}: {$staticpage_lastchange|@date_format:"%Y-%m-%d"}){/if}
            {/if}
        {/if}
        {if $staticpage_adminlink AND $staticpage_adminlink.page_user}
            | <a href="{$staticpage_adminlink.link_edit}">{$staticpage_adminlink.link_name|escape:'html':$CONST.LANG_CHARSET:false}</a>
        {/if}
        </p>
    </footer>
{/if}
</article>
