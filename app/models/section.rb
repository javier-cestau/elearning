class Section < ApplicationRecord
  acts_as_paranoid
  belongs_to :course
  has_many :tests, dependent: :destroy
 

  has_many :multimedia_sections
  has_many :section_files, dependent: :destroy

  has_many :comment_sections

  def try_destroy
    # Se analiza si la sección tiene exámenes o tuvo
    if Test.with_deleted.where(section_id: self.id).empty?
      # si no tiene se destruye realmente
      self.really_destroy!
    else
      test = Test.find_by(section_id: self.id)

      # Si los examenes se eliminan la sección también
      if Test.destroy(test)
        self.really_destroy!
      else
        self.destroy
      end
    end
  end

end
