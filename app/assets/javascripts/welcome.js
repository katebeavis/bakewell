var ready;
ready = function() {
  $('a i.fa-chevron-down').mouseover(function(){
      $(this).effect('bounce', {distance: 5, times:1}, 400);
  });

  $('.type-it').typeIt({
       speed: 80,
       lifeLike: true
  })
  .tiType('&ldquo; Helping you to bake ')
  .tiPause(1000)
  .tiSettings({speed: 80})
  .tiType('good &rdquo;')
  .tiPause(800)
  .tiDelete(6)
  .tiPause(800)
  .tiType('great &rdquo;')
  .tiPause(800)
  .tiDelete(7)
  .tiPause(1500)
  .tiType('well &rdquo;')

  $(function() {
    $('a[href*="#"]:not([href="#"])').click(function() {
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
        if (target.length) {
          $('html, body').animate({
            scrollTop: target.offset().top
          }, 300);
          return false;
        }
      }
    });
  });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
