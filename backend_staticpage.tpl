{* backend_staticpage template file v. 1.10, 2014-06-17 *}

<!-- backend_staticpage.tpl START -->

<div id="serendipityStaticpagesNav">
    <ul>
        <li{if $s9y_get_cat == 'pageedit'} id="active"{/if}><a href="{$serendipityHTTPPath}serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageedit">{$CONST.STATICPAGE_CATEGORY_PAGES}</a></li>
        <li{if $s9y_get_cat == 'pageorder'} id="active"{/if}><a href="{$serendipityHTTPPath}serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder">{$CONST.STATICPAGE_CATEGORY_PAGEORDER}</a></li>
        <li{if $s9y_get_cat == 'pagetype' || $s9y_post_cat == 'pagetype'} id="active"{/if}><a href="{$serendipityHTTPPath}serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pagetype">{$CONST.STATICPAGE_CATEGORY_PAGETYPES}</a></li>
        <li{if $s9y_get_cat == 'pageadd'} id="active"{/if}><a href="{$serendipityHTTPPath}serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageadd">{$CONST.STATICPAGE_CATEGORY_PAGEADD}</a></li>
    </ul>
</div>

{if $switch_spcat == 'pageorder'}

<div id="splistorder" class="sp_msg_success"></div>

    {if is_array($sp_pageorder_pages)}

<div id="sp_sequencer" class="configuration_group even">
    <fieldset class="sp_sequence">
        <legend>{$CONST.STATICPAGE_PAGEORDER_DESC}</legend>
        <input type="hidden" name="serendipity[plugin][sequence]" id="sequence_value" value="{foreach $sp_pageorder_pages as $orderlist}{$orderlist['pagetitle']}{if !$orderlist@last},{/if}{/foreach}">
        <noscript>
            <!-- Replace standard submit button when using up/down submits -->
            <input type="hidden" name="SAVECONF" value="Save">
        </noscript>

        <ol id="sequence" data-placement="sqid" class="sequence_container pluginmanager_container">
        {foreach $sp_pageorder_pages as $entryorder}
            <li id="{$entryorder['id']}" class="sequence_item pluginmanager_item_{cycle values="odd,even"}">{*  in normal situations id=$entryorder['pagetitle'], but we need id for js sequence mode *}
                <input type="hidden" name="serendipity[plugin][sequence][id]" id="sequence_id" value="{$entryorder['id']}">
                <div id="g{$entryorder['pagetitle']}" class="pluginmanager_grablet sequence_grablet">
                    <button class="icon_link" type="button" title="{$CONST.MOVE}"><span class="icon-move"></span><span class="visuallyhidden"> {$CONST.MOVE}</span></button>
                </div>
                {if $entryorder['parent_id'] > 0}<span class="entry_status sp_ptree">#{$entryorder['parent_id']}</span><span class="icon-right-dir sp_ctree"></span>{/if}<span class="sp_grablet_title">{$entryorder['pagetitle']}</span>
                <div class="sp_nojs">
                {if !$entryorder@first}

                    <span>
                        <noscript>
                        <a href="?serendipity[adminModule]=staticpages&amp;serendipity[moveto]=moveup&amp;serendipity[pagetomove]={$entryorder['id']}&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder" style="border: 0"><img src="{serendipity_getFile file='admin/img/uparrow.png'}" alt="{$CONST.UP}"></a>
                        </noscript>
                    </span>

                {/if}
                {if !$entryorder@last}

                    <span>
                        <noscript>
                        <a href="?serendipity[adminModule]=staticpages&amp;serendipity[moveto]=movedown&amp;serendipity[pagetomove]={$entryorder['id']}&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder" style="border: 0"><img src="{serendipity_getFile file='admin/img/downarrow.png'}" alt="{$CONST.DOWN}"></a>
                        </noscript>
                    </span>

                {/if}
                </div>
            </li>
        {/foreach}
        </ol>
    </fieldset>
