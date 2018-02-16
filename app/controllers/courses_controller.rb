 class CoursesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_course, only:[:show]
  before_action :find_course_in_section, only:[:grades]
  before_action :is_course_avaible, only:[:show]
  before_action :all_topic, only: %i[show grades]


  def index
    order = "name ASC"

    unless params[:order].nil?

      case params[:order]
        when '1'
          order = "created_at ASC"
        when '2'
          order = "name ASC"
        when '3'
          order = "name DESC"
      end
    end

    unless params[:search].nil?

      unless params[:department].nil?
        @courses = Course.search_by_department_user(params[:search], params[:department]).order("#{order}").paginate(params[:page])

      else
        unless params[:scope].nil?

          @courses = Course.search_by_scope_user(params[:search], params[:scope], current_user).order("#{order}").paginate(params[:page])
        else
          @courses = Course.search_user(params[:search]).order("#{order}").paginate(params[:page])

        end
      end
    else
      @courses = Course.active.order("#{order}").paginate(params[:page])
    end

    unless params[:cat].nil?
      begin
        Category.find(params[:cat])
        @courses = @courses.where(category: params[:cat])
      rescue
      end
    end


  end

  def show

    @course = Course.find(params[:id])

    prelations = Prelation.where(course_id: @course.id)

    @courses_prv = Hash.new

    prelations.each do |pre|

      course_id = pre.prelated_by
      course_prv = Course.find(course_id)
      @courses_prv[course_id] =  [name: course_prv.name, img: course_prv.cover_file_name]

    end

    @comments = CommentCourse.where(course_id: @course.id, prv_comment: nil).order("created_at DESC")
    @comments_count = CommentCourse.where(course_id: @course.id).count
  end

  def enroll
    @course = Course.find(params[:id])

    if @course.finished?
      flash[:alert] = 'Este curso ha finalizado'
		elsif @course.inscription_finished?
        flash[:alert] = 'Las inscripciones han finalizado'
		else
      case(current_user.can_enroll?(@course))
      when Constant::StateEnroll::Active
        enroll_user
      when Constant::StateEnroll::CanNotDepartment, Constant::StateEnroll::CanNotPrivate
        flash[:alert] = 'Este curso no está disponible para usted'
      when Constant::StateEnroll::AlreadyEnroll
        flash[:notice] = 'Ya está inscrito'
      when Constant::StateEnroll::CanNotPrelation
        flash[:alert] = 'Debe aprobar los cursos anteriores'
      end
    end

      redirect_to course_path @course
  end

  def recomendation
    @course = Course.find(params[:id])

    already_recommended = DoRecomendation.where(user_id: current_user.id, course_id: @course.id)
    approved = DoCourse.approved_enroll?(current_user,@course)

      # Aunque ya se valida en la vista que no se muestre la opcion si el usuario no esta aprobado,
      # tambien se valida en el controlador, para que no traten de acceder a dicha opcion a traves del path
      if approved

        # Se valida si el usuario ha recomendado el curso antes
        if already_recommended.empty?
          DoRecomendation.create(user_id: current_user.id, course_id: @course.id)
          # TODO confirmar si cambiar el mensaje o no
          flash[:notice] =  'Usted ha recomendado el curso correctamente'
          redirect_back(fallback_location: course_path(@course))

        else
          flash[:notice] = 'Usted ya ha recomendado este curso antes'
          redirect_back(fallback_location: course_path(@course))
        end

      else
        redirect_back(fallback_location: course_path(@course))

      end

  end


  def favorite

    #Se comprueba primero si existe un curso con el id indicado
    course_exist = Course.where(id: params[:id])

    if !course_exist.empty?
      @course = Course.find(params[:id])
      already_in_favorites = HasFavorite.where(user_id: current_user.id, course_id: @course.id)

      # Se comprueba si el usuario tiene el curso en su lista
      if already_in_favorites.empty?
        #Si el curso no esta en la lista, se agrega a ella
        HasFavorite.create(user_id: current_user.id, course_id: @course.id)
        flash[:notice]= 'El curso ha sido agregado a su lista de favoritos.'
        redirect_to course_path @course
      else
        #Si el curso esta en la lista, se elimina de ella
        HasFavorite.where(user_id: current_user.id, course_id: @course.id).destroy_all
        redirect_to course_path @course
      end
    else
      #Si el curso no existe o se ingresa un parametro falso, se redirecciona al usuario a los cursos
      redirect_to courses_path
    end

  end



  def enroll_user
    year = Time.now.year
    month = Time.now.month
    day = Time.now.day

    DoCourse.create(user_id: current_user.id, start_date: "#{year}-#{month}-#{day}", course_id: @course.id, enroll: 1)
    flash[:notice] = 'Inscrito correctamente'

  end

  def grades


    @docourse = DoCourse.find_by_id(params[:id])
    @user = current_user

    if @docourse.nil?

      redirect_back(fallback_location: root_path) and return true

    else

      @dc_user = User.find_by_id(@docourse.user_id)
      #Si el usuario es empleado, solo podrá ver sus propias notas
      if @user.is_employed?

        if @user.id != @dc_user.id
          redirect_back(fallback_location: root_path) and return true
        end

      end

      @course = Course.find_by_id(params[:course_id])
      @dotest = DoTest.where(do_course_id: @docourse.id)

      if @course.id != @docourse.course_id
        redirect_back(fallback_location: root_path) and return true
      end



      @hash_test = Hash.new


      # se usa para saber si mostrara la nota de un examen o de todos
      @docourse.do_tests.each do |dt|
        tc = Test.with_deleted.find_by(id: dt.test_id)

        if params[:test_id].nil?
         @hash_test[tc]= Array.new
        else
          if params[:test_id] == tc.id.to_s
            @hash_test[tc]= Array.new
          end
        end
      end

      if !@dotest.nil?
        @dotest.each do |dt|
          @has_answer = HasAnswer.where(do_test_id: dt.id)
          @test = Test.with_deleted.find_by_id(dt.test_id)

          # Si el examen no tiene limite de intentos y se envio un intento con respuestas vacias se elimina
          if  @test.attemps_limits == 0 && @has_answer.empty?

            dt.destroy
            dt =nil
          end

          if !dt.nil?

            if params[:test_id].nil?
              @hash_test[@test].push(dt)
            else
              if params[:test_id] == dt.test_id.to_s
                @hash_test[@test].push(dt)
              end
            end

          end

        end
      end


    end


  end








end
