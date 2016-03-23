var ready;
ready = function() {
    $('#product_name_query').autocomplete({
        source: $('#product_name_query').data('autocomplete-source'),
        select: function( event, ui ) { show_product(ui.item.value) },
        minLength: 2
    });
};
$(document).ready(ready);
$(document).on('page:load', ready);

function show_product(full_name) {
    window.location.replace("/products?full_name=" + full_name);
}