</div>
    {else}

    <p class="sp_bold">{$CONST.STATICPAGE_PAGEORDER_DESC}</p>

    {/if} {* is_array($sp_pageorder_pages) end *}

{elseif $switch_spcat == 'pagetype'}

    {if $sp_pagetype_saveconf}
<div class="msg_success"><span class="icon-ok"></span> {$CONST.DONE}! {$CONST.SETTINGS_SAVED_AT|sprintf:($smarty.now|@formatTime:'%H:%M:%S')}</div>
    {/if}

    {if $sp_pagetype_purged}
<div class="msg_success"><span class="icon-ok"></span> {$CONST.DONE}! {$CONST.RIP_ENTRY|sprintf:$sp_pagetype_ripped}</div>
    {/if}

    {if $sp_pagetype_update}
<div class="msg_error"><span class="icon-error"></span> {$CONST.ERROR}: {$sp_pagetype_mixedresult}</div>
    {/if}

<form action="serendipity_admin.php" method="post" name="serendipityEntry">
<div>
    <input type="hidden" name="serendipity[adminModule]" value="event_display">
    <input type="hidden" name="serendipity[adminAction]" value="staticpages">
    <input type="hidden" name="serendipity[staticpagecategory]" value="pagetype">
    <div>
        <p class="sp_bold">{$CONST.PAGETYPES_SELECT}</p>
        <select name="serendipity[pagetype]">
            <option value="__new">{$CONST.NEW_ENTRY}</option>
            <option value="__new">-----------------</option>
{if $sp_pagetype && is_array($sp_pagetype_types)}
    {foreach $sp_pagetype_types as $type}
        <option value="{$type['id']}"{if $smarty.post.serendipity.pagetype == $type['id']} selected="selected"{/if}>{$type['description']|escape}</option>
    {/foreach}
{/if}

        </select>
        <input type="submit" class="input_button state_submit" name="serendipity[typeSubmit]" value="{$CONST.GO}">
        <input type="submit" class="input_button state_cancel" name="serendipity[typeDelete]" value="{$CONST.DELETE}">
        {if $sp_pagetype_submit}<input type="hidden" name="serendipity[typeSave]" value="true">{/if}
        {if $sp_pagetype_isshowform && !empty($sp_pagetype_showform)}

        <!-- sp_pagetype_showform start -->
        {$sp_pagetype_showform}
        <!-- sp_pagetype_showform end -->

        {/if}

    </div>
</div>

</form>

{elseif $switch_spcat == 'pageadd'}

<div id="staticpage_pageadd" class="sp_padd">

    {if $sp_addsubmit}
    <div class="msg_success"><span class="icon-ok"></span> {$CONST.DONE}! {$CONST.SETTINGS_SAVED_AT|sprintf:($smarty.now|@formatTime:'%H:%M:%S')}</div>
    {/if}

    <p>{$CONST.STATICPAGE_PAGEADD_DESC}</p>

    {if is_array($sp_pageadd_plugins)}

    <form action="serendipity_admin.php" method="post" name="serendipityPlugins">
        <div>
        <input type="hidden" name="serendipity[adminModule]" value="event_display">
        <input type="hidden" name="serendipity[adminAction]" value="staticpages">
        <input type="hidden" name="serendipity[staticpagecategory]" value="pageadd">
    {foreach $sp_pageadd_plugins as $plugin}

        <input class="input_checkbox" type="checkbox" name="serendipity[externalPlugins][]" value="{$plugin@key}"{if isset($sp_pageadd_insplugins[$plugin@key])} checked="checked"{/if}>{$plugin['name']}<br>
    {/foreach}

        <input type="submit" name="serendipity[typeSubmit]" class="input_button state_submit" value="{$CONST.GO}">
        </div>
    </form>

    {/if} {* is_array($sp_pageadd_plugins) end *}

    <fieldset class="sp_add">
        <legend>{$CONST.STATICPAGE_PAGEADD_PLUGINS}</legend>

        <table>
            <tr class="sp_thead">
                <th>{$CONST.EVENT_PLUGIN}</th>
                <th>{$CONST.STATICPAGE_STATUS}</th>
            </tr>

    {foreach $sp_pageadd_plugstats as $plugstats}

            <tr class="sp_t{cycle values="odd,even"}">
                <td>{$plugstats@key}</td>
                <td><span class="sp_t{$plugstats['color']|lower}">{$plugstats['status']}</span></td>
            </tr>

    {/foreach}

        </table>
    </fieldset>
