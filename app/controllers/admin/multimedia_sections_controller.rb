class Admin::MultimediaSectionsController < ApplicationController
  before_action :authenticate_medium_admin!


  def create

    @section = Section.find(params[:section_id])

    # Se encarga de verificar si se envió una imagen
    if !multimedia_params_image[:image].nil?

        @multimedia = MultimediaSection.new(multimedia_params_image)
        @multimedia.section_id = @section.id
        @multimedia.save
        @multimedia.destroy_image_original

        render json: [id: @multimedia.id, name: @multimedia.image_file_name]

    else
      # Se procesa los videos
      Thread.new{
        @multimedia = MultimediaSection.new(multimedia_params_video)
        @multimedia.section_id = @section.id
        @multimedia.save

        @multimedia.destroy_video_original
      }
    end

  end

  def destroy
    @multimedia = MultimediaSection.find(params[:id])
    @multimedia.destroy
    course = Course.find(params[:course_id])
    section = Section.find(params[:section_id])
  end


  private
  def multimedia_params_image
    params.require(:multimedia).permit(:image)
  end

  def multimedia_params_video
    params.require(:multimedia).permit(:video)
  end
end
