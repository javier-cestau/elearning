class Department < ApplicationRecord
  validates :name, uniqueness: true, length: { minimum: 1 }, on: [:create, :update]
  has_attached_file :photo, styles: { medium: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  has_many :users, dependent: :nullify #Si el programa se elimina se pondra como nulo

  #relacion entre planilla y programa
  has_many :has_templates, dependent: :destroy
  has_many :templates , through: :has_templates

  # relacion entre curso y programa
  has_many :course_has_departments
  has_many :courses, through: :course_has_departments

  # Capitalizar los nombres antes de actualizar
  before_update :check_params
  before_create :check_params

  def check_params
     self.name = self.name.capitalize
  end
end
