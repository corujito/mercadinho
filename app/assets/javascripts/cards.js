var ready;
ready = function() {
    $('#card_query').autocomplete({
        source: $('#card_query').data('autocomplete-source'),
        select: function( event, ui ) { show_card(ui.item.value) },
        minLength: 2
    });
};
$(document).ready(ready);
$(document).on('page:load', ready);

function show_card(id_name_identification) {
    id= id_name_identification.substring(0,id_name_identification.indexOf("."));
    window.location.replace("/cards/" + id);
}