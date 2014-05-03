<?php /* is already called by is_smarty and switched to ob_methods */echo "<!-- modul-type::$type - is SMARTIFIED($is_smarty) - backend_inspectConfig.php -->\n";/* and may sadley not get further modulized */
        switch ($type) {
            case 'seperator':
                if (!$is_smarty) {
?>
        <tr>
            <td colspan="2"><hr noshade="noshade" size="1" /></td>
        </tr>
<?php
                }
                break;

            case 'select':
                if (!$is_smarty) {
?>
        <tr>
            <td style="border-bottom: 1px solid #000000; vertical-align: top"><strong><?php echo $cname; ?></strong>
<?php
                if ($cdesc != '') {
?>
                <br><span  style="color: #5E7A94; font-size: 8pt;">&nbsp;<?php echo $cdesc; ?></span>
                <?php } ?>
            </td>
            <td style="border-bottom: 1px solid #000000; vertical-align: middle" width="250">
                <div>
                <?php } ?>
<select class="direction_<?php echo $lang_direction; ?>" name="serendipity[plugin][<?php echo $config_item; ?>]">
<?php
foreach($select AS $select_value => $select_desc) {
    $id = htmlspecialchars($config_item . $select_value);
?>
                        <option title="<?php echo htmlspecialchars($select_desc); ?>"<?php echo ($select_value == $hvalue ? ' selected="selected"' : ''); ?> value="<?php echo $select_value; ?>"><?php echo htmlspecialchars($select_desc); ?></option>
<?php } ?>
                    </select>
<?php if (!$is_smarty) { ?>
                </div>
            </td>
        </tr>
<?php
                }
                break;

            case 'tristate':
                $per_row = 3;
                $radio['value'][] = 'default';
                $radio['desc'][]  = USE_DEFAULT;

            case 'boolean':
                $radio['value'][] = 'true';
                $radio['desc'][]  = YES;

                $radio['value'][] = 'false';
                $radio['desc'][]  = NO;

            case 'radio':
                if (!count($radio) > 0) {
                    $radio = $radio2;
                }

                if (empty($per_row)) {
                    $per_row = $per_row2;
                    if (empty($per_row)) {
                        $per_row = 2;
                    }
                }

                if (!$is_smarty) {
?>
        <tr>
            <td style="border-bottom: 1px solid #000000; vertical-align: top"><strong><?php echo $cname; ?></strong>
<?php
                if ($cdesc != '') {
?>
                <br /><span  style="color: #5E7A94; font-size: 8pt;">&nbsp;<?php echo $cdesc; ?></span>
<?php
                }
?>
            </td>
            <td style="border-bottom: 1px solid #000000; vertical-align: middle;" width="250">
<?php
                }
                $counter = 0;
                foreach($radio['value'] AS $radio_index => $radio_value) {
                    $id = htmlspecialchars($config_item . $radio_value);
                    $counter++;
                    $checked = "";

                    if ($radio_value == 'true' && ($hvalue === '1' || $hvalue === 'true')) {
                        $checked = " checked";
                    } elseif ($radio_value == 'false' && ($hvalue === '' || $hvalue ==='0' || $hvalue === 'false')) {
                        $checked = " checked";
                    } elseif ($radio_value == $hvalue) {
                        $checked = " checked";
                    }

                    if ($counter == 1) {
?>
                <div class="sp_input_radio">
<?php
                    }
?>
                    <input class="input_radio direction_<?php echo $lang_direction; ?>" type="radio" id="serendipity_plugin_<?php echo $id; ?>" name="serendipity[plugin][<?php echo $config_item; ?>]" value="<?php echo $radio_value; ?>" <?php echo $checked ?> title="<?php echo htmlspecialchars($radio['desc'][$radio_index]); ?>" />
                        <label for="serendipity_plugin_<?php echo $id; ?>"><?php echo htmlspecialchars($radio['desc'][$radio_index]); ?></label>
<?php
                    if ($counter == $per_row) {
                        $counter = 0;
?>
                </div>
<?php
                    }
                }
                if (!$is_smarty) {
?>
            </td>
        </tr>
<?php
                }
                break;

            case 'string':
                if (!$is_smarty) {
?>
        <tr>
            <td style="border-bottom: 1px solid #000000">
                    <strong><?php echo $cname; ?></strong>
                    <br><span style="color: #5E7A94; font-size: 8pt;">&nbsp;<?php echo $cdesc; ?></span>
            </td>
            <td style="border-bottom: 1px solid #000000" width="250">
                <div>
<?php           } ?>
                    <input class="input_textbox direction_<?php echo $lang_direction; ?>" type="text" name="serendipity[plugin][<?php echo $config_item; ?>]" value="<?php echo $hvalue; ?>" size="30" />
<?php           if (!$is_smarty) { ?>
                </div>
            </td>
        </tr>
<?php
                }
                break;

            case 'html':
            case 'text':
                if (!$is_smarty) {
                    echo '<tr>';
                }

                if (!$serendipity['wysiwyg']) {
                    if (!$is_smarty) {
?>
                <td><strong><?php echo $cname; ?></strong>
                &nbsp;<span style="color: #5E7A94; font-size: 8pt;">&nbsp;<?php echo $cdesc; ?></span></td>
                <td align="right">
<?php
                    }
                    if ($serendipity['version'][0] == '1') {
?>
                    <nobr><span id="tools_<?php echo $config_item ?>" class="editor_toolbar" style="display: none">
                        <?php if( $serendipity['nl2br']['iso2br'] ) { ?>
                        <input type="button" class="serendipityPrettyButton input_button" name="insX" value="NoBR" accesskey="x" data-tarea="nuggets<?php echo $elcount; ?>" data-tag="nl" style="font-style: italic" onclick="wrapSelection(document.forms['serendipityEntry']['serendipity[plugin][<?php echo $config_item ?>]'],'<nl>','</nl>')" />
                        <?php } ?>
                        <input type="button" class="serendipityPrettyButton input_button wrap_selection" name="insI" value="I" accesskey="i" data-tarea="nuggets<?php echo $elcount; ?>" data-tag="em" style="font-style: italic" onclick="wrapSelection(document.forms['serendipityEntry']['serendipity[plugin][<?php echo $config_item ?>]'],'<em>','</em>')" />
                        <input type="button" class="serendipityPrettyButton input_button wrap_selection" name="insB" value="B" accesskey="b" data-tarea="nuggets<?php echo $elcount; ?>" data-tag="strong" style="font-weight: bold" onclick="wrapSelection(document.forms['serendipityEntry']['serendipity[plugin][<?php echo $config_item ?>]'],'<strong>','</strong>')" />
                        <input type="button" class="serendipityPrettyButton input_button wrap_selection" name="insU" value="U" accesskey="u" data-tarea="nuggets<?php echo $elcount; ?>" data-tag="u" style="text-decoration: underline;" onclick="wrapSelection(document.forms['serendipityEntry']['serendipity[plugin][<?php echo $config_item ?>]'],'<u>','</u>')" />
                        <input type="button" class="serendipityPrettyButton input_button wrap_selection" name="insQ" value="<?php echo QUOTE ?>" accesskey="q" data-tarea="nuggets<?php echo $elcount; ?>" data-tag="blockquote" style="font-style: italic" onclick="wrapSelection(document.forms['serendipityEntry']['serendipity[plugin][<?php echo $config_item ?>]'],'<blockquote>','</blockquote>')" />
                        <input type="button" class="serendipityPrettyButton input_button wrap_insimg" name="insJ" value="img" accesskey="j" data-tarea="nuggets<?php echo $elcount; ?>" onclick="wrapInsImage(document.forms['serendipityEntry']['serendipity[plugin][<?php echo $config_item ?>]'])" />
                        <input type="button" class="serendipityPrettyButton input_button wrap_insmedia" name="insImage" value="<?php echo MEDIA; ?>" style="" onclick="window.open('serendipity_admin_image_selector.php?serendipity[textarea]=<?php echo urlencode('serendipity[plugin]['.$config_item.']'); ?>', 'ImageSel', 'width=800,height=600,toolbar=no,scrollbars=1,scrollbars,resize=1,resizable=1');" />
                        <input type="button" class="serendipityPrettyButton input_button wrap_insurl" name="insU" value="URL" accesskey="l" data-tarea="nuggets<?php echo $elcount; ?>" onclick="wrapSelectionWithLink(document.forms['serendipityEntry']['serendipity[plugin][<?php echo $config_item ?>]'])" />
                    </span></nobr>
<?php
                        } else {
?>
                    <nobr><span id="tools_<?php echo $config_item ?>" class="editor_toolbar" style="display: none">
                        <?php if( $serendipity['nl2br']['iso2br'] ) { ?>
                        <button class="wrap_selection lang-html" type="button" name="insX" data-tarea="nuggets<?php echo $elcount; ?>" data-tag-open="nl" data-tag-close="nl">NoBR</button>
                        <?php } ?>
                        <button class="hilite_i wrap_selection lang-html" type="button" name="insI" data-tarea="nuggets<?php echo $elcount; ?>" data-tag-open="em" data-tag-close="em">i</button>
                        <button class="hilite_b wrap_selection lang-html" type="button" name="insB" data-tarea="nuggets<?php echo $elcount; ?>" data-tag-open="strong" data-tag-close="strong">b</button>
                        <button class="wrap_selection lang-html" type="button" name="insQ" data-tarea="nuggets<?php echo $elcount; ?>" data-tag-open="blockquote" data-tag-close="blockquote"><?php echo QUOTE ?></button>
                        <button class="wrap_insimg" type="button" name="insJ" data-tarea="nuggets<?php echo $elcount; ?>">img</button>
                        <button class="wrap_insmedia" type="button" name="insImage" data-tarea="nuggets<?php echo $elcount; ?>" ><?php echo MEDIA ?></button>
                        <button class="wrap_insurl" type="button" name="insURL" data-tarea="nuggets<?php echo $elcount; ?>" >URL</button>
                    </span></nobr>
<?php
                        }
?>
                    <script type="text/javascript" language="JavaScript">
                        var tb_<?php echo $config_item ?> = document.getElementById('tools_<?php echo $config_item ?>');
                        tb_<?php echo $config_item ?>.style.display = '';
                    </script>
<?php
                    if (!$serendipity['version'][0] == '1' && !$is_smarty) {
?>
                    <script src="<?php echo serendipity_getTemplateFile('admin/js/jquery.magnific-popup.js') ?>"></script>
<?php
                    }

                    // add extra data in the entry's array so that emoticonchooser plugin
                    // behaves well with wysiwyg editors, then clean up ;-) (same apply below)
                    $entry['backend_entry_toolbar_body:nugget'] = 'nuggets' . $elcount;
                    $entry['backend_entry_toolbar_body:textarea'] = 'serendipity[plugin][' . $config_item . ']';
                    serendipity_plugin_api::hook_event('backend_entry_toolbar_body', $entry);
                    unset($entry['backend_entry_toolbar_body:textarea']);
                    unset($entry['backend_entry_toolbar_body:nugget']);
                } else {
                    if (!$is_smarty) {
?>
            <td colspan="2"><strong><?php echo $cname; ?></strong>
                &nbsp;<span style="color: #5E7A94; font-size: 8pt;">&nbsp;<?php echo $cdesc; ?></span></td>
            <td>
<?php
                    }

                    if (!$serendipity['version'][0] == '1' && !$is_smarty) {
?>
                    <script src="<?php echo serendipity_getTemplateFile('admin/js/jquery.magnific-popup.js') ?>"></script>
<?php
                    }

                    if ($serendipity['version'][0] > '1') {
                        serendipity_emit_htmlarea_code("nuggets{$elcount}","");
                    }
                    $entry['backend_entry_toolbar_body:nugget'] = 'nuggets' . $elcount;
                    $entry['backend_entry_toolbar_body:textarea'] = 'serendipity[plugin][' . $config_item . ']';
                    serendipity_plugin_api::hook_event('backend_entry_toolbar_body', $entry);
                    unset($entry['backend_entry_toolbar_body:textarea']);
                    unset($entry['backend_entry_toolbar_body:nugget']);

                }

                if (!$is_smarty) {
?>
                </td>
            </tr>

        <tr>
            <td colspan="2">
<?php           } ?>
                <div>
                    <textarea class="direction_<?php echo $lang_direction; ?>" style="width: 100%" id="nuggets<?php echo $elcount; ?>" name="serendipity[plugin][<?php echo $config_item; ?>]" rows="20" cols="80"><?php echo $hvalue; ?></textarea>
                </div>

<?php         if (!$is_smarty) { ?>

            </td>
        </tr>
<?php
                }

                if ($type == 'html') {
                    $this->htmlnugget[] = $elcount;
                    #if (version_compare(preg_replace('@[^0-9\.]@', '', $serendipity['version']), '0.9', '<')) {
                    #    serendipity_emit_htmlarea_code('nuggets' . $elcount, 'nuggets' . $elcount);
                    #} else {
                        serendipity_emit_htmlarea_code('nuggets', 'nuggets', true);
                    #}
                }
                break;

            case 'content':
                if (!$is_smarty) {
                    ?><tr><td colspan="2"><?php echo $default; ?></td></tr><?php
                } else {
                    echo $default;
                }
                break;

            case 'hidden':
                if (!$is_smarty) {?><tr><td colspan="2"><?php }
                ?><input class="direction_<?php echo $lang_direction; ?>" type="hidden" name="serendipity[plugin][<?php echo $config_item; ?>]" value="<?php echo $value; ?>" /><?php
                if (!$is_smarty) {?></td></tr><?php }
                break;

            case 'timestamp':
                if (!$is_smarty) {
?>
        <tr>
            <td style="border-bottom: 1px solid #000000">
                    <strong><?php echo $cname; ?></strong>
                    <br><span style="color: #5E7A94; font-size: 8pt;">&nbsp;<?php echo $cdesc; ?></span>
            </td>
            <td style="border-bottom: 1px solid #000000" width="250">
                <div>
<?php           } ?>
                    <input class="input_textbox direction_<?php echo $lang_direction; ?>" type="text" name="serendipity[plugin][<?php echo $config_item; ?>]" value="<?php echo serendipity_strftime(DATE_FORMAT_SHORT, $hvalue); ?>" size="30" />
<?php           if (!$is_smarty) { ?>
                </div>
            </td>
        </tr>
<?php
                }
                break;
        }

?>