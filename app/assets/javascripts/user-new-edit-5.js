/*jshint esversion: 6 */

email_valid = false

document.addEventListener("turbolinks:load", function(){

  function OnlyLetters(e) {


      var allow=' ABCÇDEFGHIJKLMNÑOPQRSTUVWXYZabcçdefghijklmnñopqrstuvwxyzàáÀÁéèÈÉíìÍÌïÏóòÓÒúùÚÙüÜ';

      var k;
      var key = e.keyCode;
      if(key == 8 ){
          return true;
      }
      else {
          k = document.all ? parseInt(e.keyCode) : parseInt(e.which);
          return (allow.indexOf(String.fromCharCode(k)) != -1);
      }
  }
  function CheckEmailWithAjax(){
    // Cuando la peticion AJAX fue exitosa a la pagina que se envio el email para comprobar si esta registrado o no
    $(document).on ("ajax:success", "#registration-form", function (ev,data){
        console.log(data.email)
      if (data.email === null){

       //Mostrar las clases de CSS que muestra que no existe en la base de datos
        $(".email-input").removeClass('invalid').addClass('validate valid');

          email_valid = true
      }
      else {
          email_valid = false
          $("#label-email").attr('data-error', "El correo electrónico ya fue registrado");

          $(".email-input").removeClass('valid').addClass(' validate invalid');

      }

    });

    // Cuando la peticion por AJAX al servidor fue erronea , Generalmente seran por problemas internos del servidor si se da el caso
    $(document).on ("ajax:error", "#registration-form", function (ev,data){
      console.log( data );
    });

  }



  function IniatilizeComponentsUser(){


    $("#user_management").keypress(function(e){
        return OnlyLetters(e);
    });
    $("#user_position").keypress(function(e){
        return OnlyLetters(e);
    });
    $("#user_name").keypress(function(e){
        return OnlyLetters(e);
    });

    // Cuando el usuario se salga del input se enviara el formulario por AJAX en el caso de ser valido
    $("#new_user #user_email").blur(function(){

        let email =$("#new_user #user_email").val();


          if (isEmail(email)){
            $("#registration-form input").val(email);
            $(".data-eval > div small").remove();
            $("#registration-form").submit();

          }
          else{
              $("label[for='user_email']").attr('data-error', "El email no es válido");
              if (email.length == 0) {
                  $(".email-input").removeClass('validate')
              }else{
                  $(".email-input").removeClass('valid').addClass(' validate invalid');

              }

          }


    });


    CheckEmailWithAjax();

    $(".submit").click(function () {
        console.log(email_valid);
        if($("#user_position").val().trim().length != 0) {

            if ($("#user_name").val().trim().length > 5) {

                if ($("body").hasClass("edit")) {
                    $(".edit_user").submit();
                }
                else{

                    if (email_valid) {
                        console.log("asdasd");
                        $(".new_user").submit();
                    }
                }

            }else{
                alert("El nombre debe tener más de 5 caracteres");
            }


        }
        else{
            alert("Debe rellenar los campos vacíos")
        }
    });
  }

  // Comporbar que la sintaxis de un correo sea valida
  function isEmail(email) {
      if (email.length > 5) {

          var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
          return regex.test(email);
      }else {

        return false;
      }
  }


  if(PageFile == 5){
      email_valid = false
    IniatilizeComponentsUser();

  }



});
