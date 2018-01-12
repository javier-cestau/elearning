class CommentSectionsController < ApplicationController
	before_action :authenticate_user!
	include Verify


	def create
		@section = Section.find(params[:section_id])
		if DoCourse.is_enroll_in_course?(@section.course,current_user) || current_user.is_at_least_medium_admin?
			if !comment_params[:body].empty?
				@comment = current_user.comment_sections.new(comment_params)

				unless params[:child_of].nil?
					@comment.prv_comment = params[:child_of]
				end
		    @comment.section = @section
		    @comment.save

				# Si es una respuesta
				unless params[:child_of].nil?
					comment_father = CommentSection.find(params[:child_of])
					owner = comment_father.user
					comments = CommentSection.where("prv_comment = #{comment_father.id} OR id = #{comment_father.id} ").select(:user_id).group(:user_id)

					comments.each do |comment|
							old_notification = Notification.where( url:"#{course_section_path(params[:course_id],@section,comment: params[:child_of])}", user_id: comment.user_id, read: 0).order("date DESC")

							if old_notification.empty?
								if owner.id == comment.user_id
									create_notification(comment.user_id, "Han respondido a su comentario en una sección del curso '#{@section.course.name}'")
								else
									create_notification(comment.user_id, "Han respondido a un comentario en en una sección del curso '#{@section.course.name}'")
								end
							else

									minutes = ((old_notification.last.date-DateTime.now.localtime("-04:00")) *24*60).to_i
									# No se permite crear una notificacion que corresponda al mismo comentario con menos de quince minutos de diferencia
									if minutes > 15

										if owner.id == comment.user_id
												create_notification(comment.user_id, "Han respondido a su comentario en una sección del curso '#{@section.course.name}'")
											else
												create_notification(comment.user_id,"Han respondido a un comentario en una sección del curso '#{@section.course.name}'")
											end
									end
							end

					end
				else
					# Si es un comentario principal
					users = User.where("privilege >= 2")

					users.each do |u|
						create_notification(u.id, "Han comentado en una sección del curso '#{@section.course.name}'")
					end
				end
				respond_to do |format|
						format.json{render :show }  #Aqui enviara el dato de comentario que se pide por AJAX
				end
			else
				render status: 500
			end

		else
			render status: 500
		end
	end


	def destroy
		if current_user.is_at_least_medium_admin? || current_user.id == @comment.user_id
			@comment = CommentSection.find(params[:id])
			CommentSection.where(prv_comment: @comment.id).destroy_all
			@comment.destroy
		end
	end

	private

	def comment_params
      params.require(:comment_section).permit(:body)
  end

	def create_notification(user_id,message)

		if params[:child_of].nil?
			comment_id = @comment.id
		else
			comment_id = params[:child_of]
		end

		if current_user.id != user_id
			notification = Notification.new(user_id: user_id ,message: message, url:"#{course_section_path(params[:course_id],@section,comment: comment_id )}", date: DateTime.now.localtime("-04:00"))
			notification.save!
			ActionCable.server.broadcast "notification_channel_#{user_id}",  notification: notification
		end
	end

end
