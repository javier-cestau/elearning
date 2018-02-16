/*jshint esversion: 6 */

document.addEventListener("turbolinks:load", function(){

    var list_type_survey, description_count, validate_name_template, validate_name_survey, validate_at_least_one_survey, validate_department, validate_multiple_options;


  //  Esta funcion analiza la pregunta que se carga por defecto y toma los tipos de surveys que hay para que
  //  cuando se creen la nuevas preguntas sean iguales
  function returnTypeDescription (){

    varlist_type_survey = {
      id: new Array([]),
      name: new Array([])
    };

    for (var i = 0; i < 4; i++) {

      list_type_survey.id.push(i+1);
      //Devuelve el texto al lado del input en los radio buttons
      //Se hace con la intencion de que no se deba cambiar el texto en caso de modificarse un radio button
      var type_question_name = $(".type-question .switch-field label:nth-child("+(i+3)+") label  ").html();

      //Aqui se guarda el nombre
      list_type_survey.name.push(type_question_name);

    }

    return list_type_survey;
  }

  // Donde se muestran las respuestas agregadas
  function addAnswer(num) {

      var choise = $("#add_choise"+num).val().trim();

      // debido a que los ID no aceptan espacios se deben cambiar dichos espacios por "-"
      var choise_replace = choise.replace(/\s+/g, "-");


    if (choise.length > 0){

      if($("#choises"+num+" #i_choise_survey"+choise_replace).val() === undefined){

        var html = "<li class='collection-item' id='i_choise_survey"+choise_replace+"'> " +
            "         <input name='template[surveys][survey"+num+"][choises][]' value='"+choise+"'  type='hidden' >"+
            "         <div>"+
                          choise+
            "             <a id='answer_"+choise_replace+"' class=\"secondary-content\">" +
            "               <i class=\"material-icons choises-pointer\">clear</i>" +
            "             </a>" +
            "         </div>" +
            "      </li>";
        $("#choises-list"+num).append("");

        $("#choises-list"+num).append(html);

        $("#choises-list"+num).one("click" ,"#answer_"+choise_replace,function(){

        $("#choises-list"+num+" #i_choise_survey"+choise_replace).remove();

        });
      }
    }

  }

  function getLastNumberDescription(){


    id = $("#button-description").attr("data");

      var counter;
      // si el id es mayor a 2 es necesario que se agreguen las funcionalidades a los botones de elimininar y cambiar el name

      vardelete_choises = function(e){
          var complete_id = e.target.id,
              id = complete_id.split("survey")[1].split("_")[0];

          $("#choises"+id+" >.jumbotron").remove();

      };

    $("input[id='template_survey1_type_survey_id_4']").click(function(){

      var exist = $("#choises1 >.jumbotron").text().length;

        $("input[id='template_survey1_type_survey_id_1']").click(delete_choises);
        $("input[id='template_survey1_type_survey_id_2']").click(delete_choises);
        $("input[id='template_survey1_type_survey_id_3']").click(delete_choises);

      if (exist === 0)
      {
        $.ajax({
          url : '/admin/templates/choises?counter=1',
          type : 'get',
          dataType:'html',
          success : function(data) {

              varchoises = data;
              $("#choises1").append(choises);

              $("#choises1").on("click", "#btn-add-choise1", function(){
                  addAnswer("1");
              });


          },
          error : function(request,error)
          {
              console.log(request);
          }
        });
      }


    }); // total





    $("input[id='template_survey1_type_survey_id_1']").click(delete_choises);
    $("input[id='template_survey1_type_survey_id_2']").click(delete_choises);
    $("input[id='template_survey1_type_survey_id_3']").click(delete_choises);




    if (id > 1){
        for (vari = 2; i <= id; i++) {

          $("input[id='template_survey"+i+"_type_survey_id_4']").click(function(){
            var exist = $("#choises"+i+" >.jumbotron").text().length;


              $("input[id='template_survey"+i+"_type_survey_id_1']").click(delete_choises);
              $("input[id='template_survey"+i+"_type_survey_id_2']").click(delete_choises);
              $("input[id='template_survey"+i+"_type_survey_id_3']").click(delete_choises);
            if (exist === 0)
            {
              $.ajax({
                url : '/admin/templates/choises?counter='+i,
                type : 'get',
                dataType:'html',
                success : function(data) {
                  //  Se debe hacer un split debido a que lo devuelve con un tag <form> y solo se debera usar lo que esta dentro de dicho tag
                    varchoises = data;
                    $("#choises"+i).append(choises);
                    $("#choises"+i).on("click", "#btn-add-choise"+i, function(){
                        addAnswer(i);
                    });
                },
                error : function(request,error)
                {
                    console.log(request);
                }
              });
            }

          });

          vardelete_choises = function(e){
            var complete_id = e.target.id,
            id = complete_id.split("survey")[1].split("_")[0];



            $("#choises"+id+" >.jumbotron").remove();

          };




          $("input[id='template_survey"+i+"_type_survey_id_1']").click(delete_choises);
          $("input[id='template_survey"+i+"_type_survey_id_2']").click(delete_choises);
          $("input[id='template_survey"+i+"_type_survey_id_3']").click(delete_choises);



          var a = function(){
            varnumber_button = i;
            $(".panel").on("click" ,".borrar"+number_button,function(){
               $("#basic-addon"+number_button).remove();
            });




            $("input[name='template[survey"+i+"][description]'").attr("name","template[surveys][survey"+i+"][description]");
           $("input[name='template[survey"+i+"][type_survey_id]'").attr("name","template[surveys][survey"+i+"][type_survey_id]");
           $("input[name='template[survey"+i+"][required]'").attr("name","template[surveys][survey"+i+"][required]");

          }();

        }

    }
    return id;
  }

  function GetHTMLNewQuestion(){
    var new_description ='      <div class=\"jumbotron jumbotron-fluid\" id=\"basic-addon'+description_count+'\" >   '  +
         '                         <div class=\"element-content contenido-post\">   '  +
                          '           <div class=\"content-post\">   '  +
                          '             <div class=\"post-avatar\">   '  +
                          '               <span class=\"input-group-addon back-red borrar'+description_count+'\">   '  +
                          '                 <i class=\"fa fa-trash color-white\"></i>   '  +
                          '               </span>   '  +
                          '             </div>   '  +
                          '             <div class=\"post-content preguntas-planilla-input\">   '  +
                          '              <span class=\"post-title\">   '  +
                          '                 <input class=\"string optional form-control pregunta-input\" label=\"false\" placeholder=\"Escriba su pregunta...\" name=\"template[surveys][survey'+description_count+'][description]\" id=\"template_survey'+description_count+'_description\" type=\"text\">   '  +
                          '              </span> <br><br>  '  +
                          '              <p class=\"post-body\"></p>  '  +
                          '              <div class=\"row\">'+
                           '               <div class=\"type-question\">  '  +
                           '                 <div class=\"switch-field\">  '  +
                           '                 <p> Seleccione un tipo de pregunta: </p>  '  +
                           '                 <input name=\"template[surveys][survey'+description_count+'][type_survey_id]\" value=\"\" type=\"hidden\">' ;
                                   // Crear cada uno de los radio buttons
                                   //se debe actualizar a mano el numero de radio button que seran creados
                                   for (var i = 1; i < list_type_survey.id.length  ; i++) {

                                     var id = list_type_survey.id[i];
                                     var name = list_type_survey.name[i];
                                     var checked;
                                     // Para que se marque el primer radio button
                                     if (i === 1){

                                       checked = "checked='checked'";
                                     }
                                     else{

                                       checked = "";
                                     }


                                     new_description +=
                                     '<label for="template_survey'+description_count+'_type_survey_id_'+id+'">'+
                                     " <input class=\"radio_buttons required\" value=\""+id+"\" name=\"template[surveys][survey"+description_count+"][type_survey_id]\" id=\"template_survey"+description_count  +"_type_survey_id_"+id+"\" type=\"radio\" "+checked+" >"+
                                       "<label for=\"template_survey"+description_count+"_type_survey_id_"+id+"\">"+name+
                                       "</label>"+
                                     "</label>";
                                   }

                     new_description += '    <div id="choises'+description_count+'"></div>'+
                                        '  </div>   '  +
                                     '  </div>   '  +
                                     '</div>   ' ;



                     new_description += '<div class=\"obligatorio\">  '  +
                                       '   <div class=\"switch-field\">  '  +
                                       "     <p>¿Es Obligatoria?</p>" +
                                       "     <input name=\"template[surveys][survey"+description_count+"][required]\" value=\"\" type=\"hidden\">" +
                                       "     <label for=\"template_survey"+description_count+"_required_1\">" +
                                       "        <input class=\"radio_buttons optional\" value=\"1\" name=\"template[surveys][survey"+description_count+"][required]\" id=\"template_survey"+description_count+"_required_1\" type=\"radio\">" +
                                       "      <label for=\"template_survey"+description_count+"_required_1\">Si</label>" +
                                       "     </label>" +
                                       "    <label for=\"template_survey"+description_count+"_required_0\">" +
                                       "      <input class=\"radio_buttons optional\" value=\"0\" checked=\"checked\" name=\"template[surveys][survey"+description_count+"][required]\" id=\"template_survey"+description_count+"_required_0\" type=\"radio\">" +
                                       "      <label for=\"template_survey"+description_count+"_required_0\">No</label>" +
                                       "    </label>" +
                                       "   </div>"+
                                       "  </div>"+
                                       "</div>"+
                                       "</div>"+
                                       "</div>"+
                                       "</div>"+
                                       "</div>";

                    return new_description;
  }

  function InitializeButtonAddQuestion(){
    $("#button-description").click(function(){


      var new_description = GetHTMLNewQuestion();


      $("#button-description").parent().prev().append(new_description);

      var CreateQuestionFromPartial = function(){

        varcounter= description_count;
        $(".jumbotron").on("click" ,".borrar"+counter,function(){
           $("#basic-addon"+counter).remove();
        });
        $("input[id='template_survey"+description_count+"_type_survey_id_4']").click(function(){
          var exist = $("#choises"+counter+" >.jumbotron").text().length;
          if (exist === 0)
          {
            $.ajax({
              url : '/admin/templates/choises?counter='+counter,
              type : 'get',
              dataType:'html',
              success : function(data) {
                // Se debe hacer un split debido a que lo devuelve con un tag <form> y solo se debera usar lo que esta dentro de dicho tag
                varchoises = data;

                $("#choises"+counter).append(choises);


                $("#choises"+counter).on("click", "#btn-add-choise"+counter, function(){
                    addAnswer(counter);
                });


              },
              error : function(request,error)
              {
                console.log(request);
              }
            });
          }
        }); // total


          vardelete_choises = function(e){
            var complete_id = e.target.id,
            id = complete_id.split("survey")[1].split("_")[0];


            $("#choises"+id+" >.jumbotron").remove();

          };


          $("input[id='template_survey"+description_count+"_type_survey_id_1']").click(delete_choises);
          $("input[id='template_survey"+description_count+"_type_survey_id_2']").click(delete_choises);
          $("input[id='template_survey"+description_count+"_type_survey_id_3']").click(delete_choises);
      }();



      description_count++;
    });
  }

  function AvoidAllowNameTemplateAlreadyExiting() {

	$("form > .jumbotron > div  > input").val("");

	$("#template-name").blur(function() {

		varnombre = $("#template-name").val().trim();

		if (nombre.length == 0) {

			$("#template-name").removeClass("validate invalid");

		} else if (nombre.length < 10) {

			$("#template-name").removeClass("valid").addClass("validate invalid");

		} else {

			$("#template-name").removeClass("invalid").addClass("validate valid");
		}

	});

}


  function IntializeComponentsTemplate(){


        InitializeButtonAddQuestion();
        AvoidAllowNameTemplateAlreadyExiting();
        list_type_survey = returnTypeDescription();
        description_count = parseInt(getLastNumberDescription());
        description_count++;


        $("input[name='template[survey1][description]'").attr("name","template[surveys][survey1][description]");
        $("input[name='template[survey1][type_survey_id]'").attr("name","template[surveys][survey1][type_survey_id]");
        $("input[name='template[survey1][required]'").attr("name","template[surveys][survey1][required]");
        // En el caso de entrar con modificar una planilla se detecta la cantidad de preguntas

        // Para recorrer los botones ya existentes para la opcion de seleccion multiple
        for (vari = 1; i <= description_count; i++) {

            $("#btn-add-choise"+i).click(function(){
                addAnswer(i);
            });

        }


        $(".type-question > .switch-field > label:not(:nth-last-child(2))").on("click", "input", function(e){
          var complete_id = e.target.id,
              id = complete_id.split("survey")[1].split("_")[0];
          $("#choises"+id+" >.jumbotron").remove();
        });







      $(".guardar-planilla").click(function(){

      	 // Evitar que se envie un nombre de planilla menor de 10 caracteres
          validate_name_survey = 1;

        	$(".post-title").each(function() {

        	    var input_survey = $(this).children().val();

      		    if (input_survey.length < 5) {

        	      $(this).children().css({
        	        "background-color": "#fbc0c0",
        	        "border-bottom": "1px solid #f44336"
      		      });

        	      validate_name_survey = 0;
      	     }
        	}); //fin de post-title function


	        //evitar que se guarde la planilla sin preguntas creadas
        	if ($("#panel-element").children().length >= 1){
        	    validate_at_least_one_survey = 1;
          } else{
      	      validate_at_least_one_survey = 0;
      	  }



  	      //Evitar que se envie el formulario sin selccionar ningun programa
	        validate_department = 0;

          $.each($('.department > .flex > label input'),function(index,input){
            if (input.checked){
    		        validate_department = 1;
    	      }

          });




          // para validar que haya al menos 2 opciones en las preguntas de seleccion multiple
          validate_multiple_options = 1;
          // se obtiene la cantidad de preguntas
          cant_survey = $(".panel-element").children().length;
          //se recorre cada pregunta para ver si alguna es de seleccion multiple
          for (i = 0; i < cant_survey; i++){
            // se selecciona de la pregunta el ultimo input que es el de seleccion multiple
            survey_input_multiple = $(".type-question > .switch-field > label:nth-last-child(2) input")[i];

            //si entra en la condición es porque  al menos una de las preguntas es de selección multiple
            if (survey_input_multiple.checked){

              validate_multiple_options = 0;
              //se obtiene el id del survey directamente porque puede variar si se elimina una pregunta
              actual_survey = survey_input_multiple.id.split("template_survey")[1].split("")[0];
              //si la lista de opciones del actual survey es mayor o igual 2 entra en la condicion
              if ($("#choises-list"+actual_survey).children().length >= 2) {
                //y la pregunta queda validada
                validate_multiple_options = 1;
              }

            }

          }

        		validate_name_template = 0;

        		var nombre = $("#template-name").val().trim();

        		if (nombre.length === 0) {

        			$("#template-name").removeClass("validate invalid");

        		} else if (nombre.length < 10) {

        			$("#template-name").removeClass("valid").addClass("validate invalid");

        		} else {

        			$("#template-name").removeClass("invalid").addClass("validate valid");
        			validate_name_template = 1;
        		}


          //Mensajes de alerta
          if (validate_name_template == 1 && validate_name_survey == 1 && validate_at_least_one_survey == 1 && validate_department == 1 && validate_multiple_options == 1){

             var validate_all = confirm("¿Esta seguro que quiere guardarla? Una vez guardada no se eliminará por propósitos de control");
             if (validate_all){
               $("#new_template").submit();
             $(".edit_template").submit();
             }
          } else if (validate_name_template == 0){

              alert("El nombre de la planilla debe tener al menos 10 caracteres.");

          } else if (validate_name_survey == 0) {

              alert("Las preguntas deben tener al menos 5 caracteres");

          } else if (validate_at_least_one_survey == 0){

              alert("Debe crear al menos una pregunta");

          } else if (validate_department == 0){

              alert("Debe seleccionar al menos un programa");

          } else if (validate_multiple_options == 0){

              alert("Las preguntas de selección múltiple deben tener al menos 2 opciones");
          }

      }); // fin del click submit


        //Inicializar la primera pregunta
        $(".borrar1").click(function(){
           $("#basic-addon1").remove();
        });


        // Permitir que las preguntas se puedan organizar de manera dinamica
        $( "#panel-element" ).sortable({
          revert: true
        });


  }



  if(PageFile == 4)
    {

      IntializeComponentsTemplate();
  }
});
