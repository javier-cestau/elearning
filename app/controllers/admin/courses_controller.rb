# coding: utf-8
class Admin::CoursesController < ApplicationController
	# TODO hace que el administrador genral pueda perlar cursos el curso
	# TODO hacer que la fecha de inicio al crear el curso sea la de hoy
	# TODO hacer que la fecha de inicio al crear el curso sea la de hoy
	# TODO cuando el curso no tenga imagen pner una en el menu por defecto
before_action :authenticate_medium_admin!
before_action :find_course, only: [:edit]
before_action :find_course_in_section, only: [:talent_list]
before_action :all_topic, only: %i[edit talent_list]


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
				@courses = Course.search_by_department_admin(params[:search], params[:department]).order("#{order}").paginate(params[:page])

			else
				unless params[:scope].nil?

					@courses = Course.search_by_scope_admin(params[:search], params[:scope], current_user).order("#{order}").paginate(params[:page])
				else
					@courses = Course.search_admin(params[:search]).order("#{order}").paginate(params[:page])

				end
			end
		else
			@courses = Course.all.order("#{order}").paginate(params[:page])
		end

		unless params[:cat].nil?
			begin
				Category.find(params[:cat])
				@courses = @courses.where(category: params[:cat])
			rescue
			end
		end
	end

	def edit
		@multimedia= MultimediaCourse.new
		@list_users = Array.new
		@list_name_video = Array.new
		@list_name_image = Array.new
		@departments = CourseHasDepartment.where(course_id: @course.id)
		@list_tags = Array.new


		@total_inscription = DoCourse.where(course_id: @course.id, enroll: 1).count
		begin
			@total_pass = DoCourse.where(course_id: @course.id, enroll: 1, failed: 0).where.not(finished_at: nil ).count

			@media_pass = @total_pass *100 / @total_inscription
			 if @media_pass >= 60
				#verde
				@color = "#aed581"
			elsif @media_pass >= 25 and @media_pass <=59
				#amarillo
				@color = "#fff176"
			else
				#rojo
				@color = "#ef5350"
			end
		rescue
				@media_pass = 0
				 @media_pass = 0
		end



		today = Date.new(Date.current.year,Date.current.month,Date.current.day)
		@days = 0

		if @course.active == 1

			(@course.day_counter_update..today).each do |date|
				@days += 1
			end
		end
		@course.tags.each do |tag|
			@list_tags.push(tag)
		end
		@list_prelation = Array.new

		list_prela = Prelation.where(course_id: @course.id)

		list_prela.each do |course|
			@list_prelation.push(Course.find(course.prelated_by))
		end

		@course.course_has_private_users.each do |relation|

			@list_users.push(relation.user.id)
		end
		# Cargar los videos que tiene el curso asociado
		@course.multimedia_courses.each do |medias|
			if !medias.video_file_name.nil?
			 video_name = medias.video_file_name.split(".webm")[0]
			 @list_name_video.push(video_name => medias.id)
		 else
			 image_name = medias.image_file_name
			 @list_name_image.push(image_name => medias.id)

			end
		end

	end

	def update

		@course = Course.find(params[:id])
		#Para saber si se pueden modificar los datos o no.
		canUpdate = false

		if current_user.is_super_admin?
			active =  course_params[:active]
		else
			active =  @course.active
		end
		# Si el curso esta desactivado se puede modificar.
		if @course.active == 0
			canUpdate = true
		else

			#Si el curso esta activado pero se detecta que se desea cambiar el estado a desactivado, se podra modificar
			if  active == '0'
				canUpdate = true
				@course.day_counter_update = nil

				# al deshabiliitar el curso, se busca a todos los usuarios inscritos en el que no lo hayan terminado
        DoCourse.where(course_id: @course.id, finished_at: nil).each do |dc|
					#Se destruye los examenes de esos usuarios
          dc.do_tests.destroy_all
					# y se quita la inscripcion de esos usuarios al curso
          dc.destroy
        end


				# Se buscan los usuarios que si terminaron el curso
				DoCourse.where(course_id: @course.id).where.not(finished_at: nil).each do |d|
					#Se buscan los examenes de cada usuario
					@dotest = DoTest.where(do_course_id: d.id)

	        if !@dotest.nil?
	          @dotest.each do |dt|
							# Se desactivan los examenes para no borrarlos
	            dt.active = 0
	            dt.save
	          end
	        end

          d.enroll = 0
					d.save
				end
				#Se eliminan las recomendaciones hechas a ese curso
				DoRecomendation.where(course_id: @course.id).destroy_all

			end
		end

		# Se comprueba si el estado enviado es valido
		if active == '1' or  active == '0'

			if canUpdate

				@course.deadline_inscription = params[:course][:deadline_inscription]
				@course.start_date = params[:course][:start_date]
				@course.deadline_course= params[:course][:deadline_course]

				if @course.dates_valid?
					# Revisar si la categoria es valida
					category_correct = check_category
					# Se comprueba si se indico una categoria
					if category_correct

						scoping = course_params[:scoping]

						if scoping == "1" || scoping == "2" || scoping == "3"

							# Para borrar las relaciones que tiene o tenia
							old_scoping = @course.scoping
							#  el 1 es para indicar que el curso si posee prelaciones
							#  Si se paso algun valor en la prelacion se indicara que tiene prelaciones con el valor 1
							prelation = nil
							if !prelation_params.empty?
								prelation = 1
							else
								prelation = 0
							end

							description = course_params[:description]

							# Si coloca el tags de video se analiza la descripcion en busca de dichos tags
							while !description.index("#video{").nil?
								# html = "video_id/name} ......."
								html = description.split("#video{")[1]
								#html = video_id/name
								html = html.split("}")[0]

								video_id = html.split("/")[0]
								video_name = html.split("/")[1]



								new_html =   '<p style=""><span contenteditable="false" draggable="false" class="fr-video fr-dvb fr-draggable">'+
															'<video src=" /system/multimedia_courses/videos/course_'+@course.id.to_s+'/'+video_id+'/mobile/'+video_name+'.webm" data-status="OK" style="width: 600px;" "="" controls="" class="fr-draggable">'
															'Your browser does not support HTML5 video.</video>'+
														'</span></p>';
								old_label = "#video{#{video_id}/#{video_name}}"
								description =   description.sub(old_label, new_html)
							end



							# Si coloca el tags de video se analiza la descripcion en busca de dichos tags

							while !description.index("#image{").nil?
								# html = "image_id/name} ......."
								html = description.split("#image{")[1]
								#html = image_id/name
								html = html.split("}")[0]

								image_id = html.split("/")[0]
								image_name = html.split("/")[1]
								new_html = "<p><img alt='.' src='/system/multimedia_courses/images/course_"+@course.id.to_s+"/"+image_id+"/medium/"+image_name+"' width='160' height='119' /></p>"
								old_label = "#image{#{image_id}/#{image_name}}"
								description =   description.sub(old_label, new_html)

							end


							category_id =  course_params_category[:category_id].to_i
							name =  course_params[:name]

							if  course_params[:cover].nil?
								cover = @course.cover
							else
								cover = course_params[:cover]
							end

							if active.to_i == 1 and @course.day_counter_update == nil
								@course.day_counter_update = Date.today
							end

							name_valid = Course.where(name: name).where.not(id: @course.id).empty?

							if !name_valid
								flash[:alert] = "El nombre esta siendo usado por otro curso"
							end

							if @course.update(
									:category_id => category_id,
									:prelation => prelation,
									:active => active.to_i,
									:description => description,
									:name => name,
									:scoping => scoping,
									:cover => cover								)

								# Dependiendo de su antiguo scoping se eliminan las relaciones anteriores
								# Para dar paso a las nuevas relaciones
								if old_scoping == 2
									CourseHasDepartment.where(course_id: @course.id).destroy_all
								end
								if old_scoping == 3
									CourseHasPrivateUser.where(course_id: @course.id).destroy_all
								end

								# Cuando el curso sea de tipo POR programaS
								if scoping == '2'
									save_department_association
								end

								# Cuando el curso sea de tipo PRIVADO se guardara en la relacion en la tabal HasPrivateUser
								if scoping == '3'
									save_user_association
								end


								begin
									# Se borran todos la sprelaciones del curso para reinicializarlo de nuevo
									Prelation.where(course_id: @course.id).destroy_all
								rescue
									# ignored
								end

								# Ejemplo de las prelaciones
								# {prelation: ["1","2","3"]}
								prelation_params.each do |prelation_key ,courses_p_id|
									save_prelation(courses_p_id)
								end

								# Guardar todos los TAG
								delete_tags_without_relation

								tag_params.each do |tag_key ,names_tags|
								 save_tags_association(names_tags)
								end

								redirect_to edit_admin_course_path(@course) , notice: 'Actualizado exitosamente'
							else
								redirect_to edit_admin_course_path(@course) , alert: @course.errors.full_messages
							end

						end
					end
				else
					flash[:alert] = @course.dates_invalid_message
					redirect_to edit_admin_course_path @course
				end
			else
				flash[:alert]= 'No se puede modificar el curso debido a que está siendo ejecutado'
				redirect_to edit_admin_course_path @course
			end
		end
	end

	def new

		@course = Course.new

		# Debido a que editar y crear comparten form por medio de un parcial se inicializan las variables para que no ocurra un error de ejecucion
		@list_prelation = Array.new
		@list_users = Array.new
		@list_tags = Array.new
	end

	def create

		deadline_inscription = params[:course][:deadline_inscription]
		start_date = params[:course][:start_date]
		deadline_course= params[:course][:deadline_course]

		# Revisar si la categoria es valida
		category_correct = check_category
		# Se comprueba si se indico una categoria
		if category_correct

			scoping = course_params[:scoping]
			if scoping == '1' || scoping == '2' || scoping == '3'

				@course = Course.new(course_params)
				@course.deadline_inscription = deadline_inscription
				@course.deadline_course = deadline_course
				@course.start_date = start_date
				@course.category_id = course_params_category[:category_id].to_i
				@course.active = 0


				# Variables necesarias de declarar en caso  de errors

				@list_prelation = Array.new
				@list_tags = Array.new
				@list_users = Array.new


				if @course.dates_valid?
							#  el 1 es para indicar que el curso si posee prelaciones
							#  Si se paso algun valor en la prelacion se indicara que tiene prelaciones con el valor 1
							if !prelation_params.empty?
								@course.prelation = 1
							else
								@course.prelation = 0
							end

							name_valid = Course.where(name: course_params[:name]).empty?
							if !name_valid
								flash[:alert] = "El nombre esta siendo usado por otro curso"
							end

							if @course.save


								# Cuando el curso sea de tipo POR programaS
								if scoping == '2'
									save_department_association
								end

								# Cuando el curso sea de tipo PRIVADO se guardara en la relacion en la tabal HasPrivateUser
								if scoping == '3'
									save_user_association
								end


								# Ejemplo de las prelaciones
								# {prelation: ["1","2","3"]}
								prelation_params.each do |prelation_key ,courses_p_id|
									save_prelation(courses_p_id)
								end
								#
								# Guardar todos los TAG
								tag_params.each do |tag_key ,names_tags|
										save_tags_association (names_tags)
								end

								redirect_to edit_admin_course_path(@course), notice: 'Creado exitosamente'
							else
								redirect_to new_admin_course_path()

							end

				else

					flash[:alert] = @course.dates_invalid_message
					 redirect_to new_admin_course_path
				end
			end
		end
	end

	# Para enviar por AJAX al momento que el adminitrador inidique que quiere un curso por programa
	def  departments
		if params[:id].nil?
			@course = Course.new
		else
			@course = Course.find(params[:id])
		end
		respond_to do |format|

			format.html { render :partial => 'departments' }

		end

	end

	# Para enviar por AJAX al momento que el adminitrador inidique que quiere un curso privado
	def users
		@users = Array.new
		if params[:id].nil?
			course = Course.new
		else
			course = Course.find(params[:id])
			CourseHasPrivateUser.where(course_id: course.id).each do |relation|
				@users.push(relation.user)

			end
		end
		respond_to do |format|

			format.html { render :partial => 'users' }

		end

	end

