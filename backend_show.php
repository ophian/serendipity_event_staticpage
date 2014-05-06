<?php
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

        $serendipity['smarty']->assign( array (
                     's9y_get_cat' => $serendipity['GET']['staticpagecategory'],
                     's9y_post_cat' => $serendipity['POST']['staticpagecategory']
                     ));

        $spcat = !empty($serendipity['GET']['staticpagecategory']) ? $serendipity['GET']['staticpagecategory'] : $serendipity['POST']['staticpagecategory'];

        $serendipity['smarty']->assign('switch_spcat', $spcat);

        switch($spcat) {
            case 'pageorder':
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
                    $serendipity['smarty']->assign('sp_pageorder_pages', $pages);
                }
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
                    $serendipity['smarty']->assign('sp_pagetype_saveconf', true);
                    $this->updatePageType();
                }

                if (!empty($serendipity['POST']['typeDelete']) && $serendipity['POST']['pagetype'] != '__new') {
                    serendipity_db_query("DELETE FROM {$serendipity['dbPrefix']}staticpages_types WHERE id = " . (int)$serendipity['POST']['pagetype']);
                    $serendipity['smarty']->assign( array (
                                 'sp_pagetype_ripped' => $this->pagetype['description'],
                                 'sp_pagetype_purged' => true
                                 ));
                }

                $types = $this->fetchPageTypes();
                $serendipity['smarty']->assign( array (
                             'sp_pagetype' => true,
                             'sp_pagetype_types' => $types
                             ));

                if (isset($serendipity['POST']['typeSubmit'])) {
                    $serendipity['POST']['staticSubmit'] = true;//??
                    $serendipity['POST']['plugin']['custom'] = $this->staticpage['custom'];//?? what for?
                    if ($serendipity['version'][0] == '2') $serendipity['smarty']->assign('new_backend', true);
                    $serendipity['POST']['backend_template'] = 'typeform_staticpage_backend.tpl';
                    $bag = new serendipity_property_bag();
                    $this->introspect($bag);
                    $name = htmlspecialchars($bag->get('name'));
                    $desc = htmlspecialchars($bag->get('description'));
                    $config_t = $bag->get('type_configuration');

                    foreach($config_t as $config_item) {
                        $cbag = new serendipity_property_bag();
                        if ($this->introspect_item_type($config_item, $cbag)) {
                            $this->pagetype[$config_item] = serendipity_get_bool($serendipity['POST']['plugin'][$config_item]);
                        }
                    }
                    $serendipity['smarty']->assign('sp_pagetype_submit', true);
                    ob_start();
                    $this->showForm($this->config_types, $this->pagetype, 'introspect_item_type', 'get_type', 'typeSubmit');
                    $smarty_pagetypeshowform = ob_get_contents();
                    ob_end_clean();
                    $serendipity['smarty']->assign( array(
                                 'sp_pagetype_isshowform' => true,
                                 'sp_pagetype_showform' => trim($smarty_pagetypeshowform)
                                 ));// showform is a string!
                }
                break;

            case 'pageadd':
                if (isset($serendipity['POST']['staticpagecategory']) && isset($serendipity['POST']['typeSubmit'])) {
                    if ($serendipity['POST']['staticpagecategory'] == 'pageadd'/* && (is_array($serendipity['POST']['externalPlugins']) && !empty($serendipity['POST']['externalPlugins']))*/) { //externalPlugins do what?
                        $serendipity['smarty']->assign('sp_addsubmit', true);
                    }
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
                    $serendipity['smarty']->assign( array (
                                 'sp_pageadd_plugins' => $plugins,
                                 'sp_pageadd_insplugins' => $insplugins
                                 ));
                }

                $this->pluginstatus();

                $serendipity['smarty']->assign('sp_pageadd_plugstats', $this->pluginstats);
                break;

            case 'pages':
            default:

                if ($serendipity['POST']['staticpage'] != '__new') {
                    $this->fetchStaticPage($serendipity['POST']['staticpage']);
                }
                if ($serendipity['POST']['staticSave'] == "true" && !empty($serendipity['POST']['SAVECONF'])) {
                    $serendipity['POST']['staticSubmit'] = true;
                    $serendipity['smarty']->assign('sp_staticsubmit', true);
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

                    $serendipity['smarty']->assign('sp_defpages_upd_result', is_string($result) ? $result : null);
                }

                if (!empty($serendipity['POST']['staticDelete']) && $serendipity['POST']['staticpage'] != '__new') {
                    $serendipity['smarty']->assign('sp_staticdelete', true);
                    if (!$this->getChildPage($serendipity['POST']['staticpage'])) {
                        serendipity_db_query("DELETE FROM {$serendipity['dbPrefix']}staticpages WHERE id = " . (int)$serendipity['POST']['staticpage']);
                        $serendipity['smarty']->assign('sp_defpages_rip_success', DONE .': '. sprintf(RIP_ENTRY, $this->staticpage['pagetitle']));
                    }
                }

                if (false===serendipity_db_bool($this->get_config('showlist')) || isset($serendipity['POST']['staticpage']) ) {
                    // this is the default SELECT list block
                    $serendipity['smarty']->assign('sp_defpages_showlist', false);

                    if (empty($serendipity['POST']['backend_template'])) {
                        if (!empty($serendipity['COOKIE']['backend_template'])) {
                            $serendipity['POST']['backend_template'] = $serendipity['COOKIE']['backend_template'];
                        }
                        $serendipity['smarty']->assign('sp_defpages_jsCookie', '');
                    } else {
                        $serendipity['smarty']->assign('sp_cookie_value', urlencode($serendipity['POST']['backend_template']));
                    }

                    // this file is located in backend_template dir, but needs to be excluded from select form array.
                    // ToDo: we might want to live and push all other used backend templates here also
                    $exclude_files = array ('typeform_staticpage_backend.tpl');
                    $dh = @opendir(dirname(__FILE__) . '/backend_templates');
                    if ($dh) {
                        while ($file = readdir($dh)) {
                            if (!in_array($file, $exclude_files) && preg_match('@^(.*).tpl$@i', $file, $m)) {
                                if (isset($m[1]) && !empty($m[1])) $templateName = ucwords(str_replace('_', ' ', $m[1]));
                                // this is, while the file was named 'default_staticpage_backend.tpl' before, to not have compat issues with new staticpage plugin
                                // new files follow naming eg. 'responsive_template.tpl', to show up as 'Responsive Template' in sp_templateselector select form
                                if ($templateName == 'Default Staticpage Backend') $templateName = STATICPAGE_TEMPLATE_EXTERNAL;
                                $ts_option[] = '<option ' . ($file == $serendipity['POST']['backend_template'] ? 'selected="selected" ' : '') . 'value="' . htmlspecialchars($file) . '">' . htmlspecialchars($templateName) . '</option>'."\n";
                            }
                        }
                    }
                    $dh = @opendir($serendipity['templatePath'] . $serendipity['template'] . '/backend_templates');
                    if ($dh) {
                        while ($file = readdir($dh)) {
                            if (!in_array($file, $exclude_files) && preg_match('@^(.*).tpl$@i', $file, $m)) {
                                if (isset($m[1]) && !empty($m[1])) $templateName = ucwords(str_replace('_', ' ', $m[1]));
                                // see upper note
                                if ($templateName == 'Default Staticpage Backend') $templateName = STATICPAGE_TEMPLATE_EXTERNAL;
                                $ts_option[] = '<option ' . ($file == $serendipity['POST']['backend_template'] ? 'selected="selected" ' : '') . 'value="' . htmlspecialchars($file) . '">' . htmlspecialchars($templateName) .'</option>'."\n";
                            }
                        }
                    }
                    if (isset($ts_option) && is_array($ts_option)) {
                        $serendipity['smarty']->assign('sp_defpages_top', $ts_option);
                    }

                    $pages = $this->fetchStaticPages();
                    if(is_array($pages)) {
                        $pages = serendipity_walkRecursive($pages);
                        foreach ($pages as $page) {
                            if ($this->checkPageUser($page['authorid'])) {
                                $ps_option[] = '<option value="' . $page['id'] . '"' . ($serendipity['POST']['staticpage'] == $page['id'] ? ' selected="selected"' : '') . '>' . str_repeat('&nbsp;&nbsp;', $page['depth']) . htmlspecialchars($page['pagetitle']) . '</option>'."\n";
                            }
                        }
                    }
                    if (isset($ps_option) && is_array($ps_option)) {
                        $serendipity['smarty']->assign('sp_defpages_pop', $ps_option);
                        //$serendipity['smarty']->assign('sp_selected_id', $serendipity['POST']['staticpage'] == $page['id'] ? $page['id'] : '');//debug
                    }

                    if ($sbplav) {
                        $serendipity['smarty']->assign('sp_defpages_sbplav', true);
                    }

                    if (!empty($serendipity['POST']['staticPreview'])) {
                        $link = $serendipity['baseURL'] . $serendipity['indexFile'] . '?serendipity[staticid]=' . $this->staticpage['id'] . '&serendipity[staticPreview]=1';
                        $serendipity['smarty']->assign('sp_defpages_link', $link);
                        $serendipity['POST']['staticSubmit'] = true;
                        $serendipity['smarty']->assign('sp_defpages_pagetitle', $this->staticpage['pagetitle']);
                    }

                    if ($serendipity['POST']['staticSubmit'] || isset($serendipity['GET']['staticid'])) {
                        $serendipity['POST']['plugin']['custom'] = $this->staticpage['custom'];
                        $serendipity['smarty']->assign('sp_defpages_staticsave', true);
                        ob_start();
                        $this->showForm($this->config, $this->staticpage, 'introspect_item', 'get_static', 'staticSubmit');
                        $smarty_showform = ob_get_contents();
                        ob_end_clean();
                        $serendipity['smarty']->assign('sp_defpages_showform', $smarty_showform);
                    }

                } else {
                    if (empty($serendipity['POST']['backend_template'])) {
                        if (!empty($serendipity['COOKIE']['backend_template'])) {
                            $serendipity['POST']['backend_template'] = $serendipity['COOKIE']['backend_template'];
                        }
                    }
                    if ($serendipity['POST']['listentries_formSubmit'] || $serendipity['GET']['staticid']) {
                        ob_start();
                        $this->showForm($this->config, $this->staticpage, 'introspect_item', 'get_static', 'staticSubmit');
                        $smarty_showform = ob_get_contents();
                        ob_end_clean();
                        $serendipity['smarty']->assign('sp_defpages_showform', $smarty_showform);
                    } else {
                        $serendipity['smarty']->assign( array (
                                     'sp_listentries_entries' => $this->fetchStaticPages(),
                                     'sp_listentries_authors' => $this->selectAuthors()
                                     ));
                    }
                    // TODO: here entryList pagination... (only in case there are too much entries; but then also needed for selectbox default option) - could be a JS pagination by first or via php and external_plugins?
                } //get_config('showlist') end
                break;
        } //end switch

?>