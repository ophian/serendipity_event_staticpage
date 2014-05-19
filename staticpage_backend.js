/***
 * Staticpage event backend js
 * Last modified: 2014-05-19
 **/

/**
 * setLocalStorage function to store 'remember option' states with modern browsers
 * param: item name
 * param: item value
 **/
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

/**
 * setTabBar function to hide top tab navigation bar
 * param: object button
 **/
setTabBar = (function(b) {
    if ($('#serendipityStaticpagesNav').is(":visible")) {
        $('#serendipityStaticpagesNav').fadeOut(function(){
            $('#sp_navigator').css({'margin-top' : '1.54em'});
            $(b).text('Show TabBar').removeClass('icon-up-dir').addClass('icon-down-dir');
            setLocalStorage('staticpageTabBar', true);
        }); return false;
    } else {
        $('#serendipityStaticpagesNav').fadeIn(function(){
            $('#sp_navigator').removeAttr('style');
            $(b).text('Hide TabBar').removeClass('icon-down-dir').addClass('icon-up-dir');
            localStorage.removeItem('staticpageTabBar');
        }); return false;
    }
});

/**
 * saveNewOrder function to save moved sequencers order ids
 **/
saveNewOrder = (function() {
    var a = [];
    $('#sequence').children().each(function (i) {
        a.push($(this).attr('id'));
    });
    var s = a.join(',');
    $.ajax({
        url: '?serendipity[adminModule]=staticpages&serendipity[moveto]=move&serendipity[pagemoveorder]='+s+'&serendipity[adminModule]=event_display&serendipity[adminAction]=staticpages&serendipity[staticpagecategory]=pageorder',
        context: document.body,
        success: function() {
            $('#splistorder').html('<span class=\"icon-ok\"></span> New staticpage pageorder list '+s+' successfully saved');
        }
    });
});

// create, set, check and bind a tab bar hide/show event button
$(function() {
    var stb = localStorage.getItem('staticpageTabBar');
    var el  = '<span id="sp_tabbar" class="button_link sp-btn sp_right icon-up-dir"></span>';
    if ( stb !== null ) {
        $('#serendipityStaticpagesNav').hide(function(){
            // since is removed navigation top tab bar, correct navigator box margin-top to #content
            $('#sp_navigator').css({'margin-top' : '1.54em'});
            // hidden set tab bar needs to create button and bind event handler
            if ($('#sp_tabbar').length == 0) {
                //  to navigator
                $('#sp_navigator input.entry_preview').after(el);
                //  to footer
                $('.sp_listfooter').find("input:last").after(el);
                // and bind click handler
                $('#sp_tabbar').on('click', function(){
                    setTabBar(this);
                })
            };
            $('#sp_tabbar').text('Show TabBar').removeClass('icon-up-dir').addClass('icon-down-dir');
        });
    } else {
        // case: nothing is set, append to listentries footer bar
        $('.sp_listfooter').find("input:last").after(el);
        // case: nothing is set, append to navigator box
        $('#sp_navigator input.entry_preview').after(el);
        // case: set the dynamically created button text
        $('#sp_tabbar').text('Hide TabBar');
        // case: bind click handler
        $('#sp_tabbar').on('click', function(){
            setTabBar(this);
        });
    }
});

// staticpage entrieslist simplePagination executor
$(function() {

    var items    = $('#step > .sp_entries_pane');
    var numItems = items.length;
    var perPage  = 6;
    var sp_class = { 'border-bottom' : '1px solid #CCC', 'margin-bottom' : '1em' };

    $('.sp_entries_pane').hide();
    $('#step').css(sp_class);

    // only show the first 6 items initially and hide the rest
    items.show().slice(perPage).hide();

    // now setup pagination
    $('#sp_entry_pagination').pagination({
        items: numItems,
        itemsOnPage: perPage,
        cssStyle: 'light-theme',
        onPageClick: function(pageNumber) { // this is where the magic happens
            // someone changed page, lets hide/show entries appropriately
            var showFrom = perPage * (pageNumber - 1);
            var showTo = showFrom + perPage;

            // first hide everything, then show for the new page
            items.hide().slice(showFrom, showTo).show();
            if (pageNumber == Math.ceil(numItems / perPage)) {
                $('#step').css({'border-bottom' : '', 'margin-bottom' : ''});
            } else {
                $('#step').css(sp_class);
            }
        }
    });
});

// simple staticpage entrieslist pagination executor
$(function() {
    var prev_value;
    $('#staticpage_dropdown').focus(function() {
        prev_value = $(this).val();
    }).change(function(){
        $(this).unbind('focus');
        if (!confirm(dropdown_dialog)){
            $(this).val(prev_value);
            $(this).bind('focus');
            return false;
        } else {
            $(this.form.elements['serendipity[staticSubmit]']).click();
        }
    });
});

// collapsible box executor for staticpage entry forms
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

// overwrite CKE save button in all nugget instances, see extending smarty note in backend_staticpage.tpl
if (typeof(CKEDITOR) != 'undefined' && CKEDITOR.plugins.registered['save']) {
    CKEDITOR.plugins.registered['save'] = {
        init: function (editor) {
            var command = editor.addCommand('save',
            {
                modes: { wysiwyg: 1, source: 1 }
            });
        }
    }
}

$(function() {
    if (! Modernizr.touch){
        function getDragdropConfiguration(group) {
            return {
                containerSelector: '.pluginmanager_container',
                group: group,
                handle: '.pluginmanager_grablet',

                onDrop: function ($item, container, _super) {
                    var placement = $item.parents('.pluginmanager_container').data('placement');
                    $item.find('select[name$="placement]"]').val(placement);
                    $item.removeClass('dragged').removeAttr('style');
                    $('body').removeClass('dragging');
                    saveNewOrder();
                    $.autoscroll.stop();
                },
                onDragStart: function ($item, container, _super) {
                    $.autoscroll.init();
                    $item.css({
                        height: $item.height(),
                        width: $item.width()
                    });
                    $item.addClass('dragged');
                    $('body').addClass('dragging');
                }
            }
        }
        $('.configuration_group .pluginmanager_container').sortable(getDragdropConfiguration('plugins_event'));
    }
});