#Lista de usuarios inscritos en el curso
	def talent_list

		if @course.nil?

			redirect_back(fallback_location: root_path)

		end

		@docourse = @course.all_users_enrolled
		@talents = Array.new

		if !@docourse.nil?
			@docourse.each do |dc|
				@talents.push(User.find_by_id(dc.user_id))
			end
		end

	end


	def report




		@years_array = Array.new
		@error = false
		if params[:department].nil?
			@years_array.push(DoCourse.all.order("created_at ASC").limit(1).first.created_at.year.to_i)
		else
			user = DoCourse.joins(:user).where( users: {department_id: params[:department]}).order("created_at ASC").limit(1).first
			unless (user.nil?)
				@years_array.push(user.created_at.year.to_i)
			else
				@error = true
			end

			begin
				@department_name = Department.find(params[:department]).name
			rescue
			end

		end

		@all_departments = Department.all
		unless @error
			@first_year = @years_array[0]
			@current_year = Time.now.year.to_i


			while @first_year != @current_year

				@first_year += 1
				@years_array.push(@first_year)

			end

		end
	end

	private

	def course_departments
		params.require(:course).permit(:departments => [])
	end

	def course_params
		params.require(:course).permit(:name,:description,:scoping,:active,:cover)
	end

	def course_params_category
		params.require(:course).permit(:category_id)
	end

	def prelation_params
		params.permit(:prelation => [])
	end

	def users_params
		params.permit(:users => [])
	end

	def tag_params
		params.permit(:tag => [])
	end

	def check_category

				# Revisar si la categoria que se paso existe
				begin
					category = Category.find(course_params_category[:category_id].to_i)
					true

				rescue
						# categoria no existe
					 redirect_to new_admin_course_path, alert: 'Error al buscar la categoria'
					 false
				end
	end

	def delete_tags_without_relation
		all_tags_course = HasTag.where(course_id: @course.id)

		all_tags_course.each do |has_tag|
				relation_with_other_course = HasTag.where("tag_id = #{has_tag.tag_id} AND course_id != #{@course.id}")
				if(relation_with_other_course.empty?)
					has_tag.tag.destroy
				else
					has_tag.destroy
				end
		end
	end

	def save_tags_association (names_tags)
		names_tags.each do |name|
			tag = Tag.find_by_name(name)

		 #  Para buscar si el Tag ya existe simplemente se hace una relacion con el existente, en el caos contrario se crea e igual se hace la relacion
		 #  Evitando asi la repeticion de TAg en la base de datos
			if tag.nil?
				tag = Tag.create(name: name)
			end

			HasTag.create(tag_id: tag.id,course_id: @course.id)
		end
	end

	def save_department_association
		course_departments.each do |departments, hash|
			hash.map do |department_id|
				if !department_id.empty?
					@course.save_has_course(department_id)
				end
			end
		end
	end

	def save_user_association
		if !users_params.empty?
			users_params.each do |users_key ,user_id_container|

				#  Se guardan las prelaciones
				 user_id_container.each do  |id_user|

						@course.save_private_user(id_user.to_i)
						create_notification(id_user)

				 end
			end
		end
	end

	def create_notification(id_user)
			has_notification = Notification.where("message = 'Usted acaba de ser invitado al curso #{@course.name}' AND user_id = ? AND ? < created_at ",id_user, DateTime.now - 2.days)
			if has_notification.empty?
				notification = Notification.new(user_id: id_user ,message: "Usted acaba de ser invitado al curso #{@course.name}", url:"#{course_path(@course)}", date: DateTime.now.localtime("-04:00"))
				notification.save!
				ActionCable.server.broadcast "notification_channel_#{id_user}",  notification: notification
			end
	end

	def save_prelation(courses_p_id)
		#  Se guardan las prelaciones


		 courses_p_id.each do  |course_p_id|
			#  Se coloca dentro de un begin en el caso de pasar un curso que no existe

			 begin
				 valid_prelation = true
				#Comprobar que los cursos no se prelen entre si
				 course_p = Course.find(course_p_id)

				 course_p_in_relation = Prelation.where(course_id: course_p.id, prelated_by:  @course.id)
					#Si devuelve algo significa que la prelacion no es valida debido a que habra dos prelaciones mutuas
					if !course_p_in_relation.empty?
						valid_prelation = false
					end

				#Comprobar que los cursos no se prelen entre si
				if valid_prelation
					# Se comprueba si la prelacion no es igual a la del curso
					if course_p_id.to_i !=  @course.id
						@course.prelations.create(prelated_by: course_p_id)
					end
				end
			rescue
			end
		end
	end


end
