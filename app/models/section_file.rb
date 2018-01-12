class SectionFile < ApplicationRecord
  belongs_to :section
  has_attached_file :file,
  :path => ':rails_root/public/system/:class/files/:section_id/:id/:style/:filename'
  validates_attachment_content_type :file, content_type: ["application/pdf", #PDF
                                                          "application/vnd.openxmlformats-officedocument.wordprocessingml.document", #Word
                                                          "application/vnd.openxmlformats-officedocument.presentationml.presentation", #PowerPoint
                                                          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" #Excel
                                                         ]

  Paperclip.interpolates :section_id do |attachment, style|
     "section_#{attachment.instance.section_id}"
  end

  def destroy_file_original
        path = self.file.path.split("/"+self.file_file_name)
        #  index = path.index('//')
        # path.insert(index+1, "000/000/0"+self.id)
        FileUtils.remove_dir(path[0])
  end

end
