# serendipity_event_staticpage dev

This is a developer repository to smartify the current **S9y** serendipity_event_staticpage plugin and make it available with upcoming Serendipity 2.0.

Please use with care and always keep a backup copy of your updated plugin.

- - -

### ToDo: :arrow_down:
- [ ] deep check, if any change broke anything with some more enhanced staticpage options (all normal behaviour is checked working!)
- [ ] future Todo - check possibility for an automated integration to templates using $template_global_config = array('navigation' => true)
- [ ] future Todo - refactor related category associations


- - -

### Already done: :arrow_up:

- [x] Fix icon-info image notifier not displayed embedded, when sidebar plugin is not installed
- [x] Update jquery.simplePagination.js
- [x] Removed icon font usage and added SVG sprites with 2.0 instead
- [x] Fixed JS spconfig_listPerPage and JS pagination function to happen on listentries pages only
- [x] Changed dtree usage page links world image to something more smart
- [x] Fixed styles now added to the END of eventData stream, while checking for existing styles (dtree)
- [x] Add configuration grouper
- [x] Add new config option to list entries paginate by N entries
- [x] Add separators to streamed css
- [x] Removed $serendipity['staticpageplugin']['JS_init'] since this had no effect for the dtree.js call
- [x] Fixed dtree.js being included more than once, by making the called script name unique
- [x] Fixed missing dtree.css includement, in case of having selected this option
- [x] Fixed cookie issue with backend form template. Set responsive_template.tpl as "default" fallback on S9y >= 2.0
- [x] Removed an old and wrong used registration, since 'in_array' already is an allowed $php_function, since S9y-1.7
- [x] Fixed default selected fallback backend form when unset or expired cookie
- [x] Fixed 2.0 backend template form chaining (4.08) and merge array backend form names uniquely
- [x] Fixed preview button for existing pages with 2.0
- [x] New: iconized entrylist/entryform tabbar for 2.0
- [x] better use fixUTFEntity method only for frontend template vars (articleformatitle and headline)
- [x] set backends form textformat option automatically to NO, on WYSIWYG usage (?) Yes. Has dependency in 2.0 entryproperties!
- [x] Added - automark an entry as written by Wysiwyg-Editor via custom fields, to disable nl2br markup formating
- [x] Fixed (html)specialchars double_encode to false for native ISO-8859-1 charsets for certain form input/testarea fields in backend and some Smarty output variables in backend/frontend (which updates plugin_staticpage_***.tpl files again)
- [x] added check for new SQLite3 OO database layer with PHP 5.4+
- [x] rename directory backend_templates. There is a risk that existing user template dirs have other files in it (not excluded by backend_show) (?) No.
- [x] move new backend template files into own or current backend_template directory (?) No.
- [x] Renamed style_sp_s9yold.css to staticpage_backend.old.css
- [x] Renamed old_backend_staticpage.tpl to backend_staticpage.old.tpl
- [x] Re-integrated previously outsourced backend_show.php
- [x] Fixed htmlspecialchars() for PHP >=5.4 with native, non-utf-8 language installs, which changed with PHP 5.4 from ISO-8859-1 to UTF-8
- [x] Added new README_FOR_CUSTOM_FIELDS.txt
- [x] Added new custom template, which now holds existing examples for custom properties, based on responsive template. This removes the custom examples in the responsive template.
- [x] Some small fixes https://github.com/ophian/serendipity_event_staticpage/compare/v4.27...master?diff=unified
- [x] Associated 1:1 relation for staticpage related categories. Touches staticpages and staticpage_categorypage tables to support the latter 1:1 relations only, as of now. Old entries don't get touched by this, until they will be updated.
- [x] Solve some last remaining questions pasted as '// RQ: ' notes (+ + + + +)
- [x] Removed commented $related_category_entries code, since being unneeded for the solution with serendipity_fetchPrintEntries and unworth to keep, since not really working.
- [x] Removed old and unused getSistersID method
- [x] Removed old and unused sequencer pageorder methods to use with javascript drag & drop only
- [x] Fixed 2.0 Markup in category hook, the example markup in related category Readme, set some more form info and minor association with related category id and the corresonding table on delete
- [x] Added more backend title attribute information for pageorder and entrylisting titles
- [x] Touch frontend templates (in this plugin dir) for HTML5, inline styles, Navigations, etc
- [x] Fix and correct entrypaging, breadcrumb and childpage navigations
- [x] Changed for 2.0: added title attribute #ID to sequencer pagetitle, to know which id is meant by childpages
- [x] Changed for 2.0: fixed save pageorder to work with current current 2.0 changes
- [x] Changed for 2.0: default config value for show entrylist is now true
- [x] Done for 2.0: since now using Smarty 3 only, some Smarty code will need a refresh (no need, but cleaner)
- [x] Main backend CSS was renamed to staticpage_backend.css and now includes seperately into backends page header
- [x] Added for 2.0: include new staticpage_backend.js to templates page footer - no need to use 2.0 js hook
- [x] Hide/Show the top tab bar menu per JS hideaway, since not used very often
- [x] Add sorting filter function to entrylists - no need, since using simplePagination now (!)
- [x] Navigate with larger amount of entrylist pages per newly added simplePagination.js, fits nice from 8 to some deci- pages
- [x] Note, that some constants were added, removed or changed
- [x] Added some missing and changed some method PHPDocs
- [x] Added for 2.0: experimental entrylistings (entrylisting and pageorder sequencer) respect parent/child staticpages treeview listing in a simple way
- [x] Added for 2.0: collapsible boxes icon change and use a universal setLocalStorage() and another for retrieve
- [x] Added new simpler pageorder table fetcher
- [x] Added for 2.0: form submit save-toolbar-button is now disabled when using the CKEDITOR full-package
- [x] Added compat fallback to defaultform_template in case of cookie stored 'all fields/non-template' (old hardcoded) form
- [x] Changed method name getSystersID() to getSisterID()
- [x] prepare everything to HTML5, which will be the default in future
- [x] prepare everything and purge plugins hardcoded non-smarty output
- [x] remove the 'no template' hardcoded stuff
- [x] Plain Editor button changes for the 2.0 backend
- [x] Extend required Serendipity version to 1.7 and Smarty 3.1, since the old_backend_staticpage.tpl would need too much old Smarty2 and CSS fixes
- [x] Added confirmation dialog on select change page events, to avoid saving into wrong page accidently
- [x] Moved listentries _new submit footer to also show up on empty list
- [x] Added new config option to show last_modified or created_on date in plugin_staticpage.tpl (needs to change templates with already supplied files!)
- [x] Applied some plain button changes for 2.0 previously bumped as 4.06
- [x] Added a responsive custom (mobile) template, to replace the old 'no Template' (previously named 'All Fields' form)
- [x] finalize the version stylesheets for this
- [x] finalize 'backend_staticpage.tpl' for Serendipity 2.0 only usage
- [x] keep 'old_staticpage_backend.tpl' for previous S9y versions
- [x] Reworked default form template by switching new_backend
- [x] Added new 'pagetype' typeform template
- [x] Set required S9y version to 1.6, due to smarty usage in sequencer 'pageorder' drag&drop
- [x] Smartified the backend as much as possible
- [x] Outsourced and changed some heavy markup functions, due to a better overview
- [x] Changed form template names
- [x] Added in 'pageorder' a new drag&drop sequencer, to automatically set the new list order on drop
- [x] Added some css and include by version files
- [x] Fixed tabs and 'pageadd' markup/css
- [x] Fixed backend_templates/default_staticpage_backend.tpl smarty markup (escape and cke-wysiwyg)
- [x] Fixed some plugin file code inconsistencies
- [x] Fixed some minor markup errors
- [x] New option: sets publishstatus (default draft) as default
- [x] New option: sets listentries (selectbox default), due to errors in combination with selectlist
- [x] Fixed (4.06) new entrylist markup