</div>

{else} {** == 'pages' || 'pageedit' || default **}

    {if $sp_staticsubmit}
        {if !empty($sp_defpages_upd_result)}
<div class="msg_error"><span class="icon-error"></span> {$CONST.ERROR}: {$sp_defpages_upd_result}</div>
        {else}
<div class="msg_success"><span class="icon-ok"></span> {$CONST.DONE}! {$CONST.SETTINGS_SAVED_AT|sprintf:($smarty.now|@formatTime:'%H:%M:%S')}</div>
        {/if}
    {/if}

    {if $sp_staticdelete}
        {if isset($sp_defpages_rip_success)}
<div class="msg_success"><span class="icon-ok"></span> {$sp_defpages_rip_success}</div>
        {else}
<div class="msg_notice">
    <span class="icon-error"></span> {$CONST.IMPORT_NOTES}: {$CONST.STATICPAGE_CANNOTDELETE_MSG}
</div>
        {/if}
    {/if}

    {if !$sp_listentries_entries} {* show selectbox form header start, if showform is present, since we need to select entries quickly *}

<form action="serendipity_admin.php" method="post" name="serendipityEntry">
    <div>
        <input type="hidden" name="serendipity[adminModule]" value="event_display">
        <input type="hidden" name="serendipity[adminAction]" value="staticpages">
        <input type="hidden" name="serendipity[staticpagecategory]" value="pages">
    </div>

    {if isset($sp_cookie_value)}
    <script type="text/javascript">
        if (window.jQuery) { jQuery(function ($) { serendipity.SetCookie("backend_template", unescape("{$sp_cookie_value}")); }); } else { serendipity.SetCookie("backend_template", unescape("{$sp_cookie_value}")); } 
    </script>
    {/if}

    <div id="sp_navigator">
        <div class="sp_templateselector">
            <label for="sp_templateselector">{$CONST.STATICPAGE_TEMPLATE}</label>
            <select id="sp_templateselector" name="serendipity[backend_template]">
            {if isset($sp_defpages_top) && is_array($sp_defpages_top)}

                {foreach $sp_defpages_top as $templateform}{$templateform}{/foreach}
            {/if}
            </select>
        </div><!-- class sp_templateselector end -->

        <div class="sp_pageselector">
            <p class="sp_bold sp_top">{$CONST.STATICPAGE_SELECT}</p>
            <select id="staticpage_dropdown" name="serendipity[staticpage]">
                <option value="__new">{$CONST.NEW_ENTRY}</option>
                <option value="__new">-----------------</option>
            {if isset($sp_defpages_pop) && is_array($sp_defpages_pop)}

                {foreach $sp_defpages_pop as $selectpage}{$selectpage}{/foreach}
            {/if}
            </select>
        {if isset($smarty.post.serendipity['staticpagecategory']) || isset($smarty.get.serendipity['staticid'])}
            <script>var dropdown_dialog = "{$CONST.STATICPAGE_CONFIRM_SELECTDIALOG}";</script>
        {/if}
            <input class="input_button state_submit" type="submit" name="serendipity[staticSubmit]" value="{$CONST.GO}">
            <input class="input_button state_cancel" type="submit" name="serendipity[staticDelete]" onclick="return confirm('{$CONST.DELETE_SURE|sprintf:"{$sp_defpages_pop.selected_id} ({$sp_defpages_pop.selected_name|truncate:30})"}');" value="{$CONST.DELETE}">
            <input class="input_button entry_preview" type="submit" name="serendipity[staticPreview]" value="{$CONST.PREVIEW}">
        {if $sp_defpages_sbplav}
            <span class="icon-info-circled sp_right sp_info" title="Staticpage Sidebar {$CONST.STATICPAGE_PLUGIN_AVAILABLE}"></span>
        {/if}
        </div><!-- class sp_pageselector end -->

    {if isset($sp_defpages_link)}
        <script type="text/javascript">
            var staticpage_preview = window.open("{$sp_defpages_link}", "staticpage_preview");
            staticpage_preview.focus();
        </script>
        <div class="msg_notice"><span class="icon-info-circled"></span> {$CONST.PLUGIN_STATICPAGE_PREVIEW|sprintf:"<a href=\"$sp_defpages_link\">$sp_defpages_pagetitle</a>"}</div>
    {/if}
    </div><!-- //id sp_navigator end -->

    {/if}{* showform, but not not entrylist end *}
    {if false === $sp_defpages_showlist} {* SELECT LIST BAR start WE NEED === here, do not use plain ! *}

    {if $sp_defpages_staticsave}

    <div>
        <input type="hidden" name="serendipity[staticSave]" value="true">
    </div>

    <!-- sp_defpages_showform -->
    {$sp_defpages_showform}{** this might come already smartified (default form) or as hardcoded table row stuff (old form) **}

    {/if}{* sp_defpages_staticsave end *}

