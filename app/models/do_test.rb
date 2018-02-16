class DoTest < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :do_course

  has_many :has_answers, dependent: :delete_all
  has_many :has_answer_descriptions, dependent: :delete_all

  def approve?
    self.grade >= self.test.min_grade
  end
end
