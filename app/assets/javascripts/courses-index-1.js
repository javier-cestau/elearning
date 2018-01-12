/*jshint esversion: 6 */

document.addEventListener("turbolinks:load", function(){
  // Se comprueba si esta en alguna de las dos paginas de course sea NEW o EDIT
  if( PageFile == 1 )
  {
    IniatilizeComponents();
  }


  function IniatilizeComponents(){

    $("#order-courses").change(function(ev){
      var str = "";
      $( "#order-courses option:selected" ).each(function() {
        var url_string = $(location).attr('href');
        var url = new URL(url_string);
        url.searchParams.set("order",$(this).val());
        window.location.replace(url);
      });
    });
  }



}); // fin total
