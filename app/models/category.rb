class Category < ApplicationRecord

  has_attached_file :photo, styles: { medium: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  has_many :courses
end
