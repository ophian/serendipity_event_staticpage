
<!-- RESPONSIVE_TEMPLATE.TPL start -->
{if !$new_backend}
<script type="text/javascript">
    var img_plus  = '{serendipity_getFile file="img/plus.png"}';
    var img_minus = '{serendipity_getFile file="img/minus.png"}';
    var state     = '';
{literal}
    function showConfig(id) {
        if (document.getElementById) {
            el = document.getElementById(id);
            if (el.style.display == 'none') {
                document.getElementById('option' + id).src = img_minus;
                el.style.display = '';
            } else {
                document.getElementById('option' + id).src = img_plus;
                el.style.display = 'none';
            }
        }
    }

    function showConfigAll(count) {
        if (document.getElementById) {
            for (i = 1; i <= count; i++) {
                document.getElementById('el' + i).style.display = state;
                document.getElementById('optionel' + i).src = (state == '' ? img_minus : img_plus);
            }

            if (state == '') {
                document.getElementById('optionall').src = img_minus;
                state = 'none';
            } else {
                document.getElementById('optionall').src = img_plus;
                state = '';
            }
        }
    }
{/literal}
</script>
{/if}

<div id="backend_sp_respond" class="default_staticpage">

    <fieldset id="sp_main_data" class="sect_basic">
        <legend>{$CONST.STATICPAGE_SECTION_BASIC}</legend>
        <span class="sp_legend_submit"><input type="submit" name="serendipity[SAVECONF]" value="{$CONST.SAVE}" class="serendipityPrettyButton input_button state_submit"{if !$new_backend} /{/if}></span>
        <div id="entry_main_headline" class="form_field_long sp_sect">
            <label class="sp_label" title="{staticpage_input item="headline" what="desc"}">{staticpage_input item="headline" what="name"}</label>
                {staticpage_input item="headline"}
        </div>

        <div id="entry_main_aftitle" class="form_field_long sp_sect">
            <label class="sp_label" title="{staticpage_input item="articleformattitle" what="desc"}">{staticpage_input item="articleformattitle" what="name"}</label>
                {staticpage_input item="articleformattitle"}
        </div>

        <div id="entry_main_data">
            <div id="entry_meta_urltitle" class="form_field sp_sect">
                <label class="sp_label" title="{staticpage_input item="pagetitle" what="desc"}">{staticpage_input item="pagetitle" what="name"}</label>
                    {staticpage_input item="pagetitle"}
            </div>

            <div id="entry_meta_permalink" class="form_field sp_sect">
                <label class="sp_label" title="{staticpage_input item="permalink" what="desc"}">{staticpage_input item="permalink" what="name"}</label>
                    {staticpage_input item="permalink"}
            </div>
        </div>

        <div class="clearfix sp_sect"></div>

        <div id="entry_main_content" class="sp_sect">
            <label class="sp_label" title="{staticpage_input item="content" what="desc"}">{staticpage_input item="content" what="name"}</label>
                {staticpage_input item="content"}
        </div>

    </fieldset>

    {if $showmeta}
    <div class="sp_sect configuration_group">
        {if $new_backend}
        <h3 class="toggle_headline"><button id="optionel1" class="toggle_info show_config_option sp_toggle" type="button" data-href="#el1" title="{$CONST.STATICPAGE_TOGGLEANDSAVE|sprintf:$CONST.TOGGLE_OPTION}"><span class="icon-right-dir"></span> {$CONST.STATICPAGES_CUSTOM_META_SHOW}</button></h3>
        {else}
        <p id="sp_toggle_optionall"><a href="#" onClick="showConfig('el1'); return false" title="{$CONST.STATICPAGE_TOGGLEANDSAVE|sprintf:$CONST.TOGGLE_OPTION}"><img src="{serendipity_getFile file="img/plus.png"}" id="optionel1" alt="+/-" border="0">&nbsp;{$CONST.STATICPAGES_CUSTOM_META_SHOW}</a></p>
        {/if}
    </div>

    <div id="el1"{if $new_backend} class="config_optiongroup additional_info"{/if}>

        <fieldset id="sp_metafield_data" class="sect_struct">
            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="title_element" what="desc"}">{staticpage_input item="title_element" what="name"}</label>
                    {staticpage_input item="title_element"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="meta_description" what="desc"}">{staticpage_input item="meta_description" what="name"}</label>
                    {staticpage_input item="meta_description"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="meta_keywords" what="desc"}">{staticpage_input item="meta_keywords" what="name"}</label>
                    {staticpage_input item="meta_keywords"}
            </div>
        </fieldset>
    </div>
    {if !$new_backend}<script type="text/javascript">document.getElementById("el1").style.display = "none";</script>{/if}
    {/if}

    <div class="sp_sect configuration_group">
    {if !$is_wysiwyg}{* $is_wysiwyg means old xinha or others than CKE! *}
        {if $new_backend}
        <h3 class="toggle_headline"><button id="optionel2" class="toggle_info show_config_option sp_toggle" type="button" data-href="#el2" title="{$CONST.STATICPAGE_TOGGLEANDSAVE|sprintf:$CONST.TOGGLE_OPTION}"><span class="icon-right-dir"></span> {$CONST.STATICPAGES_CUSTOM_STRUCTURE_SHOW}</button></h3>
        {else}
        <p id="sp_toggle_optionall"><a href="#" onClick="showConfig('el2'); return false" title="{$CONST.STATICPAGE_TOGGLEANDSAVE|sprintf:$CONST.TOGGLE_OPTION}"><img src="{serendipity_getFile file="img/plus.png"}" id="optionel2" alt="+/-" border="0">&nbsp;{$CONST.STATICPAGES_CUSTOM_STRUCTURE_SHOW}</a></p>
        {/if}
    {/if}
    </div>

    <div id="el2"{if $new_backend} class="config_optiongroup additional_info"{/if}>

        <fieldset id="sp_structure_data" class="clearfix sect_struct">
        <legend>{$CONST.STATICPAGE_SECTION_STRUCT}</legend>
            <div id="entry_struc_name" class="form_field sp_sect">{* S1 *}
                <label class="sp_label" title="{staticpage_input item="authorid" what="desc"}">{staticpage_input item="authorid" what="name"}</label>
                    {staticpage_input item="authorid"}
            </div>

            <div id="entry_struc_desc" class="form_field sp_sect">{* S2 *}
                <label class="sp_articletype" title="{staticpage_input item="articletype" what="desc"}">{staticpage_input item="articletype" what="name"}</label>
                    {staticpage_input item="articletype"}
            </div>

            <div id="entry_struc_lang" class="form_field sp_sect">{* S3 *}
                <label class="sp_label" title="{staticpage_input item="language" what="desc"}">{staticpage_input item="language" what="name"}</label>
                    {staticpage_input item="language"}
            </div>

            <div id="entry_struc_date" class="form_field sp_sect">{* O2 *}
                <label class="sp_label" title="{staticpage_input item="timestamp" what="desc"}">{staticpage_input item="timestamp" what="name"}</label>
                    {staticpage_input item="timestamp"}
            </div>

            <div id="entry_struc_password" class="form_field sp_sect">{* O8 *}
                <label class="sp_label" title="{staticpage_input item="pass" what="desc"}">{staticpage_input item="pass" what="name"}</label>
                    {staticpage_input item="pass"}
            </div>

            <div id="entry_struc_cat" class="form_field sp_sect">{* S4 *}
                <label class="sp_label" title="{staticpage_input item="related_category_id" what="desc"}">{staticpage_input item="related_category_id" what="name"}</label>
                    {staticpage_input item="related_category_id"}
            </div>

            <div id="entry_struc_format" class="form_field form_radio sp_sect">{* O6 *}
                <label class="sp_label" title="{staticpage_input item="markup" what="desc"}">{staticpage_input item="markup" what="name"}</label>
                    {staticpage_input item="markup"}
            </div>

            <div id="entry_struc_article" class="form_field form_radio sp_sect">{* O7 *}
                <label class="sp_label" title="{staticpage_input item="articleformat" what="desc"}">{staticpage_input item="articleformat" what="name"}</label>
                    {staticpage_input item="articleformat"}
            </div>

            <div id="entry_struc_precon" class="form_area sp_sect">{* S9 *}
                <label class="sp_label" title="{staticpage_input item="pre_content" what="desc"}">{staticpage_input item="pre_content" what="name"}</label>
                    {staticpage_input item="pre_content"}
            </div>
        </fieldset>

    </div>

    {if !$new_backend && !$is_wysiwyg}<script type="text/javascript">document.getElementById("el2").style.display = "none";</script>{/if}

    <div class="sp_sect configuration_group">
        {if $new_backend}
        <h3 class="toggle_headline"><button id="optionel3" class="toggle_info show_config_option sp_toggle" type="button" data-href="#el3" title="{$CONST.STATICPAGE_TOGGLEANDSAVE|sprintf:$CONST.TOGGLE_OPTION}"><span class="icon-right-dir"></span> {$CONST.STATICPAGES_CUSTOM_OPTION_SHOW}</button></h3>
        {else}
        <p id="sp_toggle_optionall"><a href="#" onClick="showConfig('el3'); return false" title="{$CONST.STATICPAGE_TOGGLEANDSAVE|sprintf:$CONST.TOGGLE_OPTION}"><img src="{serendipity_getFile file="img/plus.png"}" id="optionel3" alt="+/-" border="0">&nbsp;{$CONST.STATICPAGES_CUSTOM_OPTION_SHOW}</a></p>
        {/if}
    </div>

    <div id="el3"{if $new_backend} class="config_optiongroup additional_info"{/if}>

        <fieldset id="sp_option_data" class="clearfix sect_opt">
            <legend>{$CONST.STATICPAGE_SECTION_OPT}</legend>
            <div id="entry_option_start" class="form_field form_radio sp_sect">{* O3 *}
                <label class="sp_label" title="{staticpage_input item="is_startpage" what="desc"}">{staticpage_input item="is_startpage" what="name"}</label>
                    {staticpage_input item="is_startpage"}
            </div>

            <div id="entry_option_404" class="form_field form_radio sp_sect">{* O4 *}
                <label class="sp_label" title="{staticpage_input item="is_404_page" what="desc"}">{staticpage_input item="is_404_page" what="name"}</label>
                    {staticpage_input item="is_404_page"}
            </div>

            <div id="entry_option_status" class="form_field sp_sect">{* O1 *}
                <label class="sp_label" title="{staticpage_input item="publishstatus" what="desc"}">{staticpage_input item="publishstatus" what="name"}</label>
                    {staticpage_input item="publishstatus"}
            </div>

            <div id="entry_option_nav" class="form_field form_radio sp_sect">{* O5 *}
                <label class="sp_label" title="{staticpage_input item="showonnavi" what="desc"}">{staticpage_input item="showonnavi" what="name"}</label>
                    {staticpage_input item="showonnavi"}
            </div>

            <div id="entry_option_nav" class="form_field form_radio sp_sect">{* S7 *}
                <label class="sp_label" title="{staticpage_input item="shownavi" what="desc"}">{staticpage_input item="shownavi" what="name"}</label>
                    {staticpage_input item="shownavi"}
            </div>

            <div id="entry_option_bcrump" class="form_field form_radio sp_sect">{* S8 *}
                <label class="sp_label" title="{staticpage_input item="show_breadcrumb" what="desc"}">{staticpage_input item="show_breadcrumb" what="name"}</label>
                    {staticpage_input item="show_breadcrumb"}
            </div>

            <div id="entry_option_parent" class="form_field sp_sect">{* S5 *}
                <label class="sp_label" title="{staticpage_input item="parent_id" what="desc"}">{staticpage_input item="parent_id" what="name"}</label>
                    {staticpage_input item="parent_id"}
            </div>

            <div id="entry_option_child" class="form_field form_radio sp_sect">{* S6 *}
                <label class="sp_label" title="{staticpage_input item="show_childpages" what="desc"}">{staticpage_input item="show_childpages" what="name"}</label>
                    {staticpage_input item="show_childpages"}
            </div>
        </fieldset>

    </div>

    {if !$new_backend && !$is_wysiwyg}<script type="text/javascript">document.getElementById("el3").style.display = "none";</script>{/if}

    <div class="sp_sect configuration_group">
        {if $new_backend}
        <h3 class="toggle_headline"><button id="optionel4" class="toggle_info show_config_option sp_toggle" type="button" data-href="#el4" title="{$CONST.STATICPAGE_TOGGLEANDSAVE|sprintf:$CONST.TOGGLE_OPTION}"><span class="icon-right-dir"></span> {$CONST.STATICPAGES_CUSTOMEXAMPLE_OPTION_SHOW}</button></h3>
        {else}
        <p id="sp_toggle_optionall"><a href="#" onClick="showConfig('el4'); return false" title="{$CONST.STATICPAGE_TOGGLEANDSAVE|sprintf:$CONST.TOGGLE_OPTION}"><img src="{serendipity_getFile file="img/plus.png"}" id="optionel4" alt="+/-" border="0">&nbsp;{$CONST.STATICPAGES_CUSTOMEXAMPLE_OPTION_SHOW}</a></p>
        {/if}
    </div>

    <div id="el4"{if $new_backend} class="config_optiongroup additional_info"{/if}>

        <fieldset id="sp_custom_data" class="clearfix sect_custom">
            <legend>Custom{if $new_backend} <button class="toggle_info button_link" type="button" data-href="#entry_custom_info"><span class="icon-info-circled"></span><b>i</b><span class="visuallyhidden"> Mehr</span></button>{/if}</legend>
            {if !$new_backend}
            <p id="sp_toggle_optionall">Custom <a href="#" onClick="showConfig('el5'); return false" title="{$CONST.STATICPAGE_TOGGLEANDSAVE|sprintf:$CONST.TOGGLE_OPTION}"><img src="{serendipity_getFile file="img/plus.png"}" id="optionel5" alt="+/-" border="0">&nbsp;Info</a></p>
            {/if}

            <div id="{if !$new_backend}el5{else}entry_custom_info{/if}" class="clearfix field_info additional_info">
                <span id="custom_info" class="field_info">
                <p>This custom section vastly improves Serendipity's CMS-abilities and shows an example for saving custom fields for static pages. All custom fields need to be implemented through usual HTML form elements, and need to save their values inside a serendipity[plugin][custom][XXX] fieldname. Once entered, the data will be automatically saved inside the serendipity_staticpage_custom database table, and will be available through &#123;$staticpage_custom.XXX&#125; when later being displayed in the frontend. This way, you can easily add new custom fields for a staticpage, ie. to specify a custom header image for each staticpage. Sky's the limit!</p>
                <p>This example here enables to use a custom CSS-BODY-ID to render the page. Or you can specify, which sidebar you want to see when this staticpage is rendered.<br><span><strong>Example parts for 2k11/index.tpl:</strong></span></p>
                <pre>
