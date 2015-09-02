//= require "jquery.maskMoney.min"

var ready;
ready = function() {
    $('#payment_client_name').autocomplete({
        source: $('#payment_client_name').data('autocomplete-source'),
        select: function( event, ui ) { get_client_info(ui.item.value) },
        minLength: 2
    });

    $('#payment_amount').maskMoney({thousands:'.', decimal:',', allowNegative:false});

    $("#new_payment").on("keyup keypress", function(e) {
        var code;
        code = e.keyCode || e.which;
        if (code === 13) {
            e.preventDefault();
            return false;
        }
    });
};
$(document).ready(ready);
$(document).on('page:load', ready);


function get_client_info(full_name) {
    return $.ajax({
        type: "GET",
        url: "/clients/find_client_by_full_name",
        data: {
            full_name: full_name
        }
    });
}
