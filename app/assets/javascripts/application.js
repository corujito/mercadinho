// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets

var ready;
ready = function() {
    substituir_enter_por_tab();
};
$(document).ready(ready);
$(document).on('page:load', ready);

function substituir_enter_por_tab() {
    //tb nas telas de order e purchase por causa do botao + que adiciona campos dinamicamente
    $('input, select').on("keypress", function(e) {
        /* ENTER PRESSED*/
        if (e.keyCode == 13) {
            /* FOCUS ELEMENT */
            var inputs = $(this).parents("form").eq(0).find(":input:visible:not(disabled):not([readonly])");
            //var type = $(this).attr("type");
            //if (type == "submit") {
            //    return true;
            //}
            var idx = inputs.index(this);

            if (idx == inputs.length - 1) {
                inputs[0].select();
            } else {
                inputs[idx + 1].focus(); //  handles submit buttons
                try {
                    inputs[idx + 1].select();
                } catch(err) {
                    // handle objects not offering select
                }
            }
            return false;
        }
    });
}