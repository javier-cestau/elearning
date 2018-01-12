class Choise < ApplicationRecord
  #relacion entre opciones y respuestas
  has_many :has_choises
  has_many :responses, through: :has_choises

  belongs_to :survey
end
