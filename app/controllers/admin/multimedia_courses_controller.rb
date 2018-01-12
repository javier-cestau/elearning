class Admin::MultimediaCoursesController < ApplicationController
  before_action :authenticate_medium_admin!


  def create

    @course = Course.find(params[:course_id])

    # Se encarga de verificar si se envió una imagen
    if !multimedia_params_image[:image].nil?

        @multimedia = MultimediaCourse.new(multimedia_params_image)
        @multimedia.course_id = @course.id
        @multimedia.save
        @multimedia.destroy_image_original

        render json: [id: @multimedia.id, name: @multimedia.image_file_name]


    else
      # Se procesan los videos
      Thread.new{
        @multimedia = MultimediaCourse.new(multimedia_params_video)
        create_notification
        @multimedia.course_id = @course.id
        @multimedia.save
        @multimedia.destroy_video_original
      }
    end

  end

  def destroy
    @multimedia = MultimediaCourse.find(params[:id])
    @multimedia.destroy
    course = Course.find(params[:course_id])
  end


  private
  def multimedia_params_image
    params.require(:multimedia).permit(:image)
  end

  def multimedia_params_video
    params.require(:multimedia).permit(:video)
  end


	def create_notification
			notification = Notification.new(user_id: current_user.id ,message: "Se ha terminado de subir su video '#{@multimedia.video_file_name}'", url:"#{edit_admin_course_path(@course)}", date: DateTime.now.localtime("-04:00"))
			notification.save!
      if !current_user.nil?
  			ActionCable.server.broadcast "notification_channel_#{current_user.id}",  notification: notification
      end
	end
end
