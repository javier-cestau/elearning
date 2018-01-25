
function fill_county_update(state){
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


function fill_states_update()
{
  $('#registry_state_str').empty();
  $.getJSON( "https://raw.githubusercontent.com/aranajhonny/ciudades-de-vzla/master/venezuela.json", function( data ) {
      var items = [];

      $.each( data , function( key, val ) {
        var tag = '<option>'
        if(val.estado == gon.estado)
          tag = '<option selected="">'

        $('#registry_state_str').append($(tag, {
            value: val.estado,
            text: val.estado
        }));
      });
      $("select").material_select();

  });
}




document.addEventListener("turbolinks:load", function(){

  if(PageFile == 17){

    fill_states_update()
    $("#registry_state_str").change(function(event){
      var state = event.target.value
      $('#registry_county_str').empty();
      fill_county(state)
    })
  }

})
