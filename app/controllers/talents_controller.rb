class TalentsController < ApplicationController
	before_action :authenticate_user!

	def notifications_user

		if current_user.id == params[:id].to_i

			respond_to do |format|
					format.html {
						@notifications = current_user.notifications.order("date DESC")
					 }
					format.json {
						@notifications = current_user.notifications.limit(5).order("date DESC")

					 }
				end
		end

	end

	def notifications_readed
		notification = Notification.find(params[:id])

		if notification.user.email == current_user.email
			notification.read = 1
			notification.save
		end
	end

	def favorites_list
		@fcounter = 0
		@favorites_list = HasFavorite.where(user_id: current_user.id)

	end

	def profile


		#Se busca la planilla mas reciente que hay en el programa del usuario
		current_user.department.has_templates.reverse_each do |fill_tmp|
				#se usa luego en un link en la vista para llevarlo a esa planilla
				@template = fill_tmp.template_id
				break
		end


		@total_inscription = 0
		@courses_in_process = Array.new
		@courses_finished = Array.new
		@courses_failed = Array.new
		@courses_in_process_count = 0
		@courses_finished_count = 0
		@courses_failed_count = 0

		current_user.do_courses.each do |c|
			@total_inscription += 1
			if c.finished_at.nil?
				@courses_in_process.push(c)
				@courses_in_process_count += 1
			else
				if c.failed == 0
					@courses_finished.push(c)
					@courses_finished_count += 1
				else
						@courses_failed.push(c)
						@courses_failed_count += 1
					end
			end

		end
	end


	def update

		if current_user.update(params_talents)

		else

		end

		redirect_to profile_talent_path
	end


	private

	def params_talents
		params.require(:user).permit(:photo)

	end

end
