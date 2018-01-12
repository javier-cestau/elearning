$(document).on('turbolinks:load', function(){
  $('body').addClass('animated fadeIn');
});

$(document).on('turbolinks:request-start', function(){
  $('body').addClass('animated fadeOut');
});
