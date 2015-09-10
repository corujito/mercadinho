//= require "jquery.maskMoney.min"
//= require "jquery.print"

var ready;
ready = function() {
    $('#order_client_name').autocomplete({
        source: $('#order_client_name').data('autocomplete-source'),
        select: function( event, ui ) { get_client_info(ui.item.value) },
        minLength: 2
    });

    $('#order_order_items_attributes_0_product_name').autocomplete({
        source: $('#order_order_items_attributes_0_product_name').data('autocomplete-source'),
        select: function( event, ui ) { get_product_info(ui.item.value, "0") },
        minLength: 2
    });

    $('#order_order_items_attributes_0_unit_price').maskMoney({thousands:'.', decimal:',', allowNegative:false});
    //$('#order_order_items_attributes_0_quantity').maskMoney({thousands:'.', decimal:',', allowNegative:false});

    // gambis igual do purchase.js
    $('#order_order_items_attributes_1_product_name').autocomplete({
        source: $('#order_order_items_attributes_1_product_name').data('autocomplete-source'),
        select: function( event, ui ) { get_product_info(ui.item.value, "1") },
        minLength: 2
    });
    $('#order_order_items_attributes_1_unit_price').maskMoney({thousands:'.', decimal:',', allowNegative:false});
    $('#order_order_items_attributes_2_product_name').autocomplete({
        source: $('#order_order_items_attributes_2_product_name').data('autocomplete-source'),
        select: function( event, ui ) { get_product_info(ui.item.value, "2") },
        minLength: 2
    });
    $('#order_order_items_attributes_2_unit_price').maskMoney({thousands:'.', decimal:',', allowNegative:false});
    $('#order_order_items_attributes_3_product_name').autocomplete({
        source: $('#order_order_items_attributes_3_product_name').data('autocomplete-source'),
        select: function( event, ui ) { get_product_info(ui.item.value, "3") },
        minLength: 2
    });
    $('#order_order_items_attributes_3_unit_price').maskMoney({thousands:'.', decimal:',', allowNegative:false});
    // fim da gambis

    $("#new_order").on("keyup keypress", function(e) {
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

function get_product_info(full_name, input_id) {
    return $.ajax({
        type: "GET",
        url: "/products/find_product_by_full_name",
        data: {
            full_name: full_name,
            input_id: input_id,
            client_id: client_id
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
    $('#order_order_items_attributes_'+new_id+'_product_name').autocomplete({
        source: $('#order_order_items_attributes_'+new_id+'_product_name').data('autocomplete-source'),
        messages: {noResults: '',results: function() {}},
        select: function( event, ui ) { get_product_info(ui.item.value, new_id) },
        minLength: 2
    });
    $('#order_order_items_attributes_'+new_id+'_product_name').focus();
    $('#order_order_items_attributes_'+new_id+'_unit_price').maskMoney({thousands:'.', decimal:',', allowNegative:false});
    //$('#order_order_items_attributes_'+new_id+'_quantity').maskMoney({thousands:'.', decimal:',', allowNegative:false});
}