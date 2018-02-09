class Template < ApplicationRecord

   self.record_timestamps = true

  validates :name, presence: true,  length: { minimum: 10 }

  #relacion entre programa y planilla
  has_many :has_templates, dependent: :destroy
  has_many :departments , through: :has_templates

  has_many :surveys ,dependent: :destroy

  has_many :do_templates

  def save_has_department (department_id)
			HasTemplate.create(department_id: department_id ,template_id: self.id)
	end

  def self.search (name)
    where("name = ? ", "#{name}")
  end

end
