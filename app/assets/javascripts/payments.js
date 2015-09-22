//= require "jquery.maskMoney.min"

var ready;
ready = function() {
    $('#payment_client_name').autocomplete({
        source: $('#payment_client_name').data('autocomplete-source'),
        select: function( event, ui ) { new_payment(ui.item.value) },
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

function new_payment(full_name) {
    window.location.replace("/payments/new?full_name=" + full_name);
}
