//= require "jquery.maskMoney.min"
// require "jquery.inputmask/inputmask/inputmask.min"
// require "jquery.inputmask/inputmask/jquery.inputmask.min"
// require "jquery.inputmask/inputmask/inputmask.numeric.extensions.min"

var ready;
ready = function() {
    $('#purchase_vendor_name').autocomplete({
        source: $('#purchase_vendor_name').data('autocomplete-source'),
        minLength: 2
    });

    $('#purchase_items_attributes_0_product_name').autocomplete({
        source: $('#purchase_items_attributes_0_product_name').data('autocomplete-source'),
        select: function( event, ui ) { get_product_info(ui.item.value, "0") },
        minLength: 2
    });

    $('#purchase_items_attributes_0_unit_price').maskMoney({thousands:'.', decimal:',', allowNegative:false});
    //$('#purchase_items_attributes_0_quantity').inputmask("decimal", {radixPoint: ","});

    $("#new_purchase").on("keyup keypress", function(e) {
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

function get_product_info(full_name, input_id) {
    return $.ajax({
        type: "GET",
        url: "/purchases/find_product_by_full_name",
        data: {
            full_name: full_name,
            input_id: input_id
        }
    });
}

function remove_fields(link) {
    $(link).parent().parent().find('input[type=hidden]').val("1");
    $(link).parent().parent().hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $("#"+link).append(content.replace(regexp, new_id))
    $('#purchase_items_attributes_'+new_id+'_product_name').autocomplete({
        source: $('#purchase_items_attributes_'+new_id+'_product_name').data('autocomplete-source'),
        messages: {noResults: '',results: function() {}},
        select: function( event, ui ) { get_product_info(ui.item.value, new_id) },
        minLength: 2
    });
    $('#purchase_items_attributes_'+new_id+'_product_name').focus();
    $('#purchase_items_attributes_'+new_id+'_unit_price').maskMoney({thousands:'.', decimal:',', allowNegative:false});
    //$('#purchase_items_attributes_'+new_id+'_quantity').inputmask("decimal", {radixPoint: ","});
}