{* backend_staticpage template file v. 1.6, 2014-05-06 *}
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
     {array $sp_defpages_top}
     {array $sp_defpages_pop}
     {bool $sp_defpages_sbplav}
     {string $sp_defpages_link}
     {string $sp_defpages_pagetitle}
     {bool $sp_defpages_staticsave}
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

<script src="{serendipity_getFile file="admin/js/jquery.autoscroll.js"}"></script>
<script src="{serendipity_getFile file="admin/js/jquery.sortable.js"}"></script>
<script>
    var SYHP = "{$serendipityHTTPPath}";
function save_new_order() {
    var a = [];
    $('#sequence').children().each(function (i) {
        a.push($(this).attr('id'));
    });
    var s = a.join(',');
    jQuery.ajax({
        url: SYHP+"serendipity_admin.php?serendipity[adminModule]=staticpages&serendipity[moveto]=move&serendipity[pagemoveorder]=" + s + "&serendipity[adminModule]=event_display&serendipity[adminAction]=staticpages&serendipity[staticpagecategory]=pageorder",
        context: document.body,
        success: function() {
            jQuery('#splistorder').html("<span class=\"icon-ok\"></span> New staticpage pageorder list "+s+" successfully saved");
            //console.log("new staticpage pageorder list "+s+" successfully saved");
        }
    });
}
$("document").ready(function() {
    if (! Modernizr.touch){
        function getDragdropConfiguration(group) {
            return {
                containerSelector: '.pluginmanager_container',
                group: group,
                handle: '.pluginmanager_grablet',

                onDrop: function ($item, container, _super) {
                    var placement = $item.parents('.pluginmanager_container').data("placement");
                    $item.find('select[name$="placement]"]').val(placement);
                    $item.removeClass("dragged").removeAttr("style");
                    $("body").removeClass("dragging");
                    save_new_order();
                    $.autoscroll.stop();
               },
                onDragStart: function ($item, container, _super) {
                    $.autoscroll.init();
                    $item.css({
                        height: $item.height(),
                        width: $item.width()
                    });
                    $item.addClass("dragged");
                    $("body").addClass("dragging");
                }
            }
        }
        $('.configuration_group .pluginmanager_container').sortable(getDragdropConfiguration('plugins_event'));
    }
});
</script>
<div id="sp_sequencer" class="configuration_group even">
    <fieldset class="sp_sequence">
        <legend>{$CONST.STATICPAGE_PAGEORDER_DESC}</legend>
        <input type="hidden" name="serendipity[plugin][sequence]" id="sequence_value" value="{foreach name=sp_seqvalue item=element from=$sp_pageorder_pages}{$element['pagetitle']}{if !$smarty.foreach.sp_seqvalue.last},{/if}{/foreach}">
        <noscript>
            <!-- Replace standard submit button when using up/down submits -->
            <input type="hidden" name="SAVECONF" value="Save">
        </noscript>

        <ol id="sequence" data-placement="sqid" class="sequence_container pluginmanager_container">
        {foreach name=sp_sequence item=sp_element from=$sp_pageorder_pages}
            <li id="{$sp_element['id']}" class="sequence_item pluginmanager_item_{cycle values="odd,even"}">{*  in normal situations id=$sp_element['pagetitle'], but we need id for js sequence mode *}
                <input type="hidden" name="serendipity[plugin][sequence][id]" id="sequence_id" value="{$sp_element['id']}">
                <div id="g{$sp_element['pagetitle']}" class="pluginmanager_grablet sequence_grablet">
                    <button class="icon_link" type="button" title="{$CONST.MOVE}"><span class="icon-move"></span><span class="visuallyhidden"> {$CONST.MOVE}</span></button>
                </div>
                <span class="sp_grablet_title">{$sp_element['pagetitle']}</span>
                <div class="sp_nojs">
                {if !$smarty.foreach.sp_sequence.first}

                    <span>
                        <noscript>
                        <a href="?serendipity[adminModule]=staticpages&amp;serendipity[moveto]=moveup&amp;serendipity[pagetomove]={$sp_element['id']}&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder" style="border: 0"><img src="{serendipity_getFile file='admin/img/uparrow.png'}" alt="{$CONST.UP}"></a>
                        </noscript>
                    </span>

                {/if}
                {if !$smarty.foreach.sp_sequence.last}

                    <span>
                        <noscript>
                        <a href="?serendipity[adminModule]=staticpages&amp;serendipity[moveto]=movedown&amp;serendipity[pagetomove]={$sp_element['id']}&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder" style="border: 0"><img src="{serendipity_getFile file='admin/img/downarrow.png'}" alt="{$CONST.DOWN}"></a>
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
    {foreach name=sp_pagetype item=type from=$sp_pagetype_types}
        <option value="{$type['id']}"{if $smarty.post.serendipity.pagetype == $type['id']} selected="selected"{/if}>{$type['description']|escape:'html'}</option>
    {/foreach}
{/if}

        </select>
        <input type="submit" class="input_button state_submit" name="serendipity[typeSubmit]" value="{$CONST.GO}"> <strong>-{$CONST.WORD_OR}-</strong>
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

    {foreach name=pageadd_plugins from=$sp_pageadd_plugins key=key item=plugin}

        <input class="input_checkbox" type="checkbox" name="serendipity[externalPlugins][]" value="{$key}"{if isset($sp_pageadd_insplugins[$key])} checked="checked"{/if}>{$plugin['name']}<br>

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

    {foreach from=$sp_pageadd_plugstats key=key item=value}

            <tr class="sp_t{cycle values="odd,even"}">
                <td>{$key}</td>
                <td><span class="sp_t{$value['color']|lower}">{$value['status']}</span></td>
            </tr>

    {/foreach}

        </table>
    </fieldeset>
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

    <div class="sp_templateselector">
        <label for="sp_templateselector">{$CONST.STATICPAGE_TEMPLATE}</label> 
        <select id="sp_templateselector" name="serendipity[backend_template]">
            {if isset($sp_defpages_top) && is_array($sp_defpages_top)}

                {foreach name=sp_sts item=top from=$sp_defpages_top}{$top}{/foreach}
            {/if}
        </select>
    </div><!-- class sp_templateselector end -->

    <div class="sp_pageselector">
        <p class="sp_bold sp_top">{$CONST.STATICPAGE_SELECT}</p>
        <select id="staticpage_dropdown" name="serendipity[staticpage]">
            <option value="__new">{$CONST.NEW_ENTRY}</option>
            <option value="__new">-----------------</option>
            {if isset($sp_defpages_pop) && is_array($sp_defpages_pop)}

                {foreach name=sp_sps item=pop from=$sp_defpages_pop}{$pop}{/foreach}
            {/if}
        </select>
        {if isset($smarty.post.serendipity['staticpagecategory']) || isset($smarty.get.serendipity['staticid'])}
        <script>
            var prev_value;
            $('#staticpage_dropdown').focus(function() {
                prev_value = $(this).val();
            }).change(function(){
                $(this).unbind('focus');
                if (!confirm("{$CONST.STATICPAGE_CONFIRM_SELECTDIALOG}")){
                    $(this).val(prev_value);
                    $(this).bind('focus');
                    return false;
                } else {
                    $(this.form.elements["serendipity[staticSubmit]"]).click();
                }
            });
        </script>
        {/if}
        <input class="input_button state_submit" type="submit" name="serendipity[staticSubmit]" value="{$CONST.GO}"> <strong>-{$CONST.WORD_OR}-</strong>
        <input class="input_button state_cancel" type="submit" name="serendipity[staticDelete]" onclick="return confirm('{$CONST.DELETE_SURE|sprintf:"document.getElementById('staticpage_dropdown').options[document.getElementById('staticpage_dropdown').selectedIndex].text"}');" value="{$CONST.DELETE}">
        <strong>-{$CONST.WORD_OR}-</strong> <input class="input_button entry_preview" type="submit" name="serendipity[staticPreview]" value="{$CONST.PREVIEW}">
        {if $sp_defpages_sbplav}
        <div class="sp_plav"><span class="icon-info-circled" title="Staticpage Sidebar {$CONST.STATICPAGE_PLUGIN_AVAILABLE}"></span></div>
        {/if}
    </div><!-- class sp_pageselector end -->

    {if isset($sp_defpages_link)}
    <script type="text/javascript">
        var staticpage_preview = window.open("{$sp_defpages_link}", "staticpage_preview");
        staticpage_preview.focus();
    </script>
    <div class="msg_notice"><span class="icon-info-circled"></span> {$CONST.PLUGIN_STATICPAGE_PREVIEW|sprintf:"<a href=\"$sp_defpages_link\">$sp_defpages_pagetitle</a>"}</div>
    {/if}

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

            {foreach name=sp_listentry item=entry from=$sp_listentries_entries}

