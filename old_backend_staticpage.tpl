{* backend show starpage remplate file v. 1.0, 2014-03-10 *}
{** moduled backend_show.php tpl vars

+++++ head +++++
{$s9y_get_cat}
{$s9y_post_cat}

+++++ switch +++++
{$switch_spcat}

+++++ pageorder +++++
{array $sp_pageorder_pages}

+++++ pagetype +++++
{bool $sp_pagetype_saveconf}
{bool $sp_pagetype_purged}
     {$sp_pagetype_ripped}
{bool $sp_pagetype_update}
     {$sp_pagetype_mixedresult}
{bool $sp_pagetype}
     {$sp_pagetype_types}
{bool $sp_pagetype_submit}
{bool $sp_pagetype_isshowform}
     {multiline string $sp_pagetype_showform}
{bool $sp_pagetype_showform_isnuggets}
     {array $sp_pagetype_showform_htmlnuggets}

+++++ pageadd +++++
{array $sp_pageadd_plugins}
{array $sp_pageadd_insplugins}
{array $sp_pageadd_plugstats}

+++++ pagwedit/pages/default +++++
{bool $sp_staticsubmit}
     {$sp_defpages_upd_result}
{bool $sp_staticdelete}
     {$sp_defpages_rip_success}

{bool $sp_defpages_showlist}
     {string $sp_defpages_jsCookie}
     {string $sp_defpages_template}
     {array $sp_defpages_top}
     {array $sp_defpages_pop}
     {bool $sp_defpages_sbplav}
     {string $sp_defpages_link}
     {string $sp_defpages_pagetitle}
     {bool $sp_defpages_staticsave}
          {bool $sp_defpages_oldform}
               {$sp_defpages_showform}

     {string $sp_listentries_authors}
     {array $sp_listentries_entries}

switch pcat if      pageorder
            elseif  pagetype
            elseif  pageadd
            else    pageedit/pages/default
                    if submit results
                    if rip results
                    if      sp_defpages_showlist false === select(able)
                    elseif  sp_defpages_showlist true  === entries(list)
                    else    no entries to print

**}

<!-- backend_staticpage.tpl START -->

{if !$new_backend}
<script type="text/javascript" src="{$serendipityHTTPPath}serendipity_define.js.php"></script>
<script type="text/javascript" src="{$serendipityHTTPPath}serendipity_editor.js"></script>
{/if}

<div id="serendipityStaticpagesNav">
    <ul>
        <li{if $s9y_get_cat == 'pageedit'} id="active"{/if}><a href="{$serendipityHTTPPath}serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageedit">{$CONST.STATICPAGE_CATEGORY_PAGES}</a></li>
        <li{if $s9y_get_cat == 'pageorder'} id="active"{/if}><a href="{$serendipityHTTPPath}serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder">{$CONST.STATICPAGE_CATEGORY_PAGEORDER}</a></li>
        <li{if $s9y_get_cat == 'pagetype' || $s9y_post_cat == 'pagetype'} id="active"{/if}><a href="{$serendipityHTTPPath}serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pagetype">{$CONST.STATICPAGE_CATEGORY_PAGETYPES}</a></li>
        <li{if $s9y_get_cat == 'pageadd'} id="active"{/if}><a href="{$serendipityHTTPPath}serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageadd">{$CONST.STATICPAGE_CATEGORY_PAGEADD}</a></li>
    </ul>
</div>

{if $switch_spcat == 'pageorder'}

<div id="splistorder" class="serendipityAdminMsgSuccess sp_msg_success"></div>

    {if is_array($sp_pageorder_pages)}