&lt;body&#123;if $template_option.webfonts != 'none'&#125; class=&quot;&#123;$template_option.webfonts&#125;&#123;if !empty($staticpage_custom.css_class)&#125; &#123;$staticpage_custom.css_class&#125;&#123;/if&#125;&quot;&#123;/if&#125;&#123;if !empty($staticpage_custom.css_class)&#125; class=&quot;&#123;$staticpage_custom.css_class&#125;&quot;&#123;/if&#125;&gt;

    &lt;div class=&quot;clearfix&#123;if $leftSidebarElements &gt; 0 &amp;&amp; $rightSidebarElements &gt; 0 &amp;&amp; empty($staticpage_custom.sidebars)&#125; col3&#123;elseif ($leftSidebarElements &gt; 0 &amp;&amp; $rightSidebarElements == 0) || $staticpage_custom.sidebars=='left'&#125; col2l&#123;else&#125; col2r&#123;/if&#125;&quot;&gt;
        &lt;main id=&quot;content&quot; &#123;if $template_option.imgstyle != 'none'&#125; class=&quot;&#123;$template_option.imgstyle&#125;&quot;&#123;/if&#125;&gt;
        &#123;$CONTENT&#125;
        &lt;/main&gt;
    &#123;if !empty($staticpage_custom.sidebars)&#125;
        &lt;aside id=&quot;sidebar_&#123;$staticpage_custom.sidebars&#125;&quot;&gt;
            &lt;h2 class=&quot;visuallyhidden&quot;&gt;&#123;$CONST.TWOK11_SIDEBAR&#125;&lt;/h2&gt;
            &#123;serendipity_printSidebar side=&quot;&#123;$staticpage_custom.sidebars&#125;&quot;&#125;
        &lt;/aside&gt;
    &#123;else&#125;
        &#123;if $leftSidebarElements &gt; 0&#125;
        &lt;aside id=&quot;sidebar_left&quot;&gt;
            &lt;h2 class=&quot;visuallyhidden&quot;&gt;&#123;$CONST.TWOK11_SIDEBAR&#125;&lt;/h2&gt;
            &#123;serendipity_printSidebar side=&quot;left&quot;&#125;
        &lt;/aside&gt;
        &#123;/if&#125;
        &#123;if $rightSidebarElements &gt; 0&#125;
        &lt;aside id=&quot;sidebar_right&quot;&gt;
            &lt;h2 class=&quot;visuallyhidden&quot;&gt;&#123;$CONST.TWOK11_SIDEBAR&#125;&lt;/h2&gt;
            &#123;serendipity_printSidebar side=&quot;right&quot;&#125;
        &lt;/aside&gt;
        &#123;/if&#125;
    &#123;/if&#125;
    &lt;/div&gt;
                </pre>
                </span>
            </div>
            {if !$new_backend && !$is_wysiwyg}<script type="text/javascript">document.getElementById("el5").style.display = "none";</script>{/if}

            <div id="entry_custom_sidebar" class="form_field form_multiselect sp_sect">
                <label class="sp_label" title="Choose the main sidebar that should be shown when this staticpage is evaluated">Sidebars</label>
                <select name="serendipity[plugin][custom][sidebars][]" id="sp_customsidebar" multiple="multiple">
                    <option value="">None</option>
                    <option {if isset($form_values.custom.sidebars) && in_array('left', (array)$form_values.custom.sidebars)}selected="selected"{/if}value="left">Left</option>
                    <option {if isset($form_values.custom.sidebars) && in_array('right', (array)$form_values.custom.sidebars)}selected="selected"{/if}value="right">Right</option>
                    <option {if isset($form_values.custom.sidebars) && in_array('hidden', (array)$form_values.custom.sidebars)}selected="selected"{/if}value="hidden">Hidden</option>
                </select>
            </div>

            <div id="entry_custom_class" class="form_field sp_sect">
                <label class="sp_label" title="CSS class of the main page body that should be associated">Main CSS class</label>
                    <input class="input_textbox direction_ltr" type="text" size="30" name="serendipity[plugin][custom][css_class]" value="{$form_values.custom.css_class|@default:'None'}"{if !$new_backend} /{/if}>
            </div>
        </fieldset>

    </div>

    {if !$new_backend && !$is_wysiwyg}<script type="text/javascript">document.getElementById("el4").style.display = "none";</script>{/if}

</div>


{staticpage_input_finish}

<div class="sp_responsform_submit">
    <input type="submit" name="serendipity[SAVECONF]" value="{$CONST.SAVE}" class="serendipityPrettyButton input_button state_submit"{if !$new_backend} /{/if}>
</div>

{if $new_backend}
<script>
    $('.sp_toggle').click(function () {
        var $id   = $(this).attr('id');
        var $name = 'staticpage_mobileform_' + $id;
        var cb    = localStorage.getItem($name);
        if ( cb !== null ) {
            $('#'+$id+' > .icon-down-dir').removeClass('icon-down-dir').addClass('icon-right-dir');
            localStorage.removeItem($name);
        } else {
            $('#'+$id+' > .icon-right-dir').removeClass('icon-right-dir').addClass('icon-down-dir');
            setLocalStorage($name, true);
        }
    });
</script>
{/if}

<!-- RESPONSIVE_TEMPLATE.TPL end -->

