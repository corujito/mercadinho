//= require "jquery.print"
//= require bootstrap-datepicker
//= require "jquery.maskMoney.min"

var ready;
ready = function() {
    $('#card_query').autocomplete({
        source: $('#card_query').data('autocomplete-source'),
        select: function( event, ui ) { new_in_out_card(ui.item.value) },
        minLength: 2
    });

    $('.datetimepicker').datepicker({
        orientation: "top",
        language: "pt-BR",
        format: "dd/mm/yyyy"
    });

    $('#value').maskMoney({thousands:'.', decimal:',', allowNegative:false});
    $('#in_out_card_value').maskMoney({thousands:'.', decimal:',', allowNegative:false});

    $('#myModal').on('shown.bs.modal', function () {
        $('#value').focus();
        //    var button = $(event.relatedTarget) // Button that triggered the modal
        //    var id = button.data('id') // Extract info from data-* attributes
        //    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        //    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        //    var modal = $(this)
        //    //modal.find('.modal-title').text('New message to ' + recipient)
        //    modal.find('.modal-body input').val(id)
    })

    $('#myModal').on('hidden.bs.modal', function (e) {
        $('#card_id').val("");
        $('#card_query').val("");
    })
};
$(document).ready(ready);
$(document).on('page:load', ready);

function new_in_out_card(id_name_identification) {
    id= id_name_identification.substring(0,id_name_identification.indexOf("."));
    $('#card_id').val(id);
    $('#card_owner').val(card_owner_id);
    $('#myModal').modal('show');
    //window.location.replace("/in_out_cards/new?card_id=" + id + "&card_owner=" + card_owner_id);
}