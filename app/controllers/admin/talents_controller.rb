# coding: utf-8
class Admin::TalentsController < ApplicationController
  before_action :authenticate_medium_admin!
  before_action :authenticate_super_admin!, only:[:change_state]
  before_action :find_user, except: %i[index new create change_state]

  def index

    if current_user.is_super_admin?

      unless params[:search].nil?

        @talents = User.search_index(params[:type], params[:search],params[:page],current_user.is_super_admin?)
      else
        @talents = User.all.order("email ASC").page(params[:page]).per(10)
      end

    else

      unless params[:search].nil?
        @talents = User.search_index(params[:type], params[:search],params[:page], current_user.is_super_admin?)
      else
        @talents = User.all.order("email ASC").page(params[:page]).per(10)
      end

    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    #Obtiene el talento que se va a modificar
    @user = User.find(params[:id])

    #Se determina si el usuario es admin general o intermedio para definir los parametros que podra editar
    if current_user.is_super_admin?
      params = params_user_edit_by_super_admin_edit
    else
      params = params_user_edit_by_medium_admin_edit
    end

    #Se comprueba si se actualizan los datos correctamente
    if @user.update(params)
      redirect_to admin_talents_path,  notice: "Usuario '#{@user.email}' actualizado exitosamente"
    else
      render :edit, notice: "Hubo un error al actualizar el usuario"
    end

  end

  def new
    @user = User.new
  end

  def create


    @user = User.find_by_email(params[:user][:email])

    respond_to do |format|

				format.html {
          #A pesar que ya por javascript se comprueba que no exista se vuelve a comprobar por medidas de seguridad
          if !@user.nil?
            render :new, notice: "El usuario ya esta registrado"
          else

            if current_user.is_super_admin?
              params = params_user_edit_by_super_admin
            else
              params = params_user_edit_by_medium_admin
            end

            @user = User.new(params)
            if params[:name].length > 5

              if !params[:position].nil?


                # Siempre que el usuario que lo registre sea admin intermedio
                # el usuario se creara con privilegios de empleado
                if !current_user.is_super_admin?
                  @user.privilege = 1
                end
                # Medida de seguridad de devise aunque no se vaya a usar dicha contrasena
                @user.password = (BCrypt::Password.create(params[:email]))

                if @user.save
                  redirect_to admin_talents_path, notice: "El usuario fue registrado exitosamente"
                else
                  render :new, alert: "Ups ocurrió un error al momento de registrarlo"
                end
              else
                flash[:alert] = 'El usuario debe tener un cargo asignado '
                render :new
              end


            else
              flash[:alert] = 'El nombre debe ser mayor a 5 caracteres '

              render :new

            end
          end
        }
        # Esto es lo que se respondera por ajax al momento de registrar un usuario
        # Para saber si el usuario existe en la base de datos o no
    		format.json {
          if @user.nil?
            @user = User.new
          end
        }
			end
  end

  def certificate
    @course = Course.find_by(id:params[:course_id])

    if current_user.is_at_least_medium_admin? && DoCourse.approved?(@user,@course) 
      do_course = DoCourse.find_by(id: params[:doc_id])
      @date = localize(do_course.start_date)
      @date = @date.split(" ")[0]+" "+@date.split(" ")[2]
      name = @course.name.gsub(" ","-")
      respond_to do |format|
       format.pdf do
         render pdf: "certificado-#{name}", :page_height => '9in', :page_width => '7in', :background => true
       end
     end
   else
     redirect_to root_path
   end
  end


  def change_state
    state =  params[:state]
    begin
       user = User.find_by_email(params[:email])
      if state == "0" or state  == "1"
        user.state = state.to_i
        user.save
        respond_to do |format|
          format.json {
            render status: :ok
          }
        end
      end
    rescue
    end
  end


  def talent_progress
    @user = User.find(params[:talent_id])
    @department = Department.find(@user.department_id)
    @all_categories = Category.all.size
    @all_approved_courses_g = DoCourse.where(user_id: @user.id, failed: 0).where.not(finished_at: nil)
    @all_reprobed_courses_g = DoCourse.where(user_id: @user.id, failed: 1).where.not(finished_at: nil)
    @all_approved_courses = @all_approved_courses_g.count
    @all_reprobed_courses = @all_reprobed_courses_g.count
    @all_approved_courses_department = 0
    @all_reprobed_courses_department = 0

    #Para saber la cantidad de cursos aprobados en el programa
    @all_approved_courses_g.each do |acbd|
     @course_by_department = CourseHasDepartment.where(course_id: acbd.course_id, department_id: @department.id)
        if !@course_by_department.empty?
          @course_by_department.each do |cbd|
            @all_approved_courses_department += 1
          end
        end
    end


    #Para saber la cantidad de cursos reprobados en el programa
    @all_reprobed_courses_g.each do |acbd|
     @course_by_department = CourseHasDepartment.where(course_id: acbd.course_id, department_id: @department.id)
        if !@course_by_department.empty?
          @course_by_department.each do |cbd|
            @all_reprobed_courses_department += 1
          end
        end
    end

  end

  def approved_courses_general
    @approved_courses_general = DoCourse.where(user_id: @user.id, failed: 0).where.not(finished_at: nil)
    @counter = DoCourse.where(user_id: @user.id, failed: 0).where.not(finished_at: nil).count
    @course = Array.new
    @option_type= 1

    @approved_courses_general.each do |acg|
      @course.push(Course.find_by_id(acg.course_id))
    end

    @message =  "El talento posee  #{view_context.pluralize(@counter,'curso aprobado','cursos aprobados')}: "

    respond_to do |format|

      format.html { render :partial => 'talent_progress_option', :locals => {courses_do: @approved_courses_general, option_type: @option_type} }

    end
  end

  def approved_courses_by_department
    @department = Department.find_by_id(@user.department_id)
    @approved_courses_by_department = DoCourse.where(user_id: @user.id, failed: 0).where.not(finished_at: nil)
    @course = Array.new
    @counter = 0
    @option_type = 1

    @approved_courses_by_department.each do |acbd|
     @course_by_department = CourseHasDepartment.where(course_id: acbd.course_id, department_id: @department.id)
        if !@course_by_department.empty?
          @course_by_department.each do |cbd|
            @course.push(Course.find_by_id(cbd.course_id))
            @counter += 1
          end
        end
    end

    @message = "El talento posee  #{view_context.pluralize(@counter,'curso aprobado','cursos aprobados')} en el programa de: #{@department.name}"

    respond_to do |format|

      format.html { render :partial => 'talent_progress_option', :locals => {courses_do: @approved_courses_by_department, option_type: @option_type} }

    end
  end

  def reprobed_courses_general
    @reprobed_courses_general = DoCourse.where(user_id: @user.id, failed: 1).where.not(finished_at: nil)
    @counter = DoCourse.where(user_id: @user.id, failed: 1).where.not(finished_at: nil).count
    @course = Array.new
    @option_type = 1

    @reprobed_courses_general.each do |rcg|
      @course.push(Course.find_by_id(rcg.course_id))
    end

    @message =  "El talento ha reprobado #{view_context.pluralize(@counter,'curso','cursos')}"

    respond_to do |format|

      format.html { render :partial => 'talent_progress_option', :locals => {courses_do: @reprobed_courses_general, option_type: @option_type} }

    end
  end

  def reprobed_courses_by_department
    @department = Department.find_by_id(@user.department_id)
    @reprobed_courses_by_department = DoCourse.where(user_id: @user.id, failed: 1).where.not(finished_at: nil)
    @counter = 0
    @course = Array.new
    @option_type = 1


    @reprobed_courses_by_department.each do |rcbd|
     @course_by_department = CourseHasDepartment.where(course_id: rcbd.course_id, department_id: @department.id)
        if !@course_by_department.empty?
          @course_by_department.each do |cbd|
            @course.push(Course.find_by_id(cbd.course_id))
            @counter += 1
          end
        end
    end

    @message =  "El talento ha reprobado #{view_context.pluralize(@counter,'curso','cursos')} en el programa de: #{@department.name}"

    respond_to do |format|

      format.html { render :partial => 'talent_progress_option' , :locals => {courses_do: @reprobed_courses_by_department, option_type: @option_type} }

    end
  end

  def finished_courses_general
    @finished_courses_general = DoCourse.where(user_id: @user.id).where.not(finished_at: nil)
    @counter = DoCourse.where(user_id: @user.id).where.not(finished_at: nil).count
    @course = Array.new
    @option_type = 2
      @finished_courses_general.each do |fcg|
        @course.push(Course.find_by_id(fcg.course_id))
     end

     @message =  "El talento ha participado en  #{view_context.pluralize(@counter,'curso','cursos')}"

    respond_to do |format|

      format.html { render :partial => 'talent_progress_option' , :locals => {courses_do: @finished_courses_general, option_type: @option_type} }

    end

  end

  def finished_courses_by_department
    @department = Department.find_by_id(@user.department_id)
    @finished_courses_by_department = DoCourse.where(user_id: @user.id).where.not(finished_at: nil)
    @counter = 0
    @course = Array.new
    @option_type = 2

    @finished_courses_by_department.each do |fcbd|
     @course_by_department = CourseHasDepartment.where(course_id: fcbd.course_id, department_id: @department.id)
        if !@course_by_department.empty?
          @course_by_department.each do |cbd|
            @counter += 1
            @course.push(Course.find_by_id(cbd.course_id))
          end
        end
    end

    @message =  "El talento ha participado en  #{view_context.pluralize(@counter,'curso','cursos')} en el programa de: #{@department.name}"

    respond_to do |format|

      format.html { render :partial => 'talent_progress_option' , :locals => {courses_do: @finished_courses_by_department, option_type: @option_type} }

    end
  end

  def enrolled_courses_general
    @enrolled_courses_general = DoCourse.where(user_id: @user.id, enroll: 1, finished_at: nil)
    @counter = DoCourse.where(user_id: @user.id, enroll: 1, finished_at: nil).count
    @course = Array.new
    @option_type = 3

     @enrolled_courses_general.each do |ecg|
       @course.push(Course.find_by_id(ecg.course_id))
     end

     @message= "El talento esta inscrito en  #{view_context.pluralize(@counter,'curso','cursos')}"


    respond_to do |format|

      format.html { render :partial => 'talent_progress_option', :locals => {courses_do: @enrolled_courses_general, option_type: @option_type} }

    end
  end

  def enrolled_courses_by_department
    @department = Department.find_by_id(@user.department_id)
    @enrolled_courses_by_department = DoCourse.where(user_id: @user.id, enroll: 1, finished_at: nil)
    @counter = 0
    @course = Array.new
    @option_type = 3

    @enrolled_courses_by_department.each do |ecbd|
     @course_by_department = CourseHasDepartment.where(course_id: ecbd.course_id, department_id: @department.id)
        if !@course_by_department.empty?
          @course_by_department.each do |cbd|
            @counter += 1
            @course.push(Course.find_by_id(cbd.course_id))
          end
        end
    end

    @message= "El talento esta inscrito en  #{view_context.pluralize(@counter,'curso','cursos')} en el programa de: #{@department.name}"

    respond_to do |format|

      format.html { render :partial => 'talent_progress_option' , :locals => {courses_do: @enrolled_courses_by_department, option_type: @option_type} }

    end
  end



  def favorite_courses_general
    @favorite_courses_general = HasFavorite.where(user_id: @user.id)
    @counter = HasFavorite.where(user_id: @user.id).count
    @course = Array.new
    @option_type = 4

    @favorite_courses_general.each do |fcg|
       @course.push(Course.find_by_id(fcg.course_id))
    end

    @message = "El talento tiene #{view_context.pluralize(@counter,'curso','cursos')} en su lista de favoritos"

    respond_to do |format|

      format.html { render :partial => 'talent_progress_option' , :locals => {courses_do: @favorite_courses_general, option_type: @option_type} }

    end
  end

  def categories_talent
    @hash_categories = Hash.new
    @all_categories = Category.all

    @json_category = {
        "data": []
    }


    @all_categories.each do |ac|
      @hash_categories[ac.name] = 0
    end
    @user.do_courses.each do |c|

      @course = Course.find(c.course_id)
      @category = Category.find(@course.category_id)
      @hash_categories[@category.name] +=1

    end

    @hash_categories.each do |name,counter|
      @json_category[:data].push([name,counter])
    end

    respond_to do |format|

      format.json { }

    end
  end




  def templates
     @user = User.find(params[:talent_id])

     #buscar todas las planillas del usuario
     @templates = DoTemplate.template_made_by(@user.id)

     @templates_name = Array.new

    #  recorrer todas las planillas
     @templates.each do |n|
       #se guarda el template actual
       name = Template.find(n.template_id)

       #Se le asigna la secuencia del template
       @templates_name[n.sequence] =  name
     end
  end

  private


  def params_user_edit_by_super_admin_edit
    params.require(:user).permit( :privilege,:department_id, :name, :management, :position,:photo)
  end

  def params_user_edit_by_medium_admin_edit
    params.require(:user).permit( :department_id, :name, :management, :position)
  end

  def params_user_edit_by_super_admin
    params.require(:user).permit( :email, :privilege,:department_id, :name, :management, :position)
  end

  def params_user_edit_by_medium_admin
    params.require(:user).permit( :email, :department_id, :name, :management, :position)
  end


  def find_user
    if params[:talent_id].nil?
      @user = User.find(params[:id])
    else
      @user = User.find(params[:talent_id])
    end

  end
end
