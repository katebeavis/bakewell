var ready;
ready = function() {

  $('.fa-chevron-circle-down').on('click', function() {
    $( ".ingredients-fields" ).fadeIn( "slow", function() {
    });
    $('.title-div').fadeOut('slow', function() {
    })
  });

};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