<div class="sp_entries_pane {cycle values="odd,even"}{if $smarty.foreach.sp_listentry.last} sp_close{/if}">
    <ul id="sp_entries_list" class="plainList">
        <li id="sple{$entry['id']}" class="clearfix">
            <h3>{if empty($entry['headline'])}<span class="five">{$CONST.STATICPAGE_PAGETITLE}: </span>{/if}<a href="?serendipity[action]=admin&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pages&amp;serendipity[staticid]={$entry['id']}" title="#{$entry['id']}">{if !empty($entry['headline'])}{$entry['headline']|escape:'html'|truncate:50}{else}{$entry['pagetitle']}{/if}</a></h3>
            <div class="clearfix spmod">{$entry['timestamp']|@formatTime:'%Y-%m-%d'} {if $entry['timestamp'] <= ($entry['last_modified'] - (60*30))}{***}<span class="icon-clock" title="{$CONST.LAST_UPDATED}: {$entry['last_modified']|@formatTime:'%Y-%m-%d'}"></span>{/if}</div>
        </li>
        <li class="clearfix">
            {$CONST.POSTED_BY} {$sp_listentries_authors[$entry['authorid']]|escape:'html'}
            <div class="sp_entry_info clearfix spform">
                {if $entry['publishstatus'] == false}<span class="entry_status sp_status_draft">{$CONST.DRAFT}</span>{/if}
                <a target="_blank" class="button_link" href="{$serendipityHTTPPath}{$serendipityIndexFile}?serendipity[staticid]={$entry['id']}&amp;serendipity[staticPreview]=1" title="{$CONST.VIEW} #{$entry['pagetitle']}"><span class="icon-search"></span><span class="visuallyhidden"> {$CONST.VIEW} #{$entry['pagetitle']}</span></a>
                <form action="serendipity_admin.php" method="post" name="sp_listentry_{$entry['id']}">
                <div>
                    <input type="hidden" name="serendipity[adminModule]" value="event_display">
                    <input type="hidden" name="serendipity[adminAction]" value="staticpages">
                    <input type="hidden" name="serendipity[staticpagecategory]" value="pages">
                    <input type="hidden" name="serendipity[staticpage]" value="{$entry['id']}">
                    <input type="hidden" name="serendipity[listentries_formSubmit]" value="true">{* necessary to open form on entrylist post submits *}
                    <input type="submit" name="serendipity[staticSubmit]" class="icon-edit sp-btn sp-btn-edit" value="&#xe803;" titele="{$CONST.EDIT} #{$entry['pagetitle']}">
                    <input type="submit" name="serendipity[staticDelete]" class="icon-trash sp-btn sp-btn-purge" value="&#xe80d;" onclick="return confirm('{$CONST.DELETE_SURE|sprintf:$entry['pagetitle']}');" title="{$CONST.DELETE} #{$entry['pagetitle']}">
                </div>
                </form>
            </div>
        </li>
    </ul>