<script src="{serendipity_getFile file='dragdrop.js'}" type="text/javascript"></script>
<fieldset class="sp_sequence">
    <legend>{$CONST.STATICPAGE_PAGEORDER_DESC}</legend>
    <input type="hidden" name="serendipity[plugin][sequence]" id="sequence_value" value="{foreach name=sp_seqvalue item=element from=$sp_pageorder_pages}{$element['pagetitle']}{if !$smarty.foreach.sp_seqvalue.last},{/if}{/foreach}" />
    <noscript>
        <!-- Replace standard submit button when using up/down submits -->
        <input type="hidden" name="SAVECONF" value="Save" />
    </noscript>
    <ol id="sequence" class="sequence_container pluginmanager_container">
    {foreach name=sp_sequence item=sp_element from=$sp_pageorder_pages}
        <li id="{$sp_element['id']}" class="sequence_item pluginmanager_item_even">{*  in normal situations id=$sp_element['pagetitle'], but we need id for js sequence mode *}
            <input type="hidden" name="serendipity[plugin][sequence][id]" id="sequence_id" value="{$sp_element['id']}" />
            {if $new_backend}
            <div id="g{$sp_element['pagetitle']}" class="pluginmanager_grablet sequence_grablet">
                <button id="grabs{$sp_element['pagetitle']}" class="icon_link button_link" title="{$CONST.MOVE}" type="button">
                    <span class="icon-move"></span>
                    <span class="visuallyhidden"></span>
                </button>
            </div>
            {else}
            <div id="g{$sp_element['pagetitle']}" class="pluginmanager_grablet sequence_grablet"><a href="#"></a></div>
            {/if}
            <span{if $new_backend} style="margin: 0 auto auto 3em;"{/if}>{$sp_element['pagetitle']}</span>
            <div class="sp_nojs">
                {if !$smarty.foreach.sp_sequence.first}

                <span>
                    <noscript><a href="?serendipity[adminModule]=staticpages&amp;serendipity[moveto]=moveup&amp;serendipity[pagetomove]={$sp_element['id']}&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder" style="border: 0"></noscript>
                    <img src="{serendipity_getFile file='admin/img/uparrow.png'}" alt="{$CONST.UP}"><noscript></a></noscript>
                </span>

                {/if}
                {if !$smarty.foreach.sp_sequence.last}

                <span>
                    <noscript><a href="?serendipity[adminModule]=staticpages&amp;serendipity[moveto]=movedown&amp;serendipity[pagetomove]={$sp_element['id']}&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder" style="border: 0"></noscript>
                    <img src="{serendipity_getFile file='admin/img/downarrow.png'}" alt="{$CONST.DOWN}"><noscript></a></noscript>
                </span>

                {/if}
            </div>
        </li>
    {/foreach}
    </ol>
</fieldset>
<script type="text/javascript">
    var SYHP = "{$serendipityHTTPPath}";
{literal}
    jQuery.ajaxSetup({
        error: handleXhrError
    });

    function handleXhrError(xhr) {
        document.open();
        document.write(xhr.responseText);
        document.close();
    }

    function sort_sequence_Sequence() {
        var seq = DragDrop.serData(null, 'sequence');
        var start = seq.indexOf("(");
        var end = seq.indexOf(")");
        seq = seq.slice((start + 1), end);
        checkable_seq = seq.split(",");
        out_seq = '';
        for (i in checkable_seq) {
            if (out_seq != '') {
                out_seq += ',';
            }
            out_seq += checkable_seq[i];
        }
        var dropid = document.getElementById("sequence_id")
        var order  = document.getElementById("sequence_value")
        order.value = out_seq;
        /** debug
        console.log(order.value); // the new list order
        console.log(dropid.value); // the dropped id
        **/

        jQuery.ajax({
            url: SYHP+"serendipity_admin.php?serendipity[adminModule]=staticpages&serendipity[moveto]=move&serendipity[pagemoveorder]=" + order.value + "&serendipity[adminModule]=event_display&serendipity[adminAction]=staticpages&serendipity[staticpagecategory]=pageorder",
            context: document.body,
            success: function() {
                jQuery('#splistorder').html("<span class=\"icon-ok-circle\"></span> New staticpage pageorder list "+order.value+" successfully saved");
                console.log("new staticpage pageorder list "+order.value+" successfully saved");
            }
        });
    }

    function init_sequence_Sequence()
    {
        var lst = document.getElementById("sequence");
        DragDrop.makeListContainer(lst, 'sequence_group');
        lst.onDragOut = function() {
            sort_sequence_Sequence();
        };
    }

    /*addLoadEvent(init_sequence_Sequence);*/
    if (window.jQuery) { jQuery(function ($) { init_sequence_Sequence(); }); } else { addLoadEvent(init_sequence_Sequence); } 
{/literal}
</script>
    {else}

    <p class="sp_bold">{$CONST.STATICPAGE_PAGEORDER_DESC}</p>

    {/if} {* is_array($sp_pageorder_pages) end *}

