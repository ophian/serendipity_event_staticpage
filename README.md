# serendipity_event_staticpage dev
- - -

This is a developer repository to smartify the current **S9y** serendipity_event_staticpage plugin and make it available with upcoming Serendipity 2.0.

Please use with care and always keep a backup copy of your updated plugin.

- - -

### ToDo:
- [ ] finalize 'backend_staticpage.tpl' for Serendipity 2.0 only usage, keep 'old_staticpage_backend.tpl' for previous S9y versions
- [ ] finalize the version stylesheets for this
- [ ] create a smarty template for the unstructered staticpage form (which is currently the 'no template' select switch, build by hardcoded stuff)
- [ ] deep check, if current changes broke anything with some more enhanced staticpage options, all normal behaviour is ckecked working
- [ ] prepare everything to hold a HTM5 version, which will be the default in future
- [ ] prepare everything to shut down every hardcoded non-smarty output in future
- [ ] structure backend template files in new directory?

- - -

### Already done:
- [x] Added new 'pagetype' typeform template
- [x] Set required version to 1.6, due to smarty usage in sequencer 'pageorder' drag&drop
- [x] Smartified the backend as much as possible
- [x] Outsourced and changed some heavy markup functions, due to a better overview
- [x] Changed form template names
- [x] Added in 'pageorder' a new drag&drop sequencer, to automatically set the new list order on drop
- [x] Added some css and include by version files
- [x] Fixed tabs and 'pageadd' markup/css
- [x] Fixed backend_templates/default_staticpage_backend.tpl smarty markup (escape and cke-wysiwyg)
- [x] Fixed some plugin file code inconsistencies
- [x] Fixed some minor markup errors
- [x] Fixed (4.06) new entrylist markup and sets (4.06 listentries) to be optional (selectbox default), due to errors in combination with selectlist
