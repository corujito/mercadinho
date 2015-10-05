//= require "jquery.print"

var ready;
ready = function() {
    $('#card_query').autocomplete({
        source: $('#card_query').data('autocomplete-source'),
        select: function( event, ui ) { new_in_out_card(ui.item.value) },
        minLength: 2
    });
};
$(document).ready(ready);
$(document).on('page:load', ready);

function new_in_out_card(id_name_identification) {
    id= id_name_identification.substring(0,id_name_identification.indexOf("."));
    window.location.replace("/in_out_cards/new?card_id=" + id);
}
