var ready;
ready = function() {

  $('.first-chevron').on('click', function() {
    $( ".quantity-fields" ).fadeIn( "slow", function() {
    });
    $('.title-div').fadeOut('slow', function() {
    })
  });

  $('.second-chevron').on('click', function() {
    $( ".ingredients-fields" ).fadeIn( "slow", function() {
    });
  });

};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
