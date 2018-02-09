class TemplateController < ApplicationController

  before_action :authenticate_user! , only: [:show,:responses]
  skip_before_action :redirect_to_fill_profile




  def show

     @template = Template.find(params[:id])

     #Se guarda el programa al cual pertenece el usuario actual
     department = current_user.department
     is_valid_department_user = false


     #Se buscan las planillas que hay disponibles
     @template.has_templates.each do |relation|
      #compara si el programa del usuario es el mismo que el de la planilla
       if relation.department.name == department.name
         is_valid_department_user = true
       end
     end

    #Se comprueba si el programa del usuario es correcto
     if is_valid_department_user
       # De ser asi, se muestran todas las preguntas de la planilla que tiene ese programa
       @surveys = @template.surveys.order("sequence ASC")

     else
      #  Si el usuario trata de acceder a una planilla de un programa que no le corresponde
      #  sera redireccionado a la pagina de inicio
       redirect_to root_path
     end
  end


  def responses

    # Se obtiene la ultima planilla hecha por el usuario para obtener la secuencia
    user_last_template = DoTemplate.where("user_id = #{current_user.id}").order("sequence DESC").limit(1)

    #Se comprueba si el usuario tiene alguna planilla hecha
    if user_last_template.empty?
      #Si no tiene ninguna, la secuencia sera 1
      new_sequence =  1
    else
      #Si tiene al menos una planilla hecha, se le suma 1 a la secuencia de la ultima planilla
      new_sequence = user_last_template[0].sequence + 1
    end

    # Variable usada para validar que el survey y la respuesta no han sido alterados
    response_is_valid = true
    #Variable usada para los mensajes de error
    message = ""

    #recorrer los valores enviados por el formulario para validarlos
    params[:template].map do |survey_id,description_r,choise_id|
      survey = Survey.find(survey_id)

      #Se comprueba si el survey relacionado con la respuesta existe
      if survey.nil?
        response_is_valid = false
        break
      else

        #Se comprueba si la pregunta es obligatoria
        if (survey.required == 1)
          # Se comprueba si la pregunta es de respuesta corta o respuesta larga
          if (survey.type_survey.sequence == 1 || survey.type_survey.sequence == 2)
            # De ser asi, se comprueba que el campo no este vacio
            if description_r[:description].empty?
              message = "Debe llenar los campos obligatorios"
              response_is_valid = false
              break
            end

        # Si es de respuesta larga, se comprueba tambien si el campo posee al menos 10 caracteres
            if (survey.type_survey.sequence == 2)
              if description_r[:description].length < 10
                message = "El campo debe tener al menos 10 caracteres"
                response_is_valid = false
              end
            end
          end

          #Se comprueba si el survey es de seleccion simple
          if (survey.type_survey.sequence == 3)
            #Luego se comprueba si los valores no han sido alterados
            if !(description_r[:description] == "Si" || description_r[:description] == "No")
                message = "Debe selecionar una respuesta"
                response_is_valid = false
                break
            end
          end


          #Se comprueba si el survey es de seleccion multiple
          if (survey.type_survey.sequence == 4)
            #Se obtiene el id de todas las respuestas seleccionadas
            description_r[:choise_id].each do |choise_id|
              #Se comprueba que se haya seleccionado al menos una respuesta
              if !choise_id.empty?
                #Se guarda el id de la respuesta seleccionada
                choise_exist= Choise.where(id: choise_id)
                response_is_valid = true

                  #Se comprueba si la opcion seleccionada existe
                  if choise_exist.empty?
                    # Si no devuelve ningun valor, se mostrara un mensaje de error y
                    # la respuesta sera invalida
                    response_is_valid = false
                    message = "Hubo un error inesperado"
                    break
                  else
                    # Se comprueba si la opcion seleccionada pertenece al survey actual y
                    # si los valores no han sido manipulados
                    if (choise_exist[0].survey_id != survey.id)
                      response_is_valid = false
                      message = "Hubo un error inesperado"
                    end
                  end

              else
                #Si no se selecciona una respuesta, el valor sera considerado invalido
                response_is_valid = false
                message = "Debe seleccionar al menos una respuesta."
              end
            end
            #Si la respuesta no es valida se hace un break
            if !response_is_valid
              break
            end
          end
        end


      #Para evitar que se evalue 2 veces, se comprueba primero si el survey no es requerido
        if (survey.required == 0)
          if (survey.type_survey.sequence == 4)
            #Se obtiene el id de todas las respuestas seleccionadas
            description_r[:choise_id].each do |choise_id|
              # se comprueba si se selecciono una respuesta
              if !choise_id.empty?
                #Se guarda el id de la respuesta seleccionada
                choise_exist= Choise.where(id: choise_id)
                #Se comprueba si la opcion seleccionada existe
                if choise_exist.empty?
                  # Si no devuelve ningun valor, se mostrara un mensaje de error y
                  # la respuesta sera invalida
                  response_is_valid = false
                  message = "Hubo un error inesperado"
                  break
                else
                  # Se comprueba si la opcion seleccionada pertenece al survey actual y
                  # si los valores no han sido manipulados
                  if (choise_exist[0].survey_id != survey.id)
                    response_is_valid = false
                    message = "Hubo un error inesperado"
                  end
                end
              end
            end
            #Si la respuesta no es valida se hace un break
            if !response_is_valid
              break
            end
          end

          #Se comprueba si el survey es de seleccion simple
          if (survey.type_survey.sequence == 3)
            #Luego se comprueba si los valores no han sido alterados
            if !(description_r[:description] == "Si" || description_r[:description] == "No" || description_r[:description] == "" )
                message = "Debe selecionar una respuesta"
                response_is_valid = false
                break
            end
          end

        end


      end
    end


    #Se comprueba si las respuestas son validas.
    if response_is_valid

      #recorrer los valores enviados por el formulario para guardarlos
      params[:template].map do |survey_id,description_r|
        # Se guarda la respuesta y los datos relacionados con la planilla
        response = Response.create(description: description_r[:description])
        #Se busca el survey actual
        survey= Survey.find(survey_id)

        #Se comprueba si el survey actual es de seleccion multiple
        if (survey.type_survey.sequence == 4)
          #obtener todas las respuestas seleccionadas
          description_r[:choise_id].each do |choise_id|
          # como el primer choise siempre devuelve nulo, se comprueba que no esté vacio
            if !choise_id.empty?
              #Se guardan todas las respuestas seleccionadas por el usuario
                HasChoise.create(choise_id: choise_id, response_id: response.id)
            end
          end
        end

        # Se envian los parametros necesarios para guardar las respuestas EN la planilla
        DoTemplate.create(template_id: params[:template_id], survey_id: survey_id, response_id: response.id, user_id: current_user.id, sequence: new_sequence)
      end

      #Se le permite al usuario acceder a otras opciones porque ya tiene una planilla hecha
      session["devise.fill_profile?"] = false
      redirect_to root_path, notice: "Guardado correctamente"
    else
    # Si los datos han sido alterados o si la respuesta es invalida, el usuario
    # sera redireccionado a la planilla nuevamente
        redirect_to template_path(params[:template_id]) , :alert => "#{message}"
    end


  end #def responses

end #Final
