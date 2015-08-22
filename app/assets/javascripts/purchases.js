var ready;
ready = function() {
    $('#purchase_vendor_name').autocomplete({
        source: $('#purchase_vendor_name').data('autocomplete-source'),
        minLength: 2
    });

    $('#purchase_items_attributes_0_product_name').autocomplete({
        source: $('#purchase_items_attributes_0_product_name').data('autocomplete-source'),
        minLength: 2
    });

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
        minLength: 2
    });
    $('#purchase_items_attributes_'+new_id+'_product_name').focus();
}