{elseif $switch_spcat == 'pagetype'}

    {if $sp_pagetype_saveconf}
<div class="serendipityAdminMsgSuccess msg_success"><span class="icon-ok"></span> {$CONST.DONE}! {$CONST.SETTINGS_SAVED_AT|sprintf:($smarty.now|@formatTime:'%H:%M:%S')}</div>
    {/if}

    {if $sp_pagetype_purged}
<div class="serendipityAdminMsgSuccess msg_success"><span class="icon-ok"></span> {$CONST.DONE}! {$CONST.RIP_ENTRY|sprintf:$sp_pagetype_ripped}</div>
    {/if}

    {if $sp_pagetype_update}
<div class="serendipityAdminMsgError msg_error"><span class="icon-error"></span> {$CONST.ERROR}: {$sp_pagetype_mixedresult}</div>
    {/if}

<form action="serendipity_admin.php" method="post" name="serendipityEntry">
<div>
    <input type="hidden" name="serendipity[adminModule]" value="event_display" />
    <input type="hidden" name="serendipity[adminAction]" value="staticpages" />
    <input type="hidden" name="serendipity[staticpagecategory]" value="pagetype" />
    <div>
        <p class="sp_bold">{$CONST.PAGETYPES_SELECT}</p>
        <select name="serendipity[pagetype]">
            <option value="__new">{$CONST.NEW_ENTRY}</option>
            <option value="__new">-----------------</option>
{if $sp_pagetype && is_array($sp_pagetype_types)}
    {foreach name=sp_pagetype item=type from=$sp_pagetype_types}
        <option value="{$type['id']}"{if $smarty.post.serendipity.pagetype == $type['id']} selected="selected"{/if}>{$type['description']|escape:'html'}</option>
    {/foreach}
{/if}

        </select>
        <input type="submit" class="serendipityPrettyButton input_button" name="serendipity[typeSubmit]" value="{$CONST.GO}" /> <strong>-{$CONST.WORD_OR}-</strong> 
        <input type="submit" class="serendipityPrettyButton input_button" name="serendipity[typeDelete]" value="{$CONST.DELETE}" />
        {if $sp_pagetype_submit}<input type="hidden" name="serendipity[typeSave]" value="true" />{/if}
        {if $sp_pagetype_isshowform && !empty($sp_pagetype_showform)}

        <!-- sp_pagetype_showform start -->
        {$sp_pagetype_showform}
        <!-- sp_pagetype_showform end -->
        {/if}

    </div>
</div>

</form>

{elseif $switch_spcat == 'pageadd'}

    {if $sp_addsubmit}
<div class="serendipityAdminMsgSuccess msg_success"><span class="icon-ok"></span> {$CONST.DONE}! {$CONST.SETTINGS_SAVED_AT|sprintf:($smarty.now|@formatTime:'%H:%M:%S')}</div>
    {/if}

<p class="sp_bold">{$CONST.STATICPAGE_PAGEADD_DESC}</p>

    {if is_array($sp_pageadd_plugins)}

<form action="serendipity_admin.php" method="post" name="serendipityPlugins">
    <div>
    <input type="hidden" name="serendipity[adminModule]" value="event_display" />
    <input type="hidden" name="serendipity[adminAction]" value="staticpages" />
    <input type="hidden" name="serendipity[staticpagecategory]" value="pageadd" />

    {foreach name=pageadd_plugins from=$sp_pageadd_plugins key=key item=plugin}

    <input class="input_checkbox" type="checkbox" name="serendipity[externalPlugins][]" value="{$key}"{if isset($sp_pageadd_insplugins[$key])} checked="checked"{/if} />{$plugin['name']}<br />

    {/foreach}

    <input type="submit" name="serendipity[typeSubmit]" class="serendipityPrettyButton input_button" value="{$CONST.GO}" />
    </div>
</form>

    {/if} {* is_array($sp_pageadd_plugins) end *}

<fieldset class="sp_add">
    <legend>{$CONST.STATICPAGE_PAGEADD_PLUGINS}</legend>

