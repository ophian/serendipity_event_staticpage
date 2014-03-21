
<!-- DEFAULT_STATICPAGE_BACKEND.TPL start -->
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

<div id="backend_sp_simple" class="default_staticpage">

    <div class="sp_defaultform_left">
        <!-- LEFT -->

        <fieldset class="sect_basic">
            <legend>{$CONST.STATICPAGE_SECTION_BASIC}</legend>
            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="headline" what="desc"}">{staticpage_input item="headline" what="name"}</label>
                {staticpage_input item="headline"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="articleformattitle" what="desc"}">{staticpage_input item="articleformattitle" what="name"}</label>
                {staticpage_input item="articleformattitle"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="content" what="desc"}">{staticpage_input item="content" what="name"}</label>
                {staticpage_input item="content"}
            </div>

            {if $showmeta}
            <div class="sp_sect configuration_group">
                {if $new_backend}
                <h3 class="toggle_headline"><button id="optionel1" class="toggle_info show_config_option sp_toggle" type="button" data-href="#el1" title="{$CONST.TOGGLE_OPTION}"><span class="icon-right-dir"></span> {$CONST.STATICPAGES_CUSTOM_META_SHOW}</button></h3>
                {else}
                {$CONST.STATICPAGES_CUSTOM_META_SHOW}
                <p id="sp_toggle_optionall"><a href="#" onClick="showConfig('el1'); return false" title="{$CONST.TOGGLE_OPTION}"><img src="{serendipity_getFile file="img/plus.png"}" id="optionel1" alt="+/-" border="0">&nbsp;{$CONST.TOGGLE_ALL}</a></p>
                {/if}
            </div>

            {if !$new_backend}<div id="el1">{else}<fieldset id="el1" class="config_optiongroup additional_info">{/if}
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
            {if !$new_backend}</div>{else}</fieldset>{/if}
            {if !$new_backend}<script type="text/javascript" language="JavaScript">document.getElementById("el1").style.display = "none";</script>{/if}
            {/if}

        </fieldset>

        <fieldset class="sect_struct">
            <legend>{$CONST.STATICPAGE_SECTION_STRUCT}</legend>
            {if !$is_wysiwyg}
            <div class="sp_sect configuration_group">
                {if $new_backend}
                <h3 class="toggle_headline"><button id="optionel2" class="toggle_info show_config_option sp_toggle" type="button" data-href="#el2" title="{$CONST.TOGGLE_OPTION}"><span class="icon-right-dir"></span> {$CONST.STATICPAGES_CUSTOM_STRUCTURE_SHOW}</button></h3>
                {else}
                {$CONST.STATICPAGES_CUSTOM_STRUCTURE_SHOW}
                <p id="sp_toggle_optionall"><a href="#" onClick="showConfig('el2'); return false" title="{$CONST.TOGGLE_OPTION}"><img src="{serendipity_getFile file="img/plus.png"}" id="optionel2" alt="+/-" border="0">&nbsp;{$CONST.TOGGLE_ALL}</a></p>
                {/if}
            </div>
            {/if}

            {if !$new_backend}<div id="el2">{else}<fieldset id="el2" class="config_optiongroup additional_info">{/if}

                <div class="sp_sect">
                    <label class="sp_label" title="{staticpage_input item="authorid" what="desc"}">{staticpage_input item="authorid" what="name"}</label>
                        {staticpage_input item="authorid"}
                </div>

                <div class="sp_sect">
                    <label class="sp_label" title="{staticpage_input item="articletype" what="desc"}">{staticpage_input item="articletype" what="name"}</label>
                        {staticpage_input item="articletype"}
                </div>

                <div class="sp_sect">
                    <label class="sp_label" title="{staticpage_input item="language" what="desc"}">{staticpage_input item="language" what="name"}</label>
                        {staticpage_input item="language"}
                </div>

                <div class="sp_sect">
                    <label class="sp_label" title="{staticpage_input item="related_category_id" what="desc"}">{staticpage_input item="related_category_id" what="name"}</label>
                        {staticpage_input item="related_category_id"}
                </div>

                <div class="sp_sect">
                    <label class="sp_label" title="{staticpage_input item="parent_id" what="desc"}">{staticpage_input item="parent_id" what="name"}</label>
                        {staticpage_input item="parent_id"}
                </div>

                <div class="sp_sect">
                    <label class="sp_label" title="{staticpage_input item="show_childpages" what="desc"}">{staticpage_input item="show_childpages" what="name"}</label>
                        {staticpage_input item="show_childpages"}
                </div>

                <div class="sp_sect">
                    <label class="sp_label" title="{staticpage_input item="shownavi" what="desc"}">{staticpage_input item="shownavi" what="name"}</label>
                        {staticpage_input item="shownavi"}
                </div>

                <div class="sp_sect">
                    <label class="sp_label" title="{staticpage_input item="show_breadcrumb" what="desc"}">{staticpage_input item="show_breadcrumb" what="name"}</label>
                        {staticpage_input item="show_breadcrumb"}
                </div>

                <div class="sp_sect">
                    <label class="sp_label" title="{staticpage_input item="pre_content" what="desc"}">{staticpage_input item="pre_content" what="name"}</label>
                        {staticpage_input item="pre_content"}
                </div>

            {if !$new_backend}</div>{else}</fieldset>{/if}
            {if !$new_backend && !$is_wysiwyg}<script type="text/javascript" language="JavaScript">document.getElementById("el2").style.display = "none";</script>{/if}
        </fieldset>
    </div>

    <div class="sp_defaultform_right">
        <!-- RIGHT -->
        <fieldset class="sect_meta">
            <legend>{$CONST.STATICPAGE_SECTION_META}</legend>
            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="pagetitle" what="desc"}">{staticpage_input item="pagetitle" what="name"}</label>
                    {staticpage_input item="pagetitle"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="permalink" what="desc"}">{staticpage_input item="permalink" what="name"}</label>
                    {staticpage_input item="permalink"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="pass" what="desc"}">{staticpage_input item="pass" what="name"}</label>
                    {staticpage_input item="pass"}
            </div>

        </fieldset>
        
        <fieldset class="sect_opt">
            <legend>{$CONST.STATICPAGE_SECTION_OPT}</legend>
            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="publishstatus" what="desc"}">{staticpage_input item="publishstatus" what="name"}</label>
                    {staticpage_input item="publishstatus"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="is_startpage" what="desc"}">{staticpage_input item="is_startpage" what="name"}</label>
                    {staticpage_input item="is_startpage"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="is_404_page" what="desc"}">{staticpage_input item="is_404_page" what="name"}</label>
                    {staticpage_input item="is_404_page"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="showonnavi" what="desc"}">{staticpage_input item="showonnavi" what="name"}</label>
                    {staticpage_input item="showonnavi"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="markup" what="desc"}">{staticpage_input item="markup" what="name"}</label>
                    {staticpage_input item="markup"}
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="articleformat" what="desc"}">{staticpage_input item="articleformat" what="name"}</label>
                    {staticpage_input item="articleformat"}
            </div>

           <div class="sp_sect">
                <label class="sp_label" title="{staticpage_input item="timestamp" what="desc"}">{staticpage_input item="timestamp" what="name"}</label>
                    {staticpage_input item="timestamp"}
           </div>

        </fieldset>

        {* EXAMPLE FOR CUSTOM STATICPAGE PROPERTIES
        
        <fieldset class="sect_custom">
            <legend>Custom</legend>

            <div class="sp_sect">
                <label class="sp_label" title="Choose the main sidebar that should be shown when this staticpage is evaluated">Sidebars</label>
                <select name="serendipity[plugin][custom][sidebars][]" multiple="multiple">
                    <option {if (@in_array('left', $form_values.custom.sidebars))}selected="selected"{/if} value="left">Left</option>
                    <option {if (@in_array('right', $form_values.custom.sidebars))}selected="selected"{/if} value="right">Right</option>
                    <option {if (@in_array('hidden', $form_values.custom.sidebars))}selected="selected"{/if} value="hidden">Hidden</option>
                </select>
            </div>

            <div class="sp_sect">
                <label class="sp_label" title="CSS class of the main page body that should be associated">Main CSS class</label>
                    <input type="text" name="serendipity[plugin][custom][css_class]" value="{$form_values.custom.css_class|@default:'None'}" />
            </div>
        </fieldset>
         END OF EXAMPLE FOR CUSTOM STATICPAGE PROPERTIES *}

        <div class="sp_defaultform_submit">
            <input type="submit" name="serendipity[SAVECONF]" value="{$CONST.SAVE}" class="serendipityPrettyButton input_button" />
        </div>

    </div>
</div>


{staticpage_input_finish}

<div class="sp_defaultform_submit sp_input_finish">
    <input type="submit" name="serendipity[SAVECONF]" value="{$CONST.SAVE}" class="serendipityPrettyButton input_button" />
</div>

<!-- DEFAULT_STATICPAGE_BACKEND.TPL end -->

