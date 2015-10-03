//= require "jquery.maskMoney.min"

var ready;
ready = function() {
    $('#custom_input_amount').maskMoney({thousands:'.', decimal:',', allowNegative:false});
};
$(document).ready(ready);
$(document).on('page:load', ready);