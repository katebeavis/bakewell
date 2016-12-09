var ready;
ready = function() {

  $('.chevron-anchor-recipes').on('click', function() {
    $( ".ingredients-fields" ).fadeIn( "slow", function() {
    });
    $('.title-div').fadeOut('slow', function() {
    })
  });

  $("tr[data-link]").click(function() {
    window.location = $(this).data("link")
  });

  $('i.fa-chevron-down').mouseover(function(){
      $(this).effect('shake', {distance: 5, times:1}, 100);
  });

};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