<table>
    <tr id="serendipityStaticpagesTableHeader">
        <th>{$CONST.EVENT_PLUGIN}</th>
        <th>{$CONST.STATICPAGE_STATUS}</th>
    </tr>

    {foreach name=pageadd_pstats from=$sp_pageadd_plugstats key=key item=value}

    <tr id="serendipityStaticpagesTable{$smarty.foreach.pageadd_pstats.index % 2}">
        <td>{$key}</td>
        <td><span id="serendipityStaticpages{$value['color']}">{$value['status']}</span></td>
    </tr>

    {/foreach}
</table>
</fieldeset>

{else} {** == 'pages' || 'pageedit' || default **}

    {if $sp_staticsubmit}
        {if !empty($sp_defpages_upd_result)}
<div class="serendipityAdminMsgError msg_error"><span class="icon-error"></span> {$CONST.ERROR}: {$sp_defpages_upd_result}</div>
        {else}
<div class="serendipityAdminMsgSuccess msg_success"><span class="icon-ok"></span> {$CONST.DONE}! {$CONST.SETTINGS_SAVED_AT|sprintf:($smarty.now|@formatTime:'%H:%M:%S')}</div>
        {/if}
    {/if}

    {if $sp_staticdelete}
        {if isset($sp_defpages_rip_success)}
<div class="serendipityAdminMsgSuccess msg_success"><span class="icon-ok"></span> {$sp_defpages_rip_success}</div>
        {else}
<div class="serendipityAdminMsgNote msg_notice">
    <span class="icon-error"></span> {$CONST.IMPORT_NOTES}: {$CONST.STATICPAGE_CANNOTDELETE_MSG}
</div>
        {/if}
    {/if}

    {if !$sp_listentries_entries} {* show selectbox form header start, if showform is present, since we need to select entries quickly *}

