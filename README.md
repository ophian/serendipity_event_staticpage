# serendipity_event_staticpage dev

This is a developer repository to smartify the current **S9y** serendipity_event_staticpage plugin and make it available with upcoming Serendipity 2.0.

Please use with care and always keep a backup copy of your updated plugin.

- - -

### ToDo: :arrow_down:
- [ ] deep check, if current changes broke anything with some more enhanced staticpage options (all normal behaviour is checked working!)
- [ ] move new backend template files into own or current backend_template directory ?
- [ ] since now using Smarty 3 only, some Smarty code will need a refresh (no need, but cleaner)
- [ ] howto navigate with large amount of staticpages, beyond 10-15 ?
- [ ] touch frontend template (examples in the plugin dir) for HTML5, inline styles, etc ?
- [ ] solve some last remaining questions pasted as notes

- - -

### Already done: :arrow_up:
- [x] prepare everything to HTML5, which will be the default in future
- [x] prepare everything to shut down plugins hardcoded non-smarty output in future
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