</div>

            {/foreach}

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
    {* for the rare case, someone uses the full CKEDITOR package, including the toolbar CKE save button, we need to disable/remove the save button for static pages only, since it is not compatible with staticpage form submits. - Sorry! Do not re-active, or you may lose data, when used/clicked! *}
    if (CKEDITOR.plugins.registered['save']) {
        // overwrite CKE save button in all nugget instances, see extending smarty note in backend_staticpage.tpl
        CKEDITOR.plugins.registered['save'] = {
            init: function (editor) {
                var command = editor.addCommand('save',
                {
                    modes: { wysiwyg: 1, source: 1 }
                });
            }
        }
    }

    setLocalStorage = (function(name, value) {
        var storage, fail, uid;
        try {
            uid = new Date;
            (storage = window.localStorage).setItem(uid, uid);
            fail = storage.getItem(uid) != uid;
            storage.removeItem(uid);
            fail && (storage = false);
        } catch(e) {}

        // Remove old items first
        localStorage.removeItem(name);

        // Put the string/array/object into storage
        localStorage.setItem(name, JSON.stringify(value));
    });

    Object.keys(localStorage).forEach(function(key) {
        if (/^(staticpage_mobileform_)|(staticpage_defaultform_)/.test(key)) {
            var k   = key.split('_');
            var $id = '#'+k[2];
            var $el = $id.replace('option','');
            if (localStorage.getItem(key) !== null) {
                $($id + ' > .icon-right-dir').removeClass('icon-right-dir').addClass('icon-down-dir');
                $($el).removeClass('additional_info');
            }
        }
    });

    function Spawnnugget() {
{foreach from=$sp_pagetype_showform_htmlnuggets name=hnid item=htmlnuggetid}
        if (window.Spawnnuggets) Spawnnuggets('{$htmlnuggetid}');
{/foreach}
    }
</script>
<!-- sp_pagetype_showform_isnuggets end -->
    {/if}

{/if} {* switch end *}

<!-- backend_staticpage.tpl END -->