</form><!-- sp select form bar end -->

    {else} {* EBTRIES LIST by OPTION *}

    {if is_array($sp_listentries_entries)}

<h3>{$CONST.STATICPAGE_LIST_EXISTING_PAGES}</h3>

<div id="sp_entry_pagination"></div>

<div id="step">

{foreach $sp_listentries_entries as $entry}

    <div class="sp_entries_pane {cycle values="odd,even"}{if $entry@last} sp_close{/if}">
        <ul id="sp_entries_list" class="plainList{if $entry['parent_id'] > 0} sp_isChild{/if}">
            <li id="sple{$entry['id']}" class="clearfix">
                <h3>{if $entry['parent_id'] > 0}<span class="entry_status sp_ptree">#{$entry['parent_id']}</span><span class="icon-right-dir sp_ctree"></icon>{/if}{if empty($entry['headline'])}<span class="five">{$CONST.STATICPAGE_PAGETITLE}: </span>{/if}<a href="?serendipity[action]=admin&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pages&amp;serendipity[staticid]={$entry['id']}" title="#{$entry['id']}">{if !empty($entry['headline'])}{$entry['headline']|escape|truncate:50}{else}{$entry['pagetitle']}{/if}</a></h3>
                <div class="clearfix spmod">{$entry['timestamp']|@formatTime:'%Y-%m-%d'} {if $entry['timestamp'] <= ($entry['last_modified'] - 1800)}<span class="icon-clock" title="{$CONST.LAST_UPDATED}: {$entry['last_modified']|@formatTime:'%Y-%m-%d'}"></span>{/if}</div>
            </li>
            <li class="clearfix">
                {$CONST.POSTED_BY} {$sp_listentries_authors[$entry['authorid']]|escape} <span class="sp_dim">[<em class="sp_lang">{$entry['language']}</em>]</span>
                <div class="sp_entry_info clearfix spform">
                    {if $entry['publishstatus'] == false}<span class="entry_status sp_status_draft">{$CONST.DRAFT}</span>{/if}
                    {if $entry['parent_id'] > 0}<span class="entry_status sp_tree_child">{$CONST.STATICPAGE_TREE_CHILD} #{$entry['parent_id']}</span>{/if}

                    <a target="_blank" class="button_link" href="{$serendipityHTTPPath}{$serendipityIndexFile}?serendipity[staticid]={$entry['id']}&amp;serendipity[staticPreview]=1" title="{$CONST.VIEW} #{$entry['pagetitle']}"><span class="icon-search"></span><span class="visuallyhidden"> {$CONST.VIEW} #{$entry['pagetitle']}</span></a>
                    <form action="serendipity_admin.php" method="post" name="sp_listentry_{$entry['id']}">
                    <div>
                        <input type="hidden" name="serendipity[adminModule]" value="event_display">
                        <input type="hidden" name="serendipity[adminAction]" value="staticpages">
                        <input type="hidden" name="serendipity[staticpagecategory]" value="pages">
                        <input type="hidden" name="serendipity[staticpage]" value="{$entry['id']}">
                        <input type="hidden" name="serendipity[listentries_formSubmit]" value="true">{* necessary to open form on entrylist post submits *}
                        <input type="submit" name="serendipity[staticSubmit]" class="icon-edit sp-btn sp-btn-edit" value="&#xe803;" title="{$CONST.EDIT} #{$entry['pagetitle']}">
                        <input type="submit" name="serendipity[staticDelete]" class="icon-trash sp-btn sp-btn-purge" value="&#xe80d;" onclick="return confirm('{$CONST.DELETE_SURE|sprintf:$entry['pagetitle']}');" title="{$CONST.DELETE} #{$entry['pagetitle']}">
                    </div>
                    </form>
                </div>
            </li>
        </ul>
    </div>

