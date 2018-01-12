class Question < ApplicationRecord

  validates :description, presence: true

  belongs_to :type_question
  belongs_to :test
  has_many :answers
end
