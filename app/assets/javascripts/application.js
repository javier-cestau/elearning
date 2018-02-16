// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require jquery-fileupload/basic
//= require materialize-sprockets
//= require flipclock.min
//= require tinymce-jquery
//= require Chart.min
//= require jquery-ui/widgets/sortable
//= require jquery-ui/widgets/dialog
//= require jquery-ui/effect.all
//= require jquery.slick
//= require turbolinks
//= require turbolinks_transitions
//= require application
//= require_tree .


// window.onbeforeunload = function() {
//   return "Data will be lost if you leave the page, are you sure?";
// };




$(window).scroll(function(){

  if($(this).scrollLeft() > 350)
  {
    $("#hidden-message").addClass("display-inline-block")
  }
  else{
    $("#hidden-message").removeClass("display-inline-block")
  }
})
    //Para que no se carguen los script de otras paginas
var PageFile = 0;
var json_notifications;
var user_id;

function GetUserId(){
  user_id = $(".usuario").attr("id").split("user-")[1];
}

function AddOrRemoveFromFavorites(){

   var course_id;

  $(".favorite-button").click(function(){

     // Se obtiene el id del curso que sera agregado/eliminado de favoritos
       course_id = $(this).attr("id").split("f-btn")[1];

     // Se obtiene el valor del boton, para calcular si el curso se agregara o eliminara de favoritos
     value = $(this).attr("value");

           $.ajax({
             url : '/courses/'+course_id+'/favorite',
             type : 'get',
             dataType:'html',
             success : function() {


               // Si el valor es 1, el curso sera agregado a favoritos
               if ( value == 1 ) {

                 // Por lo tanto, el icono sera cambiado al de "eliminar de favoritos"
                 $("#f-icon"+course_id).removeClass('add-favorite').addClass('remove-favorite');
                 $("#f-btn"+course_id).attr('value', 2);
                 // Se cambia el tooltip también
                 $("#f-btn"+course_id).attr('data-tooltip', "Eliminar de favoritos");
                 $('.tooltipped').tooltip({delay: 50});


                 // Si el valor es 2, es para eliminar de favoritos
               } else if ( value == 2 ) {

                   // Por lo tanto, el icono sera cambiado al de "Agregar a favoritos"
                 $("#f-icon"+course_id).removeClass('remove-favorite').addClass('add-favorite');
                 $("#f-btn"+course_id).attr('value', 1);
                 // Se cambia el tooltip también
                 $("#f-btn"+course_id).attr('data-tooltip', "Agregar a favoritos");
                $('.tooltipped').tooltip({delay: 50});
               }

                  },
             error : function(request,error)
             {

               console.log(request);
               console.log(error);

             }

           }); //fin del ajax

  }); //fin de favorite-button.click function


} //fin de function AddOrRemoveFromFavorites ()

function AddNotificationCounter(){

            var audio = new Audio('/system/audio/notification.mp3');
            audio.play();
            var el = $(".notification");

            var count = el.attr('data-count');

            el.removeClass('nothing-notification');

            if(count !== "99+"){

             count = Number(el.attr('data-count')) || 0;
             if(count > 99 ){
               el.attr('data-count', "99+");
               $(".mobile-notification").text("99+");

             }
             else{
               el.attr('data-count', count + 1);
                $(".mobile-notification").text(count + 1);
             }



            }
            else{
              el.attr('data-count', "99+");
              $(".mobile-notification").text("99+");

            }

            el.removeClass('notify');
            el.offsetWidth = el.offsetWidth;
            el.addClass('notify');
            if(count === 0){
                el.addClass('show-count');
            }
}
function SubtractNotificationCounter(){

            var el = $(".notification");
            var count = el.attr('data-count');
            if(count > 0){

              count--;
            }

            if(count === 0){
              el.addClass('nothing-notification');
            }

               el.attr('data-count', count);
                $(".mobile-notification").text(count);

}



document.addEventListener("turbolinks:load", function(){
   
  $('input.autocomplete').autocomplete({
  data: gon.sections_url,
  limit: 20,
  onAutocomplete: function(val) {
    console.log("hola");
  },
  minLength: 1
});

  PageFile = 0;


    GetUserId();


  $('#approved_course').modal();
  $('#approved_course').modal('open');

  $('.timeago').timeago();




  $("#form-search > input[name='utf8']").remove();
  $("#form-search > input[name='commit']").attr("name", "");



  if ( $('body').hasClass('courses')) {

    if ( $('body').hasClass('edit') ||  $('body').hasClass('new') ||  $('body').hasClass('create')) {
        PageFile = 2;

    }

    if ( $('body').hasClass('index') ) {

      PageFile = 1;
    }
    if ( $('body').hasClass('report') ) {
        PageFile = 7;

    }



    if ( $('body').hasClass('show') ) {
        PageFile = 8;

    }



  }

  if ( $('body').hasClass('sections')) {

    if ( $('body').hasClass('edit') ) {
        PageFile = 3;

    }
    if ( $('body').hasClass('show') ) {
        PageFile = 9;

    }

  }

  if ( $('body').hasClass('templates')) {

      if ( $('body').hasClass('new') ) {
          PageFile = 4;

      }

  }

  if ( $('body').hasClass('template')) {

      if ( $('body').hasClass('show') ) {
          PageFile = 10;

      }

  }

  if ( $('body').hasClass('talents')) {

      if ( $('body').hasClass('new') || $('body').hasClass('edit')  ) {
          PageFile = 5;

      }
      if ( $('body').hasClass('index') ) {
          PageFile = 6;

      }
      if ( $('body').hasClass('talent_progress') ) {
          PageFile = 11;

      }
      if ( $('body').hasClass('profile') ) {
          PageFile = 12;

      }
  }

  if ( $('body').hasClass('tests')) {

    if ( $('body').hasClass('new') || $('body').hasClass('edit')  ) {
        PageFile = 13;

    }

    if ( $('body').hasClass('show')) {
      PageFile = 14;
    }


    if ( $('body').hasClass('average') ) {
      PageFile = 15;

    }
  }
  if ( $('body').hasClass('profiles')) {

    if ( $('body').hasClass('new')   ) {
        PageFile = 16;

    }

    if ( $('body').hasClass('edit')   ) {
        PageFile = 17;

    }


  }

      AddOrRemoveFromFavorites();

});
