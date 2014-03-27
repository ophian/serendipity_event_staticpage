<?php
        // debug - do not run backend_staticpage.tpl at all
        /*
        if ($serendipity['POST']['backend_template'] == 'internal') {
            $is_smarty=false;
        }
        */
        // check sidebar plugin availability
        $sbplav = (!$this->sb_plugin_status() ? true : false);

        if (isset($serendipity['GET']['staticid']) && !isset($serendipity['POST']['staticpage'])) {
             $serendipity['POST']['staticpage'] = (int)$serendipity['GET']['staticid'];
        }

        if (isset($serendipity['GET']['pre']) && is_array($serendipity['GET']['pre'])) {
            // Allow to create a new staticpage from a bookmark link
            $serendipity['POST']['plugin']       = $serendipity['GET']['pre'];
            $serendipity['POST']['staticpage']   = '__new';
            $serendipity['POST']['staticSubmit'] = true;
        }

        if (!$is_smarty) {

        echo "\n".'<script type="text/javascript" src="'.$serendipity['serendipityHTTPPath'].'serendipity_define.js.php"></script>'."\n";
        echo '<script type="text/javascript" src="'.$serendipity['serendipityHTTPPath'].'serendipity_editor.js"></script>';

?>

<div id="serendipityStaticpagesNav">
    <ul>
        <li <?php echo ($serendipity['GET']['staticpagecategory'] == 'pageedit' ? 'id="active"' : '') ?>><a href="<?php echo $serendipity['serendipityHTTPPath'].'serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageedit' ?>"><?php echo STATICPAGE_CATEGORY_PAGES ?></a></li>
        <li <?php echo ($serendipity['GET']['staticpagecategory'] == 'pageorder' ? 'id="active"' : '') ?>><a href="<?php echo $serendipity['serendipityHTTPPath'].'serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder' ?>"><?php echo STATICPAGE_CATEGORY_PAGEORDER ?></a></li>
        <li <?php echo (($serendipity['GET']['staticpagecategory'] == 'pagetype' || $serendipity['POST']['staticpagecategory'] == 'pagetype') ? 'id="active"' : '') ?>><a href="<?php echo $serendipity['serendipityHTTPPath'].'serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pagetype' ?>"><?php echo STATICPAGE_CATEGORY_PAGETYPES ?></a></li>
        <li <?php echo ($serendipity['GET']['staticpagecategory'] == 'pageadd' ? 'id="active"' : '') ?>><a href="<?php echo $serendipity['serendipityHTTPPath'].'serendipity_admin.php?serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageadd' ?>"><?php echo STATICPAGE_CATEGORY_PAGEADD ?></a></li>
    </ul>
</div>

<?php
        } else {
            if ($serendipity['POST']['backend_template'] == 'internal') {
               $serendipity['smarty']->assign('sp_defpages_oldform', true);
            }
            $serendipity['smarty']->assign( array (
                         's9y_get_cat' => $serendipity['GET']['staticpagecategory'],
                         's9y_post_cat' => $serendipity['POST']['staticpagecategory']
                         ));
        }
        $spcat = !empty($serendipity['GET']['staticpagecategory']) ? $serendipity['GET']['staticpagecategory'] : $serendipity['POST']['staticpagecategory'];
        if ($is_smarty) {
            $serendipity['smarty']->assign('switch_spcat', $spcat);
        }
        switch($spcat) {
            case 'pageorder':
                if (!$is_smarty) {
                    echo '<strong>' . STATICPAGE_PAGEORDER_DESC . '</strong><br /><br />';
                }

                switch($serendipity['GET']['moveto']) {
                    case 'move':
                        $new_order = explode(',', htmlspecialchars($serendipity['GET']['pagemoveorder']));
                        $this->move_sequence($new_order);
                        break;
                    case 'moveup':
                        $this->move_up($serendipity['GET']['pagetomove']);
                        break;
                    case 'movedown':
                        $this->move_down($serendipity['GET']['pagetomove']);
                        break;
                }

                $pages = $this->fetchStaticPages(true);
                if(is_array($pages)) {
                    $pages = serendipity_walkRecursive($pages);
                    $sort_idx = 0;
                    if (!$is_smarty) {
                        echo '<table>'."\n";

                        foreach($pages as $page) {
                            echo '<tr>'."\n";
                            echo '<td>';
                            echo str_repeat('&nbsp;', $page['depth']).$page['pagetitle'];
                            echo '</td>'."\n";
                            echo '<td>';
                            if($sort_idx == 0) {
                                echo '&nbsp;';
                            } else {
                                echo '<a href="?serendipity[adminModule]=staticpages&amp;serendipity[moveto]=moveup&amp;serendipity[pagetomove]=' . $page['id'] . '&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder" style="border: 0"><img src="' . serendipity_getTemplateFile('admin/img/uparrow.png') .'" height="16" width="16" border="0" alt="' . UP . '" /></a>';
                            }
                            echo '</td>'."\n";
                            echo '<td>';
                            if ($sort_idx == (count($pages)-1)) {
                                echo '&nbsp;';
                            } else {
                                echo '<a href="?serendipity[adminModule]=staticpages&amp;serendipity[moveto]=movedown&amp;serendipity[pagetomove]=' . $page['id'] . '&amp;serendipity[adminModule]=event_display&amp;serendipity[adminAction]=staticpages&amp;serendipity[staticpagecategory]=pageorder" style="border: 0"><img src="' . serendipity_getTemplateFile('admin/img/downarrow.png') . '" height="16" width="16" alt="'. DOWN .'" border="0" /></a>';
                            }
                            echo '</td>'."\n";
                            echo '</tr>'."\n";
                            $sort_idx++;
                        }
                        echo '</table>'."\n";
                    } else {
                        $serendipity['smarty']->assign('sp_pageorder_pages', $pages);
                    }
                } // is_array end
                break;

            case 'pagetype':

                if ($serendipity['POST']['pagetype'] != '__new') {
                    $this->fetchPageType($serendipity['POST']['pagetype']);
                }

                if ($serendipity['POST']['typeSave'] == "true" && !empty($serendipity['POST']['SAVECONF'])) {
                    $serendipity['POST']['typeSubmit'] = true;
                    $bag = new serendipity_property_bag();
                    $this->introspect($bag);
                    $name = htmlspecialchars($bag->get('name'));
                    $desc = htmlspecialchars($bag->get('description'));
                    $config_t = $bag->get('type_configuration');

                    foreach($config_t as $config_item) {
                        $cbag = new serendipity_property_bag();
                        if($this->introspect_item_type($config_item, $cbag)) {
                            $this->pagetype[$config_item] = serendipity_get_bool($serendipity['POST']['plugin'][$config_item]);
                        }
                    }
                    if (!$is_smarty) {
                        echo '<div class="serendipityAdminMsgSuccess msg_success">'. DONE .': '. sprintf(SETTINGS_SAVED_AT, serendipity_strftime('%H:%M:%S')) .'</div>';
                    } else {
                        $serendipity['smarty']->assign('sp_pagetype_saveconf', true);
                    }
                    $this->updatePageType($is_smarty);
                }

                if (!empty($serendipity['POST']['typeDelete']) && $serendipity['POST']['pagetype'] != '__new') {
                    serendipity_db_query("DELETE FROM {$serendipity['dbPrefix']}staticpages_types WHERE id = " . (int)$serendipity['POST']['pagetype']);
                    if (!$is_smarty) {
                        echo '<div class="serendipityAdminMsgSuccess msg_success">'. DONE .': '. sprintf(RIP_ENTRY, $this->pagetype['description']) . '</div>';
                    } else {
                        $serendipity['smarty']->assign( array (
                                     'sp_pagetype_ripped' => $this->pagetype['description'],
                                     'sp_pagetype_purged' => true
                                     ));
                    }
                }

                $types = $this->fetchPageTypes();
                if (!$is_smarty) {
                    echo '<form action="serendipity_admin.php" method="post" name="serendipityEntry">';
                    echo '<input type="hidden" name="serendipity[adminModule]" value="event_display" />';
                    echo '<input type="hidden" name="serendipity[adminAction]" value="staticpages" />';
                    echo '<input type="hidden" name="serendipity[staticpagecategory]" value="pagetype" />';
                    echo '<div>';
                    echo '<strong>' . PAGETYPES_SELECT . '</strong><br /><br />';
                    echo '<select name="serendipity[pagetype]">';
                    echo ' <option value="__new">' . NEW_ENTRY . '</option>';
                    echo ' <option value="__new">-----------------</option>';
                } else {
                    $serendipity['smarty']->assign( array (
                                 'sp_pagetype' => true,
                                 'sp_pagetype_types' => $types
                                 ));
                }
                if(is_array($types) && !$is_smarty) {
                    foreach($types as $type) {
                        echo ' <option value="' . $type['id'] . '" ' . ($serendipity['POST']['pagetype'] == $type['id'] ? 'selected="selected"' : '') . '>' . htmlspecialchars($type['description']) . '</option>';
                    }
                }
                if (!$is_smarty) {
                    echo '</select> <input type="submit" class="serendipityPrettyButton input_button" name="serendipity[typeSubmit]" value="' . GO . '" /> <strong>-' . WORD_OR . '-</strong> <input type="submit" class="serendipityPrettyButton input_button" name="serendipity[typeDelete]" value="' . DELETE . '" />';
                    echo '</select>';
                    echo '</div>';
                }

                if (isset($serendipity['POST']['typeSubmit'])) {
                    $serendipity['POST']['staticSubmit'] = true;//??
                    $serendipity['POST']['plugin']['custom'] = $this->staticpage['custom'];//?? what for?
                    if (!$is_smarty) {
                        echo '<!-- backend show pagetype form no smarty start -->';
                        echo '<input type="hidden" name="serendipity[typeSave]" value="true" />';
                        $this->showForm($this->config_types, $this->pagetype, 'introspect_item_type', 'get_type', 'typeSubmit', $is_smarty);
                        echo '<!-- backend show pagetype form no smarty end -->';
                    } else {
                        if ($serendipity['version'][0] == '2') $serendipity['smarty']->assign('new_backend', true);
                        $serendipity['POST']['backend_template'] = 'typeform_staticpage_backend.tpl';
                        $bag = new serendipity_property_bag();
                        $this->introspect($bag);
                        $name = htmlspecialchars($bag->get('name'));
                        $desc = htmlspecialchars($bag->get('description'));
                        $config_t = $bag->get('type_configuration');

                        foreach($config_t as $config_item) {
                            $cbag = new serendipity_property_bag();
                            if($this->introspect_item_type($config_item, $cbag)) {
                                $this->pagetype[$config_item] = serendipity_get_bool($serendipity['POST']['plugin'][$config_item]);
                            }
                        }
                        $serendipity['smarty']->assign('sp_pagetype_submit', true);
                        ob_start();
                        $this->showForm($this->config_types, $this->pagetype, 'introspect_item_type', 'get_type', 'typeSubmit', $is_smarty);
                        $smarty_pagetypeshowform = ob_get_contents();
                        ob_end_clean();
                        $serendipity['smarty']->assign( array(
                                     'sp_pagetype_isshowform' => true,
                                     'sp_pagetype_showform' => trim($smarty_pagetypeshowform)
                                     ));// showform is a string!
                    }
                }
                if (!$is_smarty) {
                    echo '</form>';
                }
                break;

            case 'pageadd':
                if (isset($serendipity['POST']['staticpagecategory']) && isset($serendipity['POST']['typeSubmit'])) {
                    if ($serendipity['POST']['staticpagecategory'] == 'pageadd'/* && (is_array($serendipity['POST']['externalPlugins']) && !empty($serendipity['POST']['externalPlugins']))*/) {
                        if (!$is_smarty) {
                            echo '<div class="serendipityAdminMsgSuccess msg_success">'. DONE .': '. sprintf(SETTINGS_SAVED_AT, serendipity_strftime('%H:%M:%S')). '</div>';
                        } else {
                            $serendipity['smarty']->assign('sp_addsubmit', true);
                        }
                    }
                }
                if (!$is_smarty) {
                    echo '<strong>' . STATICPAGE_PAGEADD_DESC . '</strong><br /><br />';
                }
                $plugins = $this->selectPlugins();
                $insplugins = $this->fetchPlugins();
                if (isset($serendipity['POST']['typeSubmit'])) {
                    foreach($insplugins as $key => $values) {
                        if (empty($serendipity['POST']['externalPlugins'][$key])) {
                            serendipity_db_query('DELETE FROM '.$serendipity['dbPrefix'].'staticpages WHERE id = '.(int)$values['id']);
                        }
                    }
                    if (count($serendipity['POST']['externalPlugins'])) {
                        foreach($serendipity['POST']['externalPlugins'] as $plugin) {
                            $this->staticpage =  array(
                                'permalink'   => $plugins[$plugin]['link'],
                                'content'     => 'plugin',
                                'pre_content' => $plugin,
                                'pagetitle'   => $plugins[$plugin]['name'],
                                'headline'    => $plugins[$plugin]['name']
                            );
                            $this->updateStaticPage();
                        }
                    }
                }
                $insplugins = $this->fetchPlugins();
                if (is_array($plugins)) {
                    if (!$is_smarty) {
?>
<form action="serendipity_admin.php" method="post" name="serendipityPlugins">
    <input type="hidden" name="serendipity[adminModule]" value="event_display" />
    <input type="hidden" name="serendipity[adminAction]" value="staticpages" />
    <input type="hidden" name="serendipity[staticpagecategory]" value="pageadd" />
<?php
                        foreach($plugins as $key => $plugin) {
                            if (!$is_smarty) {
                                if (isset($insplugins[$key])) {
                                    $c = 'checked="checked"';
                                } else {
                                    $c = '';
                                }
                                echo '<input class="input_checkbox" type="checkbox" name="serendipity[externalPlugins][]" value="'.$key.'" '.$c.' />'.$plugin['name'].'<br />';
                            }
                        }
                        echo '<input type="submit" name="serendipity[typeSubmit]" class="serendipityPrettyButton input_button" value="'.GO.'">';
                        echo '</form>';
                    } else {
                        $serendipity['smarty']->assign( array (
                                     'sp_pageadd_plugins' => $plugins,
                                     'sp_pageadd_insplugins' => $insplugins
                                     ));
                    }
                }
                if (!$is_smarty) {
                    echo '<strong>' . STATICPAGE_PAGEADD_PLUGINS . '</strong><br /><br />';
                }
                $this->pluginstatus();
                if (!$is_smarty) {
                    echo '<table>';
                    echo '<tr id="serendipityStaticpagesTableHeader">';
                    echo '<th>'.EVENT_PLUGIN.'</th>';
                    echo '<th>'.STATICPAGE_STATUS.'</th>';
                    echo '</tr>';
                    $i = 0;
                    foreach($this->pluginstats as $key => $value) {
                        echo '<tr id="serendipityStaticpagesTable'.($i++ % 2).'">';
                        echo '<td>'.$key.'</td>';
                        echo '<td><span id="serendipityStaticpages'.$value['color'].'">'.$value['status'].'</span></td>';
                        echo '</tr>';
                    }
                    echo '</table>';
                } else {
                    $serendipity['smarty']->assign('sp_pageadd_plugstats', $this->pluginstats);
                }
                break;

            case 'pages':
            default:

                if ($serendipity['POST']['staticpage'] != '__new') {
                    $this->fetchStaticPage($serendipity['POST']['staticpage']);
                }
                if ($serendipity['POST']['staticSave'] == "true" && !empty($serendipity['POST']['SAVECONF'])) {
                    $serendipity['POST']['staticSubmit'] = true;
                    if ($is_smarty) {
                        $serendipity['smarty']->assign('sp_staticsubmit', true);
                    }
                    $bag  = new serendipity_property_bag;
                    $this->introspect($bag);
                    $name = htmlspecialchars($bag->get('name'));
                    $desc = htmlspecialchars($bag->get('description'));
                    $config_names = $bag->get('page_configuration');

                    foreach ($config_names as $config_item) {
                        $cbag = new serendipity_property_bag;
                        if ($this->introspect_item($config_item, $cbag)) {
                            $this->staticpage[$config_item] = serendipity_get_bool($serendipity['POST']['plugin'][$config_item]);
                        }
                    }
                    $result = $this->updateStaticPage();
                    if (!$is_smarty) {
                        if (is_string($result)) {
                            echo '<div class="serendipityAdminMsgError msg_error"><img class="img_error" src="' . serendipity_getTemplateFile('admin/img/admin_msg_error.png') . '" alt="" />ERROR: ' . $result . '</div>';
                        } else {
                            echo '<div class="serendipityAdminMsgSuccess msg_success">'. DONE .': '. sprintf(SETTINGS_SAVED_AT, serendipity_strftime('%H:%M:%S')). '</div>';
                        }
                    } else {
                        $serendipity['smarty']->assign('sp_defpages_upd_result', is_string($result) ? $result : null);
                    }
                }

                if (!empty($serendipity['POST']['staticDelete']) && $serendipity['POST']['staticpage'] != '__new') {
                    if ($is_smarty) {
                        $serendipity['smarty']->assign('sp_staticdelete', true);
                    }
                    if (!$this->getChildPage($serendipity['POST']['staticpage'])) {
                        serendipity_db_query("DELETE FROM {$serendipity['dbPrefix']}staticpages WHERE id = " . (int)$serendipity['POST']['staticpage']);
                        if (!$is_smarty) {
                            echo '<div class="serendipityAdminMsgSuccess msg_success">'. DONE .': '. sprintf(RIP_ENTRY, $this->staticpage['pagetitle']) . '</div>';
                        } else {
                            $serendipity['smarty']->assign('sp_defpages_rip_success', DONE .': '. sprintf(RIP_ENTRY, $this->staticpage['pagetitle']));
                        }
                    } else {
                        if (!$is_smarty) {
                            echo '<div class="serendipityAdminMsgNote msg_notice"><img class="img_error" src="' . serendipity_getTemplateFile('admin/img/admin_msg_note.png') . '" alt="" />'. IMPORT_NOTES . ': '. STATICPAGE_CANNOTDELETE_MSG . '</div>';
                        }
                    }
                }

                if (false===serendipity_db_bool($this->get_config('showlist')) || isset($serendipity['POST']['staticpage']) ) {
                    // this is the default SELECT list block
                    if (!$is_smarty) {
?>

<form action="serendipity_admin.php" method="post" name="serendipityEntry">
    <div>
        <input type="hidden" name="serendipity[adminModule]" value="event_display" />
        <input type="hidden" name="serendipity[adminAction]" value="staticpages" />
        <input type="hidden" name="serendipity[staticpagecategory]" value="pages" />
    </div>

<?php
                    } else {
                        $serendipity['smarty']->assign('sp_defpages_showlist', false);
                    }
                    if (empty($serendipity['POST']['backend_template'])) {
                        if (!empty($serendipity['COOKIE']['backend_template'])) {
                            $serendipity['POST']['backend_template'] = $serendipity['COOKIE']['backend_template'];
                        }
                        if ($is_smarty) {
                            $serendipity['smarty']->assign('sp_defpages_jsCookie', '');
                        }
                    } else {
                        if (!$is_smarty) {
                            echo serendipity_JSsetCookie('backend_template', $serendipity['POST']['backend_template']);
                        } else {
                            $serendipity['smarty']->assign('sp_cookie_value', urlencode($serendipity['POST']['backend_template']));
                        }
                    }
                    if (!$is_smarty) {
?>
    <div class="sp_templateselector">
        <label for="sp_templateselector"><?php echo STATICPAGE_TEMPLATE ?></label>
        <select id="sp_templateselector" name="serendipity[backend_template]">
            <option <?php echo $serendipity['POST']['backend_template'] == 'external' ? 'selected="selected"' : ''; ?> value="external"><?php echo STATICPAGE_TEMPLATE_EXTERNAL ?></option>
            <option <?php echo $serendipity['POST']['backend_template'] == 'internal' ? 'selected="selected"' : ''; ?> value="internal"><?php echo STATICPAGE_TEMPLATE_INTERNAL ?></option>
<?php
                    } else {
                        $serendipity['smarty']->assign('sp_defpages_template', $serendipity['POST']['backend_template']);
                    }
                    $exclude_files = array ('default_staticpage_backend.tpl', 'typeform_staticpage_backend.tpl');
                    $dh = @opendir(dirname(__FILE__) . '/backend_templates');
                    if ($dh) {
                        while ($file = readdir($dh)) {
                            if (!in_array($file, $exclude_files) && preg_match('@^(.*).tpl$@i', $file, $m)) {
                                if (isset($m[1]) && !empty($m[1])) $templateName = ucwords(str_replace('_', ' ', $m[1]));
                                if (!$is_smarty) {
?>
            <option <?php echo ($file == $serendipity['POST']['backend_template'] ? 'selected="selected" ' : '') . 'value="' . htmlspecialchars($file) . '">' . htmlspecialchars($templateName) ?></option>
<?php
                                } else {
                                    $ts_option[] = '<option ' . ($file == $serendipity['POST']['backend_template'] ? 'selected="selected" ' : '') . 'value="' . htmlspecialchars($file) . '">' . htmlspecialchars($templateName) . '</option>'."\n";
                                }
                            }
                        }
                    }
                    $dh = @opendir($serendipity['templatePath'] . $serendipity['template'] . '/backend_templates');
                    if ($dh) {
                        while ($file = readdir($dh)) {
                            if (!in_array($file, $exclude_files) && preg_match('@^(.*).tpl$@i', $file, $m)) {
                                if (isset($m[1]) && !empty($m[1])) $templateName = ucwords(str_replace('_', ' ', $m[1]));
                                if (!$is_smarty) {
?>
        <option <?php echo ($file == $serendipity['POST']['backend_template'] ? 'selected="selected" ' : '') . 'value="' . htmlspecialchars($file) . '">' . htmlspecialchars($templateName) ?></option>
<?php
                                } else {
                                    $ts_option[] = '<option ' . ($file == $serendipity['POST']['backend_template'] ? 'selected="selected" ' : '') . 'value="' . htmlspecialchars($file) . '">' . htmlspecialchars($templateName) .'</option>'."\n";
                                }
                            }
                        }
                    }
                    if ($is_smarty && is_array($ts_option)) {
                        $serendipity['smarty']->assign('sp_defpages_top', $ts_option);
                    }
                    if (!$is_smarty) {
?>
        </select>
    </div><!-- class sp_templateselector end -->

    <div class="sp_pageselector">
        <strong><?php echo STATICPAGE_SELECT ?></strong><br /><br />
        <select name="serendipity[staticpage]" id="staticpage_dropdown">
            <option value="__new"><?php echo NEW_ENTRY ?></option>
            <option value="__new">-----------------</option>
<?php
                    }
                    $pages = $this->fetchStaticPages();
                    if(is_array($pages)) {
                        $pages = serendipity_walkRecursive($pages);
                        foreach ($pages as $page) {
                            if ($this->checkPageUser($page['authorid'])) {
                                if (!$is_smarty) {
?>
            <option value="<?php echo $page['id'] ?>"<?php echo $serendipity['POST']['staticpage'] == $page['id'] ? ' selected="selected"' : ''; ?>><?php echo str_repeat('&nbsp;&nbsp;', $page['depth']) . htmlspecialchars($page['pagetitle']) ?></option>
<?php
                                } else {
                                    $ps_option[] = '<option value="' . $page['id'] . '"' . ($serendipity['POST']['staticpage'] == $page['id'] ? ' selected="selected"' : '') . '>' . str_repeat('&nbsp;&nbsp;', $page['depth']) . htmlspecialchars($page['pagetitle']) . '</option>'."\n";
                                }
                            }
                        }
                    }
                    if ($is_smarty && isset($ps_option)) {
                        $serendipity['smarty']->assign('sp_defpages_pop', $ps_option);
                    }
                    if (!$is_smarty) {
?>
        </select>
        <input class="serendipityPrettyButton input_button" type="submit" name="serendipity[staticSubmit]" value="<?php echo GO ?>" /> <strong>-<?php echo WORD_OR ?>-</strong>
        <input type="submit" name="serendipity[staticDelete]" onclick="return confirm('<?php echo sprintf(DELETE_SURE, '\' + document.getElementById(\'staticpage_dropdown\').options[document.getElementById(\'staticpage_dropdown\').selectedIndex].text + \'')  ?>');" class="serendipityPrettyButton input_button" value="<?php echo DELETE  ?>" />
        <strong>-<?php echo WORD_OR ?>-</strong> <input class="serendipityPrettyButton input_button" type="submit" name="serendipity[staticPreview]" value="<?php echo PREVIEW ?>" />
<?php
                    }
                    if ($sbplav) {
                        if (!$is_smarty) {
?>
        <div style="cursor: pointer; float: right;">
            <img style="vertical-align: middle;" class="attention" title="Staticpage Sidebar <?php echo STATICPAGE_PLUGIN_AVAILABLE ?>" src="<?php echo serendipity_getTemplateFile('admin/img/admin_msg_note.png') ?>" alt="info" />
        </div>
<?php
                        } else {
                            $serendipity['smarty']->assign('sp_defpages_sbplav', true);
                        }
                    }
                    if (!$is_smarty) {
?>
    </div><!-- class sp_pageselector end -->
<?php
                    } //!is_smarty end
                    if (!empty($serendipity['POST']['staticPreview'])) {
                        $link = $serendipity['baseURL'] . $serendipity['indexFile'] . '?serendipity[staticid]=' . $this->staticpage['id'] . '&serendipity[staticPreview]=1';
                        if (!$is_smarty) {
                            echo '<script type="text/javascript">';
                            echo 'var staticpage_preview = window.open("' . $link . '", "staticpage_preview");' . "\n";
                            echo 'staticpage_preview.focus();' . "\n";
                            echo '</script>';
                        } else {
                            $serendipity['smarty']->assign('sp_defpages_link', $link);
                        }
                        $serendipity['POST']['staticSubmit'] = true;
                        if (!$is_smarty) {
                            echo '<p>' . sprintf(PLUGIN_STATICPAGE_PREVIEW, '<a href="' . $link . '">' . $this->staticpage['pagetitle'] . '</a>') . '</p>';
                        } else {
                            $serendipity['smarty']->assign('sp_defpages_pagetitle', $this->staticpage['pagetitle']);
                        }
                    }

                    if ($serendipity['POST']['staticSubmit'] || isset($serendipity['GET']['staticid'])) {
                        $serendipity['POST']['plugin']['custom'] = $this->staticpage['custom'];
                        if (!$is_smarty) {
?>
    <div>
        <input type="hidden" name="serendipity[staticSave]" value="true" />
    </div>
<?php
                        } else {
                            $serendipity['smarty']->assign('sp_defpages_staticsave', true);
                        }
                        ob_start();
                        $this->showForm($this->config, $this->staticpage, 'introspect_item', 'get_static', 'staticSubmit', $is_smarty);
                        #$this->showForm($this->config, $this->staticpage);//org
                        $smarty_showform = ob_get_contents();
                        ob_end_clean();
                        if (!$is_smarty) {
                            echo $smarty_showform;
                        } else {
                            $serendipity['smarty']->assign('sp_defpages_showform', $smarty_showform);
                        }
                    }
                    if (!$is_smarty) {
?>
</form><!-- sp select form bar end -->
<?php
                    }
                } else {
                    if (empty($serendipity['POST']['backend_template'])) {
                        if (!empty($serendipity['COOKIE']['backend_template'])) {
                            $serendipity['POST']['backend_template'] = $serendipity['COOKIE']['backend_template'];
                        }
                    }
                    if ($serendipity['POST']['listentries_formSubmit'] || $serendipity['GET']['staticid']) {
                        ob_start();
                        $this->showForm($this->config, $this->staticpage, 'introspect_item', 'get_static', 'staticSubmit', $is_smarty);
                        #$this->showForm($this->config, $this->staticpage);//org
                        $smarty_showform = ob_get_contents();
                        ob_end_clean();
                        if (!$is_smarty) {
                            echo $smarty_showform;
                        } else {
                            $serendipity['smarty']->assign('sp_defpages_showform', $smarty_showform);
                        }
                    } else {
                        if (!$is_smarty) {
                            $this->listStaticPages();
                        } else {
                            $serendipity['smarty']->assign( array (
                                         'sp_listentries_entries' => $this->fetchStaticPages(),
                                         'sp_listentries_authors' => $this->selectAuthors()
                                         ));
                        }
                    }
                    // TODO: here entryList pagination... (only in case there are too much entries; but then also needed for selectbox default option) - could be a JS pagination by first or via php and external_plugins?
                } //get_config('showlist') end
                break;
        } //end switch

?>