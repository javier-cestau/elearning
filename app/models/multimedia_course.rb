class MultimediaCourse < ApplicationRecord
   belongs_to :course
  has_attached_file :image, styles: { medium: "1280x720" },
  :path => ':rails_root/public/system/:class/images/:course_id/:id/:style/:filename',
  :url => ':rails_root/public/system/:class/images/:course_id/:id/:style/:filename'
  validates_attachment_content_type :image, content_type: ["image/jpeg" , "image/png", "image/gif"]

  has_attached_file :video, :styles => {
      mobile: {
        format: "webm",
        convert_options: {
          output: {
            # an: nil # Remove audio track resulting in a silent movie, passing in nil results in `-an`,

          }
        }
      }
    }, :processors => [:transcoder], dependent: :destroy,
    :path => ':rails_root/public/system/:class/videos/:course_id/:id/:style/:filename'


    #Para guardarlo en una carpeta con el id del courso al que pertenece la multimedia
    Paperclip.interpolates :course_id do |attachment, style|
       "course_#{attachment.instance.course_id}"
    end

    # Debido a que el video carga el nuevo formato y el original
    # Esta funcion se encrga de eliminar el video original despues de cargado el nuevo formato
    def destroy_video_original
          path = self.video.path.split("/"+self.video_file_name)
          #  index = path.index('//')
          # path.insert(index+1, "000/000/0"+self.id)
          FileUtils.remove_dir(path[0])
    end

    def destroy_image_original
          path = self.image.path.split("/"+self.image_file_name)
          #  index = path.index('//')
          # path.insert(index+1, "000/000/0"+self.id)
          FileUtils.remove_dir(path[0])
    end

end
