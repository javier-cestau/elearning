class DoTest < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :do_course
  
  has_many :has_answers, dependent: :delete_all
end
