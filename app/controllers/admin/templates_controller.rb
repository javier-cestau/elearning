class Admin::TemplatesController < ApplicationController

  before_action :authenticate_medium_admin!

  def index
    @templates = Template.all.order("created_at ASC")
    @departments = Department.all.order("name ASC")
  end

  def new
    # Debido a que las planillas no se podran editar se le mostrara al usuario
    # una nueva con los datos que se quiera
    if !params[:id].nil?
      # Evaluar si es un numero
      id = Integer(params[:id]) rescue nil
      if !id.nil?
        @template = Template.find(id) rescue Template.new
        # Si devuelve nulo significa que no existe la planilla que se paso por parametro
        if @template.id.nil?
          @survey = Survey.new
        else
          # si existe se cargan todos los surveys
          @surveys = @template.surveys
        end
      else
        # En el caso de que no se haya pasado nada por parametro
        @template = Template.new
        @survey = Survey.new
      end

    else
      # En el caso de que no se haya pasado nada por parametro
      @template = Template.new
      @survey = Survey.new
    end
  end

  def create

    @template = Template.new(params_template)

    # Se comprueba que se haya seleccionado al menos un programa
    if  !params[:template][:departments].at(1).nil?
      if @template.save!

        # Guardar Los programa que podran acceder a esta planilla que se esta creando
        params[:template][:departments].map do |department,index|
  				@template.save_has_department(department)
  			end
        @sequence = 1

        #list_survey es la lista de todas las preguntas que el usuario creo
        params_survey.map do |key,list_survey|
          @error_in_survey = false

            list_survey.each do |survey,values|
              if @error_in_survey
                break
              else
                create_survey(values)
              end

             end

             if !@error_in_survey

               create_survey_default("¿Que habilidades considera que posee?",2)
               create_survey_default("¿Que logros considera usted que ha alcanzado?",2)
               create_survey_default("¿Que logros le gustaría alcanzar en un futuro?",2)
               create_survey_default("¿Que áreas son de su interés?",4,true)
             end


        end

        # Comprueba si no ocurrio ningun error al guardar los surveys
        if !@error_in_survey


          redirect_to new_admin_template_path , notice: "Planilla creada exitosamente"
        end

    else

      redirect_with_id ("&nbsp&nbsp*El nombre de la planilla ya existe  <br> &nbsp&nbsp* El nombre es menor a 10 caracteres")

    end
  else

    redirect_with_id("&nbsp&nbsp*Debe seleccionar al menos un programa")

  end

  end


  # Este show es para mostrar la planilla con las respuestas segun el usuario
  def show
    @template = Template.find(params[:id])
    @surveys = @template.surveys.order("sequence ASC")
    @user = User.find(params[:talent_id])

    @do_template = @user.do_templates.where(sequence: params[:s])

    @responses = Hash.new

    @do_template.each do |d|
      @responses[d.survey_id] = d.response
    end
  end


  def choises

    @counter = params[:counter]
    respond_to do |format|

      format.html { render :partial => 'choises' }

    end

  end


  private

      # obtener el id del url del que viene que es de new template
      def redirect_with_id (messsage)
        id =  request.headers["HTTP_REFERER"].split("id=")[1]
        redirect_to new_admin_template_path+"?id=#{id}", alert: "Error pudo deberse a los siguientes errores: <br> "+messsage
      end


      def params_template
        params.require(:template).permit(:name)
      end

     # Con esta funcion permito aceptar dinamicamente las cantidad de preguntas que sean en el survey
      def params_survey
        params.require(:template).permit(:surveys).tap do |white|
          white[:surveys] = params[:template][:surveys]
        end
      end

      def create_survey(hash_single_survey)
        question = hash_single_survey[:description]
        type_survey_id = hash_single_survey[:type_survey_id]
        required = hash_single_survey[:required]
        choises = hash_single_survey[:choises]
        #Se crea cada uno de los surveys
        survey = @template.surveys.build(description: question,type_survey_id: type_survey_id, sequence: @sequence, required: required)

        if type_survey_id != "4"
          if !survey.save
            error_validating_survey("&nbsp&nbsp* Ha creado una pregunta vacia")
          end
        else
          if !choises.nil?
            if choises.length >= 2
              if !survey.save
                error_validating_survey("&nbsp&nbsp* Ha creado una pregunta vacia")
              else
                choises.each do |choise|
                  description = choise
                  Choise.create(description: description, survey_id: survey.id)
                end
              end
            else
              error_validating_survey("&nbsp&nbsp* Las preguntas de selección multiple deben tener al menos 2 opciones ")
            end
          else
            error_validating_survey("&nbsp&nbsp* Las preguntas de selección multiple deben tener al menos 2 opciones ")

          end
        end

        @sequence += 1
      end

      def error_validating_survey(msg)
        Survey.where(template_id: @template.id).destroy_all
        @template.destroy
        @error_in_survey = true
        redirect_with_id(msg)
      end

      def create_survey_default (question,type,categories_create = false)
        type_survey = TypeSurvey.find_by(sequence: type)
        required = 1
        survey = @template.surveys.build(description: question,type_survey_id: type_survey.id, sequence: @sequence, required: required)

        if !survey.save
          @template.destroy
          @error_in_survey = true
          redirect_with_id("&nbsp&nbsp* Ha creado una pregunta vacia")
        else
          if categories_create
            categories = Category.all

            categories.each do |category|
              description = category.name
              Choise.create(description: description, survey_id: survey.id)
            end
          end
        end

        @sequence += 1

      end

      def choise_params
        params.permit(:choise => [])
      end



end
