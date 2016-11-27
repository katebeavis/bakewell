var ready;
ready = function() {

  $('.fa-chevron-circle-down').on('click', function() {
    $( ".ingredients-fields" ).fadeIn( "slow", function() {
      // Animation complete
    });
  });

};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
