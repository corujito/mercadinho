//= require "jquery.maskMoney.min"

var ready;
ready = function() {
    $('#client_balance').maskMoney({thousands:'.', decimal:',', allowNegative:true});

    $('#client_name_query').autocomplete({
        source: $('#client_name_query').data('autocomplete-source'),
        select: function( event, ui ) { show_client(ui.item.value) },
        minLength: 2
    });
};
$(document).ready(ready);
$(document).on('page:load', ready);

function show_client(full_name) {
    window.location.replace("/clients?full_name=" + full_name);
}