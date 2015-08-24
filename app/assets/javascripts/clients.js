//= require "jquery.maskMoney.min"

var ready;
ready = function() {
    $('#client_balance').maskMoney({thousands:'.', decimal:',', allowNegative:true});
};
$(document).ready(ready);
$(document).on('page:load', ready);