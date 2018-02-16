class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_action :redirect_to_fill_profile
  before_action :redirect_sign_page
  before_action :notification_readed
  before_action :count_notification

  # TODO cambiar los find de los modelos para evitar errores

  # Solo permitira acceder al cierre de sesion y a la planilla en si ,
  #  mientras no haya llenado todavia su primera planilla
  def redirect_to_fill_profile
      redirect_to new_profile_path() if session['devise.fill_profile?'] && request.path != '/users/sign_out'
  end

  def redirect_sign_page
    redirect_to root_path  if request.path == '/users/sign_in'
  end

  def authenticate_medium_admin!
    if user_signed_in?
      redirect_to root_path unless current_user.is_at_least_medium_admin?
    else
      redirect_to root_path
    end
  end

  def authenticate_super_admin!
    if user_signed_in?
      redirect_to root_path unless  current_user.is_super_admin?
    else
      redirect_to root_path
    end
  end

  #Funciones para los cursos y secciones

  def find_course_in_section
    @course = Course.find(params[:course_id])
  end

  def find_course
    @course = Course.find(params[:id])
  end




  def is_course_avaible
    if @course.closed?
      flash[:alert] = "El curso no está actualmente activo para los usuarios"
      redirect_to courses_path and return true
    end
  end

  def section_child (s, counter)
    counter += 1

    has_child = Section.where(prv_section: s.id).select(:name, :id).order('created_at ASC')

    unless has_child.empty?
      has_child.each do |c|
        @all_topic[c] = counter
        @tests_sections
        section_child(c, counter)
      end
    end
  end

  def all_topic
    @principal_sections = @course.sections.where(prv_section: nil).order('created_at ASC')
    @all_topic = Hash.new
    @tests_sections = Hash.new
    @principal_sections.each do |s|
      counter = 1
      @all_topic[s] = counter
      section_child(s,counter)
    end

    # Separar las secciones principales y las subsecciones
    @sections_hash = Hash.new
		@primary_sections = Array.new
    @tests_in_course = Array.new
		tmp_primary_section = ""
    section_hash_url = Hash.new
		@all_topic.each do |section , index|
      section_hash_url[section.name] = section.id.to_s

      # confirmar que hay un examen
      if !section.tests.last.nil?
        @tests_in_course.push(section.tests.last)
      end
			if index == 1
				tmp_primary_section = section
				@primary_sections.push(section)
			else
				if @sections_hash[tmp_primary_section].nil?
					@sections_hash[tmp_primary_section] = []
				end
				@sections_hash[tmp_primary_section].push([section => index])
			end
		end
    gon.course_id = @course.id
    gon.sections_url = section_hash_url.to_json
  end

  def count_notification
    unless current_user.nil?
      @counter_notifications = Notification.where(user_id: current_user.id,read: 0).count
    end
  end

  def notification_readed

      begin

        notification = current_user.notifications.find_by_id(params[:notification])
          if notification.read.zero?
            notification.read = 1
            notification.save!
          end

      rescue
      end

  end

end