<form action="serendipity_admin.php" method="post" name="serendipityEntry">
    <div>
        <input type="hidden" name="serendipity[adminModule]" value="event_display" />
        <input type="hidden" name="serendipity[adminAction]" value="staticpages" />
        <input type="hidden" name="serendipity[staticpagecategory]" value="pages" />
    </div>

    {if isset($sp_cookie_value)}
    <script type="text/javascript">
        {if $new_backend}
        if (window.jQuery) { jQuery(function ($) { serendipity.SetCookie("backend_template", unescape("{$sp_cookie_value}")); }); } else { serendipity.SetCookie("backend_template", unescape("{$sp_cookie_value}")); } 
        {else}
        if (window.jQuery) { jQuery(function ($) { SetCookie("backend_template", unescape("{$sp_cookie_value}")); }); } else { SetCookie("backend_template", unescape("{$sp_cookie_value}")); } 
        {/if}
    </script>
    {/if}

    <div class="sp_templateselector">
        <label for="sp_templateselector">{$CONST.STATICPAGE_TEMPLATE}</label> 
        <select id="sp_templateselector" name="serendipity[backend_template]">
            <option{if $sp_defpages_template == 'external'} selected="selected"{/if} value="external">{$CONST.STATICPAGE_TEMPLATE_EXTERNAL}</option>
            <option{if $sp_defpages_template == 'internal'} selected="selected"{/if} value="internal">{$CONST.STATICPAGE_TEMPLATE_INTERNAL}</option>
            {if isset($sp_defpages_top) && is_array($sp_defpages_top)}

                {foreach name=sp_sts item=top from=$sp_defpages_top}{$top}{/foreach}
            {/if}
        </select>
    </div><!-- class sp_templateselector end -->

    <div class="sp_pageselector">
        <p class="sp_bold sp_top">{$CONST.STATICPAGE_SELECT}</p>
        <select name="serendipity[staticpage]" id="staticpage_dropdown">
            <option value="__new">{$CONST.NEW_ENTRY}</option>
            <option value="__new">-----------------</option>
            {if isset($sp_defpages_pop) && is_array($sp_defpages_pop)}

                {foreach name=sp_sps item=pop from=$sp_defpages_pop}{$pop}{/foreach}
            {/if}
        </select>
        <input class="serendipityPrettyButton input_button" type="submit" name="serendipity[staticSubmit]" value="{$CONST.GO}" /> <strong>-{$CONST.WORD_OR}-</strong>
        <input type="submit" name="serendipity[staticDelete]" onclick="return confirm('{$CONST.DELETE_SURE|sprintf:"document.getElementById('staticpage_dropdown').options[document.getElementById('staticpage_dropdown').selectedIndex].text"}');" class="serendipityPrettyButton input_button" value="{$CONST.DELETE}" />
        <strong>-{$CONST.WORD_OR}-</strong> <input class="serendipityPrettyButton input_button" type="submit" name="serendipity[staticPreview]" value="{$CONST.PREVIEW}" />
        {if $sp_defpages_sbplav}
        <div class="sp_plav">
            <img class="attention" title="Staticpage Sidebar {$CONST.STATICPAGE_PLUGIN_AVAILABLE}" src="{serendipity_getFile file='admin/img/admin_msg_note.png'}" alt="info" />
        </div>
        {/if}
    </div><!-- class sp_pageselector end -->

    {if isset($sp_defpages_link)}
    <script type="text/javascript">
        var staticpage_preview = window.open("{$sp_defpages_link}", "staticpage_preview");
        staticpage_preview.focus();
    </script>
        {if $new_backend}
    <div class="serendipityAdminMsgNotice msg_notice"><span class="icon-info-circled"></span> {$CONST.PLUGIN_STATICPAGE_PREVIEW|sprintf:"<a href=\"$sp_defpages_link\">$sp_defpages_pagetitle</a>"}</div>
        {else}
    <p>{$CONST.PLUGIN_STATICPAGE_PREVIEW|sprintf:"<a href=\"$sp_defpages_link\">$sp_defpages_pagetitle</a>"}</p>
        {/if}
    {/if}

    {/if}{* showform, but not not entrylist end *}
    {if false === $sp_defpages_showlist} {* SELECT LIST BAR start WE NEED === here, do not use plain ! *}

    {if $sp_defpages_staticsave}

    <div>
        <input type="hidden" name="serendipity[staticSave]" value="true" />
    </div>

    {**
     - In case of $sp_defpages_oldform == the 'All Fields' Form, the rows are build by internal hardcoded markup, which is based to sent $serendipity['POST']['backend_template'] == 'internal'.
     - The "simple" form is the better, newer and default form and internally build as an already smartified form by backend_templates/default_staticpage_backend.tpl.
     - It is possible to just disable Smarty usage by "if 'internal' $is_smarty = false" on top of backend_show.php file, to skip this template at all.
     **}

    {if $sp_defpages_oldform}
    <!-- internal inspectConfig() allField form markup -->
    <br /><hr />
    <table border="0" cellspacing="0" cellpadding="3" width="100%">

    {/if}

    <!-- sp_defpages_showform -->
    {$sp_defpages_showform}{** this might come already smartified (default form) or as hardcoded table row stuff (old form) **}

    {if $sp_defpages_oldform}

    </table>
    <br />
    <div style="padding-left: 20px">
        <input type="submit" name="serendipity[SAVECONF]" value="Speichern" class="serendipityPrettyButton input_button" />
    </div>

    {/if}

    {/if}{* sp_defpages_staticsave end *}

</form><!-- sp select form bar end -->

    {else} {* EBTRIES LIST by OPTION *}

        {if is_array($sp_listentries_entries)}

<h3>{$CONST.STATICPAGE_LIST_EXISTING_PAGES}</h3>

            {foreach name=sp_listentry item=entry from=$sp_listentries_entries}

