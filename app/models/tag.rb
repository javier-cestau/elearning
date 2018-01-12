class Tag < ApplicationRecord
  #relacion entre categorias y curso
  has_many :has_tags, dependent: :destroy
  has_many :courses, through: :has_tags

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
end
