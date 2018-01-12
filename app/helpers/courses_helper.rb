# coding: utf-8
# coding: utf-8
module CoursesHelper
	include Constant::StateEnroll

	def see_grades(admin_)
		msg = ""

		if admin_ == 0
			do_course = DoCourse.get_current_enroll(current_user.id,@course.id)
			if !do_course.nil?
				msg = "Ver mis notas"
				link = course_grades_path(@course,do_course)
				icon = "files-o"
			end
		else
			msg = "Ver usuarios inscritos"
			icon = "group"
			link = admin_course_talent_list_path(@course.id)
		end

			if !msg.empty?
				link_to link do |a|
					content_tag(:i,"",class: "fa fa-#{icon}")+
					content_tag(:span, msg)
				end
			end
	end

	def recomendation
		 approved = DoCourse.approved_enroll?(current_user,@course)
		 already_recommended = DoRecomendation.where(user_id: current_user.id, course_id: @course.id)

		 if  approved
		   if already_recommended.empty?
				 color = "teal"
				 href = "/courses/#{@course.id}/recomendation"
				 text = "Recomendar curso"
				 link_to href, class:""  do
					 content_tag(:i , "thumb_up", class: "material-icons ")+
					 text
				 end
			 else
				 color = "blue"
				 text = "Recomendó este curso"
				 content_tag  :a, class:"pointer"  do
					 content_tag(:i , "thumb_up", class: "material-icons ")+
					 text
				 end
			 end



			end
	end


	def card_title(t_required,section_id)

          @section = Section.find_by_id(section_id)

            if t_required == 0
              content_tag(:span,"Cuestionario práctico")+
              tag(:br)+
              content_tag(:span,"Sección: #{@section.name}")
            elsif t_required == 1
              content_tag(:span,"Examen obligatorio")+
              tag(:br)+
              content_tag(:span,"Sección: #{@section.name}")
	    end



	end


	def talent_grade(dt_grade,t_min_grade)

                color = ""
		if dt_grade < t_min_grade
	           color = "red darken-2"
		else
		   color = "green"
		end

                content_tag(:a, class: "btn-floating btn-large #{color} cursor-default btn-grade") do
		  "#{dt_grade}/20"
	        end


	end

        def talent_duration(dt_duration)

          if  dt_duration < 1

            content_tag(:span, class:"span-info-box") do
              "Menos de un minuto"
            end

          elsif dt_duration >= 1

            content_tag(:span, class:"span-info-box") do
              "#{pluralize(dt_duration, 'minuto','minutos')}"
            end

          end

        end

	def time_limit_message(t_time_limit)

		content_tag(:span, class: "span-info-box") do
			if t_time_limit < 1
				"Sin límite de tiempo."
			else
				"#{pluralize(t_time_limit, 'minuto','minutos')}"
			end
		end

	end

	def attemps_limits_message(t_attemps_limits)

		content_tag(:span, class: "span-info-box") do
			if t_attemps_limits < 1
				"Sin límite de intentos."
			else
				"#{pluralize(t_attemps_limits, 'intento','intentos')}"
			end
		end


	end

        def head_message_grades(user,course)

          if user.is_employed?

            content_tag(:h4,"Exámenes del curso:",class: "align-text")+
            content_tag(:h4,"#{course.name}",class: "align-text")+
            content_tag(:h5, "Notas obtenidas" ,class: "align-text")

          else

            content_tag(:h4,"Exámenes del curso:",class: "align-text")+
            content_tag(:h4,"#{course.name}",class: "align-text")+
            content_tag(:h5, "Notas obtenidas del talento: #{user.name}", class: "align-text")

          end

        end

	def no_attemps_message(attemps_counter)

		if attemps_counter == 1
			content_tag(:li) do
				content_tag(:div, class: "collapsible-header align-text") do
				 "El talento no ha realizado ningún intento de este examen"
				end
			end

		end

	end

	def enroll_button(current_user)
		if @course.finished?
			content_tag(:div,class: "align-text") do
				content_tag(:span,"Este curso ha finalizado", class: "btn red")
			end
		elsif @course.inscription_finished?
				content_tag(:div,class: "align-text") do
					content_tag(:span,"Las inscripciones han finalizado", class: "btn red")
				end
		else
			case(current_user.can_enroll?(@course))
			when Constant::StateEnroll::Active
				content_tag(:div,class: "align-text") do
					link_to("Inscribirse ahora",enroll_courses_path(@course), class: "btn")
				end
			when Constant::StateEnroll::CanNotDepartment, Constant::StateEnroll::CanNotPrivate
					content_tag(:div,class: "align-text") do
						content_tag(:span,"Este curso no está disponible para usted", class: "btn red")
					end
			when Constant::StateEnroll::AlreadyEnroll
				content_tag(:div,class: "align-text") do
					content_tag(:span,"Ya está inscrito", class: "btn blue lighten-1")
				end
			when Constant::StateEnroll::CanNotPrelation
					content_tag(:div,class: "align-text") do
						content_tag(:span,"Debe de aprobar los cursos anteriores", class: "btn red")
					end
			else
			end
		end
	end

def get_ids(text)
	# Si coloca el tags de video se analiza la descripcion en busca de dichos tags
	while !text.index("#=").nil?

		# html = "#=NameId# ......."
		html = text.split("#=")[1]
		word = html.split("#")[0]

		new_html =   '<span id="'+word+'"></span>'
		old_label = "#=#{word}#"
		text =text.sub(old_label, new_html)
		text =text.sub('href="#'+word+'"','href="#'+word+'" target="_self"' )

	end
	text.html_safe
end
end