<div class="sp_entries_pane">
    <ul id="sp_entries_list" class="plainList serendipity_admin_list_item serendipity_admin_list_item_{if $smarty.foreach.sp_listentry.iteration % 2}even{else}uneven{/if}">
        <li id="sple{$entry['id']}" class="clearfix">
            <h3>{if $entry['publishstatus'] == false}{$CONST.DRAFT}: {/if}{if empty($entry['headline'])}<span class="five">{$CONST.STATICPAGE_PAGETITLE}: </span>{/if}<a href="?serendipity[action]=admin&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pages&amp;serendipity[staticid]={$entry['id']}" title="#{$entry['id']}">{if !empty($entry['headline'])}{$entry['headline']|escape:'html'|truncate:50}{else}{$entry['pagetitle']}{/if}</a></h3>
            <div class="clearfix spmod">{$entry['timestamp']|@formatTime:'%Y-%m-%d'} {if $entry['timestamp'] <= ($entry['last_modified'] - (60*30))}{***}<span class="icon-clock" title="{$CONST.LAST_UPDATED}: {$entry['last_modified']|@formatTime:'%Y-%m-%d'}"></span>{/if}</div>
        </li>
        <li class="clearfix">
            {$CONST.POSTED_BY} {$sp_listentries_authors[$entry['authorid']]|escape:'html'}
            <div class="sp_entry_info clearfix spform">
                <a target="_blank" href="{$serendipityHTTPPath}{$serendipityIndexFile}?serendipity[staticid]={$entry['id']}&amp;serendipity[staticPreview]=1" title="{$CONST.VIEW} #{$entry['pagetitle']}" class="serendipityIconLink"><img src="{serendipity_getFile file='admin/img/zoom.png'}" alt="{$CONST.VIEW} #{$entry['pagetitle']}" /></a>
                <form action="serendipity_admin.php" method="post" name="sp_listentry_{$entry['id']}">
                <div>
                    <input type="hidden" name="serendipity[adminModule]" value="event_display" />
                    <input type="hidden" name="serendipity[adminAction]" value="staticpages" />
                    <input type="hidden" name="serendipity[staticpagecategory]" value="pages" />
                    <input type="hidden" name="serendipity[staticpage]" value="{$entry['id']}" />
                    <input type="hidden" name="serendipity[listentries_formSubmit]" value="true" />{* necessary to open form on entrylist post submits *}
                    <input type="image" name="serendipity[staticSubmit]" src="{serendipity_getFile file='admin/img/edit.png'}" class="spleim" title="{$CONST.EDIT} #{$entry['pagetitle']}" />
                    <input type="image" name="serendipity[staticDelete]" src="{serendipity_getFile file='admin/img/delete.png'}" onclick="return confirm('{$CONST.DELETE_SURE|sprintf:$entry['pagetitle']}');" title="{$CONST.DELETE} #{$entry['pagetitle']}" />
                </div>
                </form>
            </div>
        </li>
    </ul>
</div>

            {/foreach}

<div class="sp_listfooter">
    <form action="serendipity_admin.php" method="post" name="sp_ListFooter">
    <div>
        <input type="hidden" name="serendipity[adminModule]" value="event_display" />
        <input type="hidden" name="serendipity[adminAction]" value="staticpages" />
        <input type="hidden" name="serendipity[staticpagecategory]" value="pages" />
        {$CONST.NEW_ENTRY} <em>{$CONST.WORD_OR|lower}</em> {$CONST.EDIT_ENTRY}: #<input class="input_textbox" type="text" size="3" name="serendipity[staticpage]" /> 
        <input type="hidden" name="serendipity[listentries_formSubmit]" value="true" />{* necessary to open form on entrylist post submits *}
        <input type="hidden" name="serendipity[pagetype]" value="__new" />
        <input class="serendipityPrettyButton input_button" type="submit" name="serendipity[staticSubmit]" value="{$CONST.GO}" />
    </div>
    </form>
</div>

        {else} {* if !$sp_listentries_entries || empty($sp_listentries_entries) *}

<div class="serendipityAdminMsgNote msg_notice">
    <span class="icon-attention"></span> {$CONST.NO_ENTRIES_TO_PRINT}
</div>

        {/if} {* is_array($sp_listentries_entries) end *}

    {/if} {* sp_defpages_showlist false/true end  *}
    {if $sp_pagetype_showform_isnuggets}

{if $new_backend}
<script src="{serendipity_getFile file='admin/js/jquery.magnific-popup.js'}"></script>
{/if}

<!-- sp_pagetype_showform_isnuggets start -->
<script type="text/javascript">
    function Spawnnugget() {ldelim}
{foreach from=$sp_pagetype_showform_htmlnuggets name=hnid item=htmlnuggetid}
        if (window.Spawnnuggets) Spawnnuggets('{$htmlnuggetid}');
{/foreach}
    {rdelim}
</script>
<!-- sp_pagetype_showform_isnuggets end -->
    {/if}

{/if} {* switch end *}

<!-- backend_staticpage.tpl END -->
