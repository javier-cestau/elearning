
function fill_county(state){
  $.getJSON( "https://raw.githubusercontent.com/aranajhonny/ciudades-de-vzla/master/venezuela.json", function( data ) {
    $.each( data, function( key, val ) {
      if(val.estado == state){
          $.each( val.municipios, function( key2, val2 ) {
              $("#registry_county_str").append($('<option>', {
                  value: val2.municipio,
                  text: val2.municipio
              }));
          });
      }
    });
    $("select").material_select();

  });
}


function fill_states()
{
  $('#registry_state_str').empty();
  $('#registry_county_str').empty();
  $.getJSON( "https://raw.githubusercontent.com/aranajhonny/ciudades-de-vzla/master/venezuela.json", function( data ) {
      var items = [];
      $('#registry_state_str').append($('<option  disabled="" selected="">', {
        value: "",
        text: "Seleccionar Estado"
      }));

      $.each( data , function( key, val ) {
        $('#registry_state_str').append($('<option>', {
            value: val.estado,
            text: val.estado
        }));
      });
      $("select").material_select();

  });
}



function validateRegex(allow,e){

                     var k;
                     var key = e.keyCode;
                     if(key == 8 || key == 37 || key == 39){
                         return true;
                     }
                     else {
                         k = document.all ? parseInt(e.keyCode) : parseInt(e.which);
                         var type = allow.indexOf(String.fromCharCode(k));
                         if(type != -1)
                           return true
                         else
                           e.preventDefault();
                     }
     }





document.addEventListener("turbolinks:load", function(){

  if(PageFile == 16){

    fill_states()
    $("#phone").keypress(function(e){

      var allow='0123456789';

      // Borrar el cero inicial
      if(e.target.value.charAt(0) === "0")
      {
        e.target.value = e.target.value.substring(1, 11);
      }
      else{
        var key = e.keyCode;
        //Permite borrar, mover flecha a la izquierda o derecha

        if (key != 8 && key != 37 && key != 39 && key != 9) {
          e.target.value = e.target.value.substring(0, 9);
        }

      }
      return validateRegex(allow,e);


    })
    $("#registry_state_str").change(function(event){
      var state = event.target.value
      $('#registry_county_str').empty();
      fill_county(state)
    })

  }

})