{/foreach}

</div>

    {else} {* if !$sp_listentries_entries || empty($sp_listentries_entries) *}

<div class="msg_notice">
    <span class="icon-attention"></span> {$CONST.NO_ENTRIES_TO_PRINT}
</div>

    {/if} {* is_array($sp_listentries_entries) end *}

<div class="sp_listfooter">
    <form action="serendipity_admin.php" method="post" name="sp_ListFooter">
    <div>
        <input type="hidden" name="serendipity[adminModule]" value="event_display">
        <input type="hidden" name="serendipity[adminAction]" value="staticpages">
        <input type="hidden" name="serendipity[staticpagecategory]" value="pages">
        {$CONST.NEW_ENTRY} <em>{$CONST.WORD_OR|lower}</em> {$CONST.EDIT_ENTRY}: #<input class="input_textbox" type="text" size="3" name="serendipity[staticpage]">
        <input type="hidden" name="serendipity[listentries_formSubmit]" value="true">{* necessary to open form on entrylist post submits *}
        <input type="hidden" name="serendipity[pagetype]" value="__new">
        <input class="input_button state_submit" type="submit" name="serendipity[staticSubmit]" value="{$CONST.GO}">
    </div>
    </form>
</div>

    {/if} {* sp_defpages_showlist false/true end  *}
    {if $sp_pagetype_showform_isnuggets}

<!-- sp_pagetype_showform_isnuggets start -->
<script>
    {** NOTE: for the rare case, someone uses the full CKEDITOR package, including the toolbar CKE save button,
        we need to disable/remove the "save" button for static pages only, since it currently is not compatible with current staticpage form submits.
        Sorry! Do not re-active, or you may lose data, when used/click-saved! The code for this has moved to staticpage_backend.js **}

    function Spawnnugget() {
{foreach $sp_pagetype_showform_htmlnuggets as $htmlnuggetid}
        if (window.Spawnnuggets) Spawnnuggets('{$htmlnuggetid}');
{/foreach}
    }
</script>
<!-- sp_pagetype_showform_isnuggets end -->
    {/if} {* isnuggets end *}

{/if} {* switch end *}

<script src="{serendipity_getFile file="admin/js/jquery.autoscroll.js"}"></script>
<script src="{serendipity_getFile file="admin/js/jquery.sortable.js"}"></script>
<script src="{$serendipityHTTPPath}plugins/serendipity_event_staticpage/jquery.simplePagination.js"></script>
<script src="{$serendipityHTTPPath}plugins/serendipity_event_staticpage/staticpage_backend.js"></script>

<!-- backend_staticpage.tpl END -->

