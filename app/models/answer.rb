# Estas respuestas pertenecen a las respuestas de los examenes
class Answer < ApplicationRecord

  validates :description, presence: true
  
  belongs_to :question
end
