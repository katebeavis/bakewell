var ready;
ready = function() {

  $('.fa-chevron-circle-down').on('click', function() {
    $( ".ingredients-fields" ).fadeIn( "slow", function() {
    });
    $('.title-div').fadeOut('slow', function() {
    })
  });

  $("tr[data-link]").click(function() {
    window.location = $(this).data("link")
  })

};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
