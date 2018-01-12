class Survey < ApplicationRecord
  
  belongs_to :template
  belongs_to :type_survey
  has_many :choises, dependent: :destroy
  has_many :do_templates
  validates :description, presence: true
end
