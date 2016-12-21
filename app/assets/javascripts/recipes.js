var ready;
ready = function() {

  $('.chevron-anchor-recipes').on('click', function() {
    $( ".hidden-field" ).fadeIn( "slow", function() {
    });
    $('.title-div').fadeOut('slow', function() {
    })
  });

  $("tr[data-link]").click(function() {
    window.location = $(this).data("link")
  });

  $('i.fa-chevron-down').mouseover(function(){
      $(this).effect('bounce', {distance: 5, times:1}, 400);
  });

};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
