class Department < ApplicationRecord
  validates :name, uniqueness: true, length: { minimum: 1 }, on: [:create, :update]

  has_many :users, dependent: :nullify #Si el departamento se elimina se pondra como nulo

  #relacion entre planilla y departamento
  has_many :has_templates, dependent: :destroy
  has_many :templates , through: :has_templates

  # relacion entre curso y departamento
  has_many :course_has_departments
  has_many :courses, through: :course_has_departments

  # Capitalizar los nombres antes de actualizar
  before_update :check_params
  before_create :check_params

  def check_params
     self.name = self.name.capitalize
  end
end
