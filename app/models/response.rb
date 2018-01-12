# Este modelo pertence a las respuesta del la planilla
class Response < ApplicationRecord
  has_many :do_templates

  #relacion entre opciones y respuestas
  has_many :has_choises
  has_many :choises, through: :has_choises

end
