class CommentCoursesController < ApplicationController
	before_action :authenticate_user!


	def create

		if !comment_params[:body].empty?
			@course = Course.find(params[:course_id])
			@comment = current_user.comment_courses.new(comment_params)
			unless params[:child_of].nil?
				@comment.prv_comment = params[:child_of]
			end
	    @comment.course = @course
	    @comment.save

			# Si es una respuesta
			unless params[:child_of].nil?
				comment_father = CommentCourse.find(params[:child_of])
				owner = comment_father.user
				comments = CommentCourse.where("prv_comment = #{comment_father.id} OR id = #{comment_father.id} ").select(:user_id).group(:user_id)

				comments.each do |comment|
						old_notification = Notification.where( url:"#{course_path(@course,comment: params[:child_of])}", user_id: comment.user_id, read: 0).order("date DESC")

						if old_notification.empty?
							if owner.id == comment.user_id
								create_notification(comment.user_id, "Han respondido a su comentario en el curso '#{@course.name}'")
							else
								create_notification(comment.user_id, "Han respondido a un comentario en el curso '#{@course.name}'")
							end
						else

								minutes = ((old_notification.last.date-DateTime.now.localtime("-04:00")) *24*60).to_i
								# No se permite crear una notificacion que corresponda al mismo comentario con menos de quince minutos de diferencia
								if minutes > 15

									if owner.id == comment.user_id
											create_notification(comment.user_id, "Han respondido a su comentario en el curso '#{@course.name}'")
										else
											create_notification(comment.user_id,"Han respondido a un comentario en el curso '#{@course.name}'")
										end
								end
						end

				end
			else
				# Si es un comentario principal
				users = User.where("privilege >= 2")

				users.each do |u|
					create_notification(u.id, "Han comentado en el curso '#{@course.name}'")
				end
			end
			respond_to do |format|
					format.json{render :show }  #Aqui enviara el dato de comentario que se pide por AJAX
			end
		else
			render status: 500
		end
	end
	def destroy
		@comment = CommentCourse.find(params[:id])
		CommentCourse.where(prv_comment: @comment.id).destroy_all
		@comment.destroy



	end
	private

	def comment_params
      params.require(:comment_course).permit(:body)
  end

	def create_notification(user_id,message)

		if params[:child_of].nil?
			comment_id = @comment.id
		else
			comment_id = params[:child_of]
		end

		if current_user.id != user_id
			notification = Notification.new(user_id: user_id ,message: message, url:"#{course_path(@course,comment: comment_id )}", date: DateTime.now.localtime("-04:00"))
			notification.save!
			ActionCable.server.broadcast "notification_channel_#{user_id}",  notification: notification
		end
	end

end
