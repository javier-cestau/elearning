# coding: utf-8
module SectionsHelper
	def do_button_test(section_id)
		test_section = @section.tests.last
		type = if test_section.required == 1
						 "examen"
					 else
						 "cuestionario práctico"
					 end


		if DoCourse.is_enroll_in_course?(@section.course,current_user)


			do_course = DoCourse.find_by(enroll: 1, user_id: current_user.id, course_id: @course.id,finished_at:nil)

			disabled_pass = ""

			# Evaluar si el usuario termino el curso
			if !do_course.nil?

        # Si es manual y ya fue enviado
				send_it = false
				# Comprobar si aprobo el examen
				do_course.do_tests.each do |do_t|

					if test_section.id == do_t.test_id
						# Si aprobo se descactiva la opción de hacerlo
						if do_t.grade.nil?
							send_it = true
						else
							if test_section.min_grade < do_t.grade
								disabled_pass = "disabled"
							end
						end
					end
				end

				if !send_it
					disabled_current = ""
						# Si ya realizo el examen no hace falta comprobar los examenes anteriores
						if (disabled_pass.empty?)
							can_do_it = test_section.can_do_it?(@tests_in_course,do_course)
							if !can_do_it
								disabled_current = "disabled"
							end
						end

					# Se evalua si ya paso el examen
					if disabled_pass.empty?

						# Si no lo ha pasado se evalua si paso el anterior para asi obligar al usuario a realizarlo
						if disabled_current.empty?
							content_tag(:div, class: "align-text") do
								link_to("Hacer #{type}", course_section_test_path( @course, @section,test_section), class: "btn")
							end
						else
							# En el caso de que no haya realizado el anterior
							content_tag(:div, class: "align-text") do
								content_tag(:h3,"Debe completar los exámenes anteriores", class: "align-text red-text")+
								tag(:br)+
								link_to("Hacer #{type}", course_section_test_path( @course, @section,test_section), class: "btn #{disabled_current} ")
							end
						end
					else
						# Si aprobo el examen
						content_tag(:div, class: "align-text") do
							content_tag(:h3,"Examen aprobado", class: "align-text ")+
							tag(:br)+
							link_to("Hacer #{type}", course_section_test_path( @course, @section,test_section), class: "btn #{disabled_pass} ")+
							link_to("Ver nota", course_grades_path(@course,do_course,test_id: test_section.id), class: "btn")
						end
					end
				else
					content_tag(:div, class: "align-text") do
						content_tag(:h5,"En espera de revisión", class: "align-text red-text")+
						tag(:br)+
						link_to("Hacer #{type}", course_section_test_path( @course, @section,test_section), class: "btn disabled ")
					end
				end

			else

				do_course = DoCourse.where(enroll: 1, user_id: current_user.id, course_id: @course.id).where.not(finished_at: nil).last

				if !do_course.nil?
					content_tag(:div, class: "align-text") do
						link_to("Ver nota", course_grades_path(@course,do_course,test_id: test_section.id), class: "btn")
					end
				end
			end
		else
			content_tag(:div, class: "align-text") do
				link_to("Hacer #{type}", "", class: "btn disabled")
			end
		end
	end

	def info_test(section_id)

		test_section = @section.tests.with_deleted.last

		start_date = ""

		unless test_section.deadline.nil?
			deadline = "Fecha Límite: #{localize(test_section.deadline)}"
		else
			deadline = "Sin fecha de entrega"
		end

		unless test_section.time_limit == 0
			time_limit = "Tiempo límite: #{pluralize(test_section.time_limit,'minuto','minutos')}"
		else
			time_limit = "No tiene tiempo límite "
		end

		# En el caso de que sea una dministrador sin inscribirse
		if DoCourse.is_enroll_in_course?(@section.course,current_user)
			do_course_id = DoCourse.inscription(current_user,@course).send(:id)
			count = DoTest.where(do_course_id: do_course_id,test_id: test_section.id).count

			if test_section.attemps_limits != 0
				attemps_limits = "Ha realizado #{pluralize(count,"intento","intentos")} de #{test_section.attemps_limits}"
			else
				attemps_limits = "Sin límite de intentos"
			end
		else
			if test_section.attemps_limits != 0
				attemps_limits = "Máximo de #{pluralize(test_section.attemps_limits,"intento","intentos")} "
			else
				attemps_limits = "Sin límite de intentos"
			end
		end


		unless test_section.start_date.nil?
			start_date_msg = "Fecha de inicio: #{localize(test_section.start_date)}"
			content_tag(:h4,"Nota miníma para aprobar: #{pluralize(test_section.min_grade,'punto','puntos')}")+
			content_tag(:li,start_date_msg)+
			content_tag(:li, deadline)+
			content_tag(:li, time_limit)+
			content_tag(:li, attemps_limits)
		else
			content_tag(:h4,"Nota miníma para aprobar: #{pluralize(test_section.min_grade,'punto','puntos')}")+
			content_tag(:li, deadline)+
			content_tag(:li, time_limit)+
			content_tag(:li, attemps_limits)
		end


	end

	def link_menu(admin,section,index=1)

		symbol = "file-text-o"
		if section.tests.empty?
			symbol = "circle"
		end

		if admin == 1
			link_to edit_admin_course_section_path(@course,section),style: "padding: 0" do |a|
				content_tag(:i,"",class: "fa fa-#{symbol} primary-symbol")+
				section.name
			end
		else
				link_to course_section_path(@course,section),style: "padding: 0" do |a|
					content_tag(:i,"",class: "fa fa-#{symbol} primary-symbol")+
					section.name
				end
		end
	end

	def level_section(index,name)

		if index == 2
			content_tag(:i,"",class: "fa fa-circle")+
			name
		elsif index == 3
			content_tag(:i,"",class: "fa fa-circle-o")+
			name
		else
			content_tag(:i,"",class: "fa fa-circle-thin")+
			name
		end

	end

	def create_subsection(subsection,admin)
		index = subsection.first[1]
		margin = 15 * (index-1)
		name = subsection.first[0].name
		tooltip = ""
		truncate = ""

		if name.length >= 35
			 tooltip = "tooltipped"
			 truncate = "truncate"
		end

		content_tag(:li,class: "#{truncate} #{tooltip}",style: "margin-left: #{margin}px;","data-position": "right", "data-delay": "50", "data-tooltip": "#{name}") do
			if admin == 1
				link_to edit_admin_course_section_path(@course,subsection.first[0]) do |a|
					if subsection.first[0].tests.empty?
						level_section(index,name)
					else
						content_tag(:i,"",class: "fa fa-file-text-o")+
						name
					end
				end
			else
				link_to course_section_path(@course,subsection.first[0]) do |a|
					if subsection.first[0].tests.empty?
						level_section(index,name)
					else
						content_tag(:i,"",class: "fa fa-file-text-o")+
						name
					end
				end
			end
		end
	end
end
